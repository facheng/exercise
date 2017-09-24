package com.dt.tarmag.dao;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Repair;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.RepairSearchVo;

/**
 * @author yuwei
 * @Time 2015-7-19上午10:04:04
 */
@Repository
public class RepairDao extends DaoImpl<Repair, Long> implements IRepairDao {

	@Override
	public int getRepairRecCount(long unitId, List<Byte> statusList) {
		if(statusList == null || statusList.size() <= 0) {
			return 0;
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(a.ID) ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" LEFT JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" WHERE a.STATUS IN (:statusList) ")
		   .append(" AND a.DELETED = :deleted ")
		   .append(" AND b.DELETED = :deleted ")
		   .append(" AND b.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("statusList", statusList);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Repair> getRepairRecList(long unitId, List<Byte> statusList, int pageNo, int pageSize) {
		if(statusList == null || statusList.size() <= 0) {
			return new ArrayList<Repair>();
		}

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.* ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" LEFT JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" WHERE a.STATUS IN (:statusList) ")
		   .append(" AND a.DELETED = :deleted ")
		   .append(" AND b.DELETED = :deleted ")
		   .append(" AND b.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("statusList", statusList);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		return query(sql.toString(), Repair.class, pageNo, pageSize, params);
	}

	@Override
	public int getRepairCount(long unitId, RepairSearchVo searchVo, List<Byte> defaultStatusList) {
		if(searchVo == null) {
			return getRepairRecCount(unitId, defaultStatusList);
		}
		if(defaultStatusList == null) {
			defaultStatusList = new ArrayList<Byte>();
		}
		if(defaultStatusList.size() <= 0) {
			defaultStatusList.add((byte)-1);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(DISTINCT a.ID) ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" LEFT JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" LEFT JOIN DT_STORY c ON b.STORY_ID = c.ID ")
		   .append(" WHERE a.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		if(searchVo.getRepairType() != null) {
			sql.append(" AND a.REPAIR_TYPE = :repairType ");
			params.put("repairType", searchVo.getRepairType());
		}
		
		if(searchVo.getServiceType() != null) {
			sql.append(" AND a.SERVICE_TYPE = :serviceType ");
			params.put("serviceType", searchVo.getServiceType());
		}
		
		if(searchVo.getPartitionId() != null) {
			sql.append(" AND c.PARTITION_ID = :partitionId AND b.DELETED = :deleted AND c.DELETED = :deleted ");
			params.put("partitionId", searchVo.getPartitionId());
		} else {
			sql.append(" AND a.UNIT_ID = :unitId ");
			params.put("unitId", unitId);
		}
		
		if(searchVo.getStatus() == null) {
			sql.append(" AND a.STATUS IN (:statusList) ");
			params.put("statusList", defaultStatusList);
		} else {
			sql.append(" AND a.STATUS = :status ");
			params.put("status", searchVo.getStatus());
		}
		
		if(searchVo.getUrgentState() != null) {
			sql.append(" AND a.URGENT_STATE = :urgentState ");
			params.put("urgentState", searchVo.getUrgentState());
		}
		
		if(searchVo.getRno() != null && !searchVo.getRno().trim().equals("")) {
			sql.append(" AND b.ROOM_NUM LIKE :roomNum AND b.DELETED = :deleted ");
			params.put("roomNum", "%" + searchVo.getRno().trim() + "%");
		}
		
		if(searchVo.getRname() != null && !searchVo.getRname().trim().equals("")) {
			sql.append(" AND a.RESIDENT_NAME LIKE :rname ");
			params.put("rname", "%" + searchVo.getRname().trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Repair> getRepairList(long unitId, RepairSearchVo searchVo, List<Byte> defaultStatusList, int pageNo, int pageSize) {
		if(searchVo == null) {
			return getRepairRecList(unitId, defaultStatusList, pageNo, pageSize);
		}
		if(defaultStatusList == null) {
			defaultStatusList = new ArrayList<Byte>();
		}
		if(defaultStatusList.size() <= 0) {
			defaultStatusList.add((byte)-1);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT DISTINCT a.* ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" LEFT JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" LEFT JOIN DT_STORY c ON b.STORY_ID = c.ID ")
		   .append(" WHERE a.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		if(searchVo.getRepairType() != null) {
			sql.append(" AND a.REPAIR_TYPE = :repairType ");
			params.put("repairType", searchVo.getRepairType());
		}
		
		if(searchVo.getServiceType() != null) {
			sql.append(" AND a.SERVICE_TYPE = :serviceType ");
			params.put("serviceType", searchVo.getServiceType());
		}
		
		if(searchVo.getPartitionId() != null) {
			sql.append(" AND c.PARTITION_ID = :partitionId AND b.DELETED = :deleted AND c.DELETED = :deleted ");
			params.put("partitionId", searchVo.getPartitionId());
		} else {
			sql.append(" AND a.UNIT_ID = :unitId ");
			params.put("unitId", unitId);
		}
		
		if(searchVo.getStatus() == null) {
			sql.append(" AND a.STATUS IN (:statusList) ");
			params.put("statusList", defaultStatusList);
		} else {
			sql.append(" AND a.STATUS = :status ");
			params.put("status", searchVo.getStatus());
		}
		
		if(searchVo.getUrgentState() != null) {
			sql.append(" AND a.URGENT_STATE = :urgentState ");
			params.put("urgentState", searchVo.getUrgentState());
		}
		
		if(searchVo.getRno() != null && !searchVo.getRno().trim().equals("")) {
			sql.append(" AND b.ROOM_NUM LIKE :roomNum AND b.DELETED = :deleted ");
			params.put("roomNum", "%" + searchVo.getRno().trim() + "%");
		}
		
		if(searchVo.getRname() != null && !searchVo.getRname().trim().equals("")) {
			sql.append(" AND a.RESIDENT_NAME LIKE :rname ");
			params.put("rname", "%" + searchVo.getRname().trim() + "%");
		}
		
		return query(sql.toString(), Repair.class, pageNo, pageSize, params);
	}
	
	@Override
	public int getRepairWorkersCount(long unitId, Byte status, List<Byte> defaultStatusList, int year, int month) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(DISTINCT a.WORKER_ID) ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" INNER JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted ")
		   .append(" AND b.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		
		if(status == null) {
			sql.append(" AND a.STATUS IN (:statusList) ");
			params.put("statusList", defaultStatusList);
		} else {
			sql.append(" AND a.STATUS = :status ");
			params.put("status", status);
		}
		
		if(year > 0 && month > 0) {
			sql.append(" AND YEAR(a.CREATE_DATE_TIME) = :year ")
			   .append(" AND MONTH(a.CREATE_DATE_TIME) = :month ");
			params.put("year", year);
			params.put("month", month);
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getRepairWorkerList(long unitId, Byte status, List<Byte> defaultStatusList, int year, int month, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.WORKER_ID AS workerId ")
		   .append(" ,(CASE WHEN c.USER_NAME IS NULL THEN '' ELSE c.USER_NAME END) AS workerName ")
		   .append(" ,COUNT(a.ID) AS totalCount " )
		   .append(" ,SUM(a.SCORE_RESPONSE + a.SCORE_DOOR + a.SCORE_SERVICE + a.SCORE_QUALITY) AS totalScore ")
		   .append(" ,MIN(a.SCORE_RESPONSE + a.SCORE_DOOR + a.SCORE_SERVICE + a.SCORE_QUALITY) AS minScore ")
		   .append(" ,MAX(a.SCORE_RESPONSE + a.SCORE_DOOR + a.SCORE_SERVICE + a.SCORE_QUALITY) AS maxScore ")
		   .append(" ,ROUND(AVG(a.SCORE_RESPONSE + a.SCORE_DOOR + a.SCORE_SERVICE + a.SCORE_QUALITY)) AS avgScore ")
		   .append(" FROM DT_REPAIR a ")
		   .append(" INNER JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" LEFT JOIN DT_WORKER c ON a.WORKER_ID = c.ID ")
		   .append(" WHERE a.DELETED = :deleted AND b.DELETED = :deleted ")
		   .append(" AND b.UNIT_ID = :unitId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		
		if(status == null) {
			sql.append(" AND a.STATUS IN (:statusList) ");
			params.put("statusList", defaultStatusList);
		} else {
			sql.append(" AND a.STATUS = :status ");
			params.put("status", status);
		}
		
		if(year > 0 && month > 0) {
			sql.append(" AND YEAR(a.CREATE_DATE_TIME) = :year ")
			   .append(" AND MONTH(a.CREATE_DATE_TIME) = :month ");
			params.put("year", year);
			params.put("month", month);
		}
		
		sql.append(" GROUP BY a.WORKER_ID ")
		   .append(" ORDER BY COUNT(a.ID) DESC ");
		
		return queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public List<Map<String, Object>> repairs(Long unitId, Long residentId,
			byte status, int pageNo) {
		StringBuffer sqlbuf = new StringBuffer("SELECT r.NICK_NAME nickName, r.HEAD_IMG headImg, RR.ID repairId,RR.CREATE_DATE_TIME createDateTime,RR.REMARK remark, RR.STATUS status FROM DT_REPAIR RR INNER JOIN DT_RESIDENT r ON RR.RESIDENT_ID=r.ID WHERE RR.DELETED='N'");
		Params<String, Object> params = Params.getParams();
		if(unitId != null){
			params.add("unitId", unitId);
			sqlbuf.append(" AND UNIT_ID=:unitId");
		}
		if(residentId != null){
			params.add("residentId", residentId);
			sqlbuf.append(" AND RESIDENT_ID=:residentId");
		}else{
			sqlbuf.append(" AND IS_PUBLIC='0'");
		}
		if(status == 1){//进行中
			sqlbuf.append(" AND STATUS IN(0, 1, 2, 3, 4, 5, 6, 7)");
		}else{
			sqlbuf.append(" AND STATUS=8");
		}
		sqlbuf.append(" ORDER BY RR.CREATE_DATE_TIME DESC");
		return this.queryForMapList(sqlbuf.toString(), pageNo==0?1:pageNo, 10, params);
	}
	
	@Override
	public int getRepairStatisticCount(long unitId, long workerId, List<Byte> statusList) {
		if(statusList == null) {
			statusList = new ArrayList<Byte>();
		}
		if(statusList.size() <= 0) {
			statusList.add((byte) -1);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_REPAIR ")
		   .append(" WHERE UNIT_ID = :unitId ")
		   .append(" AND WORKER_ID = :workerId ")
		   .append(" AND STATUS IN (:statusList) ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("workerId", workerId);
		params.put("statusList", statusList);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return queryCount(sql.toString(), params);
	}
	
	@Override
	public List<Repair> getRepairStatisticList(long unitId, long workerId, List<Byte> statusList, int pageNo, int pageSize) {
		if(statusList == null) {
			statusList = new ArrayList<Byte>();
		}
		if(statusList.size() <= 0) {
			statusList.add((byte) -1);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_REPAIR ")
		   .append(" WHERE UNIT_ID = :unitId ")
		   .append(" AND WORKER_ID = :workerId ")
		   .append(" AND STATUS IN (:statusList) ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("workerId", workerId);
		params.put("statusList", statusList);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return query(sql.toString(), Repair.class, pageNo, pageSize, params);
	}
	
	@Override
	public List<Map<String, Object>> comments(Long repairId){
		String sql = "SELECT RC.CONTENT content,RC.CREATE_TIME createTime,R.HEAD_IMG headImg, R.NICK_NAME nickName FROM DT_REPAIR_COMMENT RC, DT_RESIDENT R WHERE RC.RESIDENT_ID=R.ID AND RC.DELETED='N' AND R.DELETED='N' AND RC.REPAIR_ID=?";
		return this.queryForMapList(sql, repairId);
	}

	@Override
	public List<Map<String, Object>> reparis(Long workerId, int status,
			int pageNo) {
		StringBuffer sqlbuf = new StringBuffer("SELECT RR.ID repairId,RR.CREATE_DATE_TIME createDateTime,RR.REMARK remark, RR.STATUS status,CONCAT(U.UNIT_NAME, H.DY_CODE) address FROM DT_REPAIR RR INNER JOIN DT_UNIT U ON U.ID=RR.UNIT_ID AND U.DELETED='N' INNER JOIN DT_HOUSE H ON H.DELETED='N' AND H.ID=RR.HOUSE_ID WHERE RR.DELETED='N'");
		Params<String, Object> params = Params.getParams();
		if(workerId != null){
			params.add("workerId", workerId);
			sqlbuf.append(" AND RR.WORKER_ID=:workerId");
		}else{
			sqlbuf.append(" AND RR.IS_PUBLIC='0'");
		}
		if(status == 1){//进行中
			sqlbuf.append(" AND RR.STATUS IN(1, 3, 4, 5)");
		}else{
			sqlbuf.append(" AND RR.STATUS=8");
		}
		sqlbuf.append(" ORDER BY RR.CREATE_DATE_TIME DESC");
		return this.queryForMapList(sqlbuf.toString(), pageNo==0?1:pageNo, 10, params);
	}
}
