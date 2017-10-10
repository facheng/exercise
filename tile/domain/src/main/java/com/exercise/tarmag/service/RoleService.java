package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Constant;
import com.dt.tarmag.dao.ICustomerRoleUnitDao;
import com.dt.tarmag.dao.IMenuDao;
import com.dt.tarmag.dao.IRoleDao;
import com.dt.tarmag.dao.IRoleMenuDao;
import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.model.Role;
import com.dt.tarmag.model.RoleMenu;
import com.dt.tarmag.vo.RoleVo;
import com.dt.tarmag.vo.Tree;


/**
 * @author yuwei
 * @Time 2015-6-29下午04:03:37
 */
@Service
public class RoleService implements IRoleService {

	@Autowired
	private IMenuDao menuDao;
	@Autowired
	private IRoleDao roleDao;
	@Autowired
	private ICustomerRoleUnitDao customerRoleUnitDao;
	@Autowired
	private IRoleMenuDao roleMenuDao;
	
	
	
	@Override
	public List<Menu> getFirstLevelMenus(long roleId) {
		return menuDao.getFirstLevelMenus(roleId);
	}

	@Override
	public List<Menu> getSecondeLevelMenus(long roleId, long parentId) {
		return menuDao.getSecondeLevelMenus(roleId, parentId);
	}

	@Override
	public List<Map<String, Object>> getRoleListByCustomerAndUnit(long customerId, long unitId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Long> roleIdList = customerRoleUnitDao.getRoleListByCustomerAndUnit(customerId, unitId);
		if(roleIdList == null || roleIdList.size() <= 0) {
			return mapList;
		}
		
		for(long roleId : roleIdList) {
			Role role = roleDao.get(roleId);
			if(role == null) {
				continue;
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("roleId", roleId);
			map.put("roleName", role.getRoleName());
			mapList.add(map);
		}
		
		return mapList;
	}
	
	@Override
	public List<Map<String, Object>> getRoleListByCompanyId(long companyId, boolean isAdmin) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Role> roleList = roleDao.getRoleListByCompanyId(companyId, isAdmin);
		if(roleList == null || roleList.size() <= 0) {
			return mapList;
		}
		
		for(Role role : roleList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", role.getId());
			map.put("name", role.getRoleName());
			mapList.add(map);
		}
		
		return mapList;
	}

	@Override
	public CustomerRoleUnit getCustomerRoleUnit(long customerId, long roleId, long unitId) {
		return customerRoleUnitDao.getCustomerRoleUnit(customerId, roleId, unitId);
	}

	@Override
	public void saveCustomerRoleUnit_tx(long customerId, long roleId, long unitId) {
		if(customerId <= 0 || roleId <= 0) {
			return;
		}
		
		CustomerRoleUnit cru = customerRoleUnitDao.getCustomerRoleUnit(customerId, roleId, unitId);
		if(cru != null) {
			return;
		}
		
		cru = new CustomerRoleUnit();
		cru.setCustomerId(customerId);
		cru.setUnitId(unitId);
		cru.setRoleId(roleId);
		cru.setDeleted(Constant.MODEL_DELETED_N);
		customerRoleUnitDao.save(cru);
	}
	
	@Override
	public void deleteCustomerRoleUnit_tx(long cruId) {
		customerRoleUnitDao.deleteLogic(cruId);
	}
	
	@Override
	public int getRoleCount(long companyId, String roleName) {
		return roleDao.getRoleCount(companyId, roleName);
	}
	
	@Override
	public List<Map<String, Object>> getRoleList(long companyId, String roleName, int pageNo, int pageSize) {
		List<Map<String ,Object>> mapList = new ArrayList<Map<String ,Object>>();
		List<Role> roleList = roleDao.getRoleList(companyId, roleName, pageNo, pageSize);
		if(roleList == null || roleList.size() <= 0) {
			return mapList;
		}
		
		for(Role role : roleList) {
			int count = customerRoleUnitDao.getCountByRoleId(role.getId());
			Map<String ,Object> map = new HashMap<String ,Object>();
			map.put("id", role.getId());
			map.put("name", role.getRoleName());
			map.put("canDelete", count <= 0 ? "1" : "0");
			mapList.add(map);
		}
		
		return mapList;
	}

	@Override
	public Map<String, Object> getRoleToEdit(long roleId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Role role = roleDao.get(roleId);
		if(role == null) {
			return null;
		}
		
		map.put("roleName", role.getRoleName());
		return map;
	}

	@Override
	public void createRole_tx(RoleVo vo) {
		if(vo == null 
				|| vo.getCompanyId() <= 0
				|| vo.getRoleName() == null || vo.getRoleName().trim().equals("")) {
			return;
		}
		
		Role role = new Role();
		role.setCompanyId(vo.getCompanyId());
		role.setRoleName(vo.getRoleName().trim());
		roleDao.save(role);
	}

	@Override
	public void updateRole_tx(long roleId, RoleVo vo) {
		if(vo == null 
				|| vo.getCompanyId() <= 0
				|| vo.getRoleName() == null || vo.getRoleName().trim().equals("")) {
			return;
		}
		
		Role role = roleDao.get(roleId);
		if(role == null) {
			return;
		}
		
		role.setRoleName(vo.getRoleName().trim());
		roleDao.update(role);
	}
	
	@Override
	public boolean deleteRole_tx(long roleId) {
		int count = customerRoleUnitDao.getCountByRoleId(roleId);
		if(count > 0) {
			return false;
		}
		
		roleDao.deleteLogic(roleId);
		return true;
	}
	
	@Override
	public List<Tree> getAuthedMenuTreeByCompanyId(long companyId) {
		Set<Tree> set = new TreeSet<Tree>(new Comparator<Tree>() {
            @Override
            public int compare(Tree a, Tree b) {
                return a.getId().compareTo(b.getId());
            }
        });
		
		Role adminRole = roleDao.findAdminRole(companyId);
		if(adminRole != null) {
			List<Long> menuIds = roleMenuDao.getMenuIdListByRoleId(adminRole.getId());
			List<Menu> sMenuList = menuDao.getSecondMenuList(menuIds);
			for(Menu sMenu : sMenuList) {
				Menu fMenu = menuDao.get(sMenu.getParentId());
				
				Tree sTree = new Tree();
				sTree.setId("" + sMenu.getId());
				sTree.setpId("u" + sMenu.getParentId());
				sTree.setName(sMenu.getTitle());
				sTree.setOpen("false");
				sTree.setValid(Tree.VALID_Y);
				set.add(sTree);
				
				Tree fTree = new Tree();
				fTree.setId("u" + fMenu.getId());
				fTree.setpId("0");
				fTree.setName(fMenu.getTitle());
				fTree.setOpen("false");
				fTree.setValid(Tree.VALID_N);
				set.add(fTree);
			}
		}
		
		return new ArrayList<Tree>(set);
	}
	
	@Override
	public List<Tree> getAuthedMenuTreeByRoleId(long roleId) {
		Set<Tree> set = new TreeSet<Tree>(new Comparator<Tree>() {
            @Override
            public int compare(Tree a, Tree b) {
                return a.getId().compareTo(b.getId());
            }
        });
		
		Role role = roleDao.get(roleId);
		if(role == null) {
			return new ArrayList<Tree>();
		}
		
		Role adminRole = roleDao.findAdminRole(role.getCompanyId());
		if(adminRole != null) {
			List<Long> menuIds = roleMenuDao.getMenuIdListByRoleId(adminRole.getId());
			List<Menu> sMenuList = menuDao.getSecondMenuList(menuIds);
			for(Menu sMenu : sMenuList) {
				Menu fMenu = menuDao.get(sMenu.getParentId());

				RoleMenu srm = roleMenuDao.getRoleMenu(roleId, sMenu.getId());
//				RoleMenu frm = roleMenuDao.getRoleMenu(roleId, fMenu.getId());
				
				Tree sTree = new Tree();
				sTree.setId("" + sMenu.getId());
				sTree.setpId("u" + sMenu.getParentId());
				sTree.setName(sMenu.getTitle());
				sTree.setOpen("false");
				sTree.setValid(Tree.VALID_Y);
				sTree.setChecked(srm != null);
				set.add(sTree);
				
				Tree fTree = new Tree();
				fTree.setId("u" + fMenu.getId());
				fTree.setpId("0");
				fTree.setName(fMenu.getTitle());
				fTree.setOpen("false");
				fTree.setValid(Tree.VALID_N);
				fTree.setChecked(srm != null);
				set.add(fTree);
			}
		}
		
		return new ArrayList<Tree>(set);
	}
	
	@Override
	public void updateRoleMenus_tx(long roleId, List<Long> menuIdList) {
		if(roleId <= 0) {
			return;
		}
		roleMenuDao.deleteByRoleId(roleId);
		for(long menuId : menuIdList) {
			Menu sMenu = menuDao.get(menuId);
			if(sMenu == null) {
				continue;
			}
			
			RoleMenu esrm = roleMenuDao.getRoleMenu(roleId, menuId);
			if(esrm != null) {
				continue;
			}
			
			RoleMenu srm = new RoleMenu();
			srm.setRoleId(roleId);
			srm.setMenuId(menuId);
			roleMenuDao.save(srm);
			
			if(sMenu.getParentId() > 0) {
				RoleMenu efrm = roleMenuDao.getRoleMenu(roleId, sMenu.getParentId());
				if(efrm == null) {
					RoleMenu frm = new RoleMenu();
					frm.setRoleId(roleId);
					frm.setMenuId(sMenu.getParentId());
					roleMenuDao.save(frm);
				}
			}
		}
	}
	
}
