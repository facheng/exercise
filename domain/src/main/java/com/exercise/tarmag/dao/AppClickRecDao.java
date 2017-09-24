package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.AppClickRec;

/**
 * @author yuwei
 * @Time 2015-7-17下午01:18:01
 */
@Repository
public class AppClickRecDao extends DaoImpl<AppClickRec, Long> implements IAppClickRecDao {

	@Override
	public List<Map<String , Object>> findAppClickRec(Page page) {
		String sql = "SELECT COUNT(TYPE_ID) counts ,A.TYPE type,A.TYPE_ID typeId ,COUNT(DISTINCT A.CREATE_USER_ID) userCount FROM DT_APP_CLICK_REC A WHERE A.DELETED = ? GROUP BY A.TYPE ,A.TYPE_ID";
		List<Map<String, Object>> appClickRecs = this.queryForMapList(sql,page.getCurrentPage() ,page.getPageSize(),new Object[]{Constant.MODEL_DELETED_N});
		
		return appClickRecs;
	}

	@Override
	public int findAppClickRec() {
		String sql = "SELECT COUNT(*) FROM ((SELECT COUNT(TYPE_ID) counts FROM DT_APP_CLICK_REC A WHERE A.DELETED = ? GROUP BY A.TYPE ,A.TYPE_ID) B)";
		return this.queryCount(sql ,Constant.MODEL_DELETED_N);
	}

	@Override
	public long getSumAppClickRec() {
		
		String sql = "SELECT SUM(A.CLICK_TIMES) clicks FROM DT_IN_OUT A ";
		
		List<Map<String , Object>> result = queryForMapList(sql);
		
		if(result != null && result.size() == 1){
			return Long.parseLong(result.get(0).get("clicks").toString());
		}
		
		
		return 0;
	}
	
}
