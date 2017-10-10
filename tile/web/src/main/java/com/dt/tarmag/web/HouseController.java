package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.BufferedOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.service.IHouseResidentService;
import com.dt.tarmag.service.IHouseService;
import com.dt.tarmag.service.IInfoService;
import com.dt.tarmag.service.IPropertyChargeService;
import com.dt.tarmag.service.IResidentService;
import com.dt.tarmag.service.IStoryService;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.service.IUnitService;
import com.dt.tarmag.vo.HouseVo;
import com.dt.tarmag.vo.PropertyChargeBillSearchVo;
import com.dt.tarmag.vo.ResidentVo;
import com.dt.tarmag.vo.Tree;

/**
 * 房屋管理
 *
 * @author jiaoshaofeng
 * @since 2015年6月30日
 */
@Controller
public class HouseController {
	
	private static final Logger logger = LoggerFactory.getLogger(HouseController.class);

	@Autowired
	private IHouseService houseService;
	@Autowired
	private IStoryService storyService;
	@Autowired
	private IUnitService unitService;
	@Autowired
	private IResidentService residentService;
	@Autowired
	private IHouseResidentService houseResidentService;
	@Autowired
	private IUnitPartitionService unitPartitionService;
	
	@Autowired
	private IPropertyChargeService propertyChargeService;
	
	@Autowired
	private IInfoService infoService;
	
	

	/**
	 * 房屋统计
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/statistics", method = GET)
	public String showHouseStatistics(ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		int count = houseService.getHouseCountByUnitId(unitId);
		JSONArray jsonArrResult = houseService.getHouseStatisticsJson(unitId);

		model.put("count", count);
		model.put("jsonArrResult", jsonArrResult);
		return "to.house.statistics";
	}
	
	/**
	 * 房屋管理列表
	 * @param pageNo
	 * @param pageSize
	 * @param dyCode
	 * @param status
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/list", method = GET)
	public String houseMangelist (@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="rno" , required = false) String rno 
			, @RequestParam(value="status" , required = false) Byte status
			, @RequestParam(value="partitionId" , required = false) Long partitionId 
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//获取片区列表
		List<UnitPartition> unitPs = unitPartitionService.getUnitPartitionListByUnitId(unitId);
		
		//分页设置
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		//获取数据
		int count = houseService.getHouseCount(unitId, status, rno , partitionId);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> houseList = houseService.getHouseList(unitId, status , rno,  partitionId , pageNo,  pageSize);
		
		model.put("status", status);
		model.put("rno", rno);
		model.put("partitionId", partitionId);
		model.put("page", page);
		model.put("unitPs", unitPs);
		model.put("houseList", houseList);
		return "to.show.house.list";
	}
	
	/**
	 * 房屋详细
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/message", method = GET)
	public String houseMessage(@RequestParam(value="houseId" , required = true) long houseId,ModelMap model){
		//查询房屋详情
		House house = houseService.getHouseById(houseId);
		//查询住户信息
		List<Map<String ,Object>> residentList = residentService.getResidentByHouseId(houseId);
		model.put("house", house);
		model.put("residentList", residentList);
		return "to.house.message";
	}
	
	/**
	 * 房屋修改
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/{id}", method = GET)
	public String toEditHouse(@PathVariable(value = "id") long houseId, ModelMap model){
		Map<String, Object> map = houseService.getHouseToEdit(houseId);
		model.put("map", map);
		return "to.edit.house";
	}
	
	/**
	 * 房屋修改保存
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/{id}", method = POST)
	public String saveHouse(@PathVariable(value = "id") long houseId, HouseVo vo, ModelMap model){
		houseService.updateHouse_tx(houseId, vo);
		return ActionUtil.redirect("/house/list");
	}
	
	/**
	 * 检查指定房屋下是否可以绑定某住户
	 * 1可，0不可
	 * @param houseId
	 * @param phoneNum
	 * @return
	 */
	@RequestMapping(value = "/house/{houseId}/phone/validate", method = POST)
	@ResponseBody
	public String checkHouseResident(@PathVariable(value = "houseId") long houseId
			, @RequestParam(value = "phoneNum", required = true) String phoneNum
			, @RequestParam(value = "hrId", required = false) Long houseResidentId){
		if(CommonUtil.isMobile(phoneNum) == false) {
			return "0";
		}
		
		HouseResident houseResident = houseService.getHouseResident(houseId, phoneNum);
		if(houseResidentId == null) {
			return houseResident == null ? "1" : "0";
		}
		
		return houseResident == null || houseResident.getId() == houseResidentId ? "1" : "0";
	}

	/**
	 * 绑定房屋住户
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/{houseId}/resident/bind", method = POST)
	public String bindHouseResident(@PathVariable(value = "houseId") long houseId
			, ResidentVo vo, ModelMap model) {
		houseResidentService.bindHouseResident_tx(houseId, vo);
		return ActionUtil.redirect("/house/list");
	}

	/**
	 * 解绑房屋住户
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/resident/unbind", method = POST)
	@ResponseBody
	public String unbindHouseResident(@RequestParam(value = "houseResidentId", required = true) long houseResidentId
			, ModelMap model) {
		houseResidentService.delete_tx(houseResidentId);
		return "1";
	}

	/**
	 * 修改房屋住户绑定
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/resident/bind/modify/{hrId}", method = POST)
	public String modifyBindHouseResident(@PathVariable(value = "hrId") long houseResidentId
			, ResidentVo vo, ModelMap model) {
		houseResidentService.modifyBindHouseResident_tx(houseResidentId, vo);
		HouseResident houseResident = houseResidentService.getHouseResidentById(houseResidentId);
		return ActionUtil.redirect("/house/message?houseId=" + houseResident.getHouseId());
	}
	
	

	/**
	 * 查询需要审核的房屋
	 * @param state
	 * @param roomNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/review", method = GET)
	public String showHouseReviewList(@RequestParam(value = "state", required = false) Byte state
			, @RequestParam(value = "roomNo", required = false) String roomNo
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="partitionId" , required = false) Long partitionId 
			, @RequestParam(value="userName" , required = false) String userName 
			, @RequestParam(value="phoneNum" , required = false) String phoneNum 
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//获取片区列表
		List<UnitPartition> unitPs = unitPartitionService.getUnitPartitionListByUnitId(unitId);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		//int count = houseService.getHouseResidentReviewCount(unitId, state, roomNo);
		int count = houseService.getHouseResidentReviewCount(unitId, state, roomNo , partitionId , userName , phoneNum);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		//List<Map<String, Object>> houseResidenList = houseService.getHouseResidentReviewMapList(unitId, state, roomNo, pageNo, pageSize);
		List<Map<String, Object>> houseResidenList = houseService.getHouseResidentReviewList(unitId, state, roomNo ,partitionId , userName , phoneNum , pageNo, pageSize);
		
		model.put("state", state);
		model.put("roomNo", roomNo);
		model.put("partitionId", partitionId);
		model.put("userName", userName);
		model.put("phoneNum", phoneNum);
		model.put("page", page);
		model.put("unitPs", unitPs);
		model.put("houseResidenList", houseResidenList);
		return "to.show.house.review.list";
	}
	
	/**
	 * 核准房屋绑定。
	 * houseResidentIds为需要核准的房屋住户关系表ID，多个值用半角逗号(,)隔开
	 * @param houseResidentIds
	 * @param model
	 * @return
	 * 1成功；0失败
	 */
	@RequestMapping(value = "/house/review/approve", method = POST)
	@ResponseBody
	public String approveHouseReview(@RequestParam(value = "houseResidentIds", required = true) String houseResidentIds, ModelMap model){
		if(houseResidentIds == null || houseResidentIds.trim().equals("")) {
			return "0";
		}
		
		String[] arr = houseResidentIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		houseService.doHouseResidentReview_tx(idList, HouseResident.IS_APPROVED_YES);
		return "1";
	}
	
	/**
	 * 驳回房屋绑定。
	 * houseResidentIds为需要驳回的房屋住户关系表ID，多个值用半角逗号(,)隔开
	 * @param houseResidentIds
	 * @param model
	 * @return
	 * 1成功；0失败
	 */
	@RequestMapping(value = "/house/review/reject", method = POST)
	@ResponseBody
	public String rejectHouseReview(@RequestParam(value = "houseResidentIds", required = true) String houseResidentIds, ModelMap model){
		if(houseResidentIds == null || houseResidentIds.trim().equals("")) {
			return "0";
		}
		
		String[] arr = houseResidentIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		houseService.doHouseResidentReview_tx(idList, HouseResident.IS_APPROVED_REJECT);
		return "1";
	}

	/**
	 * 车辆出入记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/vehicle/records", method = GET)
	public String showHouseVehicleRecords(ModelMap model){
		
		
		return "to.show.house.vehicle.records";
	}

	/**
	 * 缴费管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/payment", method = GET)
	public String showPaymentRecords(
			@RequestParam(value = "pageNo", required = false) Integer pageNo,
			@RequestParam(value = "pageSize", required = false) Integer pageSize,
			PropertyChargeBillSearchVo pbSearchVo,
			ModelMap model
			) {
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		/**
		 * 如果没有时间，默认“今天”
		 **/
		if(pbSearchVo == null) {
			pbSearchVo = new PropertyChargeBillSearchVo();
		}
		if(pbSearchVo.getTimeFlag() == null) {
			pbSearchVo.setTimeFlag((byte) 2);
			pbSearchVo.setTimeType((byte) 1);
		}
		
		//获取数据
		int count = propertyChargeService.getPropertyChargeCount(unitId, pbSearchVo);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		
		List<Map<String ,Object>> propertyChargeList = propertyChargeService.getPropertyChargeList(unitId, pbSearchVo, pageNo, pageSize);
		pbSearchVo.calculateDate();
		model.put("page", page);
		model.put("pbSearchVo", pbSearchVo);
		model.put("propertyChargeList", propertyChargeList);
		
		return "to.show.payment.records";
	}
	
	/**
	 * 更新缴费状态
	 * @param houseResidentIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/payment/new/status", method = POST)
	@ResponseBody
	public String updatePropertyChargeStatus(@RequestParam(value = "pcIds", required = true) String pcIds,
			@RequestParam(value = "opt", required = true) String opt,
			ModelMap model){
		if(pcIds == null || pcIds.trim().equals("")) {
			return "0";
		}
		String[] arr = pcIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		propertyChargeService.updatePropertyChargeStatus_tx(idList,opt);
		
		return "1";
	}
	
	/**
	 * 发送缴费通知
	 * @param houseResidentIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/house/payment/notice", method = POST)
	@ResponseBody
	public String sendPaymentNotice(@RequestParam(value = "pcIds", required = true) String pcIds,
			ModelMap model){
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		if(pcIds == null || pcIds.trim().equals("")) {
			return "0";
		}
		String[] arr = pcIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		this.infoService.sendPaymentNotice_tx(idList ,unitId);
		
		return "1";
	}
	
	/**
	 * 房屋管理-导出
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @param houseInfo
	 */
	@RequestMapping("/house/houseInfoExport")
	@ResponseBody
	public void houseInfoExport(HttpServletRequest request,HttpServletResponse response, ModelMap map,House house) {
		try {
			Object objUnitId =  ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
			String unitId = objUnitId == null ? "" : objUnitId.toString();
			unitId = "14";
			if(StringUtils.isNotBlank(unitId)){
				house.setUnitId(Long.parseLong(unitId));
			}
			
			String path = request.getSession().getServletContext().getRealPath("/dt-static/uploadfile/houseInfoImport.xls");
			
			HSSFWorkbook wb = houseService.findHouseInfosExcel(house,path);
			
			response.setHeader("content-disposition",
					"attachment;filename=houseInfoImport.xls");
			BufferedOutputStream out = new BufferedOutputStream(
					response.getOutputStream());
			wb.write(out);
			out.flush();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("errer message", e);
			map.put("memo", "物业管理");
		}
	}
	
	
	/**
	 * 查询指定小区下所有房屋
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/unit/{unitId}/houses", method = GET)
	public String getUnitHouses(@PathVariable(value = "unitId") long unitId, ModelMap model){
		List<Tree> trees = houseService.getHouseTreeByUnitId(unitId);
		model.put("trees", trees);
		return "ajax.get.unit.houses";
	}

	/**
	 * 查询指定小区下的所有楼栋
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/unit/{unitId}/stories", method = GET)
	public String getUnitStories(@PathVariable(value = "unitId") long unitId, ModelMap model){
		List<Tree> trees = storyService.getStoryTreeByUnitId(unitId);
		model.put("trees", trees);
		return "ajax.get.unit.stories";
	}

	/**
	 * 查询指定楼栋下的所有房屋
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/story/{storyId}/houses", method = GET)
	public String getStoryHouses(@PathVariable(value = "storyId") long storyId, ModelMap model){
		List<Tree> trees = houseService.getStoryHouseByStoryId(storyId);
		model.put("trees", trees);
		return "ajax.get.story.houses";
	}
	

	/**
	 * 根据小区期数查询楼栋
	 * @return
	 */
	@RequestMapping(value = "/ajax/partition/{id}/stories", method = GET)
	@ResponseBody
	public Map<String, Object> getStoryMapListByPartitionId(@PathVariable(value = "id") long partitionId) {
		List<Map<String, Object>> storyList = storyService.getStoryMapListByPartitionId(partitionId);
		Map<String, Object>  map = new HashMap<String, Object>();
		map.put("storyList", storyList);
		return map;
	}
	
	/**
	 * 查房屋地址(小区的地址+房屋的dycode)
	 * @param houseId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/house/{id}/address", method = GET)
	@ResponseBody
	public String getHouseAddress(@PathVariable(value = "id") long houseId, ModelMap model){
		House house = houseService.getHouseById(houseId);
		if(house == null) {
			return "";
		}
		
		Unit unit = unitService.getUnitById(house.getUnitId());
		if(unit == null) {
			return "";
		}
		
		return unit.getAddress() + " " + house.getDyCode();
	}
	
}
