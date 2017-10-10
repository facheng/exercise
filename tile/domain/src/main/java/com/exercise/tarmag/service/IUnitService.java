/**
 * 
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.vo.UnitVo;

/**
 * @author raymond
 *
 */
public interface IUnitService {
	/**
	 * 根据条件获取小区
	 * @param unit
	 * @return
	 */
	public List<Map<String, Object>> getUnits(Long districtId); 
	
	/**
	 * 查询用户所有的小区
	 * @param customerId
	 * @return
	 */
	List<Map<String,Object>> getUnitListByCustmerId(long customerId);
	
	/**
	 * 查询一个用户所有的小区+角色组合(未被删除的)
	 * @param customerId
	 * @return
	 */
	List<CustomerRoleUnit> getCustomerRoleUnitList(long customerId);
	
	/**
	 * 分页获取获取小区
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> findPageUnit(int pageNo, int pageSize ,Map<String, Object> params);
	
	/**
	 * 获取小区总数
	 * @param params
	 * @return
	 */
	int findCountUnit(Map<String, Object> params);
	
	/**
	 * 
	 * 添加或修改小区
	 * @param unit
	 * @param storeURL 
	 * @param filePath 
	 * @throws Exception 
	 */
	public void saveOrUpdate_tx(UnitVo unitVo, String storeURL) throws Exception;
	
	/**
	 * 删除小区
	 * @param unit
	 */
	public void delUnit_tx(Unit unit);
	
	/**
	 *根据 id 获取小区
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> findUnitById(Map<String, Object> params);
	
	/**
	 * 根据组织ID查小区集合(包括下级组织的小区)
	 * @return
	 */
	List<Map<String, Object>> getUnitListByBranchId(long branchId);
	Unit getUnitById(long unitId);
	
	/**
	 * 获取小区信息
	 * @param unitId
	 * @return
	 */
	public Map<String, Object> findUnitInfoById(Long unitId);
}
