package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.House;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class HouseDao extends DaoImpl<House, Long> implements IHouseDao {

	@Override
	public int getHouseCount() {
		String sql = "SELECT COUNT(1) FROM DT_HOUSE";
		return queryCount(sql);
	}

	/**
	 * 根据用户小区id 房屋状态的统计
	 * 
	 * @param unitId
	 *            当前登 录用户对应的小区id
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getHouseCount(long unitId) {
		String sql1 = "SELECT STATUS AS status,COUNT(1) AS count FROM DT_HOUSE WHERE  UNIT_ID =:unitId GROUP BY STATUS";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		List<Map<String, Object>> list = queryForMapList(sql1, params);
		return list;
	}

	@Override
	public House getDefaultHouse(Long residentId) {
		String sql = "SELECT h.* FROM DT_HOUSE h, DT_HOUSE_RESIDENT hr ,DT_UNIT un   WHERE h.DELETED = 'N' AND hr.DELETED = 'N' and un.DELETED='N' and h.id = hr.HOUSE_ID and h.UNIT_ID = un.ID and hr.RESIDENT_ID=? and hr.IS_DEFAULT='1' and hr.IS_APPROVED='1'";
		return this.queryForObject(sql, House.class, residentId);
	}

	@Override
	public List<House> getHouses(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer(
				"SELECT H.* FROM DT_HOUSE H WHERE DELETED='N' AND NOT EXISTS(SELECT 1 FROM DT_HOUSE_RESIDENT HR WHERE HR.DELETED='N' AND HR.HOUSE_ID=H.ID AND HR.RESIDENT_ID=:residentId)");
		if (params.containsKey("storyId")) {
			sql.append(" AND H.STORY_ID=:storyId");
		}
		return this.query(sql.toString(), House.class, params);
	}

	/**
	 * 获取 导出房屋的信息
	 * 
	 * @param house
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getHouseInfosExcel(House house) {
		StringBuffer sbSql = new StringBuffer();
		sbSql.append(
				"select aa.*,d.USER_NAME userName,d.PHONE_NUM phoneNum,d.ID_CARD idCard,c.STORY_NUM storyNum ")
				.append("from (select DISTINCT a.ID id, b.RESIDENT_ID residentId ,a.PRO_NO proNo,a.AREA area, ")
				.append("a.STATUS status,a.DY_CODE dyCode,a.FLOOR_NUM floorNum,b.TYPE type,a.AMOUNT amount,a.STORY_ID, a.REMARK remark ")
				.append("from DT_HOUSE a left join DT_HOUSE_RESIDENT b ")
				.append("on a.ID = b.HOUSE_ID where 1=1 and a.UNIT_ID="
						+ house.getUnitId());
		if (StringUtils.isNotBlank(house.getDyCode())) {
			sbSql.append(" and a.DY_CODE like %'" + house.getDyCode() + "'%");
		}
		if (house.getStatus() > 0) {
			sbSql.append(" and a.STATUS =" + house.getStatus());
		}
		sbSql.append(" ) aa left join DT_STORY c on aa.STORY_ID = c.ID ")
				.append("left join DT_RESIDENT d on aa.residentId = d.ID ");
		return this.queryForMapList(sbSql.toString());

	}

	@Override
	public int getHouseCount(long unitId, Byte status, String roomNo ,Long partitionId) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		sql.append("SELECT COUNT(*) FROM DT_HOUSE A INNER JOIN DT_STORY B ON A.STORY_ID = B.ID INNER JOIN DT_UNIT_PARTITION C ON B.PARTITION_ID = C.ID");
		sql.append(" WHERE A.UNIT_ID = :unitId AND A.DELETED = :deleted");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		if (status != null) {
			sql.append(" AND A.STATUS = :status ");
			params.put("status", status);
		}

		if (roomNo != null && !roomNo.trim().equals("")) {
			sql.append(" AND A.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		
		if (partitionId != null) {
			sql.append(" AND C.ID = :partitionId ");
			params.put("partitionId", partitionId);
		}

		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String ,Object>> getHouseList(long unitId, Byte status, String roomNo, Long partitionId ,
			int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> params = new HashMap<String, Object>();
		
		sql.append("SELECT C.ALIAS_NAME aliasName,A.STORY_ID storyId ,A.ID id ,B.STORY_NUM storyNum ,A.ROOM_NUM roomNum ,A.STATUS status ,A.DELEGATE_DELIVERY delegateDelivery FROM DT_HOUSE A INNER JOIN DT_STORY B ON A.STORY_ID = B.ID INNER JOIN DT_UNIT_PARTITION C ON B.PARTITION_ID = C.ID");
		
		
		sql.append(" WHERE A.UNIT_ID = :unitId AND A.DELETED = :deleted");
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if (status != null) {
			sql.append(" AND A.STATUS = :status ");
			params.put("status", status);
		}

		if (roomNo != null && StringUtils.isNotBlank(roomNo)) {
			sql.append(" AND A.ROOM_NUM LIKE :roomNo ");
			params.put("roomNo", "%" + roomNo.trim() + "%");
		}
		
		if (partitionId != null) {
			sql.append(" AND C.ID = :partitionId ");
			params.put("partitionId", partitionId);
		}

		return queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public List<Map<String, Object>> getHouseInfoById(Long houseId) {
		String sql = "SELECT A.* , B.LANTITUDE , B.LONGITUDE FROM DT_HOUSE A ,DT_STORY B WHERE B.ID = A.STORY_ID AND A.ID = ? AND A.DELETED='N'";
		return this.queryForMapList(sql, houseId);
	}

	@Override
	public void updateHouse(Map<String, Object> paramsMap) {
		StringBuffer sql = new StringBuffer("UPDATE DT_HOUSE SET");

		if (paramsMap.containsKey("dyCode")) {
			sql.append(" DY_CODE=:dyCode ,");
		}
		if (paramsMap.containsKey("proNo")) {
			sql.append(" PRO_NO=:proNo ,");
		}
		if (paramsMap.containsKey("area")) {
			sql.append(" AREA=:area ,");
		}
		if (paramsMap.containsKey("status")) {
			sql.append(" STATUS=:status ");
		}

		sql.append("where ID=:Id");
		this.execute(sql.toString(), paramsMap);
	}

	@Override
	public List<House> getHouses(Long residentId) {
		String sql = "SELECT H.* FROM DT_HOUSE_RESIDENT HR, DT_HOUSE H WHERE HR.RESIDENT_ID=? AND HR.DELETED='N' AND HR.IS_APPROVED='1' AND H.DELETED='N' AND H.ID=HR.HOUSE_ID";
		return this.query(sql, House.class, residentId);
	}

	/**
	 * 根据 房屋dycode 和 小区id 获取房屋总数
	 * 
	 * @return
	 */
	@Override
	public int getCountHouse(House house) {
		String sql = "SELECT count(1) FROM DT_HOUSE h WHERE h.DELETED = 'N' AND  h.UNIT_ID = :unitId and h.DY_CODE = :dyCode";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", house.getUnitId());
		params.put("dyCode", house.getDyCode());
		return this.queryCount(sql, params);
	}

	/**
	 * 根据 房屋dycode 和 小区id 获取房屋总数
	 * 
	 * @return
	 */
	@Override
	public House getHouseByDyCode(House house) {
		String sql = "SELECT h.* FROM DT_HOUSE h WHERE h.DELETED = 'N' AND  h.UNIT_ID = :unitId and h.DY_CODE = :dyCode";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", house.getUnitId());
		params.put("dyCode", house.getDyCode());
		return this.queryForObject(sql, House.class, params);
	}

	@Override
	public List<House> getHouseListByStoryId(long storyId) {
		String sql = "SELECT * FROM DT_HOUSE WHERE STORY_ID = ? AND DELETED = ?";
		return query(sql, House.class, new Object[] {storyId, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public List<House> getHouseListByPartitionId(long partitionId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT b.* ")
		   .append(" FROM DT_STORY a ")
		   .append(" INNER JOIN DT_HOUSE b ON a.ID = b.STORY_ID ")
		   .append(" WHERE a.PARTITION_ID = :partitionId AND a.DELETED = :deleted AND b.DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("partitionId", partitionId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		return query(sql.toString(), House.class, params);
	}

	@Override
	public List<House> getHouseListByUnitId(long unitId) {
		String sql = "SELECT H.*,S.PARTITION_ID FROM DT_HOUSE H LEFT JOIN DT_STORY S ON H.STORY_ID = S.ID  WHERE H.UNIT_ID = ? AND H.DELETED = ? ORDER BY S.PARTITION_ID,H.STORY_ID,H.ROOM_NUM ";
		return query(sql, House.class, new Object[] { unitId,
				Constant.MODEL_DELETED_N });
	}
	
	@Override
	public int getHouseCountByUnitId(long unitId) {
		String sql = "SELECT COUNT(ID) FROM DT_HOUSE WHERE UNIT_ID = ? AND DELETED = ?";
		return queryCount(sql, new Object[] {unitId, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public int getHouseCountByUnitIdAndStatus(long unitId, byte status) {
		String sql = "SELECT COUNT(ID) FROM DT_HOUSE WHERE UNIT_ID = ? AND STATUS = ? AND DELETED = ?";
		return queryCount(sql, new Object[] {unitId, status, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Map<String, Object>> getHouseInfosForExport(House house) {
		
		StringBuffer sql = new StringBuffer();
		sql.append( " SELECT  a.ID id, a.ROOM_NUM roomNum, ")
				.append("  b.RESIDENT_ID residentId, ")
				.append("  a.PRO_NO proNo, a.AREA area, ")
				.append("  a.STATUS status, ")
				.append("  a.DY_CODE dyCode, ")
				.append("  a.FLOOR_NUM floorNum, ")
				.append("  b.TYPE type, ")
				.append("  a.AMOUNT amount, ")
				.append("  a.STORY_ID storyId, ")
				.append("  a.REMARK remark , ")
				.append("  e.USER_NAME userName, ")
				.append("  e.PHONE_NUM phoneNum, ")
				.append("  e.ID_CARD idCard, ")
				.append("  c.STORY_NUM storyNum , ")
				.append("  f.PARTITION_NAME partitionName ")
				.append("  FROM ")
				.append("  DT_HOUSE a  ")
				.append("  LEFT JOIN DT_HOUSE_RESIDENT b  ON a.ID = b.HOUSE_ID   AND b.DELETED = :deleted  ")
				.append("  INNER JOIN  DT_STORY c ON a.STORY_ID = c.ID  AND c.DELETED = :deleted  ")
				.append("  LEFT JOIN DT_RESIDENT e ON b.RESIDENT_ID = e.ID AND e.DELETED = :deleted ")
				.append("  INNER JOIN DT_UNIT_PARTITION f ON c.PARTITION_ID = f.ID AND f.DELETED = :deleted ")
				.append("  WHERE a.UNIT_ID = :unitId  ")
				.append("  AND a.DELETED = :deleted ");
				
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("unitId", house.getUnitId());
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return this.queryForMapList( sql.toString() , params);
	}

}
