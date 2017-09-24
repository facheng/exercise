package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.ProfitPer;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:42:39
 */
public interface IProfitPerDao extends Dao<ProfitPer, Long> {
	
	/**
	 * 获取物业结算列表
	 * @param map 
	 * @param page
	 * @return
	 */
	List<Map<String, Object>> getPropertyProfitList(Map<String, Object> params, Page page);
	
	/**
	 * 获取物业结算列表总数
	 * @param map
	 * @return
	 */
	int getPropertyProfitListCount(Map<String, Object> params);
	
	/**
	 * 根据公司查询返润率
	 * @param id
	 * @return
	 */
	public ProfitPer getProfitPerByCompanyId(long id);
	
}
