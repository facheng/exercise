package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.service.ICustomerService;
import com.dt.tarmag.service.IRoleService;
import com.dt.tarmag.service.IUnitService;
import com.dt.tarmag.vo.CustomerVo;


/**
 * @author yuwei
 * @Time 2015-7-3下午01:18:43
 */
@Controller
public class AdminUserController {

	@Autowired
	private ICustomerService customerService;
	@Autowired
	private IRoleService roleService;
	@Autowired
	private IUnitService unitService;
	
	
	
	/**
	 * 显示用户列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user/list", method = GET)
	public String showUserList(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="userName" , required = false) String userName 
			, ModelMap model){
		//菜单设置
		model.put("firstMenu", 4);
		model.put("secondMenu", 1);
		
		long userId = ActionUtil.getSessionUserId();
		Customer admin = customerService.findCustomerById(userId);
		
		//分页设置
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = customerService.getCustomerCountByCompanyId(admin.getCompanyId(), false , userName);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String, Object>> customerList = customerService.getCustomerListByCompanyId(admin.getCompanyId(), false , userName , pageNo , pageSize);

		model.put("companyId", admin.getCompanyId());
		model.put("userName", userName);
		model.put("page", page);
		model.put("customerList", customerList);
		return "to.show.user.list";
	}

	/**
	 * 编辑用户
	 * 如果id为空，表示新建用户，否则是修改现有用户
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user", method = GET)
	public String toEditUser(@RequestParam(value = "id", required = false) Long customerId, ModelMap model){
		Customer admin = (Customer) ActionUtil.getSession().getAttribute(Constant.SESSION_USER);
		//菜单设置
		model.put("firstMenu", 4);
		model.put("secondMenu", 1);
		model.put("companyId", admin.getCompanyId());
		
		if(customerId == null) {
			return "to.edit.user";
		}
		
		Map<String, Object> map = customerService.getCustomerToEdit(customerId);
		if(map == null) {
			return ActionUtil.redirect("/admin/user");
		}
		
		model.put("map", map);
		model.put("customerId", customerId);
		return "to.edit.user";
	}
	
	/**
	 * 保存用户
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user", method = POST)
	public String saveUser(@RequestParam(value = "id", required = false) Long customerId
			, CustomerVo customerVo, ModelMap model){
		if(customerId == null || customerId <= 0) {
			customerService.createCustomer_tx(customerVo);
		} else {
			customerService.updateCustomer_tx(customerId, customerVo);
		}
		return ActionUtil.redirect("/admin/user/list");
	}
	
	/**
	 * 用户详情
	 * @param customerId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user/{id}", method = GET)
	public String showCustomerDetail(@PathVariable(value = "id") long customerId, ModelMap model){
		model.put("firstMenu", 4);
		model.put("secondMenu", 1);
		
		Map<String, Object> map = customerService.getCustomerDetailMap(customerId);
		model.put("map", map);
		return "to.show.user.detail";
	}
	
	/**
	 * 删除用户
	 * 1成功，0失败
	 * @param customerId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user/{id}", method = DELETE)
	@ResponseBody
	public String deleteCustomer(@PathVariable(value = "id") long customerId, ModelMap model){
		customerService.deleteCustomer_tx(customerId);
		return "1";
	}

	/**
	 * 检查用户名是否可使用，1可，0不可
	 * @param name
	 * @return
	 */
	@RequestMapping(value = "/ajax/user/nc", method = POST)
	@ResponseBody
	public String checkUserName(@RequestParam(value = "id", required = false) Long customerId
			, @RequestParam(value = "name", required = true) String name){
		if(name == null || name.trim().equals("")) {
			return "0";
		}
		
		Customer customer = customerService.getCustomerByUserName(name);
		if(customerId == null) {
			return customer == null ? "1" : "0";
		} else {
			return customer == null || customer.getId() == customerId ? "1" : "0";
		}
	}
	
	/**
	 * 保存用户+角色+小区关系
	 * @param userId
	 * @param roleId
	 * @param unitId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user/{userId}/role/{roleId}/unit/{unitId}", method = POST)
	@ResponseBody
	public String saveCustomerRoleUnit(@PathVariable(value = "userId") long userId
			, @PathVariable(value = "roleId") long roleId
			, @PathVariable(value = "unitId") long unitId
			, ModelMap model) {
		roleService.saveCustomerRoleUnit_tx(userId, roleId, unitId);
		return "1";
	}
	
	/**
	 * 删除用户+角色+小区关系
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/user/role/unit/{id}", method = DELETE)
	@ResponseBody
	public String deleteCustomerRoleUnit(@PathVariable(value = "id") long cruId, ModelMap model) {
		roleService.deleteCustomerRoleUnit_tx(cruId);
		return "1";
	}
	
	/**
	 * 根据公司ID查非管理员角色集合
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/admin/company/{id}/roles", method = GET)
	public String getRoleListByCompanyId(@PathVariable(value = "id") long companyId
			, ModelMap model) {
		List<Map<String, Object>> roleList = roleService.getRoleListByCompanyId(companyId, false);
		model.put("roleList", roleList);
		return "ajax.admin.company.roles";
	}
	
	/**
	 * 根据组织ID查小区集合(包括下级组织的小区)
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/admin/branch/{id}/units", method = GET)
	public String getUnitListByBranchId(@PathVariable(value = "id") long branchId
			, ModelMap model) {
		List<Map<String, Object>> unitList = unitService.getUnitListByBranchId(branchId);
		model.put("unitList", unitList);
		return "ajax.admin.branch.units";
	}
}
