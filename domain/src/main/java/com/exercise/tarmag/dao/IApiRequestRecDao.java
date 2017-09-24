package com.dt.tarmag.dao;




import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.ApiRequestRec;


/**
 * @author yuwei
 * @Time 2015-7-19上午11:39:49
 */
public interface IApiRequestRecDao extends Dao<ApiRequestRec, Long> {
	/**
	 * 查询指定用户最近一次登录记录
	 * @param residentId
	 * @return
	 */
	ApiRequestRec getLatestLoginRec(long residentId);

	/**
	 * 查询统计在线时长
	 * @return
	 */
	long getOnLineTime();
	
	/**
	 * 按用户返回登录时长
	 * @param params
	 * @param page
	 * @return
	 */
	public List<Map<String, Object>> getApiRequestRec(Map<String, Object> params, Page page);
	
	/**
	 * 按用户返回登录时长记录总数
	 * @param params
	 * @return
	 */
	public int getApiRequestRecCount(Map<String, Object> params);
}
