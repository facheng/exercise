package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.FocusResident;
import com.dt.tarmag.model.HouseResident;

/**
 * @author yuwei
 * @Time 2015-7-17下午07:29:07
 */
@Repository
public class FocusResidentDao extends DaoImpl<FocusResident, Long> implements IFocusResidentDao {

	@Override
	public List<Map<String, Object>> getFocusResidentList(Map<String, Object> mapParams,
			Integer pageNo, Integer pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.*,D.ROOM_NUM , D.ID houseId , C.USER_NAME ,C.PHONE_NUM FROM DT_FOCUS_RESIDENT A INNER JOIN DT_HOUSE_RESIDENT B ON A. HR_ID = B.ID INNER JOIN DT_RESIDENT C ON B.RESIDENT_ID = C.ID INNER JOIN DT_HOUSE D ON B.HOUSE_ID = D.ID WHERE D.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = 'N'");
		sql.append(" AND B.TYPE IN (" + HouseResident.TYPE_OWNER + "," + HouseResident.TYPE_FAMILY_MEMBER + ")");
		if(mapParams.containsKey("roomNum")){
			sql.append(" AND D.ROOM_NUM=:roomNum");
		}
		
		if(mapParams.containsKey("residentStatus")){
			sql.append(" AND A.RESIDENT_STATUS=:residentStatus");
		}
		
		sql.append(" ORDER BY A.ID DESC");
		List<Map<String, Object>> list = queryForMapList(sql.toString(), pageNo , pageSize , mapParams);
		return list;
	}

	@Override
	public int getFocusResidentList(Map<String, Object> mapParams) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(1) FROM DT_FOCUS_RESIDENT A INNER JOIN DT_HOUSE_RESIDENT B ON A. HR_ID = B.ID INNER JOIN DT_RESIDENT C ON B.RESIDENT_ID = C.ID INNER JOIN DT_HOUSE D ON B.HOUSE_ID = D.ID WHERE D.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = 'N'");
		sql.append(" AND B.TYPE IN ( " + HouseResident.TYPE_OWNER + "," + HouseResident.TYPE_FAMILY_MEMBER + ")");
		if(mapParams.containsKey("roomNum")){
			sql.append(" AND D.ROOM_NUM=:roomNum");
		}
		
		if(mapParams.containsKey("residentStatus")){
			sql.append(" AND A.RESIDENT_STATUS=:residentStatus");
		}
		
		int count = queryCount(sql.toString(), mapParams);
		return count;
	}

	@Override
	public List<Map<String, Object>> getFocusResidentInfo(long hrId) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.* ,B.ID hrId,C.ID houseId,D.ID storyId,E.ID partitionId FROM DT_FOCUS_RESIDENT A ");
		sql.append(" INNER JOIN DT_HOUSE_RESIDENT B ON A.HR_ID = B.ID");
		sql.append(" INNER JOIN DT_HOUSE C ON B.HOUSE_ID = C.ID");
		sql.append(" INNER JOIN DT_STORY D ON C.STORY_ID = D.ID");
		sql.append(" INNER JOIN DT_UNIT_PARTITION E ON D.PARTITION_ID = E.ID");
		sql.append(" WHERE A.HR_ID =?");
		return queryForMapList(sql.toString(), hrId);
	}

	@Override
	public List<FocusResident> getfocusResidentByHrId(long hrId) {
		String sql = "SELECT * FROM `dt_focus_resident` A WHERE A.`HR_ID` = ? AND A.`DELETED` = 'N'";
		
		return query(sql ,FocusResident.class ,hrId);
	}
	
}
