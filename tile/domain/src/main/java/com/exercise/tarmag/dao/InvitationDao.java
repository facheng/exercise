/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.Invitation;

/**
 * @author 👤wisdom 邀约数据操作类
 */
@Repository
public class InvitationDao extends DaoImpl<Invitation, Long> implements
		IInvitationDao {

	@Override
	public List<Map<String, Object>> findInvitations(Map<String, Object> params, int pageNo) {
		StringBuffer sqlbuf = new StringBuffer(
				"SELECT I.ID id, I.VISIT_TIME visitTime,I.DEADLINE_TIME deadlineTime,R.HEAD_IMG headImg,R.USER_NAME userName,R.PHONE_NUM phoneNum,CONCAT(U.ADDRESS,U.UNIT_NAME,S.STORY_NUM, '栋', H.DY_CODE, H.ROOM_NUM) address FROM DT_INVITATION I, DT_RESIDENT R,DT_HOUSE H INNER JOIN DT_STORY S ON H.STORY_ID=S.ID AND S.DELETED='N' INNER JOIN DT_UNIT U ON U.DELETED='N' AND H.UNIT_ID=U.ID WHERE I.DELETED='N' AND I.HOUSE_ID=H.ID AND R.ID=I.INVITEE_ID ");
		// 获取发起的邀约列表
		if (params.containsKey("inviterId")) {
			sqlbuf.append(" AND I.INVITER_ID=:inviterId");
			if (params.containsKey("houseId")) {
				sqlbuf.append(" AND I.HOUSE_ID=:houseId");
			}
		}

		// 获取收到的邀约列表
		if (params.containsKey("inviteeId")) {
			sqlbuf.append(" AND I.INVITEE_ID=:inviteeId AND R.ID=I.INVITEE_ID");
		}
		sqlbuf.append(" ORDER BY I.CREATE_TIME DESC");
		return this.queryForMapList(sqlbuf.toString(),pageNo==0?1:pageNo,10, params);
	}

	@Override
	public Map<String, Object> findInvitation(Long id) {
		String sql = "SELECT R.USER_NAME userName, R.PHONE_NUM phoneNum, I.VISIT_TIME visitTime, I.DEADLINE_TIME deadlineTime, I.MESSAGE message FROM DT_INVITATION I INNER JOIN DT_RESIDENT R ON I.INVITEE_ID=R.ID AND R.DELETED='N' WHERE I.DELETED='N' AND I.ID=?";
		List<Map<String, Object>> lists = this.queryForMapList(sql, id);
		return lists == null || lists.isEmpty() ? new HashMap<String, Object>() : lists.get(0);
	}

	@Override
	public Map<String, Object> findReceptionInvitation(Long id) {
		String sql = "SELECT I.DEADLINE_TIME deadlineTime, CONCAT(DATE_FORMAT(I.VISIT_TIME, '%Y.%m.%d %H:%m'),' - ',DATE_FORMAT(I.DEADLINE_TIME, '%m.%d %H:%m')) visitTime, CONCAT(U.ADDRESS,U.UNIT_NAME,S.STORY_NUM, '栋', H.DY_CODE, H.ROOM_NUM) visitAddress, I.QR_CODE qrCode,I.MESSAGE message, S.LANTITUDE lantitude, S.LONGITUDE longitude, I.HOUSE_ID houseId,I.CREATE_TIME createTime,R.USER_NAME userName FROM DT_INVITATION I, DT_RESIDENT R,DT_HOUSE H INNER JOIN DT_STORY S ON H.STORY_ID=S.ID AND S.DELETED='N' INNER JOIN DT_UNIT U ON U.DELETED='N' AND H.UNIT_ID=U.ID WHERE R.id = I.INVITEE_ID AND I.HOUSE_ID = H.ID AND I.DELETED='N' AND I.ID=?";
		List<Map<String, Object>> lists = this.queryForMapList(sql, id);
		return lists == null || lists.isEmpty() ? new HashMap<String, Object>() : lists.get(0);
	}
}
