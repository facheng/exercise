package com.dt.tarmag.service;


import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;

/**
 * App 点击率
 *
 * @author jiaosf
 * @since 2015-7-30
 */
public interface IAppClickRecService {
	
	/**
	 * 获取点击率列表
	 * @param filterEmpty
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findAppClickRec(Page page);
	
	/**
	 * 统计APP点击率总数
	 * @return
	 */
	public long getSumAppClickRec();
	

}
