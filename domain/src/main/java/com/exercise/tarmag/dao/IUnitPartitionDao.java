package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.UnitPartition;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:35
 */
public interface IUnitPartitionDao extends Dao<UnitPartition, Long> {
	
	/**
	 * 分页获取获取小区期数
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> getPageUnitPartition(int pageNo, int pageSize ,Map<String, Object> params);
	
	/**
	 * 获取小区期数总数
	 * @param params
	 * @return
	 */
	int getCountUnitPartition(Map<String, Object> params);
	
	/**
	 * 根据id查询
	 * @param id
	 * 		主键
	 * @return
	 */
	public List<Map<String, Object>> getUnitPartitionById(Long id);

	/**
	 * 根据小区ID和片区名称查询片区
	 * @param unitId
	 * @param partitionName
	 * @return
	 */
	public UnitPartition getPartitionByUnitIdAndPartitionName(Long unitId, String partitionName);
	
	/**
	 * 查询当前小区下所有期数
	 * @param unitId
	 * @return
	 */
	public List<UnitPartition> getUnitPartitionListByUnitId(long unitId);
	
}
