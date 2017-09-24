/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

/**
 * @author 👤wisdom
 *
 */
public interface INoticeService {
	/**
	 * 获取通知列表
	 * @param residentId 用户id
	 * @param unitId 
	 * @return
	 */
	public List<Map<String, Object>> notices(Long residentId, Long unitId, int pageNo);

	/**
	 * 查阅通知公告
	 * @param id 通知公告的id
	 * @param residentId 用户id
	 * @return
	 */
	public Map<String, Object> notice_tx(long id, long residentId);

	/**
	 * 清空已读
	 * @param unitId 小区id
	 * @param residentId 用户id
	 */
	public void clean_tx(Long unitId, Long residentId);
}
