/**
 * 
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.vo.RepairSearchVo;
import com.dt.tarmag.vo.RepairVo;


/**
 * @author yuwei
 * @Time 2015-7-21上午10:41:01
 */
public interface IRepairService {
	List<WorkType> getWorkTypeByType(byte type);
	/**
	 * 创建报修
	 * @param vo
	 * @return
	 */
	void createNewRepair_tx(RepairVo vo);
	/**
	 * app创建
	 * @param repair
	 * @param picPaths
	 */
	void appCreateRepair_tx(RepairVo vo,String [] picPaths);
	
	Map<String, Object> getRepairToEdit(long repairId);
	/**
	 * 修改报修
	 * @param vo
	 * @return
	 */
	void updateRepair_tx(long repairId, RepairVo vo);
	
	/**
	 * 删除报修
	 * 只能删除“待分派 ”、“已分派待接受 ”和“已拒绝”状态的报修
	 * @param repairId
	 * @return
	 */
	boolean deleteRepair_tx(long repairId);
	
	/**
	 * 根据小区期数+维修工种查询小区工作人员
	 * @param partitionId
	 * @param wtypeId
	 * @return
	 */
	List<Map<String, Object>> getWorkerListByPartitionIdAndWtypeId(long partitionId, long wtypeId);
	
	/**
	 * 查询未分派的报修条数
	 * @param searchVo
	 * @return
	 */
	int getUnAssignedRepairRecCount(long unitId, RepairSearchVo searchVo);
	/**
	 * 查询未分派的报修
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getUnAssignedRepairRecList(long unitId, RepairSearchVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 查询已分派的报修条数
	 * @param searchVo
	 * @return
	 */
	int getAssignedRepairRecCount(long unitId, RepairSearchVo searchVo);
	/**
	 * 查询已分派的报修
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getAssignedRepairRecList(long unitId, RepairSearchVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 查看报修详情
	 * @param repairId
	 * @param imgAccessUrlPre
	 * @return
	 */
	Map<String, Object> getRepairDetail(long repairId, String imgAccessUrlPre);
	
	/**
	 * 打分
	 * @param repairId
	 * @param responseScore
	 * @param doorScore
	 * @param serviceScore
	 * @param qualityScore
	 */
	void score_tx(Long repairId,int responseScore,int doorScore,int serviceScore,int qualityScore);
	/**
	 * 查看APP报修详情
	 * @param repairId
	 * @return
	 */
	Map<String, Object> getAppRepairDetail(long repairId);
	
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
	List<Map<String, Object>> getRepairStatisticList(long unitId, long workerId, List<Byte> statusList, int pageNo, int pageSize);
	/**获取保修评论列表
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
	List<Map<String, Object>> repairs(Long workerId, int status, int pageNo);
	/**
	 * 维修人员操作 
	 * @param repairId
	 * @param status 1已分派待接受，2已拒绝，3已接收，4已签到，5可修，6不可修，7已完成，8已结束
	 * @param remark
	 */
	void oper_tx(Long workerId, Long repairId, int status, String remark);
	/**
	 * 获取保修图片
	 * @param repairId 维修id
	 * @param status 状态
	 * @return
	 */
	Map<String, Object> pictures(Long workerId, Long repairId, int status);
	/**
	 * 获取评分
	 * @param repairId
	 * @return
	 */
	Map<String, Object> scores(Long repairId);
}
