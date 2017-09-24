package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dt.framework.util.ActionUtil;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.dto.MenuDto;

/**
 * @author yuwei
 * @Time 2015-7-2上午10:10:37
 */
@Controller
public class HomeController {

	/**
	 * 如果用户没有任何菜单，显示欢迎页面； 否则跳转到第一个菜单
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/", method = GET)
	public String toHome() {
		HttpSession session = ActionUtil.getSession();
		List<MenuDto> fMenuList = (List<MenuDto>) session.getAttribute(PortalConstants.SESSION_AUTHORIZED_MENUS);
		if (fMenuList == null || fMenuList.size() <= 0) {
			return "to.welcome";
		}
		
		MenuDto fMenuDto = fMenuList.get(0);
		return ActionUtil.redirect(fMenuDto.getUrl());
	}
}
