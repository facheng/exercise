package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.BeanUtil;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.framework.util.SecurityUtil;
import com.dt.framework.util.TextUtil;
import com.dt.tarmag.dao.ICompanyBranchDao;
import com.dt.tarmag.dao.ICompanyDao;
import com.dt.tarmag.dao.ICustomerDao;
import com.dt.tarmag.dao.ICustomerRoleUnitDao;
import com.dt.tarmag.dao.IMenuDao;
import com.dt.tarmag.dao.IRoleDao;
import com.dt.tarmag.dao.IRoleMenuDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.model.Role;
import com.dt.tarmag.model.RoleMenu;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.CustomerVo;



@Service
public class CustomerService implements ICustomerService {

	@Autowired
	private ICustomerDao customerDao;
	@Autowired
	private IRoleDao roleDao;
	@Autowired
	private IUnitDao unitDao;
	@Autowired
	private ICustomerRoleUnitDao customerRoleUnitDao;
	@Autowired
	private ICompanyBranchDao companyBranchDao;
	@Autowired
	private ICompanyDao companyDao;
	@Autowired
	private IMenuDao menuDao;
	@Autowired
	private IRoleMenuDao roleMenuDao;
	
	

	@Override
	public boolean getCustomerByLoginInfo(Customer user) {
		boolean result = false; 
		user = customerDao.getCustomer(user);
		if(user != null){
			result = true;
		}
		return result;
	}

	@Override
	public Customer getCustomerByUserName(String userName) {
		return customerDao.getCustomerByUserName(userName);
	}

	@Override
	public void delete_tx(Long[] ids) {
		if(ids == null) return;
		for(Long id : ids){
			this.customerDao.deleteLogic(id);
		}
	}

	@Override
	public void saveCustomer_tx(Customer customer) {
		if(customer.getId() == 0){
			//设置用户为管理员
			customer.setIsAdmin(true);
			customer.setPassword(SecurityUtil.getMD5(customer.getPassword()));
			customer.setBranchId(this.companyBranchDao.getRoot(customer.getCompanyId()).getId());
			this.customerDao.save(customer);
			
			//保存默认的管理员角色
			Role role = new Role();
			role.setCompanyId(customer.getCompanyId());
			role.setIsAdmin(true);
			role.setRoleName(TextUtil.getText("admin_name"));
			this.roleDao.save(role);
			
			//保存角色用户组织管理表
			CustomerRoleUnit customerRoleUnit = new CustomerRoleUnit();
			customerRoleUnit.setCustomerId(customer.getId());
			customerRoleUnit.setRoleId(role.getId());
			this.customerRoleUnitDao.save(customerRoleUnit);
		}else{//更新
			Customer entity = this.customerDao.get(customer.getId());
			if(!entity.getPassword().equals(customer.getPassword())){//如果密码不一致 则使用MD5加密修改过后的密码
				customer.setPassword(SecurityUtil.getMD5(customer.getPassword()));
			}
			BeanUtil.copyProperty(customer, entity);
			this.customerDao.update(entity);
		}
	}

	@Override
	public Customer findCustomerById(long id) {
		return this.customerDao.get(id);
	}

	@Override
	public PageResult<Map<String, Object>> findCustomer(Map<String, Object> params, Page page) {
		return this.customerDao.findCustomer(params, page);
	}

	@Override
	public boolean isRepeat(String userName) {
		return this.customerDao.getCustomerByUserName(userName) != null;
	}

	@Override
	public Map<String, Object> allocationmodule(Long companyId) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Role role = this.roleDao.findAdminRole(companyId);
		List<Map<String, Object>> all = this.menuDao.findAll();
		List<Long> owns = this.menuDao.findOwns(companyId);
		for(Map<String, Object> menu : all){
			menu.put("isChecked", owns.contains(Long.valueOf(menu.get("id").toString())));
		}
		resultMap.put("menus", all);
		resultMap.put("roleId", role.getId());
		return resultMap;
	}

	@Override
	public void alloteModule_tx(Long roleId, Long[] mIds) {
		//删除已有的
		this.roleMenuDao.deleteByRoleId(roleId);
		//保存分配的
		if(mIds != null){
			for(long mId : mIds){
				RoleMenu roleMenu = new RoleMenu();
				roleMenu.setRoleId(roleId);
				roleMenu.setMenuId(mId);
				this.roleMenuDao.save(roleMenu);
			}
		}
	}

	@Override
	public int getCustomerCountByCompanyId(long companyId, boolean isAdmin ,String userName) {
		return customerDao.getCustomerCountByCompanyId(companyId, isAdmin, userName);
	}

	@Override
	public List<Map<String, Object>> getCustomerListByCompanyId(long companyId, boolean isAdmin, String userName, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Customer> customerList = customerDao.getCustomerListByCompanyId(companyId, isAdmin, userName, pageNo, pageSize);
		if(customerList == null || customerList.size() <= 0) {
			return mapList;
		}
		
		for(Customer customer : customerList) {
			Customer creator = customerDao.get(customer.getCreateUserId());
			CompanyBranch branch = companyBranchDao.get(customer.getBranchId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", customer.getId());
			map.put("userName", customer.getUserName());
			map.put("idCard", customer.getIdCard() == null ? "" : customer.getIdCard());
			map.put("branchId", customer.getBranchId());
			map.put("branchName", branch == null ? "" : branch.getBranchName());
			map.put("creator", creator == null ? "" : creator.getUserName());
			map.put("createTime", DateUtil.formatDate(customer.getCreateDateTime(), DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}
		return mapList;
	}
	
	@Override
	public Map<String, Object> getCustomerToEdit(long customerId) {
		Customer customer = customerDao.get(customerId);
		if(customer == null) {
			return null;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		CompanyBranch branch = companyBranchDao.get(customer.getBranchId());

		map.put("customerName", customer.getUserName());
		map.put("realName", customer.getRealName() == null ? "" : customer.getRealName());
		map.put("idCard", customer.getIdCard() == null ? "" : customer.getIdCard().trim());
		map.put("branchId", customer.getBranchId());
		map.put("branchName", branch == null ? "" : branch.getBranchName());
		return map;
	}

	@Override
	public boolean createCustomer_tx(CustomerVo customerVo) {
		if(customerVo == null
				|| customerVo.getUserName() == null || customerVo.getUserName().trim().equals("")
				|| customerVo.getPassword() == null || customerVo.getPassword().equals("")
				|| customerVo.getBranchId() <= 0) {
			return false;
		}
		Customer c = customerDao.getCustomerByUserName(customerVo.getUserName());
		if(c != null) {
			return false;
		}
		CompanyBranch cb = companyBranchDao.get(customerVo.getBranchId());
		if(cb == null) {
			return false;
		}
		
		c = new Customer();
		c.setUserName(customerVo.getUserName().trim());
		if(customerVo.getRealName() != null && !customerVo.getRealName().trim().equals("")) {
			c.setRealName(customerVo.getRealName().trim());
		}
		c.setPassword(SecurityUtil.getMD5(customerVo.getPassword()));
		c.setIdCard(customerVo.getIdCard());
		c.setBranchId(customerVo.getBranchId());
		c.setCompanyId(cb.getCompanyId());
		customerDao.save(c);
		return true;
	}

	@Override
	public boolean updateCustomer_tx(long customerId, CustomerVo customerVo) {
		if(customerId <= 0
				|| customerVo == null
				|| customerVo.getUserName() == null || customerVo.getUserName().trim().equals("")
				|| (customerVo.getChangePassword() == CustomerVo.CHANGE_PASSWORD_Y
						&& (customerVo.getPassword() == null || customerVo.getPassword().equals("")))
				|| customerVo.getBranchId() <= 0) {
			return false;
		}
		
		Customer customer = customerDao.get(customerId);
		if(customer == null) {
			return false;
		}
		CompanyBranch cb = companyBranchDao.get(customerVo.getBranchId());
		if(cb == null) {
			return false;
		}
		
		customer.setUserName(customerVo.getUserName().trim());
		if(customerVo.getRealName() != null && !customerVo.getRealName().trim().equals("")) {
			customer.setRealName(customerVo.getRealName().trim());
		}
		if(customerVo.getChangePassword() == CustomerVo.CHANGE_PASSWORD_Y) {
			customer.setPassword(SecurityUtil.getMD5(customerVo.getPassword()));
		}
		customer.setIdCard(customerVo.getIdCard());
		customer.setBranchId(customerVo.getBranchId());
		customer.setCompanyId(cb.getCompanyId());
		customerDao.update(customer);
		return true;
	}
	
	@Override
	public void deleteCustomer_tx(long customerId) {
		customerDao.deleteLogic(customerId);
	}
	
	@Override
	public Map<String, Object> getCustomerDetailMap(long customerId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Customer customer = customerDao.get(customerId);
		if(customer == null) {
			return map;
		}
		
		CompanyBranch cb = companyBranchDao.get(customer.getBranchId());
		Company c = companyDao.get(cb == null ? 0 : cb.getCompanyId());
		List<CustomerRoleUnit> cruList = customerRoleUnitDao.getCustomerRoleUnitList(customerId);
		
		List<Map<String, Object>> cruMapList = new ArrayList<Map<String, Object>>();
		if(cruList != null && cruList.size() > 0) {
			for(CustomerRoleUnit cru : cruList) {
				Role role = roleDao.get(cru.getRoleId());
				Unit unit = unitDao.get(cru.getUnitId());
				
				Map<String, Object> cruMap = new HashMap<String, Object>();
				cruMap.put("id", cru.getId());
				cruMap.put("roleName", role.getRoleName());
				cruMap.put("unitName", unit == null ? "" : unit.getUnitName());
				cruMapList.add(cruMap);
			}
		}

		map.put("userName", customer.getUserName());
		map.put("realName", customer.getRealName() == null ? "" : customer.getRealName());
		map.put("idCard", customer.getIdCard() == null ? "" : customer.getIdCard().trim());
		map.put("branchName", (c == null ? "" : c.getCompanyName()) + " " + (cb == null ? "" : cb.getBranchName()));
		map.put("cruList", cruMapList);
		return map;
	}
}
