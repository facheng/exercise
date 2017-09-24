package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.CookieUtil;
import com.dt.framework.util.SecurityUtil;
import com.dt.framework.util.TextUtil;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.service.ICustomerService;
import com.dt.tarmag.service.IRoleService;
import com.dt.tarmag.service.IUnitService;

/**
 * 
 * 用户登录
 * 
 * @author jiaoshaofeng
 * @since 2015年6月29日
 */
@Controller
public class LoginController {

	@Autowired
	private ICustomerService customerService;
	
	@Autowired
	private IUnitService unitService;
	
	@Autowired
	private IRoleService roleService;


	
	/**
	 * 初始化当前小区和角色。
	 * 初始化小区列表和角色列表。
	 * 客户进入网站后，在页面头部可以更换小区和角色。
	 **/
	protected void initUnitAndRoleList(long unitId, long roleId){
		HttpSession session = ActionUtil.getSession();
		session.setAttribute(PortalConstants.SESSION_USER_UNIT, unitId);
		session.setAttribute(PortalConstants.SESSION_USER_ROLE, roleId);
		
		long customerId = ActionUtil.getSessionUserId();
		/**
		 * 查询用户所有的小区
		 **/
		List<Map<String, Object>> unitList = unitService.getUnitListByCustmerId(customerId);
		/**
		 * 查询用户在当前小区中的所有角色
		 **/
		List<Map<String, Object>> roleList = roleService.getRoleListByCustomerAndUnit(customerId, unitId);
		session.setAttribute(PortalConstants.SESSION_USER_UNIT_LIST, unitList);
		session.setAttribute(PortalConstants.SESSION_USER_ROLE_LIST, roleList);
		
		/**
		 * 因为角色已变，所以权限菜单需重置
		 **/
		session.removeAttribute(PortalConstants.SESSION_AUTHORIZED_MENUS);
	}
	
	
	/**
	 * 跳转到登录页面
	 * @param model
	 * @return 登录页面
	 */
	@RequestMapping(value = "/login", method = GET)
	public String login(@RequestParam(value = "url", required = false) String url, ModelMap model) {
		model.put("url", url);
		return "to.login";
	}

	/**
	 * 登录校验
	 * @param model
	 */
	@RequestMapping(value = "/login", method = POST)
	public String doLogin(HttpServletRequest request, HttpServletResponse response
			, @RequestParam(value = "url", required = false) String url
			, @RequestParam(value = "loginName", required = true) String loginName
			, @RequestParam(value = "password", required = true) String password
			, @RequestParam(value = "remember", required = false) Integer remember
			, ModelMap model){
		Customer customer = customerService.getCustomerByUserName(loginName);
		if(customer == null || !customer.getPassword().equals(SecurityUtil.getMD5(password))) {
			model.put("url", url);
			model.put("loginName", loginName);
			model.put("remember", remember);
			if(customer == null) {
				model.put("loginNameError", "用户名不存在");
				return "to.login";
			} else {
				model.put("passwordError", "密码错误");
				return "to.login";
			}
		}
		
		HttpSession session = ActionUtil.getSession();
		session.setAttribute(Constant.SESSION_USER_ID, customer.getId());
		session.setAttribute(Constant.SESSION_USER, customer);
		if(remember != null && remember == 1) {
			CookieUtil.addUserToCookie(response, loginName);
		}
		
		/**
		 * 如果是管理员，跳转到公司组织架构管理页面；
		 * 如果是普通用户，跳转到选择角色和小区的页面
		 **/
		if(customer.getIsAdmin()) {
			if(url != null && !url.trim().equals("")){
				String to = SecurityUtil.decode(url.trim());
				if(to != null && to.startsWith("/admin")){
					return ActionUtil.redirect(to);
				}
			}
			return ActionUtil.redirect("/admin");
		}

		if (url != null && !url.trim().equals("")){
			return ActionUtil.redirect("/select/unit/role?url=" + url);
		} else {
			return ActionUtil.redirect("/select/unit/role");
		}
	}
	
	/**
	 * 用户登出
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/logout", method = GET)
	public String logout(HttpServletResponse response){
		HttpSession session = ActionUtil.getSession();
		session.invalidate();
		CookieUtil.invalidate(response);
		return ActionUtil.redirect("/login");
	}
	

	/**
	 * 跳转到选择小区和角色的页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/select/unit/role", method = GET)
	public String selectUnitAntRole(@RequestParam(value = "url", required = false) String url, ModelMap model) {
		if(url != null && !url.trim().equals("")) {
			model.put("url", url);
		}
		
		/**
		 * 如果用户只有一个小区一个角色，直接设置为用户的当前小区和角色，跳过选择
		 **/
		long customerId = ActionUtil.getSessionUserId();
		List<CustomerRoleUnit> curList = unitService.getCustomerRoleUnitList(customerId);
		if(curList != null && curList.size() == 1) {
			model.remove("url");
			CustomerRoleUnit cru = curList.get(0);
			
			initUnitAndRoleList(cru.getUnitId(), cru.getRoleId());
			
			if(url != null && !url.trim().equals("")){
				String to = SecurityUtil.decode(url.trim());
				if(to != null){
					return ActionUtil.redirect(to);
				}
			}
			
			return ActionUtil.redirect("/");
		}
		
		/**
		 * 查询用户所有的小区供用户选择
		 **/
		List<Map<String, Object>> unitList = unitService.getUnitListByCustmerId(customerId);

		model.put("unitList", unitList);
		model.put("customerId", customerId);
		return "to.select.unit.and.role";
	}
	

	

	/**
	 * 将用户选择的小区和角色存入session
	 * @param unitId
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/select/unit/role", method = POST)
	public String saveUnitAndRole(@RequestParam(value = "unitId", required = true) long unitId
			, @RequestParam(value = "roleId", required = true) long roleId
			, @RequestParam(value = "url", required = false) String url
			, ModelMap model) {
		if(roleId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, TextUtil.getText("role.null.error"));
			return Constant.GLOBAL_TO_ERROR;
		}
		
		long customerId = ActionUtil.getSessionUserId();
		CustomerRoleUnit cru = roleService.getCustomerRoleUnit(customerId, roleId, unitId);
		if(cru == null || !Constant.MODEL_DELETED_N.equals(cru.getDeleted())) {
			return Constant.GLOBAL_TO_ERROR;
		}
		
		initUnitAndRoleList(unitId, roleId);

		if(url != null && !url.trim().equals("")){
			String to = SecurityUtil.decode(url.trim());
			if(to != null){
				return ActionUtil.redirect(to);
			}
		}
		
		return ActionUtil.redirect("/");
	}

}
