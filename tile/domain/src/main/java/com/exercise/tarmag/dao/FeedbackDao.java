package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Feedback;

/**
 * @author yuwei
 * @Time 2015-7-17下午01:17:25
 */
@Repository
public class FeedbackDao extends DaoImpl<Feedback, Long> implements IFeedbackDao {

	@Override
	public List<Map<String, Object>> getFeedbackList(Map<String, Object> params, Page page) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id , B.USER_NAME userName,B.PHONE_NUM phoneNmu,A.MESSAGE message,A.CREATE_DATE_TIME createTime FROM DT_FEEDBACK A");
		sql.append(" LEFT JOIN DT_RESIDENT B ON A.CREATE_USER_ID = B.ID WHERE A.DELETED =:deleted");
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(params.containsKey("startTime")){
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime");
			params.put("startTime", params.get("startTime"));
		}
		
		if(params.containsKey("endTime")){
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime");
			params.put("endTime", params.get("endTime"));
		}
		sql.append(" ORDER BY A.CREATE_DATE_TIME DESC");
		return queryForMapList(sql.toString(), page.getCurrentPage() ,page.getPageSize() , params);
	}

	@Override
	public int getFeedbackListCount(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(*) FROM DT_FEEDBACK A");
		sql.append(" LEFT JOIN DT_RESIDENT B ON A.CREATE_USER_ID = B.ID WHERE A.DELETED =:deleted");
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(params.containsKey("startTime")){
			sql.append(" AND A.CREATE_DATE_TIME >= :startTime");
			params.put("startTime", params.get("startTime"));
		}
		if(params.containsKey("endTime")){
			sql.append(" AND A.CREATE_DATE_TIME <= :endTime");
			params.put("endTime", params.get("endTime"));
		}
		return queryCount(sql.toString(), params);
	}
	
}
