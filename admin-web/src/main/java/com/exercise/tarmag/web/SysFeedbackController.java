package com.dt.tarmag.web;

import java.util.Date;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.StringUtils;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IFeedbackService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.util.Params;

/**
 * 用户反馈
 *
 * @author jiaosf
 * @since 2015-8-7
 */
@RequestMapping("sysfeedback")
@Controller
public class SysFeedbackController extends AbstractDtController {
	
	@Autowired
	private IFeedbackService feedbackService;
	
	
	/**
	 * 跳转用户反馈页面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/feedback/index";
	}
	
	
	
	@RequestMapping("feedbacks")
	@ResponseBody
	protected JSONObject findCustomer(String startTimes, String endTimes,
			final DataTableParams params) {
		Date startTime = null;
		if(StringUtils.isNotBlank(startTimes)){
			startTime = DateUtil.parseDate(startTimes, DateUtil.PATTERN_DATE_TIME2);
		}
		Date endTime = null;
		if(StringUtils.isNotBlank(endTimes)){
			endTime = DateUtil.parseDate(endTimes, DateUtil.PATTERN_DATE_TIME2);
		}
		
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.feedbackService.findFeedbackList(
							Params.getParams().add("startTime", startTime)
									.add("endTime", endTime).filterEmpty(),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.feedbackService.delete_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}

}
