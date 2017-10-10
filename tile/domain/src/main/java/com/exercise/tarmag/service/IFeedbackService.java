package com.dt.tarmag.service;

import java.util.Map;


import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;

public interface IFeedbackService {
	
	/**
	 * 获取用户意见反馈列表
	 * @param params
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findFeedbackList(Map<String, Object> params, Page page);
	
	/**
	 * 意见反馈删除
	 * @param ids
	 */
	public void delete_tx(Long[] ids);

}
