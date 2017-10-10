package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Notice;

/**
 * @author yuwei
 * @Time 2015-7-6下午07:03:23
 */
@Repository
public class NoticeDao extends DaoImpl<Notice, Long> implements INoticeDao {

	@Override
	public List<Map<String, Object>> notices(Map<String, Object> params, int pageNo) {

		StringBuffer sqlbuf = new StringBuffer(
				"SELECT N.ID id, N.TITLE title, N.CREATE_DATE_TIME createDateTime, CASE NR.IS_READ WHEN 1 THEN '1' ELSE '0' END isRead, N.FROM_TYPE fromType FROM DT_NOTICE N, DT_NOTICE_RECEIVER NR WHERE NR.DELETED='N' AND N.ID=NR.NOTICE_ID AND N.DELETED='N'");
		if (params.containsKey("residentId")) {
			sqlbuf.append(" AND NR.RESIDENT_ID=:residentId");
		}

		if (params.containsKey("unitId")) {
			sqlbuf.append(" AND N.UNIT_ID=:unitId");
		}
		return this.queryForMapList(sqlbuf.toString(),pageNo ==0 ?1 : pageNo,10, params);
	}

	@Override
	public void clean(Long unitId, Long residentId) {
		String sql = "UPDATE DT_NOTICE_RECEIVER DR SET DR.DELETED='Y' WHERE DR.IS_READ=? AND DR.RESIDENT_ID=? AND DR.NOTICE_ID IN (SELECT ID FROM DT_NOTICE WHERE UNIT_ID=?)";
		this.execute(sql, 1, residentId, unitId);
	}


	@Override
	public int getNoticeCount(long unitId, Byte type) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_NOTICE ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (type != null) {
			sql.append(" AND FROM_TYPE = :fromType ");
			params.put("fromType", type);
		}
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Notice> getNoticeList(long unitId, Byte type, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append(" SELECT * ")
		   .append(" FROM DT_NOTICE ")
		   .append(" WHERE UNIT_ID = :unitId AND DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (type != null) {
			sql.append(" AND FROM_TYPE = :fromType ");
			params.put("fromType", type);
		}
		
		sql.append(" ORDER BY (CASE WHEN UPDATE_DATE_TIME IS NOT NULL THEN UPDATE_DATE_TIME ELSE CREATE_DATE_TIME END) DESC ");
		return query(sql.toString(), Notice.class, pageNo, pageSize, params);
	}
}
