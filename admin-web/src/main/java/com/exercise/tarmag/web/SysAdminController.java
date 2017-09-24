package com.dt.tarmag.web;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dt.framework.util.Constant;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.tarmag.model.SysAdmin;
import com.dt.tarmag.service.ISysAdminService;

@RequestMapping("sysadmin")
@Controller
public class SysAdminController extends AbstractDtController{
	
	@Autowired
	private ISysAdminService sysAdminService;
	
	@RequestMapping(value="login")
	public String login(final HttpSession session, final ModelMap map, String userName, String password){
		String redirect = null;
		try {
			Map<String, Object> resultMap = this.sysAdminService.login(userName, password);
			if(resultMap.containsKey("errmsg")){
				redirect = "admin/login";
				map.addAllAttributes(resultMap);
			}else{
				redirect = "admin/index";
				session.setAttribute(Constant.SESSION_USER_ID, ((SysAdmin)resultMap.get("user")).getId());
				session.setAttribute(Constant.SESSION_USER, resultMap.get("user"));
				session.setAttribute("menus", resultMap.get("menus"));
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return redirect;
	}
	
	@RequestMapping("logout")
	public String logout(final HttpSession session){
		session.removeAttribute(Constant.SESSION_USER_ID);
		session.removeAttribute(Constant.SESSION_USER);
		session.removeAttribute("menus");
		return "admin/login";
	}
}
