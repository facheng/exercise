package com.dt.tarmag.dao;




import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.tarmag.model.ProfitBalanceIn;

/**
 * @author yuwei
 * @Time 2015-8-13下午05:39:36
 */
@Repository
public class ProfitBalanceInDao extends DaoImpl<ProfitBalanceIn, Long> implements IProfitBalanceInDao {
	@Override
	public List<Map<String, Object>> findPageProfitBalanceIn(
			long ecomId,
			Date startTime,
			Date endTime,
			String status,
			int pageNo,
			int pageSize) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id ,DATE_FORMAT(A.CREATE_DATE_TIME,'%Y-%m-%d') checkAmountTime ,  DATE_FORMAT(A.START_TIME,'%Y-%m-%d') startTime ,DATE_FORMAT(A.END_TIME,'%Y-%m-%d') endTime , A.CONSUME_AMOUNT  consumeAmount ,")
			.append(" A.PROFIT_AMOUNT profitAmount ,A.STATUS status , B.ECOM_NAME ecomName ")
		    .append(" FROM DT_PROFIT_BALANCE_IN A INNER JOIN DT_PROFIT_ECOM B ON A.ECOM_ID = B.ID AND B.DELETED = :deleted ")
			.append(" WHERE A.DELETED = :deleted   AND A.ECOM_ID = :ecomId ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted",  Constant.MODEL_DELETED_N);
		params.put("ecomId", ecomId);
		
		if(startTime != null ){
			sql.append(" AND  A.CREATE_DATE_TIME >= :startTime");
			params.put("startTime", startTime);
		}
		if(endTime != null ){
			sql.append(" AND  A.CREATE_DATE_TIME <= :endTime");
			params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		}
		
		if(status != null && !"".equals(status.trim())){
			sql.append(" AND  A.STATUS = :status");
//			if("0".equals(status.trim())){
//				params.put("status",  ProfitBalanceIn.STATUS_NOT_SETTLED);
//			}else if("1".equals(status.trim())){
//				params.put("status",  ProfitBalanceIn.STATUS_SETTLING);
//			} else {
//				params.put("status",  ProfitBalanceIn.STATUS_SETTLED);
//			}
			params.put("status",  Byte.valueOf((status.trim())));
			
		}
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public int getProfitBalanceInCount(long ecomId, Date startTime, Date endTime,String status) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID)")
		    .append(" FROM DT_PROFIT_BALANCE_IN A INNER JOIN DT_PROFIT_ECOM B ON A.ECOM_ID = B.ID AND B.DELETED = :deleted ")
		    .append(" WHERE A.DELETED = :deleted   AND A.ECOM_ID = :ecomId ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted",  Constant.MODEL_DELETED_N);
		params.put("ecomId", ecomId);
		
		if(startTime != null ){
			sql.append(" AND  A.CREATE_DATE_TIME >= :startTime");
			params.put("startTime", startTime);
		}
		if(endTime != null ){
			sql.append(" AND  A.CREATE_DATE_TIME <= :endTime");
			params.put("endTime",  DateUtil.getLastSecOfDate(endTime));
		}
		
		if(status != null && !"".equals(status.trim())){
			sql.append(" AND  A.STATUS = :status");
//			if("0".equals(status.trim())){
//				params.put("status",  ProfitBalanceIn.STATUS_NOT_SETTLED);
//			}else if("1".equals(status.trim())){
//				params.put("status",  ProfitBalanceIn.STATUS_SETTLING);
//			} else {
//				params.put("status",  ProfitBalanceIn.STATUS_SETTLED);
//			}
			params.put("status",  Byte.valueOf((status.trim())));
			
		}
		return this.queryCount(sql.toString(), params);
	}

}
