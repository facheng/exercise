package com.dt.tarmag.dao;


import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.InOut;
import com.dt.tarmag.vo.InoutSearchVo;

/**
 * @author yuwei
 * @Time 2015-7-24下午02:34:47
 */
@Repository
public class InOutDao extends DaoImpl<InOut, Long> implements IInOutDao {

	@Override
	public int getInoutPasserbyCount(long unitId) {
		String sql = "SELECT COUNT(ID) FROM DT_IN_OUT WHERE UNIT_ID = ? AND DELETED = ?";
		return queryCount(sql, new Object[]{unitId, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<InOut> getInoutPasserbyList(long unitId, int pageNo, int pageSize) {
		String sql = "SELECT * FROM DT_IN_OUT WHERE UNIT_ID = ? AND DELETED = ?";
		return query(sql, InOut.class, pageNo, pageSize, new Object[]{unitId, Constant.MODEL_DELETED_N});
	}

	@Override
	public int getInoutPasserbyCount(long unitId, InoutSearchVo searchVo) {
		if(searchVo == null) {
			return getInoutPasserbyCount(unitId);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(a.ID) ")
		   .append(" FROM DT_IN_OUT a ")
		   .append(" LEFT JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.UNIT_ID = :unitId ")
		   .append(" AND a.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		if(searchVo.getRname() != null && !searchVo.getRname().trim().equals("")) {
			sql.append(" AND b.USER_NAME LIKE :rname ");
			params.put("rname", "%" + searchVo.getRname().trim() + "%");
		}
		
		if(searchVo.getResidentId() != null && searchVo.getResidentId() > 0) {
			sql.append(" AND a.RESIDENT_ID =:residentId ");
			params.put("residentId", searchVo.getResidentId());
		}

		return queryCount(sql.toString(), params);
	}

	@Override
	public List<InOut> getInoutPasserbyList(long unitId, InoutSearchVo searchVo, int pageNo, int pageSize) {
		if(searchVo == null) {
			return getInoutPasserbyList(unitId, pageNo, pageSize);
		}
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.* ")
		   .append(" FROM DT_IN_OUT a ")
		   .append(" LEFT JOIN DT_RESIDENT b ON a.RESIDENT_ID = b.ID ")
		   .append(" WHERE a.UNIT_ID = :unitId ")
		   .append(" AND a.DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND a.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		if(searchVo.getRname() != null && !searchVo.getRname().trim().equals("")) {
			sql.append(" AND b.USER_NAME LIKE :rname ");
			params.put("rname", "%" + searchVo.getRname().trim() + "%");
		}
		
		if(searchVo.getResidentId() != null && searchVo.getResidentId() > 0) {
			sql.append(" AND a.RESIDENT_ID =:residentId ");
			params.put("residentId", searchVo.getResidentId());
		}
		
		sql.append(" ORDER BY a.CREATE_DATE_TIME DESC ");
		return query(sql.toString(), InOut.class, pageNo, pageSize, params);
	}

	@Override
	public List<Map<String, Object>> getInoutPasserbyStatisticsDay(Long unitId ,InoutSearchVo searchVo) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID) counts ,B.ID keyId,B.KEY_NAME keyName,DATE_FORMAT( A.CREATE_DATE_TIME,'%k')  ct FROM");
		sql.append(" DT_IN_OUT A  INNER JOIN DT_KEY_DEVICE B ON A.KEY_DEVICE_ID = B.ID WHERE A.UNIT_ID = B.UNIT_ID");
		sql.append(" AND A.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = :deleted ");
		sql.append(" AND B.DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		sql.append(" GROUP BY ct , keyId ORDER BY ct ASC");
		
		return this.queryForMapList(sql.toString(), params);
	}
	
	@Override
	public List<Map<String, Object>> getInoutPasserbyStatisticsWeek(Long unitId ,InoutSearchVo searchVo) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID) counts ,B.ID keyId,B.KEY_NAME keyName,DATE_FORMAT( A.CREATE_DATE_TIME,'%j')  ct FROM");
		sql.append(" DT_IN_OUT A  INNER JOIN DT_KEY_DEVICE B ON A.KEY_DEVICE_ID = B.ID WHERE A.UNIT_ID = B.UNIT_ID");
		sql.append(" AND A.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = :deleted ");
		sql.append(" AND B.DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		sql.append(" GROUP BY ct , keyId ORDER BY ct ASC");
		
		return this.queryForMapList(sql.toString(), params);
	}
	
	@Override
	public List<Map<String, Object>> getInoutPasserbyStatisticsMonth(Long unitId ,InoutSearchVo searchVo) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID) counts ,B.ID keyId,B.KEY_NAME keyName,DATE_FORMAT( A.CREATE_DATE_TIME,'%j')  ct FROM");
		sql.append(" DT_IN_OUT A  INNER JOIN DT_KEY_DEVICE B ON A.KEY_DEVICE_ID = B.ID WHERE A.UNIT_ID = B.UNIT_ID");
		sql.append(" AND A.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = :deleted ");
		sql.append(" AND B.DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		sql.append(" GROUP BY ct , keyId ORDER BY ct DESC");
		
		return this.queryForMapList(sql.toString(), params);
	}
	
	@Override
	public List<Map<String, Object>> getInoutPasserbyStatisticsYear(Long unitId ,InoutSearchVo searchVo) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID) counts ,B.ID keyId,B.KEY_NAME keyName,DATE_FORMAT( A.CREATE_DATE_TIME,'%c')  ct FROM");
		sql.append(" DT_IN_OUT A  INNER JOIN DT_KEY_DEVICE B ON A.KEY_DEVICE_ID = B.ID WHERE A.UNIT_ID = B.UNIT_ID");
		sql.append(" AND A.UNIT_ID =:unitId");
		sql.append(" AND A.DELETED = :deleted ");
		sql.append(" AND B.DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);

		Date startTime = searchVo.getStartTime();
		if(startTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime ");
			params.put("startTime", startTime);
		}
		
		Date endTime = searchVo.getEndTime();
		if(endTime != null) {
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime ");
			params.put("endTime", endTime);
		}
		
		sql.append(" GROUP BY ct , keyId ORDER BY ct ASC");
		
		return this.queryForMapList(sql.toString(), params);
	}

	@Override
	public int getNowDays() {
		final String sql = "SELECT DATE_FORMAT(  NOW(),'%j') dayIndex ";

		return getHibernateTemplate().execute(new HibernateCallback<Integer>() {

			@Override
			public Integer doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				
				Object dayIndex = query.uniqueResult();
				
				return Integer.parseInt(dayIndex.toString());
			}
		});
	}

	@Override
	public boolean isUsed(long residentId, long keyId, Date fromDate, Date endDate) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_IN_OUT ")
		   .append(" WHERE RESIDENT_ID = :residentId ")
		   .append(" AND KEY_DEVICE_ID = :keyId ")
		   .append(" AND CREATE_DATE_TIME >= :fromDate ")
		   .append(" AND CREATE_DATE_TIME <= :endDate ")
		   .append(" AND DELETED = :deleted ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("residentId", residentId);
		params.put("keyId", keyId);
		params.put("fromDate", fromDate);
		params.put("endDate", endDate);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return queryCount(sql.toString(), params) > 0;
	}
}
