package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dt.framework.util.ActionUtil;


/**
 * @author yuwei
 * @Time 2015-6-30下午06:02:33
 */
@Controller
public class AdminController {

	@RequestMapping(value = "/admin", method = GET)
	public String toAdminHome(ModelMap model){
		return ActionUtil.redirect("/admin/company/branch/list");
	}
	
}
