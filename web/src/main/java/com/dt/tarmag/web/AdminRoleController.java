package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

import java.util.ArrayList;
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
import com.dt.tarmag.service.IRoleService;
import com.dt.tarmag.vo.RoleVo;
import com.dt.tarmag.vo.Tree;


/**
 * @author yuwei
 * @Time 2015-7-3下午01:22:21
 */
@Controller
public class AdminRoleController {
	@Autowired
	private IRoleService roleService;
	
	
	/**
	 * 角色列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role/list", method = GET)
	public String showRoleList(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="rname" , required = false) String rname 
			, ModelMap model){
		Customer manager = (Customer) ActionUtil.getSession().getAttribute(Constant.SESSION_USER);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		int count = roleService.getRoleCount(manager.getCompanyId(), rname);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> roleList = roleService.getRoleList(manager.getCompanyId(), rname, pageNo, pageSize);
		
		model.put("rname", rname);
		model.put("page", page);
		model.put("roleList", roleList);
		model.put("companyId", manager.getCompanyId());
		model.put("firstMenu", 3);
		model.put("secondMenu", 1);
		return "to.show.role.list";
	}
	
	/**
	 * 创建/修改角色
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role", method = GET)
	public String toEditRole(@RequestParam(value = "id", required = false) Long roleId, ModelMap model){
		model.put("firstMenu", 3);
		model.put("secondMenu", 1);
		
		if(roleId == null) {
			return "to.edit.role";
		}
		
		Map<String, Object> map = roleService.getRoleToEdit(roleId);
		if(map == null) {
			return ActionUtil.redirect("/admin/role");
		}
		
		model.put("map", map);
		model.put("roleId", roleId);
		return "to.edit.role";
	}
	
	/**
	 * 创建/修改角色
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role", method = POST)
	public String toEditRole(@RequestParam(value = "id", required = false) Long roleId
			, RoleVo vo, ModelMap model){
		Customer manager = (Customer) ActionUtil.getSession().getAttribute(Constant.SESSION_USER);
		vo.setCompanyId(manager.getCompanyId());
		
		if(roleId == null || roleId <= 0) {
			roleService.createRole_tx(vo);
		} else {
			roleService.updateRole_tx(roleId, vo);
		}
		
		return ActionUtil.redirect("/admin/role/list");
	}
	
	/**
	 * 删除角色
	 * 1成功，0失败
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role/{id}", method = DELETE)
	@ResponseBody
	public String deleteRole(@PathVariable(value = "id") long roleId, ModelMap model){
		boolean b = roleService.deleteRole_tx(roleId);
		return b ? "1" : "0";
	}

	/**
	 * 查询指定公司下所有授权的菜单
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/company/{id}/menus", method = GET)
	public String getCompanyMenus(@PathVariable(value = "id") long companyId, ModelMap model){
		List<Tree> trees = roleService.getAuthedMenuTreeByCompanyId(companyId);
		model.put("trees", trees);
		return "ajax.get.company.menus";
	}

	/**
	 * 查询指定角色对应的公司下所有的授权菜单，并将该角色对应的菜单做标记
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role/{id}/menus", method = GET)
	public String getRoleMenus(@PathVariable(value = "id") long roleId, ModelMap model){
		List<Tree> trees = roleService.getAuthedMenuTreeByRoleId(roleId);
		model.put("trees", trees);
		return "admin.get.role.menus.ajax";
	}

	/**
	 * 给指定的角色设置权限菜单
	 * @param roleId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role/{id}/menus", method = POST)
	@ResponseBody
	public String updateRoleMenus(@PathVariable(value = "id") long roleId
			, @RequestParam(value = "menuIds", required = true) String menuIds
			, ModelMap model){
		List<Long> menuIdList = new ArrayList<Long>();
		if(menuIds != null && !menuIds.trim().equals("")) {
			String[] arr = menuIds.trim().split(",");
			if(arr != null && arr.length > 0) {
				for(String mId : arr) {
					menuIdList.add(Long.parseLong(mId));
				}
			}
		}

		roleService.updateRoleMenus_tx(roleId, menuIdList);
		return "1";
	}

	/**
	 * 分配小区/角色
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/customer/unit/role", method = GET)
	public String toSetCustomerUnitRole(ModelMap model){
		model.put("firstMenu", 3);
		model.put("secondMenu", 2);
		return "to.set.customer.unit.role";
	}

	/**
	 * 分配权限
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/role/menu", method = GET)
	public String toSetRoleMenu(ModelMap model){
		model.put("firstMenu", 3);
		model.put("secondMenu", 3);
		return "to.set.role.menu";
	}
}
