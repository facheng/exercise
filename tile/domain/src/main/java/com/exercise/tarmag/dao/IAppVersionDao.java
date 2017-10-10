package com.dt.tarmag.dao;


import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppVersion;


/**
 * @author yuwei
 * @Time 2015-6-27下午05:41:48
 */
public interface IAppVersionDao extends Dao<AppVersion, Long> {
	AppVersion getAppVersionByAppId(int appId);
}
