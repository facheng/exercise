package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitConsumeRecVo;

/**
 * 从电商处获得的消费日志
 * @author wangfacheng
 * @time 2015年8月18日10:35:06
 */

public interface IProfitConsumeRecService {

	/**
	 * 根据条件分页查询电商消费日志
	 * @return
	 */
	public PageResult<Map<String, Object>> findPageProfitConsumeRec(ProfitConsumeRecVo searchVo , Page page);
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额和反润金额
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	
	public List<Map<String, Object>> getProfitConsumeRecsAmount(String startTime, String endTime, Long ecomId, Long companyId);
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额,以小区分组
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByUnit(Long balanceOutId ,String unitName , int pageNo, int pageSize);
	
	/**
	 * 
	 *	查询物业公司所属小区在相应时间内所有消费金额,以小区分组个数
	 * @param searchVo 查询条件
	 */
	public int getProfitConsumeRecsAmountGroupByUnitCount(Long balanceOutId ,String unitName);
	
	/**
	 * 查询物业公司所属小区所有住户在相应时间内所有消费金额,以小区分组
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param companyId
	 * @return
	 */
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByResident(String startTime, String endTime, Long ecomId, Long unitId  ,int pageNo, int pageSize);
	
	/**
	 * 
	 *	 查询物业公司所属小区所有住户在相应时间内所有消费金额,以小区分组个数
	 * @param startTime
	 * @param endTime
	 * @param ecomId
	 * @param unitId
	 */
	public int getProfitConsumeRecsAmountGroupByResidentCount(String startTime, String endTime, Long ecomId, Long unitId);
}
