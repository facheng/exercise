package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dt.tarmag.service.IRoleService;


/**
 * @author yuwei
 * @Time 2015-7-3上午10:17:25
 */
@Controller
public class RoleController {
	
	@Autowired
	private IRoleService roleService;

	
	
	/**
	 * 查询用户在指定小区的角色列表
	 * @param unitId
	 * @param customerId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/role/list", method = GET)
	public String getRoleList(@RequestParam(value = "unitId", required = true) long unitId
			, @RequestParam(value = "customerId", required = true) long customerId
			, ModelMap model) {
		List<Map<String, Object>> roleList = roleService.getRoleListByCustomerAndUnit(customerId, unitId);

		model.put("roleList", roleList);
		return "ajax.get.role.list";
	}
	
}
