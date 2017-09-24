package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.CustomerVo;

/**
 * 
物业用户
 *
 * @author Administrator
 * @since 2015年6月29日
 */
public interface ICustomerService {
	
	/**
	 * 判断登陆是否成功
	 * @param user
	 * @return 
	 */
	boolean getCustomerByLoginInfo(Customer user);

	/**
	 * 根据用户名查询用户对象
	 * @param userName
	 * @return
	 */
	Customer getCustomerByUserName(String userName);

	/**
	 * 删除用户
	 * @param ids
	 */
	void delete_tx(Long[] ids);

	/**
	 * 保存用户
	 * @param customer
	 */
	void saveCustomer_tx(Customer customer);

	/**
	 * 根据id查找用户
	 * @param id
	 * @return
	 */
	Customer findCustomerById(long id);

	/**
	 * 查找用户
	 * @param map
	 * @param page
	 * @return
	 */
	PageResult<Map<String, Object>> findCustomer(Map<String, Object> map, Page page);

	/**
	 * 验证用户名是否重复
	 * @param userName
	 */
	public boolean isRepeat(String userName);

	/**
	 * 分配模块
	 * @param id
	 */
	public Map<String, Object> allocationmodule(Long companyId);

	/**
	 * 给管理员分配模块
	 * @param roleId
	 * @param mIds
	 */
	public void alloteModule_tx(Long roleId, Long[] mIds);
	
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
	List<Map<String, Object>> getCustomerListByCompanyId(long companyId, boolean isAdmin ,String userName , int pageNo, int pageSize);
	
	/**
	 * 创建用户
	 * @param customerVo
	 * @return
	 */
	boolean createCustomer_tx(CustomerVo customerVo);
	
	/**
	 * 修改用户
	 * @param customerId
	 * @param customerVo
	 * @return
	 */
	public boolean updateCustomer_tx(long customerId, CustomerVo customerVo);
	
	/**
	 * 查询用户供编辑
	 * @param noticeId
	 * @return
	 */
	Map<String, Object> getCustomerToEdit(long customerId);
	
	void deleteCustomer_tx(long customerId);
	Map<String, Object> getCustomerDetailMap(long customerId);
}
