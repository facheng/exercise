package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Broadcast;


/**
 * @author yuwei
 * @Time 2015-7-6下午06:58:56
 */
public interface IBroadcastDao extends Dao<Broadcast, Long> {
	/**
	 * 查询小区的公告条数
	 * @param unitId
	 * @param type
	 * @return
	 */
	int getBroadcastCount(long unitId, Byte type);
	/**
	 * 查询小区的公告
	 * @param unitId
	 * @param type
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Broadcast> getBroadcastList(long unitId, Byte type, int pageNo, int pageSize);
	/**
	 * 清除已读的公告
	 * @param residentId
	 * @param unitId
	 */
	void clean(Long residentId, Long unitId);
}
