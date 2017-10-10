package com.dt.tarmag.dao;



import java.util.Date;
import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ProfitBalanceIn;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:39:05
 */
public interface IProfitBalanceInDao extends Dao<ProfitBalanceIn, Long> {
	/**
	 * 查询反润结算信息
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> findPageProfitBalanceIn( long ecomId, Date startTime, Date endTime,String status, int pageNo, int pageSize);
	
	/**
	 * 
	 *	查询反润结算信息个数
	 * @param searchVo 查询条件
	 */
	public int getProfitBalanceInCount( long ecomId, Date startTime, Date endTime,String status);
}
