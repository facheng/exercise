package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Repair;
import com.dt.tarmag.vo.RepairSearchVo;


/**
 * @author yuwei
 * @Time 2015-7-19上午10:03:27
 */
public interface IRepairDao extends Dao<Repair, Long> {
	/**
	 * 查询指定状态的报修条数
	 * @param statusList
	 * @return
	 */
	int getRepairRecCount(long unitId, List<Byte> statusList);
	/**
	 * 查询指定状态的报修
	 * @param statusList
	 * @return
	 */
	List<Repair> getRepairRecList(long unitId, List<Byte> statusList, int pageNo, int pageSize);
	/**
	 * 查询报修条数
	 * @return
	 */
	int getRepairCount(long unitId, RepairSearchVo searchVo, List<Byte> defaultStatusList);
	/**
	 * 查询报修
	 * @return
	 */
	List<Repair> getRepairList(long unitId, RepairSearchVo searchVo, List<Byte> defaultStatusList, int pageNo, int pageSize);
	
	/**
	 * 查询维修人个数
	 * @param unitId
	 * @param status
	 * @param defaultStatusList
	 * @param year
	 * @param month
	 * @return
	 */
	int getRepairWorkersCount(long unitId, Byte status, List<Byte> defaultStatusList, int year, int month);
	/**
	 * 查询维修人(按维修总件数倒序)
	 * @param unitId
	 * @param status
	 * @param defaultStatusList
	 * @param year
	 * @param month
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getRepairWorkerList(long unitId, Byte status, List<Byte> defaultStatusList, int year, int month, int pageNo, int pageSize);

	/**
	 * 获取报修列表
	 * @param unitId 小区id
	 * @param residentId 用户id 
	 * @param status 进行中和已结束  1进行中 2已结束 
	 * @return
	 */
	List<Map<String, Object>> repairs(Long unitId, Long residentId, byte status, int pageNo);
	
	/**
	 * 查询指定维修人员的维修记录数
	 * @return
	 */
	int getRepairStatisticCount(long unitId, long workerId, List<Byte> statusList);
	/**
	 * 查询指定维修人员的维修记录
	 * @return
	 */
	List<Repair> getRepairStatisticList(long unitId, long workerId, List<Byte> statusList, int pageNo, int pageSize);
	/**
	 * 获取报修的评论
	 * @param repairId
	 * @return
	 */
	List<Map<String, Object>> comments(Long repairId);
	
	/**
	 * 获取维修人员保修列表
	 * @param workerId 当前id
	 * @param status 1 进行中 2已完成
	 * @param pageNo 页码
	 * @return
	 */
	List<Map<String, Object>> reparis(Long workerId, int status, int pageNo);
}
