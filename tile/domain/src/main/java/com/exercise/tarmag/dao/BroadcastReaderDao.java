package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.BroadcastReader;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-7-6下午06:59:34
 */
@Repository
public class BroadcastReaderDao extends DaoImpl<BroadcastReader, Long> implements IBroadcastReaderDao {

	@Override
	public List<Map<String, Object>> broadcasts(Params<String, Object> params, int pageNo) {
		String sql = "SELECT B.ID id, B.TITLE title, B.FROM_TYPE fromType, B.CREATE_DATE_TIME createDateTime, CASE BR.IS_READ WHEN 1 THEN '1' ELSE '0' END isRead FROM DT_BROADCAST_READER BR,DT_BROADCAST B WHERE BR.DELETED='N' AND B.DELETED = 'N' AND BR.BROADCAST_ID=B.ID AND BR.RESIDENT_ID=:residentId AND B.UNIT_ID=:unitId";
		return this.queryForMapList(sql,pageNo==0?1:pageNo,10, params);
	}

	@Override
	public BroadcastReader getBroadcastReader(Long id, Long residentId) {
		String sql = "SELECT * FROM DT_BROADCAST_READER WHERE RESIDENT_ID=? AND BROADCAST_ID=?";
		return this.queryForObject(sql, BroadcastReader.class, residentId, id);
	}

	@Override
	public int getReadCountByBroadcastId(long broadcastId) {
		String sql = "SELECT COUNT(ID) FROM DT_BROADCAST_READER WHERE BROADCAST_ID = ? AND IS_READ = ? AND DELETED = ?";
		return queryCount(sql, new Object[] {broadcastId, true, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<BroadcastReader> getBroadcastReadList(long broadcastId, int pageNo, int pageSize) {
		String sql = "SELECT * FROM DT_BROADCAST_READER WHERE BROADCAST_ID = ? AND IS_READ = ? AND DELETED = ? ORDER BY READ_TIME DESC";
		return query(sql, BroadcastReader.class, new Object[]{broadcastId, true, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Map<String, Object>> getPushVos(long broadcastId) {
		StringBuffer sql = new StringBuffer();
		sql.append("select br.ID id,b.TITLE content,'0' type,br.RESIDENT_ID userId,dm.APP_TYPE appType,dm.N_TOKEN nToken,dm.DEVICE_MODEL deviceModel,dm.DEVICE_TYPE deviceType ");
		sql.append("from DT_BROADCAST_READER br ");
		sql.append("left join DT_BROADCAST b on b.ID = br.BROADCAST_ID ");
		sql.append("inner join DT_DEVICE_MANAGE dm on dm.USER_ID = br.RESIDENT_ID ");
		sql.append("where br.BROADCAST_ID = ? ");
		return this.queryForMapList(sql.toString(), broadcastId);
	}
}
