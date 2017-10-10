package com.dt.tarmag.dao;


import java.util.Date;
import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.InOut;
import com.dt.tarmag.vo.InoutSearchVo;

/**
 * @author yuwei
 * @Time 2015-7-24下午02:33:49
 */
public interface IInOutDao extends Dao<InOut, Long> {
	/**
	 * 查询出入记录条数
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	int getInoutPasserbyCount(long unitId);
	
	/**
	 * 查询出入记录
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<InOut> getInoutPasserbyList(long unitId, int pageNo, int pageSize);
	
	/**
	 * 查询出入记录条数
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	int getInoutPasserbyCount(long unitId, InoutSearchVo searchVo);
	
	/**
	 * 查询出入记录
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<InOut> getInoutPasserbyList(long unitId, InoutSearchVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 按日统计行人出入记录
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getInoutPasserbyStatisticsDay(Long unitId ,InoutSearchVo searchVo);
	
	/**
	 * 按周统计行人出入记录
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getInoutPasserbyStatisticsWeek(Long unitId ,InoutSearchVo searchVo);
	
	/**
	 * 按月统计行人出入记录
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getInoutPasserbyStatisticsMonth(Long unitId ,InoutSearchVo searchVo);
	
	/**
	 * 按年统计行人出入记录
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	List<Map<String, Object>> getInoutPasserbyStatisticsYear(Long unitId ,InoutSearchVo searchVo);
	
	/**
	 * 
	 * @return
	 */
	int getNowDays();
	/**
	 * 住户是否在指定时间内使用过钥匙
	 * @param residentId
	 * @param keyId
	 * @param fromDate
	 * @param endDate
	 * @return
	 */
	boolean isUsed(long residentId, long keyId, Date fromDate, Date endDate);
}
