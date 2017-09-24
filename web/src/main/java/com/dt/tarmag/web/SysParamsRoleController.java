package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.service.IWorkerService;
import com.dt.tarmag.service.IWorkerTypeService;
import com.dt.tarmag.vo.UnitPartitionVo;
import com.dt.tarmag.vo.WorkerVo;

/**
 * 系统参数设置 角色分配
 * @author jiaosf
 * @since 2015-7-22
 */
@Controller
public class SysParamsRoleController {
	
	@Autowired
	private IWorkerService workerService;
	
	@Autowired
	private IUnitPartitionService unitPartitionService;
	
	@Autowired
	private IWorkerTypeService workerTypeService;
	
	private  final Logger logger = LoggerFactory.getLogger(SysParamsRoleController.class);
	
	
	/**
	 * 获取角色列表
	 * @param pageNo
	 * @param pageSize
	 * @param userName
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/role/list", method = GET)
	public String showWorkerList(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, WorkerVo worker
			, ModelMap model){
		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//获取区块分类
		List<UnitPartition> upList = unitPartitionService.getUnitPartitionListByUnitId(unitId);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		int count = workerService.getWorkerCount(unitId, worker);
		
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		
		List<Map<String, Object>> workerList = workerService.getWorkerList(unitId, worker, pageNo, pageSize);
		
		model.put("upList", upList);
		model.put("worker", worker);
		model.put("page", page);
		model.put("workerList", workerList);
		
		return "to.sys.role.setting";
	}
	
	/**
	 * 添加修改页面初始化
	 * @param wtType
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/sys/params/role/init" , method = GET)
	public String sysRoleEditInfo(@RequestParam(value = "workId", required = false) Long workId ,
			ModelMap model) throws Exception{
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		//获取区块分类
		List<UnitPartitionVo> upList = workerService.getUnitPartitionListByUnitId(workId , unitId);
		
		//修改帐号信息回显
		if(workId != null && workId > 0){
			WorkerVo wk= workerService.getEditWorker(workId , unitId);
			model.put("wk", wk);
			model.put("workId", workId);
		}
		
		model.put("upList", upList);
		
		return "to.edit.role.worker";
	}
	
	/**
	 * 根据工种类型获取工种
	 * @return
	 */
	@RequestMapping("/sys/params/role/wt")
	@ResponseBody
	public Map<String,Object> findWorkType(Byte wtType) {
		try {
			List<WorkType> wts = workerTypeService.getWorkTypeByType(wtType);
			Map<String,Object>  map = new HashMap<String, Object>();
			map.put("wts", wts);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("get WorkType failed ! ", e);
			return null;
		}
	}
	
	/**
	 * 添加修改角色
	 * @param worker
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sys/params/role/new", method = POST)
	public String toSaveOrUpdate(@RequestParam(value = "id", required = false) Long workId,
			WorkerVo worker, ModelMap model) throws Exception{
		
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		workerService.saveOrUpdate_tx(worker , unitId);
		
		return ActionUtil.redirect("/sys/params/role/list");
	} 
	
	/**
	 * 删除保安保修工人
	 * @param houseResidentIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/role/re", method = POST)
	@ResponseBody
	public String removeFocusResident(@RequestParam(value = "workerIds", required = true) String workerIds,
			ModelMap model){
		if(workerIds == null || workerIds.trim().equals("")) {
			return "0";
		}
		String[] arr = workerIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		workerService.deleteWorker_tx(idList);
		
		return "1";
	}
	
	
	/**
	 * 检查保安保修人员手机号是否已经存在
	 * 1不存在 ，0存在
	 * @param phoneNum
	 * @return
	 */
	@RequestMapping(value = "/sys/params/role/phone/validate", method = POST)
	@ResponseBody
	public String checkHouseResident(
			@RequestParam(value = "phoneNum", required = true) String phoneNum
			, @RequestParam(value = "workerId", required = false) Long workerId
			){
		if(CommonUtil.isMobile(phoneNum) == false) {
			return "0";
		}
		
		Worker worker = workerService.getWorkerByPhoneNum(phoneNum);
		if(worker == null) {
			return worker == null ? "1" : "0";
		}
		
		if(worker != null && workerId == null){
			return "0";
		}
		
		return worker == null || worker.getId() == workerId ? "1" : "0";
	}
}
