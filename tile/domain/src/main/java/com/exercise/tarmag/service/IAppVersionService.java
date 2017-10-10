/**
 * 
 */
package com.dt.tarmag.service;

import java.util.Map;


/**
 * @author yuwei
 * @Time 2015-6-27下午05:54:08
 */
public interface IAppVersionService {
	/**
	 * 取得客户端APP最新版本
	 * @param type
	 * @return
	 */
	Map<String, Object> getCurrentAppVersion(int type);
}
