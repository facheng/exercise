package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CustomerRoleUnit;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:45:32
 */
public interface ICustomerRoleUnitDao extends Dao<CustomerRoleUnit, Long> {

	/**
	 * 查询指定用户所有的小区Id
	 * @param customerId
	 * @return
	 */
	List<Long> getUnitListByCustmerId(long customerId);

	/**
	 * 根据客户和小区查找角色集合
	 * @param customerId
	 * @param unitId
	 * @return
	 */
	List<Long> getRoleListByCustomerAndUnit(long customerId, long unitId);
	
	/**
	 * @param customerId
	 * @param roleId
	 * @param unitId
	 * @return
	 */
	CustomerRoleUnit getCustomerRoleUnit(long customerId, long roleId, long unitId);
	
	/**
	 * 查询一个用户所有的小区+角色组合(未被删除的)
	 * @param customerId
	 * @return
	 */
	List<CustomerRoleUnit> getCustomerRoleUnitList(long customerId);
	
	/**
	 * 查询指定角色被分配的人数
	 * @param roleId
	 * @return
	 */
	int getCountByRoleId(long roleId);
}
