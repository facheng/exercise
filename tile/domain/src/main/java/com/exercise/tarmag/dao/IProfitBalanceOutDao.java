package com.dt.tarmag.dao;



import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ProfitBalanceOut;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:40:21
 */
public interface IProfitBalanceOutDao extends Dao<ProfitBalanceOut, Long> {

	/**
	 * 查询指定物业公司的反润记录数
	 * @param companyId
	 * @param status
	 * @return
	 */
	int getProfitCountByCompanyId(long companyId, Byte status);
	/**
	 * 查询指定物业公司的反润记录(按时间倒序)
	 * @param companyId
	 * @param status
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<ProfitBalanceOut> getProfitListByCompanyId(long companyId, Byte status, int pageNo, int pageSize);
	
	/**
	 * 根据ID查询物业返润记录
	 * @param id
	 * @return
	 */
	public ProfitBalanceOut getPropertyProfitById(Long id);
}
