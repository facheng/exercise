package com.dt.tarmag.dao;


import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppVersionRec;


/**
 * @author yuwei
 * @Time 2015-6-27下午05:49:59
 */
public interface IAppVersionRecDao extends Dao<AppVersionRec, Long> {
	AppVersionRec getAppVersionRec(int appId, String versionNo);
}
