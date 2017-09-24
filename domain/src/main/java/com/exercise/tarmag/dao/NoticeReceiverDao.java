package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.NoticeReceiver;

/**
 * @author yuwei
 * @Time 2015-7-6下午07:05:34
 */
@Repository
public class NoticeReceiverDao extends DaoImpl<NoticeReceiver, Long> implements
		INoticeReceiverDao {

	@Override
	public NoticeReceiver getNoticeReceiver(Long noticeId, Long residentId){
		String sql = "SELECT * FROM DT_NOTICE_RECEIVER NR WHERE NOTICE_ID=? AND RESIDENT_ID=?";
		return this.queryForObject(sql, NoticeReceiver.class, noticeId, residentId);
	}

	@Override
	public int getReadCountByNoticeId(long noticeId) {
		String sql = "SELECT COUNT(ID) FROM DT_NOTICE_RECEIVER WHERE NOTICE_ID = ? AND IS_READ = ? AND DELETED = ?";
		return queryCount(sql, new Object[]{noticeId, true, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<NoticeReceiver> getNoticeReadList(long noticeId, int pageNo, int pageSize) {
		String sql = "SELECT * FROM DT_NOTICE_RECEIVER WHERE NOTICE_ID = ? AND IS_READ = ? AND DELETED = ? ORDER BY READ_TIME DESC";
		return query(sql, NoticeReceiver.class, pageNo, pageSize, new Object[]{noticeId, true, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public List<Map<String, Object>> getPushVos(long broadcastId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select br.ID id,b.TITLE content,'1' type,br.RESIDENT_ID userId,dm.APP_TYPE appType,dm.N_TOKEN nToken,dm.DEVICE_MODEL deviceModel,dm.DEVICE_TYPE deviceType ");
		sql.append("from DT_NOTICE_RECEIVER br ");
		sql.append("left join DT_NOTICE b on b.ID = br.NOTICE_ID ");
		sql.append("inner join DT_DEVICE_MANAGE dm on dm.USER_ID = br.RESIDENT_ID ");
		sql.append("where br.NOTICE_ID = ? ");
		return this.queryForMapList(sql.toString(), broadcastId);
	}
}
