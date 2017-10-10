package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.framework.util.TextUtil;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.service.ICarService;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.vo.CarPortVo;
import com.dt.tarmag.vo.CarVo;



/**
 * 车辆管理
 * @author yuwei
 * @Time 2015-7-30下午01:32:13
 */
@Controller
public class HouseCarController {
	@Autowired
	private ICarService carService;
	@Autowired
	private IUnitPartitionService unitPartitionService;


	/**
	 * 车位管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/list", method = GET)
	public String showHouseCarportList(CarPortVo searchVo
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
		
		int count = carService.getCarportCount(unitId, searchVo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = carService.getCarportMapList(unitId, searchVo, pageNo, pageSize);
		
		Map<Byte, String> btypesMap = CarPort.getAllBindTypes();
		
		model.put("searchVo", searchVo);
		model.put("btypesMap", btypesMap);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.show.house.carport.list";
	}

	/**
	 * 车位详情
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}/detail", method = GET)
	public String showCarportDetail(@PathVariable(value = "id") long portId, ModelMap model){
		Map<String, Object> map = carService.getCarportDetail(portId);
		
		if(map != null && !map.isEmpty()) {
			Object portNo = map.get("portNo");
			if(portNo != null) {
				String _title = TextUtil.getText("house.carport.detail") + " - " + portNo;
				model.put("_title", _title);
			}
		}
		
		Map<Byte, String> btypesMap = CarPort.getAllBindTypes();

		model.put("btypesMap", btypesMap);
		model.put("map", map);
		return "to.car.port.detail";
	}
	
	/**
	 * 修改车位信息
	 * 只有“已租”状态的车位才能修改
	 * @param portId
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}", method = POST)
	public String updateCarport(@PathVariable(value = "id") long portId
			, CarPortVo vo
			, ModelMap model){
		carService.updateCarport_tx(portId, vo);
		return ActionUtil.redirect("/house/carport/" + portId + "/detail");
	}

	/**
	 * 删除车位，只有“空置”状态的车位才可删除
	 * 返回：1成功，0失败
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}", method = DELETE)
	@ResponseBody
	public String deleteCarport(@PathVariable(value = "id") long portId , ModelMap model){
		boolean b = carService.deleteCarport_tx(portId);
		return b ? "1" : "0";
	}
	
	/**
	 * 车位解绑，只有非“空置”状态的车位才可解绑
	 * 返回：1成功，0失败
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}/unbind", method = POST)
	@ResponseBody
	public String unbindCarport(@PathVariable(value = "id") long portId, ModelMap model){
		boolean b = carService.unbindCarport_tx(portId);
		return b ? "1" : "0";
	}

	/**
	 * 跳转到绑定车位页面
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}/bind", method = GET)
	public String toBindCarport(@PathVariable(value = "id") long portId, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		Map<Byte, String> rentPeriodsMap = CarPort.getAllBindRentPeriods();
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);
		
		Map<String, Object> map = carService.getCarportToEdit(portId);

		model.put("rentPeriodsMap", rentPeriodsMap);
		model.put("partitionList", partitionList);
		model.put("map", map);
		return "to.bind.car.port";
	}
	
	/**
	 * 绑定车位与住户
	 * 返回：1成功，0失败
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/carport/{id}/bind", method = POST)
	public String bindCarport(@PathVariable(value = "id") long portId
			, CarPortVo vo, ModelMap model){
		carService.bindCarport_tx(portId, vo);
		return ActionUtil.redirect("/house/carport/list");
	}

	/**
	 * 车辆管理
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/car/list", method = GET)
	public String showHouseCarList(CarVo searchVo
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
		
		int count = carService.getCarCount(unitId, searchVo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = carService.getCarMapList(unitId, searchVo, pageNo, pageSize);
		
		model.put("searchVo", searchVo);
		model.put("page", page);
		model.put("resultList", resultList);
		
		return "to.show.house.car.list";
	}
	
	/**
	 * 跳转到添加车辆信息页面
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/car", method = GET)
	public String toEditCar( @RequestParam( value = "id" , required = false)Long carId , ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		Map<String , Object > map = new HashMap<String, Object>();
		
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);
		if( carId != null ){
			map = carService.getCarDetail(carId);
		}
		
		model.put("partitionList", partitionList);
		model.put("map", map);
		return "to.edit.car";
	}
	
	
	/**
	 *	保存车辆信息
	 * 返回：1成功，0失败
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/car", method = POST)
	public String saveCar(@RequestParam(value = "id",required = false ) Long carId
			, CarVo vo, ModelMap model){
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		if( carId == null ){
			
			 carService.createCar_tx(vo);
		} else {
			
			carService.updateCar_tx(carId, vo);
		}
		
		return ActionUtil.redirect("/house/car/list");
	}
	
	/**
	 * 判断车牌是否重复
	 * 返回：1可 0不可
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/car/plate", method = POST)
	@ResponseBody
	public String checkCarIsExist(@RequestParam(value = "plateNo", required = true) String plateNo , ModelMap model){
		if(plateNo == null || "".equals(plateNo.trim())){
			return "0";
		}
		
		boolean b = carService.checkCarIsExist(plateNo);
		return b ? "0" : "1";
	}
	
	/**
	 * 车辆详情
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/car/{id}/detail", method = GET)
	public String showCarDetail(@PathVariable(value = "id") long carId, ModelMap model){
		Map<String, Object> map = carService.getCarDetail(carId);
		
		if(map != null && !map.isEmpty()) {
			Object portNo = map.get("portNo");
			if(portNo != null) {
				String _title = TextUtil.getText("house.car.detail") + " - " + portNo;
				model.put("_title", _title);
			}
		}

		model.put("map", map);
		return "to.car.detail";
	}
	
	/**
	 * 删除车辆信息
	 * 返回：1成功，0失败
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/cars", method = DELETE)
	@ResponseBody
	public String deleteCar(@RequestParam(value = "carIds" , required = true) String carIds , ModelMap model){
		
		if(carIds == null || carIds.trim().equals("")) {
			return "0";
		}
		String[] arrs = carIds.trim().split(",");
		if(arrs == null || arrs.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arrs) {
			idList.add(Long.parseLong(id));
		}
		
		boolean b = carService.deleteCars_tx(idList);
		
		return b ? "1" : "0";
	}
	
}






