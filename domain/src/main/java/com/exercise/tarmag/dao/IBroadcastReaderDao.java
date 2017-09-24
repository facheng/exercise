package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.BroadcastReader;
import com.dt.tarmag.util.Params;


/**
 * @author yuwei
 * @Time 2015-7-6下午06:58:56
 */
public interface IBroadcastReaderDao extends Dao<BroadcastReader, Long> {

	/**
	 * 获取公告列表
	 * @param params
	 * @return
	 */
	public List<Map<String, Object>> broadcasts(Params<String, Object> params, int pageNo);
	
	/**
	 * 公告是否已阅读
	 * @param id 公告id
	 * @param residentId 用户id
	 * @return
	 */
	public BroadcastReader getBroadcastReader(Long id, Long residentId);
	
	/**
	 * 查询指定公告被阅读次数
	 * @param broadcastId
	 * @return
	 */
	int getReadCountByBroadcastId(long broadcastId);
	
	/**
	 * 查询公告已读记录
	 * @param broadcastId
	 * @return
	 */
	List<BroadcastReader> getBroadcastReadList(long broadcastId, int pageNo, int pageSize);
	
	/**
	 * 通过id串查询需要推送的数据
	 * @param broadcastId
	 * @return
	 */
	List<Map<String, Object>> getPushVos(long broadcastId);
}
