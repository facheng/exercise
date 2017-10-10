package com.dt.tarmag.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.AppVersionContent;

/**
 * @author yuwei
 * @Time 2015-6-27下午05:53:21
 */
@Repository
public class AppVersionContentDao extends DaoImpl<AppVersionContent, Long> implements IAppVersionContentDao {

	@Override
	public List<AppVersionContent> getAppVersionContentList(long recId) {
		String sql = "SELECT * FROM APP_VERSION_CONTENT WHERE REC_ID = ?";
		return query(sql, AppVersionContent.class, new Object[]{recId});
	}
	
}
