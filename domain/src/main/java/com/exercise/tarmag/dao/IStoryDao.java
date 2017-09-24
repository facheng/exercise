package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Story;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:39:41
 */
public interface IStoryDao extends Dao<Story, Long> {
	/**
	 * 根据条件查询楼栋
	 * @param story
	 * @return
	 */
	public List<Story> getStorysByUnitId(Map<String, Object> params);
	
	/**
	 * 
	 * 根据楼栋编号 和小区id 获取楼栋
	 * @param story
	 * @return
	 */
	public Story getStorysByUnitIdAndStoryNmu(Story story);
	
	List<Story> getStoryListByPartitionId(long partitionId);
	List<Story> getStoryListByUnitId(long unitId);
	
	/**
	 * 统计当前小区下所有期数下的楼栋数量
	 * @param unitId
	 * @return
	 */
	public List<Map<String, Object>> getStorysCountByUnitId(Long unitId);
}
