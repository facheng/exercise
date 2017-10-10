package com.dt.tarmag.dao;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.ProfitBalanceOut;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:40:51
 */
@Repository
public class ProfitBalanceOutDao extends DaoImpl<ProfitBalanceOut, Long> implements IProfitBalanceOutDao {

	@Override
	public int getProfitCountByCompanyId(long companyId, Byte status) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_PROFIT_BALANCE_OUT ")
		   .append(" WHERE COMPANY_ID = :companyId ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(status != null) {
			sql.append(" AND STATUS = :status ");
			params.put("status", status);
		}
		   
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<ProfitBalanceOut> getProfitListByCompanyId(long companyId, Byte status, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_PROFIT_BALANCE_OUT ")
		   .append(" WHERE COMPANY_ID = :companyId ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(status != null) {
			sql.append(" AND STATUS = :status ");
			params.put("status", status);
		}
		
		sql.append(" ORDER BY CREATE_DATE_TIME DESC ");
		return query(sql.toString(), ProfitBalanceOut.class, pageNo, pageSize, params);
	}

	@Override
	public ProfitBalanceOut getPropertyProfitById(Long id) {
		String sql = " SELECT * FROM DT_PROFIT_BALANCE_OUT A WHERE A.ID = ? AND DELETED = ?";
		return this.queryForObject(sql,ProfitBalanceOut.class, new Object[]{id, Constant.MODEL_DELETED_N});
	}
	
}
