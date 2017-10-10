/**
 * 
 */
package com.dt.tarmag.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.TextUtil;
import com.dt.tarmag.dao.IAppVersionContentDao;
import com.dt.tarmag.dao.IAppVersionDao;
import com.dt.tarmag.dao.IAppVersionRecDao;
import com.dt.tarmag.model.AppVersion;
import com.dt.tarmag.model.AppVersionContent;
import com.dt.tarmag.model.AppVersionRec;


/**
 * @author yuwei
 * @Time 2015-6-27下午06:22:01
 */
@Service
public class AppVersionService implements IAppVersionService {

	@Autowired
	private IAppVersionDao appVersionDao;
	@Autowired
	private IAppVersionRecDao appVersionRecDao;
	@Autowired
	private IAppVersionContentDao appVersionContentDao;
	
	
	@Override
	public Map<String, Object> getCurrentAppVersion(int type) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		AppVersion av = appVersionDao.getAppVersionByAppId(type);
		if(av == null) {
			map.put("status", 0);
			map.put("msg", TextUtil.getText("app.version.null"));
			return map;
		}
		
		AppVersionRec avr = appVersionRecDao.getAppVersionRec(type, av.getVersionNo());
		if(avr == null) {
			map.put("status", 0);
			map.put("msg", TextUtil.getText("app.version.null"));
			return map;
		}
		
		List<AppVersionContent> contentList = appVersionContentDao.getAppVersionContentList(avr.getId());

		map.put("status", 1);
		map.put("msg", "ok");
		map.put("forceUpdate", avr.getForceUpdate() ? 1 : 0);
		map.put("updateUrl", avr.getUpdateUrl());
		map.put("contentList", contentList);
		map.put("updateVersion", av.getVersionNo());
		
		return map;
	}
}
