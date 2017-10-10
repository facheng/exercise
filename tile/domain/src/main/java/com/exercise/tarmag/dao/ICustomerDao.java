package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.util.PageResult;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:46:00
 */
public interface ICustomerDao extends Dao<Customer, Long> {
	
	/**
	 * 通过登录信息查询用户
	 * @param user 物业用户
	 * @return Customer 物业用户
	 */
	Customer getCustomer(Customer user);
	
	/**
	 * 根据用户名查询用户
	 * @param userName
	 * @return
	 */
	Customer getCustomerByUserName(String userName);

	/**
	 * 根据条件查询用户列表
	 * @param params
	 * @param page
	 * @return
	 */
	PageResult<Map<String, Object>> findCustomer(Map<String, Object> params, Page page);

	/**
	 * 查询指定公司的用户
	 * @param companyId
	 * @param isAdmin
	 * @param pageSize 
	 * @param pageNo 
	 * @return
	 */
	List<Customer> getCustomerListByCompanyId(Map<String, Object> paramsMap , int pageNo, int pageSize);
	
	
	/**
	 * 通过登录信息查询用户数量
	 * @param paramsMap
	 * @return
	 */
	int getCountCustomerListByCompanyId(Map<String, Object> paramsMap);
	
	/**
	 * 查询指定公司的非管理员帐号数量
	 * @param companyId
	 * @param isAdmin
	 * @return
	 */
	public int getCustomerCountByCompanyId(long companyId, boolean isAdmin , String userName);

	/**
	 * 查询指定公司的用户
	 * @param companyId
	 * @param isAdmin
	 * @return
	 */
	List<Customer> getCustomerListByCompanyId(long companyId, boolean isAdmin ,String userName , int pageNo, int pageSize);
}
