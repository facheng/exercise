package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.FocusResident;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.service.IFocusResidentServie;
import com.dt.tarmag.service.IHouseService;
import com.dt.tarmag.service.IResidentService;
import com.dt.tarmag.service.IStoryService;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.vo.FocusResidentVo;
import com.dt.tarmag.vo.ResidentVo;

/**
 * 需要关注的业主
 * @author jiaosf
 * @since 2015-7-17
 */
@Controller
public class HouseFocusResidentController {
	
	@Autowired
	private IFocusResidentServie  focusResidentServie;
	
	@Autowired
	private IUnitPartitionService unitPartitionService;
	
	@Autowired
	private IStoryService storyService;
	
	@Autowired
	private IHouseService houseService;
	
	@Autowired
	private IResidentService residentService;
	
	private  final Logger logger = LoggerFactory.getLogger(HouseFocusResidentController.class);
	
	
	/**
	 * 显示需要关注的业主列表
	 * @param pageNo
	 * @param pageSize
	 * @param roomNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/resident/focus", method = GET)
	public String focusResidentList(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="roomNum" , required = false) String roomNum
			, @RequestParam(value="residentStatus" , required = false) Byte residentStatus
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//分页设置
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		//获取数据
		int count = focusResidentServie.getFocusResidentCount(unitId , roomNum ,residentStatus);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> focusResidentList = focusResidentServie.getFocusResidentList(unitId, roomNum , residentStatus, pageNo, pageSize);
		 
		model.put("roomNum", roomNum);
		model.put("residentStatus", residentStatus);
		model.put("page", page);
		model.put("focusResidenList", focusResidentList);
		return "to.show.resident.focus";
	}
	
	/**
	 * 房屋信息初始化
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/resident/focus/info/{id}", method = GET)
	public String getFocusResidentInfo(@PathVariable(value = "id") long frId,
		ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		//获取当前小区期数
		List<UnitPartition> ups = unitPartitionService.getUnitPartitionListByUnitId(unitId);
		
		if(frId != 0){
			//设置修改参数回显
			FocusResidentVo frV = focusResidentServie.getFocusResidentInfo(frId);
			model.put("fr", frV);
		}
		model.put("ups", ups);
		model.put("frId", frId);
		return "to.edit.focus.resident";
	}
	
	/**
	 * 修改或者添加需要关注的业主
	 * @param roleId
	 * @param vo
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/house/resident/focus/edit", method = POST)
	public String toSaveOrUpdate(FocusResidentVo focusResidentVo, ModelMap model) throws Exception{
		
		focusResidentServie.saveOrUpdate_tx(focusResidentVo);
		
		return ActionUtil.redirect("/house/resident/focus");
	} 
	
	
	/**
	 * 根据期数获取楼栋
	 * @return
	 */
	@RequestMapping("/story/findStory")
	@ResponseBody
	public Map<String,Object> findStory(long partitionId) {
		try {
			List<Story> storys = storyService.getStoryListByPartitionId(partitionId);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("storys", storys);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("get story failed ! ", e);
			return null;
		}
	}
	
	/**
	 * 根据楼栋获取房屋
	 * @return
	 */
	@RequestMapping("/house/findHouse")
	@ResponseBody
	public Map<String,Object> findHouse(long storyId) {
		try {
			List<House> houses = houseService.getHouseListByStoryId(storyId);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("houses", houses);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("get houses failed ! ", e);
			return null;
		}
	}
	
	/**
	 * 根据房屋室号获取住户
	 * @return
	 */
	@RequestMapping("/resident/findResident")
	@ResponseBody
	public Map<String,Object> findResident(long houseId) {
		try {
			List<ResidentVo> residents = residentService.getResidentByHouseIdAndType(houseId);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("residents", residents);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("get houses failed ! ", e);
			return null;
		}
	}
	
	/**
	 * 移除需要关注的业主
	 * @param houseResidentIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/resident/focus/remove", method = POST)
	@ResponseBody
	public String removeFocusResident(@RequestParam(value = "frIds", required = true) String frIds,
			ModelMap model){
		if(frIds == null || frIds.trim().equals("")) {
			return "0";
		}
		String[] arr = frIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		focusResidentServie.removeFocusResident_tx(idList);
		
		return "1";
	}
	
	/**
	 * 校验需要关注的业主是否存在
	 * @param id
	 * @param name
	 * @return
	 */
	@RequestMapping(value = "/ajax/user/fr", method = POST)
	@ResponseBody
	public String checkfocusResident(@RequestParam(value = "id", required = false) long id
			, @RequestParam(value = "hrId", required = true) long hrId){
		
		if(hrId == 0) {
			return "0";
		}
		List<FocusResident> focusResidents = focusResidentServie.getfocusResidentByHrId(hrId);
		if(focusResidents != null && focusResidents.size() == 0) {
			return "1";
		} else if(focusResidents != null && focusResidents.size() == 1){
			if(id == focusResidents.get(0).getId()){
				return "1";
			}
		} 
		
		return "0";
	}
	
}
