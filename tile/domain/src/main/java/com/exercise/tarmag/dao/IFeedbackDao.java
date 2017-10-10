package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Feedback;


/**
 * @author yuwei
 * @Time 2015-7-17下午01:16:13
 */
public interface IFeedbackDao extends Dao<Feedback, Long> {
	
	/**
	 * 分页获取用户意见反馈列表
	 */
	public List<Map<String, Object>> getFeedbackList(Map<String, Object> params ,Page page);
	
	/**
	 * 获取用户意见反馈列表总数
	 * @param params
	 * @return
	 */
	public int getFeedbackListCount(Map<String, Object> params);
	
}
