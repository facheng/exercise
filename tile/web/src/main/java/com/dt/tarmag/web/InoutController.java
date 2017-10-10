package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.service.IInOutService;
import com.dt.tarmag.vo.InoutSearchVo;


/**
 * 出入统计
 * @author yuwei
 * @Time 2015-7-7下午02:24:26
 */
@Controller
public class InoutController {
	@Autowired
	private IInOutService inOutService;
	
	

	/**
	 * 车辆出入记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inout/vehicle", method = GET)
	public String showInoutVehicleList(ModelMap model){
		
		
		return "to.show.inout.vehicle.list";
	}

	/**
	 * 行人出入记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inout/passerby", method = GET)
	public String showInoutPasserbyList(InoutSearchVo searchVo
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		/**
		 * 如果没有时间，默认“今天”
		 **/
		if(searchVo == null) {
			searchVo = new InoutSearchVo();
		}
		if(searchVo.getTimeFlag() == null) {
			searchVo.setTimeFlag((byte) 2);
			searchVo.setTimeType((byte) 1);
		}
		
		int count = inOutService.getInoutPasserbyCount(unitId, searchVo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = inOutService.getInoutPasserbyList(unitId, searchVo, pageNo, pageSize);

		searchVo.calculateDate();
		model.put("searchVo", searchVo);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.show.inout.passerby.list";
	}

	/**
	 * 车辆非正常出入记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inout/vehicle/exception", method = GET)
	public String showInoutVehicleExceptionList(ModelMap model){
		
		
		return "to.show.inout.vehicle.exception.list";
	}

	/**
	 * 行人非正常出入记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/inout/passerby/exception", method = GET)
	public String showInoutPasserbyExceptionList(ModelMap model){
		
		
		return "to.show.inout.passerby.exception.list";
	}
	
	
	/**
	 * 行人出入记录统计
	 * @param searchVo
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/inout/passerby/statistics", method = GET)
	public String showInoutPasserbyStatistics(Byte timeType , ModelMap model) throws Exception{
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		inOutService.getInoutPasserbyStatistics(unitId ,timeType ,model);
		return "to.show.inout.passerby.statistics";
	}
}
