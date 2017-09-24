package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppVersionContent;


/**
 * @author yuwei
 * @Time 2015-6-27下午05:52:59
 */
public interface IAppVersionContentDao extends Dao<AppVersionContent, Long> {
	List<AppVersionContent> getAppVersionContentList(long recId);
}
