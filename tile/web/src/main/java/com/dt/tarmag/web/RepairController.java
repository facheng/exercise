package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

import java.io.File;
import java.util.Calendar;
import java.util.Date;
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
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.model.Repair;
import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.service.ICommonWordsService;
import com.dt.tarmag.service.IRepairService;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.vo.RepairSearchVo;
import com.dt.tarmag.vo.RepairVo;


/**
 * 报修管理
 * @author yuwei
 * @Time 2015-7-7下午02:34:57
 */
@Controller
public class RepairController {
	
	@Autowired
	private IRepairService repairService;
	@Autowired
	private IUnitPartitionService unitPartitionService;

	@Autowired
	private ICommonWordsService commonWordsService;
	

	/**
	 * 未分派的报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/unassigned", method = GET)
	public String showUnAssignedRepairRecList(RepairSearchVo searchVo
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
			searchVo = new RepairSearchVo();
		}
		if(searchVo.getTimeFlag() == null) {
			searchVo.setTimeFlag((byte) 2);
			searchVo.setTimeType((byte) 1);
		}
		
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);

		int count = repairService.getUnAssignedRepairRecCount(unitId, searchVo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = repairService.getUnAssignedRepairRecList(unitId, searchVo, pageNo, pageSize);

		searchVo.calculateDate();
		model.put("repairTypeList", Repair.getAllRepairTypes());
		model.put("serviceTypeList", Repair.getAllServiceTypes());
		model.put("partitionList", partitionList);
		model.put("statusList", Repair.getUnAssignedStatuses());
		model.put("urgentStateList", Repair.getAllUrgentStates());
		model.put("searchVo", searchVo);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.show.unassigned.repair.rec.list";
	}

	/**
	 * 已分派的报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/assigned", method = GET)
	public String showAassignedRepairRecList(RepairSearchVo searchVo
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
			searchVo = new RepairSearchVo();
		}
		if(searchVo.getTimeFlag() == null) {
			searchVo.setTimeFlag((byte) 2);
			searchVo.setTimeType((byte) 1);
		}
		
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);

		int count = repairService.getAssignedRepairRecCount(unitId, searchVo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = repairService.getAssignedRepairRecList(unitId, searchVo, pageNo, pageSize);

		searchVo.calculateDate();
		model.put("repairTypeList", Repair.getAllRepairTypes());
		model.put("serviceTypeList", Repair.getAllServiceTypes());
		model.put("partitionList", partitionList);
		model.put("statusList", Repair.getAssignedStatuses());
		model.put("urgentStateList", Repair.getAllUrgentStates());
		model.put("searchVo", searchVo);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.show.assigned.repair.rec.list";
	}
	
	/**
	 * 根据小区期数+维修工种查询小区工作人员
	 * @return
	 */
	@RequestMapping(value = "/ajax/partition/{pid}/wtype/{wtid}/workers", method = GET)
	@ResponseBody
	public Map<String, Object> getWorkerListByPartitionIdAndWtypeId(@PathVariable(value = "pid") long partitionId 
			, @PathVariable(value = "wtid") long wtypeId) {
		List<Map<String, Object>> workerList = repairService.getWorkerListByPartitionIdAndWtypeId(partitionId, wtypeId);
		Map<String, Object>  map = new HashMap<String, Object>();
		map.put("workerList", workerList);
		return map;
	}

	/**
	 * 新增报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/new", method = GET)
	public String toCreateNewRepair(ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);
		List<WorkType> workTypeList = repairService.getWorkTypeByType(WorkType.TYPE_REPIAR);
		
		List< CommonWords > commonWordsList = commonWordsService.getCommonWordsVoByType(CommonWords.TYPE_REPAIR , unitId);
		//常用语
		model.put("commonWordsList", commonWordsList);
		
		model.put("partitionList", partitionList);
		model.put("repairTypeList", Repair.getAllRepairTypes());
		model.put("serviceTypeList", Repair.getAllServiceTypes());
		model.put("urgentStateList", Repair.getAllUrgentStates());
		model.put("workTypeList", workTypeList);
		return "to.create.new.repair";
	}

	/**
	 * 保存新增报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/new", method = POST)
	public String doCreateNewRepair(RepairVo vo, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		vo.setUnitId(unitId);
		
		repairService.createNewRepair_tx(vo);
		return ActionUtil.redirect("/repair/unassigned");
	}

	/**
	 * 编辑报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/{id}", method = GET)
	public String toEditRepair(@PathVariable(value = "id") long repairId, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		Map<String, Object> repair = repairService.getRepairToEdit(repairId);
		
		List<Map<String, Object>> partitionList = unitPartitionService.getUnitPartitionMapListByUnitId(unitId);
		List<WorkType> workTypeList = repairService.getWorkTypeByType(WorkType.TYPE_REPIAR);
		
		List< CommonWords > commonWordsList = commonWordsService.getCommonWordsVoByType(CommonWords.TYPE_REPAIR , unitId);
		//常用语
		model.put("commonWordsList", commonWordsList);

		model.put("repair", repair);
		model.put("partitionList", partitionList);
		model.put("repairTypeList", Repair.getAllRepairTypes());
		model.put("serviceTypeList", Repair.getAllServiceTypes());
		model.put("urgentStateList", Repair.getAllUrgentStates());
		model.put("workTypeList", workTypeList);
		return "to.edit.repair";
	}

	/**
	 * 保存编辑报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/{id}", method = POST)
	public String updateRepair(@PathVariable(value = "id") long repairId, RepairVo vo, ModelMap model){
		repairService.updateRepair_tx(repairId, vo);
		return ActionUtil.redirect("/repair/unassigned");
	}

	/**
	 * 删除报修
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/{id}", method = DELETE)
	@ResponseBody
	public String deleteRepair(@PathVariable(value = "id") long repairId, ModelMap model){
		boolean b = repairService.deleteRepair_tx(repairId);
		return b ? "1" : "0";
	}
	
	/**
	 * 报修详细
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/{id}/detail", method = GET)
	public String showRepairDetail(@PathVariable(value = "id") long repairId, ModelMap model){
		String imgAccessUrlPre = PortalConstants.FILE_ACCESS_URL + File.separator + PortalConstants.IMG_URL;
		Map<String, Object> map = repairService.getRepairDetail(repairId, imgAccessUrlPre);
		model.put("map", map);
		return "to.repair.detail";
	}

	/**
	 * 报修统计(按维修人)
	 * @param status
	 * @param period(格式为yyyy-MM)
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/statistics", method = GET)
	public String showRepairStatistics(
			@RequestParam(value = "status", required = false) Byte status
			, @RequestParam(value = "period", required = false) String period
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		if(status != null && status < 0) {
			status = null;
		}
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		Map<Byte, String> statusMap = Repair.getAllStatusStatistcs();
		List<Byte> statusList = Repair.getAllStatusStatistcKeys();
		
		int year = 0;
		int month = 0;
		try {
			Date date = DateUtil.parseDate(period, DateUtil.PATTERN_YM);
			Calendar c = Calendar.getInstance();
			c.setTime(date);

			year = c.get(Calendar.YEAR);
			month = c.get(Calendar.MONTH) + 1;
		} catch(Exception e) {
			period = null;
			year = 0;
			month = 0;
		}
		
		int count = repairService.getRepairWorkersCount(unitId, status, statusList, year, month);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = repairService.getRepairWorkerList(unitId, status, statusList, year, month, pageNo, pageSize);

		model.put("statusMap", statusMap);
		model.put("status", status);
		model.put("period", period);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.show.repair.statistics";
	}
	
	/**
	 * 查询指定维修人员的维修记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/repair/statistic/{workerId}/detail", method = GET)
	public String showRepairStatisticDetail(@PathVariable(value = "workerId") long workerId
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
		
		List<Byte> statusList = Repair.getAllStatusStatistcKeys();
		
		int count = repairService.getRepairStatisticCount(unitId, workerId, statusList);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = repairService.getRepairStatisticList(unitId, workerId, statusList, pageNo, pageSize);

		model.put("page", page);
		model.put("resultList", resultList);
		return "to.repair.statistic.detail";
	}
	
}
