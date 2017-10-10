/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.INoticeDao;
import com.dt.tarmag.dao.INoticeReceiverDao;
import com.dt.tarmag.model.NoticeReceiver;
import com.dt.tarmag.util.DateUtils;
import com.dt.tarmag.util.Params;

/**
 * @author 👤wisdom
 *
 */
@Service
public class NoticeService implements INoticeService {

	@Autowired
	private INoticeDao noticeDao;

	@Autowired
	private IHouseDao houseDao;

	@Autowired
	private INoticeReceiverDao noticeReceiverDao;

	@Override
	public List<Map<String, Object>> notices(Long residentId, Long unitId, int pageNo) {
		List<Map<String, Object>> notices = this.noticeDao.notices(Params
				.getParams("residentId", residentId, "unitId", unitId), pageNo);
		for (Map<String, Object> notice : notices) {
			DateUtils.disposeCreateDateTime(notice);
		}
		return notices;
	}

	@Override
	public Map<String, Object> notice_tx(long id, long residentId) {
		NoticeReceiver noticeReceiver = this.noticeReceiverDao
				.getNoticeReceiver(id, residentId);
		// 更新已阅状态
		if (noticeReceiver != null && !noticeReceiver.getIsRead()) {
			noticeReceiver.setIsRead(true);
			noticeReceiver.setReadTime(new Date());
			this.noticeReceiverDao.update(noticeReceiver);
		}
		Map<String, Object> notice = this.noticeDao.get(id).toMap(
				new String[] { "title", "content", "createDateTime", "fromType"});
		DateUtils.disposeCreateDateTime(notice);
		return notice;
	}

	@Override
	public void clean_tx(Long unitId, Long residentId) {
		this.noticeDao.clean(unitId, residentId);
	}
}
