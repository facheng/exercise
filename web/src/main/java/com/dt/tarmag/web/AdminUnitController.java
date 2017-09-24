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

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.ImgUploadUtil;
import com.dt.framework.util.LocaleUtil;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.City;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.Province;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.service.IAreaService;
import com.dt.tarmag.service.ICustomerService;
import com.dt.tarmag.service.IUnitService;
import com.dt.tarmag.vo.UnitVo;


/**
 * 小区信息管理
 *
 * @author Administrator
 * @since 2015年7月6日
 */
@Controller
public class AdminUnitController {
	private final static Logger logger = Logger.getLogger(AdminUnitController.class);
	
	@Autowired
	private IUnitService unitService;
	
	@Autowired
	private IAreaService areaService;
	
	@Autowired
	private ICustomerService customerService;
	
	/**
	 * 
	 * 返回分页或的结果.
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/unit/list", method = GET)
	public String findPageUnit (
			@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value = "serachUnitName", required = false) String serachUnitName
			, ModelMap model){
		logger.info("findPageUnit start...........");
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		long userId = ActionUtil.getSessionUserId();
		Customer admin = customerService.findCustomerById(userId);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		Map<String, Object> params = new HashMap<String, Object>();

		params.put("companyId", admin.getCompanyId());
		
		if(StringUtils.isNotBlank(serachUnitName)){
			params.put("unitName", "%" + serachUnitName + "%");
		}

		int count = unitService.findCountUnit(params);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> resultList = unitService.findPageUnit(pageNo, pageSize, params);
		
		model.put("units", resultList);
		model.put("page", page);
		model.put("serachUnitchName", serachUnitName);

		logger.info("findPageUnit end...........");
		return "to.unit.index";
		
	}
	
	/**
	 * 跳转到添加页面
	 * @return
	 */
	@RequestMapping("/admin/unit/edit/init")
	public String toAddUnitPage(ModelMap model,Unit unit){
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		long userId = ActionUtil.getSessionUserId();
		Customer admin = customerService.findCustomerById(userId);
		
		
		Province province = new Province();
		province.setLocale(LocaleUtil.getLocale().toString());
		List<Province>  provinces = areaService.findProvinces(province);
		
		model.put("provinces", provinces);
		
		//id 不等于0 表示编辑
		if(unit.getId() != 0){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", unit.getId());
			params.put("locale", LocaleUtil.getLocale().toString());
			List<Map<String, Object>> units = unitService.findUnitById(params);
			if(units != null && units.size() > 0){
				Map<String, Object> mapUnit = units.get(0);
				
				model.put("districtId", mapUnit.get("districtId"));
				Long cityId = Long.parseLong(mapUnit.get("cityId").toString());
				City city = new City();
				city.setCityId(cityId);
				city.setLocale(LocaleUtil.getLocale().toString());
				List<City> citys = areaService.findCitys(city);
				
				Double longitude = Double.valueOf(mapUnit.get("longitude").toString());
				
				Double lantitude = Double.valueOf(mapUnit.get("lantitude").toString());
				
				if(longitude == 0.0){
					mapUnit.put("longitude", null);
				}
				if(lantitude == 0.0){
					mapUnit.put("lantitude", null);
				}
				
				model.put("mapUnit", mapUnit);
				model.put("cityId", cityId);
				if(citys != null && citys.size() > 0){
					Long provinceId = citys.get(0).getProvinceId();
					model.put("provinceId", provinceId);
				}
			}
		}
		model.put("companyId", admin.getCompanyId());
		return "to.unit.edit";
	}
	
	/**
	 * 
	 * 添加或修改小区信息
	 * @param companyBranch
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/unit/edit")
	public String saveOrUpdateUnit(MultipartFile unitImg, ModelMap model, UnitVo unitVo) throws Exception {

		// 如果小区背景不为空，则上传
		String storeURL = "";
		if (unitImg.getSize() !=0) {
			
			storeURL = ImgUploadUtil.uploadFile(PortalConstants.FILE_STORE_URL + File.separator + PortalConstants.IMG_URL + File.separator +Unit.IMG_PATH + File.separator, unitImg.getInputStream());
			
		}

		unitService.saveOrUpdate_tx(unitVo, storeURL);

		return ActionUtil.redirect("/admin/unit/list");
	}
	
	/**
	 * 删除小区信息
	 * @param id
	 * 			主键
	 * @return
	 */
	@RequestMapping(value = "/admin/unit/del")
	public @ResponseBody
	Map<String, Object> delUnitInfo(@RequestParam(value = "id", required = true) Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Unit unit = new Unit();
			unit.setId(id);
			unitService.delUnit_tx(unit);
			map.put("flag", true);
			return map;
		}
		catch (Exception e) {
			e.printStackTrace();
			map.put("flag", false);
			return map;
		}
	}
	
	/**
	 * 小区信息详情
	 * @return
	 */
	@RequestMapping("/admin/uint/info")
	public String toUnitInfoPage(ModelMap model,Unit unit){
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		//id 不等于0 表示编辑
		if(unit.getId() != 0){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", unit.getId());
			params.put("locale", LocaleUtil.getLocale().toString());
			List<Map<String, Object>> units = unitService.findUnitById(params);
			if(units != null && units.size() > 0){
				Map<String, Object> mapUnit = units.get(0);
				
				model.put("districtId", mapUnit.get("districtId"));
				
				Long cityId = Long.parseLong(mapUnit.get("cityId").toString());
				City city = new City();
				city.setCityId(cityId);
				city.setLocale(LocaleUtil.getLocale().toString());
				//市
				List<City> citys = areaService.findCitys(city);
				
				if(citys != null && citys.size() > 0){
					mapUnit.put("cityName", citys.get(0).getCityName());
					
					Long provinceId = citys.get(0).getProvinceId();
					
					Province province = new Province();
					province.setProvinceId(provinceId);
					province.setLocale(LocaleUtil.getLocale().toString());
					//省
					List<Province> provinces = areaService.findProvincebyProvinceId(province);
					if(provinces != null && provinces.size() > 0){
						mapUnit.put("provinceName", provinces.get(0).getProvinceName());
					}
				}
				model.put("mapUnit", mapUnit);
			}
		}
		return "to.unit.info";
	}

}
