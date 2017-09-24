/*
 * 版权所有 团团科技 沪ICP备14043145号
 * 
 * 团团科技拥有此网站内容及资源的版权，受国家知识产权保护，未经团团科技的明确书面许可，
 * 任何单位或个人不得以任何方式，以中文和任何文字作全部和局部复制、转载、引用。
 * 否则本公司将追究其法律责任。
 * 
 * $Id$
 * $URL$
 */
package com.dt.tarmag.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.LocaleUtil;
import com.dt.tarmag.model.City;
import com.dt.tarmag.model.District;
import com.dt.tarmag.service.IAreaService;


/**
 * 省、市、区 管理
 *
 * @author Administrator
 * @since 2015年7月6日
 */
@Controller
public class AdminAreaController {
	
	private  final Logger logger = LoggerFactory.getLogger(AdminAreaController.class);
	
	@Autowired
	private IAreaService areaService;
	
	/**
	 * 根据省id获取城市
	 * @return
	 */
	@RequestMapping("/admin/findCitys")
	@ResponseBody
	public Map<String,Object> findCitys(City city) {
		try {
			city.setLocale(LocaleUtil.getLocale().toString());
			List<City> citys = areaService.findCitys(city);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("citys", citys);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("errer message", e);
			return null;
		}
	}
	
	/**
	 * 根据市id获取县
	 * @return
	 */
	@RequestMapping("/admin/findDistricts")
	@ResponseBody
	public Map<String,Object> findDistricts(District district) {
		try {
			district.setLocale(LocaleUtil.getLocale().toString());
			List<District> districts = areaService.findDistricts(district);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("districts", districts);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("errer message", e);
			return null;
		}
	}
	

}
