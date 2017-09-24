package com.dt.tarmag.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.HouseResident;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class HouseResidentDao extends DaoImpl<HouseResident, Long> implements
		IHouseResidentDao {

	@Override
	public List<Map<String, Object>> getBindHouses(Long residentId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT HR.ID id ")
				.append(",concat(U.ADDRESS,S.STORY_NUM,H.ROOM_NUM,'室') houseAddress ")
				.append(",HR.IS_DEFAULT isDefault ")
				.append(",C.CITY_NAME city ")
				.append(",C.ID cityId ")
				.append(",D.DISTRICT_NAME district ")
				.append(",D.ID districtId ")
				.append(",P.PROVINCE_NAME province ")
				.append(",P.ID provinceId ")
				.append(",U.ID unitId ")
				.append(",U.UNIT_NAME unitName ")
				.append(",S.STORY_NUM storyNum ")
				.append(",S.ID storyId ")
				.append(",H.DY_CODE dyCode ")
				.append(",H.ROOM_NUM roomNum ")
				.append(",HR.TYPE role ")
				.append(",HR.IS_APPROVED isApproved ")
				.append(",U.APP_BACKGROUND_IMG appBackgroundImg ")
				//.append(",CASE HR.TYPE WHEN 0 THEN '业主' WHEN 1 THEN '家属' WHEN 2 THEN '租客' END role ")
				.append(" FROM DT_HOUSE H ")
				.append(" INNER JOIN DT_HOUSE_RESIDENT HR ON H.ID = HR.HOUSE_ID AND HR.DELETED = 'N'")
				.append(" INNER JOIN DT_STORY S ON S.ID = H.STORY_ID AND S.UNIT_ID=H.UNIT_ID AND S.DELETED = 'N' ")
				.append(" INNER JOIN DT_UNIT U ON H.UNIT_ID = U.ID AND U.DELETED = 'N' ")
				.append(" INNER JOIN DT_DISTRICT D ON U.DISTRICT_ID = D.ID ")
				.append(" INNER JOIN DT_CITY C ON C.ID = D.CITY_ID ")
				.append(" INNER JOIN DT_PROVINCE P ON P.ID = C.PROVINCE_ID ")
				.append(" WHERE HR.RESIDENT_ID = ?");
		return this.queryForMapList(sql.toString(), residentId);
	}

	@Override
	public void changeDefault(Long id, int isDefault) {
		HouseResident houseResident = this.get(id);
		houseResident.setIsDefault((byte)isDefault);
		if (isDefault == 1 && houseResident.getIsApproved() == 1) {// 如果修改当前审核通过的房屋为默认房屋 则将原审核通过的默认房屋设置取消
			String sql = "UPDATE DT_HOUSE_RESIDENT SET IS_DEFAULT=? WHERE RESIDENT_ID=? AND ID!=? AND IS_APPROVED='1'";
			this.execute(sql, 0, houseResident.getResidentId(), id);
		}
		this.update(houseResident);
	}
	
	@Override
	public HouseResident getHouseResident(long houseId, long residentId) {
		String sql = "SELECT * FROM DT_HOUSE_RESIDENT A WHERE A.DELETED = ? AND A.HOUSE_ID = ? AND A.RESIDENT_ID = ? ";
		
		return this.queryForObject(sql, HouseResident.class, new Object[]{Constant.MODEL_DELETED_N, houseId, residentId});
	}

	@Override
	public int getHouseResidentReviewCount(long unitId, Byte state, String roomNo) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		
		sql.append(" SELECT COUNT(a.ID) ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" WHERE b.UNIT_ID = :unitId AND a.DELETED = :deleted AND b.DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(state != null) {
			sql.append(" AND a.IS_APPROVED = :state ");
			params.put("state", state);
		}
		
		if(roomNo != null && !roomNo.trim().equals("")) {
			sql.append(" AND b.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<HouseResident> getHouseResidentReviewMapList(long unitId, Byte state, String roomNo, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		
		sql.append(" SELECT a.* ")
		   .append(" FROM DT_HOUSE_RESIDENT a ")
		   .append(" INNER JOIN DT_HOUSE b ON a.HOUSE_ID = b.ID ")
		   .append(" WHERE b.UNIT_ID = :unitId AND a.DELETED = :deleted AND b.DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(state != null) {
			sql.append(" AND a.IS_APPROVED = :state ");
			params.put("state", state);
		}
		
		if(roomNo != null && !roomNo.trim().equals("")) {
			sql.append(" AND b.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		sql.append(" ORDER BY A.ID DESC ");
		return query(sql.toString(), HouseResident.class, pageNo, pageSize, params);
	}
	
	@Override
	public List<HouseResident> getHouseResidentList(long houseId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_HOUSE_RESIDENT ")
		   .append(" WHERE DELETED = :deleted AND HOUSE_ID = :houseId ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseId", houseId);
		
		return query(sql.toString(), HouseResident.class, params);
	}
	
	@Override
	public List<HouseResident> getHouseResidentList(long houseId, List<Byte> typeList) {
		if(houseId <= 0
				|| typeList == null || typeList.size() <= 0) {
			return new ArrayList<HouseResident>();
		}

		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_HOUSE_RESIDENT ")
		   .append(" WHERE DELETED = :deleted AND HOUSE_ID = :houseId AND TYPE IN (:typeList) ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("houseId", houseId);
		params.put("typeList", typeList);
		
		return query(sql.toString(), HouseResident.class, params);
	}

	@Override
	public List<Map<String, Object>> getHouseResidentReviewList(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum,
			Integer pageNo,
			Integer pageSize) {

		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();

		sql.append("SELECT A.ID id, E.ALIAS_NAME aliasName,D.STORY_NUM storyNum,C.DY_CODE dyCode,C.ROOM_NUM roomNum, A.IS_DEFAULT isDefault,A.TYPE type,B.USER_NAME userName,B.PHONE_NUM phoneNum,A.IS_APPROVED isApproved");;
		sql.append(" FROM DT_HOUSE_RESIDENT A INNER JOIN DT_RESIDENT B ON A.RESIDENT_ID = B.ID");
		sql.append(" INNER JOIN DT_HOUSE C ON A.HOUSE_ID = C.ID INNER JOIN DT_STORY D ON D.ID = C.STORY_ID");
		sql.append(" INNER JOIN DT_UNIT_PARTITION E ON D.PARTITION_ID = E.ID ");
		sql.append(" WHERE C.UNIT_ID = :unitId AND A.DELETED = :deleted AND B.DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (state != null) {
			sql.append(" AND A.IS_APPROVED = :state ");
			params.put("state", state);
		}

		if (roomNo != null && !roomNo.trim().equals("")) {
			sql.append(" AND C.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		
		if (partitionId != null) {
			sql.append(" AND D.PARTITION_ID = :partitionId ");
			params.put("partitionId", partitionId);
		}
		
		if (userName != null && StringUtils.isNotBlank(userName)) {
			sql.append(" AND B.USER_NAME LIKE :userName ");
			params.put("userName", "%" + userName.trim() + "%");
		}
		
		if (phoneNum != null && StringUtils.isNotBlank(phoneNum)) {
			sql.append(" AND B.PHONE_NUM LIKE :phoneNum ");
			params.put("phoneNum", "%" + phoneNum.trim() + "%");
		}
		
		sql.append(" ORDER BY A.ID DESC ");
		return queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public int getHouseResidentReviewCount(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();

		sql.append("SELECT COUNT(*)");;
		sql.append(" FROM DT_HOUSE_RESIDENT A INNER JOIN DT_RESIDENT B ON A.RESIDENT_ID = B.ID");
		sql.append(" INNER JOIN DT_HOUSE C ON A.HOUSE_ID = C.ID INNER JOIN DT_STORY D ON D.ID = C.STORY_ID");
		sql.append(" INNER JOIN DT_UNIT_PARTITION E ON D.PARTITION_ID = E.ID ");
		sql.append(" WHERE C.UNIT_ID = :unitId AND A.DELETED = :deleted AND B.DELETED = :deleted ");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (state != null) {
			sql.append(" AND A.IS_APPROVED = :state ");
			params.put("state", state);
		}

		if (roomNo != null && !roomNo.trim().equals("")) {
			sql.append(" AND C.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		
		if (partitionId != null) {
			sql.append(" AND D.PARTITION_ID = :partitionId ");
			params.put("partitionId", partitionId);
		}
		
		if (userName != null && StringUtils.isNotBlank(userName)) {
			sql.append(" AND B.USER_NAME LIKE :userName ");
			params.put("userName", "%" + userName.trim() + "%");
		}
		
		if (phoneNum != null && StringUtils.isNotBlank(phoneNum)) {
			sql.append(" AND B.PHONE_NUM LIKE :phoneNum ");
			params.put("phoneNum", "%" + phoneNum.trim() + "%");
		}
		return queryCount(sql.toString() , params);
	}

	@Override
	public List<Map<String, Object>> getUsageStatistics(Map<String, Object> params, Page page) {
		StringBuffer sql = new StringBuffer("");

		/*modify by wangfacheng 住户不一定绑定房屋，改为DT_RESIDENT_UNIT和DT_UNIT查询住户和小区信息
		sql.append("SELECT H.UNIT_ID unitId ,H.UNIT_NAME unitName ,H.COMPANY_NAME companyName ,SUM(UNUSE) registeredCount,SUM(USES) usedCount FROM ");;
		sql.append(" (SELECT DISTINCT A.RESIDENT_ID, B.UNIT_ID, C.UNIT_NAME, D.COMPANY_NAME ,");
		sql.append(" CASE WHEN IOC.RESIDENT_ID IS NULL THEN 1 ELSE 1 END AS UNUSE,");
		sql.append(" CASE WHEN IOC.RESIDENT_ID IS NOT NULL THEN 1 ELSE 0 END AS USES");
		sql.append(" FROM DT_HOUSE_RESIDENT A INNER JOIN DT_HOUSE B ON A.HOUSE_ID = B.ID AND A.DELETED = :deleted");
		sql.append(" INNER JOIN DT_UNIT C ON B.UNIT_ID = C.ID AND B.DELETED = :deleted");
		sql.append(" LEFT JOIN DT_COMPANY D ON C.COMPANY_ID = D.ID");  
		sql.append(" LEFT JOIN (SELECT DISTINCT IO.RESIDENT_ID FROM DT_IN_OUT IO WHERE IO.DELETED='N') IOC");
		sql.append(" ON IOC.RESIDENT_ID = A.RESIDENT_ID) H WHERE 1=1");
		*/
		
		
		
		sql.append("SELECT H.UNIT_ID unitId ,H.UNIT_NAME unitName ,H.COMPANY_NAME companyName ,SUM(UNUSE) registeredCount,SUM(USES) usedCount ,SUM(ZHS) converts ,J.ioCounts, G.clickCounts");
		sql.append(" FROM (SELECT DISTINCT A.RESIDENT_ID, A.UNIT_ID, B.UNIT_NAME, D.COMPANY_NAME ,");
		sql.append(" CASE WHEN IOC.RESIDENT_ID IS NULL THEN 1 ELSE 1 END AS UNUSE,");
		sql.append(" CASE WHEN IOC.RESIDENT_ID IS NOT  NULL THEN 1 ELSE 0 END AS USES,");
		
		sql.append(" CASE WHEN ACRC.CREATE_USER_ID != 0 THEN 1 ELSE 0 END AS ZHS FROM DT_RESIDENT_UNIT A");
		
		sql.append(" INNER JOIN DT_UNIT B ON A.UNIT_ID = B.ID AND A.DELETED =:deleted AND B.DELETED =:deleted LEFT JOIN DT_COMPANY D ON B.COMPANY_ID = D.ID");  
		sql.append(" LEFT JOIN (SELECT DISTINCT IO.RESIDENT_ID FROM DT_IN_OUT IO WHERE IO.DELETED =:deleted) IOC ON IOC.RESIDENT_ID = A.RESIDENT_ID");
		sql.append(" LEFT JOIN (SELECT DISTINCT ACR.CREATE_USER_ID FROM DT_APP_CLICK_REC ACR WHERE ACR.DELETED =:deleted) ACRC ON ACRC.CREATE_USER_ID = A.RESIDENT_ID) H");
		
		//新增开门点击数 
		sql.append(" LEFT JOIN (SELECT COUNT(I.RESIDENT_ID) ioCounts ,I.UNIT_ID FROM DT_IN_OUT I GROUP BY I.UNIT_ID) J ON H.UNIT_ID = J.UNIT_ID LEFT JOIN");
		//新增APP菜单点击数 
		sql.append(" (SELECT COUNT(E.CREATE_USER_ID) clickCounts,F.UNIT_ID FROM DT_APP_CLICK_REC E LEFT JOIN DT_RESIDENT_UNIT F ON E.CREATE_USER_ID = F.RESIDENT_ID GROUP BY F.UNIT_ID) G ON H.UNIT_ID = G.UNIT_ID");
		
		sql.append(" WHERE 1=1");
		
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(params.containsKey("unitName")){
			sql.append(" AND H.UNIT_NAME LIKE :unitName");
			params.put("unitName", "%"+params.get("unitName")+"%");
		}
		sql.append(" GROUP BY  H.UNIT_ID , H.UNIT_NAME");
		return queryForMapList(sql.toString(), page.getCurrentPage(), page.getPageSize(), params);
	}

	@Override
	public int getUsageStatisticsCount(Map<String, Object> params) {
		
		/*modify by wangfacheng 住户不一定绑定房屋，改为DT_RESIDENT_UNIT和DT_UNIT查询住户和小区信息
		
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM (");

		sql.append("SELECT * FROM (SELECT DISTINCT A.RESIDENT_ID, B.UNIT_ID, C.UNIT_NAME");;
		sql.append(" FROM DT_HOUSE_RESIDENT A INNER JOIN DT_HOUSE B ON A.HOUSE_ID = B.ID AND A.DELETED = :deleted");
		sql.append(" INNER JOIN DT_UNIT C ON B.UNIT_ID = C.ID AND B.DELETED = :deleted");
		sql.append(" ) H WHERE 1=1");
		*/
		
		
		StringBuffer sql = new StringBuffer("SELECT COUNT(*) FROM (");

		sql.append("SELECT * FROM (SELECT DISTINCT A.RESIDENT_ID, A.UNIT_ID, B.UNIT_NAME")
			.append(" FROM DT_RESIDENT_UNIT A ")
			.append(" INNER JOIN DT_UNIT B ON A.UNIT_ID =B.ID AND B.DELETED = :deleted AND A.DELETED = :deleted")
			.append(" ) H WHERE 1=1");
		
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(params.containsKey("unitName")){
			sql.append(" AND H.UNIT_NAME LIKE :unitName");
			params.put("unitName", "%"+params.get("unitName")+"%");
		}
		
	    sql.append(" GROUP BY UNIT_ID,UNIT_NAME ) X");
	    return queryCount(sql.toString(), params);
	}

}
