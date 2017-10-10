package com.dt.tarmag.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.dto.MenuDto;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.service.IRoleService;


/**
 * 初始化菜单
 * @author yuwei
 * @Time 2015-6-30下午07:20:04
 */
public class MenuInitInterceptor extends AbstractHandlerInterceptor {

	@Autowired
	private IRoleService roleService;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = ActionUtil.getSession();
		Customer customer = (Customer) session.getAttribute(Constant.SESSION_USER);
		
		/**
		 * 如果是管理员，不需要初始化菜单。
		 **/
		if(customer.getIsAdmin()) {
			return true;
		}
		
		List<MenuDto> fMenuDtoList = initMenuList();
		session.setAttribute(PortalConstants.SESSION_AUTHORIZED_MENUS, fMenuDtoList);

		
		/**
		 * 将当前被点击菜单的code存入session，仅限于权限菜单
		 **/
		String currentURL = ActionUtil.getRequest().getRequestURI();
		if(fMenuDtoList != null && fMenuDtoList.size() > 0) {
			for(MenuDto fMenu : fMenuDtoList) {
				List<MenuDto> sMenuList = fMenu.getChildMenuList();
				if(sMenuList == null || sMenuList.size() <= 0) {
					continue;
				}
				
				for(MenuDto sMenu : sMenuList) {
					if(currentURL != null && currentURL.equals(sMenu.getUrl())) {
						session.setAttribute(PortalConstants.SESSION_FIRST_LEVEL_MENU_CODE, fMenu.getCode());
						session.setAttribute(PortalConstants.SESSION_SECOND_LEVEL_MENU_CODE, sMenu.getCode());
					}
				}
			}
		}
		
		if(fMenuDtoList != null && fMenuDtoList.size() > 0) {
			String fMenuCode = (String) session.getAttribute(PortalConstants.SESSION_FIRST_LEVEL_MENU_CODE);
			String sMenuCode = (String) session.getAttribute(PortalConstants.SESSION_SECOND_LEVEL_MENU_CODE);
			
			if(sMenuCode == null) {
				MenuDto defaultMenu = fMenuDtoList.get(0);
				fMenuCode = defaultMenu.getCode();
				if(defaultMenu.getChildMenuList() != null && defaultMenu.getChildMenuList().size() > 0) {
					sMenuCode = defaultMenu.getChildMenuList().get(0).getCode();
					session.setAttribute(PortalConstants.SESSION_FIRST_LEVEL_MENU_CODE, fMenuCode);
					session.setAttribute(PortalConstants.SESSION_SECOND_LEVEL_MENU_CODE, sMenuCode);
				}
			}
		}
		
		return true;
	}

	@SuppressWarnings("unchecked")
	private List<MenuDto> initMenuList(){
		HttpSession session = ActionUtil.getSession();
		List<MenuDto> _fMenuList = (List<MenuDto>) session.getAttribute(PortalConstants.SESSION_AUTHORIZED_MENUS);
		if(_fMenuList != null && _fMenuList.size() > 0) {
			return _fMenuList;
		}

		List<MenuDto> fMenuDtoList = new ArrayList<MenuDto>();
		Long roleId = (Long) session.getAttribute(PortalConstants.SESSION_USER_ROLE);
		List<Menu> fMenus = roleService.getFirstLevelMenus((roleId == null) ? 0 : roleId);
		if(fMenus == null || fMenus.size() <= 0) {
			return fMenuDtoList;
		}
		
		for(Menu fMenu : fMenus) {
			MenuDto fMenuDto = new MenuDto();
			
			List<Menu> sMenuList = roleService.getSecondeLevelMenus(roleId, fMenu.getId());
			if(sMenuList == null || sMenuList.size() <= 0) {
				continue;
			}
			List<MenuDto> sMenuDtoList = new ArrayList<MenuDto>();
			for(Menu sMenu : sMenuList) {
				MenuDto sMenuDto = new MenuDto();
				sMenuDto.setTitle(sMenu.getTitle());
				sMenuDto.setCode(sMenu.getCode());
				sMenuDto.setUrl(sMenu.getUrl());
				sMenuDtoList.add(sMenuDto);
			}
			
			fMenuDto.setChildMenuList(sMenuDtoList);
			fMenuDto.setTitle(fMenu.getTitle());
			fMenuDto.setCode(fMenu.getCode());
			fMenuDto.setUrl(sMenuDtoList.get(0).getUrl());
			fMenuDtoList.add(fMenuDto);
		}
		
		return fMenuDtoList;
	}
}
