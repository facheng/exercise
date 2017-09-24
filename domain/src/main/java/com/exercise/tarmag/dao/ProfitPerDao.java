package com.dt.tarmag.dao;




import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.ProfitPer;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:43:04
 */
@Repository
public class ProfitPerDao extends DaoImpl<ProfitPer, Long> implements IProfitPerDao {

	@Override
	public List<Map<String, Object>> getPropertyProfitList(Map<String, Object> params, Page page) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT IFNULL(B.ID , 0) id, A.ID cId ,A.COMPANY_NAME companyName, IFNULL(B.PERCENT , 0) percent FROM DT_COMPANY A LEFT JOIN DT_PROFIT_PER B ON A.ID = B.COMPANY_ID");
		sql.append("  WHERE A.DELETED  =:deleted" );
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if (params.containsKey("companyName")) {
			sql.append(" AND A.COMPANY_NAME LIKE :companyName");
			params.put("companyName", "%" + params.get("companyName") + "%");
		}
		return queryForMapList(sql.toString(), page.getCurrentPage() ,page.getPageSize() , params);
	}

	@Override
	public int getPropertyProfitListCount(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(1) FROM DT_COMPANY A");
		sql.append("  WHERE A.DELETED  =:deleted");
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if (params.containsKey("companyName")) {
			sql.append(" AND A.COMPANY_NAME LIKE :companyName");
			params.put("companyName", "%" + params.get("companyName") + "%");
		}
		
		return queryCount(sql.toString(), params);
	}
	
	@Override
	public ProfitPer getProfitPerByCompanyId(long companyId) {
		String sql = "SELECT * FROM DT_PROFIT_PER A WHERE A.COMPANY_ID = ? AND A.DELETED  = ?";
		return queryForObject(sql, ProfitPer.class,  new Object[]{companyId, Constant.MODEL_DELETED_N});
	}
	
}
