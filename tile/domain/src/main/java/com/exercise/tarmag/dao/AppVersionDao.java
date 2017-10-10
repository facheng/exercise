package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.AppVersion;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class AppVersionDao extends DaoImpl<AppVersion, Long> implements IAppVersionDao {

	@Override
	public AppVersion getAppVersionByAppId(int appId) {
		String sql = "SELECT * FROM APP_VERSION WHERE APP_ID = ?";
		return queryForObject(sql, AppVersion.class, new Object[]{appId});
	}
	
}
