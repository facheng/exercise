/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IBroadcastDao;
import com.dt.tarmag.dao.IBroadcastReaderDao;
import com.dt.tarmag.model.BroadcastReader;
import com.dt.tarmag.util.DateUtils;
import com.dt.tarmag.util.Params;

/**
 * @author 👤wisdom
 *
 */

@Service
public class BroadcastReaderService implements IBroadcastReaderService {

	@Autowired
	private IBroadcastReaderDao broadcastReaderDao;

	@Autowired
	private IBroadcastDao broadcastDao;

	@Override
	public List<Map<String, Object>> broadcasts(Long unitId, Long residentId, int pageNo) {
		List<Map<String, Object>> broadcasts = this.broadcastReaderDao
				.broadcasts(Params.getParams("unitId", unitId, "residentId",
						residentId), pageNo);
		for (Map<String, Object> broadcast : broadcasts) {
			DateUtils.disposeCreateDateTime(broadcast);
		}
		return broadcasts;
	}

	@Override
	public Map<String, Object> broadcast_tx(Long id, Long residentId) {
		BroadcastReader broadcastReader = this.broadcastReaderDao
				.getBroadcastReader(id, residentId);
		if (broadcastReader != null && !broadcastReader.getIsRead()) {
			broadcastReader.setIsRead(true);
			broadcastReader.setReadTime(new Date());
			this.broadcastReaderDao.update(broadcastReader);
		}
		// 获取明细
		Map<String, Object> broadcast = this.broadcastDao.get(id).toMap(
				new String[] { "title", "content", "createDateTime" , "fromType"});
		DateUtils.disposeCreateDateTime(broadcast);
		return broadcast;
	}

	@Override
	public void clean_tx(Long residentId, Long unitId) {
		this.broadcastDao.clean(residentId, unitId);
	}
}
