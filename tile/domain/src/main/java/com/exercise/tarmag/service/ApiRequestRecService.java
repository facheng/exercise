package com.dt.tarmag.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IApiRequestRecDao;
import com.dt.tarmag.util.PageResult;

@Service
public class ApiRequestRecService implements IApiRequestRecService {
	
	@Autowired
	private IApiRequestRecDao apiRequestRecDao;
	
	
	/**
	 * 访问时间格式化
	 * @param time
	 * @return
	 */
	private String getTimes(long time) {
		long days = time / (60 * 60 * 24);
        long hours = (time % (60 * 60 * 24)) / (60 * 60);
        long minutes = (time % (60 * 60) / 60);
        long seconds = (time % 60);
        
		return  days + " 天 " + hours + " 小时 " + minutes + " 分 " + seconds + " 秒 ";
	}
	
	@Override
	public String geTimeCount(){
		long time = apiRequestRecDao.getOnLineTime();
		return getTimes(time);
	}
	
	@Override
	public PageResult<Map<String, Object>> findApiRequestRec(Map<String, Object> params, Page page) {
		
		List<Map<String , Object>> apiRequestRecs = apiRequestRecDao.getApiRequestRec(params , page);
		int count = apiRequestRecDao.getApiRequestRecCount(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		if (apiRequestRecs != null && apiRequestRecs.size() > 0) {

			for (Map<String, Object> map : apiRequestRecs) {
				Map<String, Object> resultMap = new HashMap<String, Object>();
				resultMap.put("userName", map.get("userName").toString());
				resultMap.put("phoneNmu", map.get("phoneNmu").toString());
				Long time = Long.parseLong(map.get("times").toString());
				resultMap.put("times",getTimes(time));
				resultList.add(resultMap);
			}
		}
		
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, resultList);
	}

}
