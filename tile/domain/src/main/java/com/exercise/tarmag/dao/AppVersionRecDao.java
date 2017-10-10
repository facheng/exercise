package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.AppVersionRec;

/**
 * @author yuwei
 * @Time 2015-6-27下午05:50:27
 */
@Repository
public class AppVersionRecDao extends DaoImpl<AppVersionRec, Long> implements IAppVersionRecDao {

	@Override
	public AppVersionRec getAppVersionRec(int appId, String versionNo) {
		String sql = "SELECT * FROM APP_VERSION_REC WHERE APP_ID = ? AND VERSION_NO = ?";
		return queryForObject(sql, AppVersionRec.class, new Object[]{appId, versionNo});
	}
	
}
