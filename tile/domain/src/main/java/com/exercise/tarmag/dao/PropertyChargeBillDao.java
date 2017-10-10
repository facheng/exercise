package com.dt.tarmag.dao;


import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.vo.PropertyChargeBillSearchVo;


/**
 * @author yuwei
 * @Time 2015-8-21上午10:00:18
 */
@Repository
public class PropertyChargeBillDao extends DaoImpl<PropertyChargeBill, Long> implements IPropertyChargeBillDao {

	@Override
	public int getPropertyChargeCount(Long unitId, PropertyChargeBillSearchVo pblSearchVo) {
		StringBuffer sql = new StringBuffer("");
		
		sql.append("SELECT COUNT(*)");
		sql.append(" FROM DT_PROPERTY_CHARGE_BILL A INNER JOIN DT_HOUSE B ON A.HOUSE_ID = B.ID");
		sql.append(" WHERE B.UNIT_ID = :unitId AND A.DELETED = :deleted");
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("unitId", unitId);
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		
		Date startTime = pblSearchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			paramsMap.put("startTime", startTime);
		}
		
		Date endTime = pblSearchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			paramsMap.put("endTime", endTime);
		}
		
		if(StringUtils.isNotBlank(pblSearchVo.getRoomNum())) {
			sql.append(" AND B.ROOM_NUM LIKE :roomNum");
			paramsMap.put("roomNum", "%" + pblSearchVo.getRoomNum().trim() + "%");
		}
		
		if(pblSearchVo.getStatus() != null) {
			sql.append(" AND A.STATUS = :status ");
			paramsMap.put("status", pblSearchVo.getStatus());
		}
		
		return this.queryCount(sql.toString(), paramsMap);
	}

	@Override
	public List<Map<String, Object>> getPropertyChargeList(
			Long unitId,
			PropertyChargeBillSearchVo pblSearchVo,
			Integer pageNo,
			Integer pageSize) {
		StringBuffer sql = new StringBuffer("");
		
		sql.append("SELECT A.ID id ,A.START_DATE startDate ,A.END_DATE endDate,A.AMOUNT amount ,A.REMIND_TIMES  remindTimes ,A.STATUS status ,B.ROOM_NUM roomNum ,A.CREATE_DATE_TIME createtime");
		sql.append(" FROM DT_PROPERTY_CHARGE_BILL A INNER JOIN DT_HOUSE B ON A.HOUSE_ID = B.ID");
		sql.append(" WHERE B.UNIT_ID = :unitId AND A.DELETED = :deleted");
		
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("unitId", unitId);
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		
		Date startTime = pblSearchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			paramsMap.put("startTime", startTime);
		}
		
		Date endTime = pblSearchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			paramsMap.put("endTime", endTime);
		}
		
		if(StringUtils.isNotBlank(pblSearchVo.getRoomNum())) {
			sql.append(" AND B.ROOM_NUM LIKE :roomNum");
			paramsMap.put("roomNum", "%" + pblSearchVo.getRoomNum().trim() + "%");
		}
		
		if(pblSearchVo.getStatus() != null) {
			sql.append(" AND A.STATUS = :status ");
			paramsMap.put("status", pblSearchVo.getStatus());
		}
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, paramsMap);
	}
	
}
