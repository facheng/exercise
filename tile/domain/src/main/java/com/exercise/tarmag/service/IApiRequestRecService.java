package com.dt.tarmag.service;

import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;




/**
 * API 接口访问记录
 *
 * @author jiaosf
 * @since 2015-7-30
 */
public interface IApiRequestRecService {
	
	/**
	 *  统计当前所有帐号在线时长
	 * @return
	 */
	public String geTimeCount();
	
	
	/**
	 * 按帐号统计在线时长
	 * @param params
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findApiRequestRec(Map<String, Object> params, Page page);

}
