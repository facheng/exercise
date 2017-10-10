package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.tarmag.service.IResidentService;


/**
 * @author yuwei
 * @Time 2015-7-22下午12:37:35
 */
@Controller
public class HouseResidentController {
	@Autowired
	private IResidentService residentService;
	
	
	/**
	 * 根据房屋查询住户信息
	 * @return
	 */
	@RequestMapping(value = "/ajax/house/{id}/residents", method = GET)
	@ResponseBody
	public Map<String, Object> getResidentsByHouseIs(@PathVariable(value = "id") long houseId) {
		List<Map<String, Object>> residentList = residentService.getResidentListByHouseId(houseId);
		Map<String, Object>  map = new HashMap<String, Object>();
		map.put("residentList", residentList);
		return map;
	}
}
