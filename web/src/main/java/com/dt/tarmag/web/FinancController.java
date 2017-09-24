package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 账务统计
 * @author yuwei
 * @Time 2015-7-7下午02:34:57
 */
@Controller
public class FinancController {

	/**
	 * 物业费缴纳信息
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/financ/property/charges", method = GET)
	public String showFinancPropertyCharges(ModelMap model){
		
		
		return "to.show.financ.property.charges";
	}

	/**
	 * 车辆费缴纳信息
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/financ/vehicle/charges", method = GET)
	public String showFinancVehicleCharges(ModelMap model){
		
		
		return "to.show.financ.vehicle.charges";
	}
}
