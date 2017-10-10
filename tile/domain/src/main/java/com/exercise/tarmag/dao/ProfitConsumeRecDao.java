package com.dt.tarmag.dao;




import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.tarmag.model.ProfitConsumeRec;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:41:54
 */
@Repository
public class ProfitConsumeRecDao extends DaoImpl<ProfitConsumeRec, Long> implements IProfitConsumeRecDao {

	@Override
	public List<ProfitConsumeRec> findProfitConsumeRecs(long ecomId,
			Date startTime, Date endTime) {
		String sql = "SELECT * FROM DT_PROFIT_CONSUME_REC WHERE DELETED='N' AND STATUS=0 AND ECOM_ID=? AND CONSUME_TIME BETWEEN ? AND ? ";
		return this.query(sql, ProfitConsumeRec.class, new Object[]{ecomId, startTime, DateUtil.getDateOffset(endTime, 1, DateUtil.UNIT_DAY) });
	}

	@Override
	public List<Map<String, Object>> findPageProfitConsumeRecs(
			long ecomId,
			Date startTime,
			Date endTime,
			int pageNo,
			int pageSize) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id , A.CONSUME_TIME consumeTime , A.ORDER_ID orderId , A.CONSUME_AMOUNT  consumeAmount ,")
			.append(" A.PROFIT_AMOUNT profitAmount , B.ECOM_NAME ecomName ")
		    .append(" FROM DT_PROFIT_CONSUME_REC A INNER JOIN DT_PROFIT_ECOM B ON A.ECOM_ID = B.ID AND B.DELETED = :deleted ")
			.append(" WHERE A.DELETED = :deleted  AND A.STATUS = 0  AND A.ECOM_ID = :ecomId  AND  A.CONSUME_TIME BETWEEN :startTime AND :endTime");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted",  Constant.MODEL_DELETED_N);
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public int getProfitConsumeRecsCount(long ecomId, Date startTime, Date endTime) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID)")
		    .append(" FROM DT_PROFIT_CONSUME_REC A INNER JOIN DT_PROFIT_ECOM B ON A.ECOM_ID = B.ID AND B.DELETED = :deleted ")
			.append(" WHERE A.DELETED = :deleted  AND A.STATUS = 0  AND A.ECOM_ID = :ecomId  AND  A.CONSUME_TIME BETWEEN :startTime AND :endTime");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted",  Constant.MODEL_DELETED_N);
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		return this.queryCount(sql.toString(), params);
	}

	@Override
	public ProfitConsumeRec getProfitConsumeRec(long ecomId, String orderId) {
		String sql = "SELECT * FROM DT_PROFIT_CONSUME_REC WHERE ECOM_ID = ? AND ORDER_ID = ? AND DELETED = ?";
		return queryForObject(sql, ProfitConsumeRec.class, new Object[]{ecomId, orderId, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmount(Date startTime, Date endTime, Long ecomId, Long companyId) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT SUM(A.CONSUME_AMOUNT) consumeAmount , SUM(A.PROFIT_AMOUNT) profitAmount ")
			.append(" FROM DT_PROFIT_CONSUME_REC A  INNER JOIN DT_UNIT B ")
			.append(" ON A.UNIT_ID = B.ID AND A.DELETED = 'N' AND B.DELETED = 'N' ")
			.append(" WHERE A.STATUS = :status AND A.CONSUME_TIME >= :startTime AND A.CONSUME_TIME <= :endTime ")
			.append(" AND A.ECOM_ID = :ecomId AND B.COMPANY_ID = :companyId ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		params.put("companyId",  companyId);
		params.put("status",  ProfitConsumeRec.STATUS_APPROVED);
		
		return this.queryForMapList(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByUnit(
			Date startTime,
			Date endTime,
			Long ecomId,
			Long companyId , String unitName,int pageNo, int pageSize) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT ROUND(SUM(A.CONSUME_AMOUNT),2) consumeAmount , A.UNIT_ID unitId  , A.ECOM_ID ecomId, B.UNIT_NAME unitName ")
			.append(" FROM DT_PROFIT_CONSUME_REC A  INNER JOIN DT_UNIT B ")
			.append(" ON A.UNIT_ID = B.ID AND A.DELETED = 'N' AND B.DELETED = 'N' ")
			.append(" WHERE A.STATUS = :status AND A.CONSUME_TIME >= :startTime AND A.CONSUME_TIME <= :endTime ")
			.append(" AND A.ECOM_ID = :ecomId AND B.COMPANY_ID = :companyId ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		params.put("companyId",  companyId);
		params.put("status",  ProfitConsumeRec.STATUS_APPROVED);
		
		if(unitName != null && !"".equals(unitName.trim())){
			sql.append(" AND B.UNIT_NAME LIKE :unitName ");
			params.put("unitName", "%"+unitName.trim()+"%");
		}
		
		sql.append(" GROUP BY A.UNIT_ID ");
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public int getProfitConsumeRecsAmountGroupByUnitCount(Date startTime, Date endTime, Long ecomId, Long companyId , String unitName) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(*) FROM ( ")
			.append(" SELECT A.ID   ")
			.append(" FROM DT_PROFIT_CONSUME_REC A  INNER JOIN DT_UNIT B ")
			.append(" ON A.UNIT_ID = B.ID AND A.DELETED = 'N' AND B.DELETED = 'N' ")
			.append(" WHERE A.STATUS = :status AND A.CONSUME_TIME >= :startTime AND A.CONSUME_TIME <= :endTime ")
			.append(" AND A.ECOM_ID = :ecomId AND B.COMPANY_ID = :companyId ");
			
		
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		params.put("companyId",  companyId);
		params.put("status",  ProfitConsumeRec.STATUS_APPROVED);
		
		if(unitName != null && !"".equals(unitName.trim())){
			sql.append(" AND B.UNIT_NAME LIKE :unitName ");
			params.put("unitName", "%"+unitName.trim()+"%");
		}
		
		sql.append(" GROUP BY A.UNIT_ID ").append(" ) C ");
			
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByResident(
			Date startTime,
			Date endTime,
			Long ecomId,
			Long unitId ,int pageNo, int pageSize) {
		
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT AA.* FROM (")
			.append(" SELECT A.ID id , ROUND(SUM(A.CONSUME_AMOUNT),2) consumeAmount , C.USER_NAME userName , C.PHONE_NUM phoneNum ,  ")
			.append(" C.ID residentId, A.CONSUME_TIME consumeTime ")
			.append(" FROM DT_PROFIT_CONSUME_REC A  INNER JOIN DT_RESIDENT_UNIT B ")
			.append(" ON A.UNIT_ID = B.UNIT_ID AND A.RESIDENT_ID = B.RESIDENT_ID AND  A.DELETED = 'N' AND B.DELETED = 'N' ")
			.append(" INNER JOIN DT_RESIDENT C ")
			.append(" ON A.RESIDENT_ID = C.ID AND A.RESIDENT_ID = C.ID AND C.DELETED = 'N' ")
			.append(" WHERE A.STATUS = :status AND A.CONSUME_TIME >= :startTime AND A.CONSUME_TIME <= :endTime ")
			.append(" AND A.ECOM_ID = :ecomId AND B.UNIT_ID = :unitId ")
			
			.append(" GROUP BY A.RESIDENT_ID")
			.append(" )AA")
			
			.append(" ORDER BY AA.consumeAmount DESC");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		params.put("unitId",  unitId);
		params.put("status",  ProfitConsumeRec.STATUS_APPROVED);
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, params);
		
	}

	@Override
	public int getProfitConsumeRecsAmountGroupByResidentCount(Date startTime, Date endTime, Long ecomId, Long unitId) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(AA.id) FROM (")
			.append(" SELECT A.ID id ")
			.append(" FROM DT_PROFIT_CONSUME_REC A  INNER JOIN DT_RESIDENT_UNIT B ")
			.append(" ON A.UNIT_ID = B.UNIT_ID AND  A.RESIDENT_ID = B.RESIDENT_ID AND  A.DELETED = 'N' AND B.DELETED = 'N' ")
			.append(" INNER JOIN DT_RESIDENT C ")
			.append(" ON A.RESIDENT_ID = C.ID AND A.RESIDENT_ID = C.ID AND C.DELETED = 'N' ")
			.append(" WHERE A.STATUS = :status AND A.CONSUME_TIME >= :startTime AND A.CONSUME_TIME <= :endTime ")
			.append(" AND A.ECOM_ID = :ecomId AND B.UNIT_ID = :unitId ")
			
			.append(" GROUP BY A.RESIDENT_ID")
			.append(" )AA");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("ecomId", ecomId);
		params.put("startTime", startTime);
		params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		params.put("unitId",  unitId);
		params.put("status",  ProfitConsumeRec.STATUS_APPROVED);
		
		return this.queryCount(sql.toString(), params);
	}

}
