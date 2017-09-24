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
public interface IBroadcastReaderService {

	/**
	 * 获取用户所有的公告
	 * 
	 * @param unitId
	 *            小区id
	 * @param residentId
	 *            用户id
	 * @return
	 */
	public List<Map<String, Object>> broadcasts(Long unitId, Long residentId, int pageNo);

	/**
	 * 获取公告明细
	 * 
	 * @param id
	 *            公告id
	 * @param residentId
	 *            用户id
	 * @return
	 */
	public Map<String, Object> broadcast_tx(Long id, Long residentId);

	/**
	 * 清除已读
	 * @param residentId
	 * @param unitId 
	 */
	public void clean_tx(Long residentId, Long unitId);

}
