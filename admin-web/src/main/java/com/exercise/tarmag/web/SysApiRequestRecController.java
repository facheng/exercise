package com.dt.tarmag.web;


import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.tarmag.service.IApiRequestRecService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.Params;

@RequestMapping("sysapirequestrec")
@Controller
public class SysApiRequestRecController extends AbstractDtController {
	
	@Autowired
	private IApiRequestRecService apiRequestRecService;
	
	/**
	 * 统计在线时长
	 * @param map
	 * @return
	 */
	@RequestMapping("index")
	protected String index(final ModelMap map) {
		try {
			String time = this.apiRequestRecService.geTimeCount();
			map.put("time", time);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return "admin/apirequestrec/index";
	}
	
	/**
	 * 加载在线时长统计列表
	 * @param userName
	 * @param phoneNum
	 * @param params
	 * @return
	 */
	@RequestMapping("apirequestrecs")
	@ResponseBody
	protected JSONObject findCustomer(String userName, String phoneNum,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.apiRequestRecService.findApiRequestRec(
							Params.getParams().add("userName", userName)
									.add("phoneNum", phoneNum).filterEmpty(),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
}
