package com.dt.tarmag.dao;



import java.util.Date;
import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ProfitConsumeRec;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:41:31
 */
public interface IProfitConsumeRecDao extends Dao<ProfitConsumeRec, Long> {
	
	/**
	 * 根据时间获取电商日志列表
	 * @param ecomId 电商id
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 * @return
	 */
	public List<ProfitConsumeRec> findProfitConsumeRecs(long ecomId, Date startTime, Date endTime);
	
	/**
	 * 查询电商信息
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> findPageProfitConsumeRecs( long ecomId, Date startTime, Date endTime, int pageNo, int pageSize);
	
	/**
	 * 
	 *	查询电商信息个数
	 * @param searchVo 查询条件
	 */
	public int getProfitConsumeRecsCount( long ecomId, Date startTime, Date endTime);
	
	ProfitConsumeRec getProfitConsumeRec(long ecomId, String orderId);
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额和反润金额
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	public List<Map<String, Object>> getProfitConsumeRecsAmount(Date startTime ,  Date endTime , Long ecomId , Long companyId);
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额,以小区分组
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByUnit(Date startTime ,  Date endTime , Long ecomId , Long companyId , String unitName,int pageNo, int pageSize);
	
	/**
	 * 
	 *	查询物业公司所属小区在相应时间内所有消费金额,以小区分组个数
	 * @param searchVo 查询条件
	 */
	public int getProfitConsumeRecsAmountGroupByUnitCount(Date startTime ,  Date endTime , Long ecomId , Long companyId , String unitName);
	
	/**
	 * 查询物业公司所属小区所有住户在相应时间内所有消费金额,以小区分组
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByResident(Date startTime ,  Date endTime , Long ecomId , Long unitId ,int pageNo, int pageSize);
	
	/**
	 * 
	 *	 查询物业公司所属小区所有住户在相应时间内所有消费金额,以小区分组个数
	 * @param searchVo 查询条件
	 */
	public int getProfitConsumeRecsAmountGroupByResidentCount(Date startTime ,  Date endTime , Long ecomId , Long unitId);
}
