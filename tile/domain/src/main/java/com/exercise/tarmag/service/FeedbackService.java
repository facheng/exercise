package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IFeedbackDao;
import com.dt.tarmag.util.PageResult;

@Service
public class FeedbackService implements IFeedbackService {
	@Autowired
	private IFeedbackDao feedbackDao;

	@Override
	public PageResult<Map<String, Object>> findFeedbackList(Map<String, Object> params, Page page) {
		List<Map<String , Object>> feedbacks = feedbackDao.getFeedbackList(params , page);
		int count = feedbackDao.getFeedbackListCount(params);
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		if (feedbacks != null && feedbacks.size() > 0) {

			for (Map<String, Object> map : feedbacks) {
				Map<String, Object> resultMap = new HashMap<String, Object>();
				
				resultMap.put("id", map.get("id").toString());
				
				Object userName = map.get("userName");
				if(userName != null && StringUtils.isNotBlank(userName.toString())){
					resultMap.put("userName", userName.toString());
				}else{
					resultMap.put("userName", "匿名用户");
				}
				
				Object phoneNmu = map.get("phoneNmu");
				if(phoneNmu != null && StringUtils.isNotBlank(phoneNmu.toString())){
					resultMap.put("phoneNmu", phoneNmu.toString());
				}else{
					resultMap.put("phoneNmu", "");
				}
				
				resultMap.put("message", map.get("message").toString());
				
				Date createTime = DateUtil.parseDate(map.get("createTime").toString(), DateUtil.PATTERN_DATE_TIME2);
				resultMap.put("createTime", DateUtil.formatDate(createTime, DateUtil.PATTERN_DATE_TIME2));
				
				resultList.add(resultMap);
			}
		}
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, resultList);
	}

	@Override
	public void delete_tx(Long[] ids) {
		if(ids == null) return;
		for(Long id : ids){
			this.feedbackDao.deleteLogic(id);
		}
	}

}
