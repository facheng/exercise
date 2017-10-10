package com.dt.tarmag.web;


import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.tarmag.service.IHouseResidentService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.Params;

/**
 * 用户使用率统计
 * @author jiaosf
 * @since 2015-8-7
 */
@RequestMapping("sysusagestatistics")
@Controller
public class SysUsageStatisticsController extends AbstractDtController {
	
	@Autowired
	private IHouseResidentService houseResidentService;
	 
	
	/**
	 * 跳转使用情况统计面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/usagestatistics/index";
	}
	
	
	
	@RequestMapping("usagestatistics")
	@ResponseBody
	protected JSONObject findCustomer(String unitName,
			final DataTableParams params) {
		
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.houseResidentService.findUsageStatistics(
							Params.getParams().add("unitName", unitName).filterEmpty(),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
}
