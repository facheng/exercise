package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.ApiRequestRec;


/**
 * @author yuwei
 * @Time 2015-7-19上午11:40:28
 */
@Repository
public class ApiRequestRecDao extends DaoImpl<ApiRequestRec, Long> implements IApiRequestRecDao {

	@Override
	public ApiRequestRec getLatestLoginRec(long residentId) {
		String sql = "SELECT * FROM DT_API_REQUEST_REC WHERE RESIDENT_ID = ? ORDER BY LOGIN_TIME DESC";
		return queryForObject(sql, ApiRequestRec.class, new Object[]{residentId});
	}

	@Override
	public long getOnLineTime() {
		String sql = "SELECT SUM(TIMESTAMPDIFF(SECOND ,LOGIN_TIME,LATEST_VISIT_TIME)) times  FROM DT_API_REQUEST_REC";
		
		List<Map<String , Object>> result = queryForMapList(sql);
		
		if(result != null && result.size() == 1){
			return Long.parseLong(result.get(0).get("times").toString());
		}
		return 0;
	}

	@Override
	public List<Map<String, Object>> getApiRequestRec(Map<String, Object> params, Page page) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID recId,A.RESIDENT_ID resId,B.USER_NAME userName,B.PHONE_NUM phoneNmu,SUM(TIMESTAMPDIFF(SECOND ,LOGIN_TIME,LATEST_VISIT_TIME)) times");
		sql.append(" FROM DT_API_REQUEST_REC A INNER JOIN DT_RESIDENT B ON A.RESIDENT_ID = B.ID");
		sql.append(" WHERE DELETED =:deleted");
		if(params.containsKey("userName")){
			sql.append(" AND B.USER_NAME LIKE :userName");
			params.put("userName", "%"+params.get("userName")+"%");
		}
		
		if(params.containsKey("phoneNum")){
			sql.append(" AND B.PHONE_NUM LIKE :phoneNum");
			params.put("phoneNum", "%"+params.get("phoneNum")+"%");
		}
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		sql.append(" GROUP BY A.RESIDENT_ID");
		return queryForMapList(sql.toString(), page.getCurrentPage() ,page.getPageSize() , params);
				
		
	}

	@Override
	public int getApiRequestRecCount(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(*) FROM (SELECT A.ID FROM DT_API_REQUEST_REC A INNER JOIN DT_RESIDENT B ON A.RESIDENT_ID = B.ID ");
		
		sql.append("WHERE DELETED =:deleted");
		if(params.containsKey("userName")){
			sql.append(" AND B.USER_NAME LIKE :userName");
			params.put("userName", "%" + params.get("userName" + "%"));
		}
		
		if(params.containsKey("phoneNum")){
			sql.append(" AND B.PHONE_NUM LIKE :phoneNum");
			params.put("phoneNum", "%"+params.get("phoneNum")+"%");
		}
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		sql.append(" GROUP BY A.RESIDENT_ID ) C");
		
		return queryCount(sql.toString(), params);
	}
}
