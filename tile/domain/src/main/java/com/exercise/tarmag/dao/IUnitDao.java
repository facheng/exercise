package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Unit;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
public interface IUnitDao extends Dao<Unit, Long> {
	/**
	 * 根据条件获取小区
	 * @param unit
	 * @return
	 */
	public List<Unit> getUnits(Map<String, Object> params); 
	
	/**
	 * 分页获取获取小区
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getPageUnit(int pageNo, int pageSize ,Map<String, Object> params);
	
	/**
	 * 获取小区总数
	 * @param params
	 * @return
	 */
	int getCountUnit(Map<String, Object> params);
	
	/**
	 *根据 id 获取小区
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getUnitById(Map<String, Object> params);
	
	/**
	 * 获取默认的小区
	 * @param residentId 用户id
	 * @return
	 */
	Unit getDefaultUnit(Long residentId);
	/**
	 * 根据组织ID查小区集合(包括下级组织的小区)
	 * @param branchId
	 * @param companyId
	 * @return
	 */
	List<Unit> getUnitsByBranchId(long branchId, long companyId);
	
}
