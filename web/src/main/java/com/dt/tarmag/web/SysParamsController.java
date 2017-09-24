package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
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
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.service.IAppMenuService;
import com.dt.tarmag.service.IKeyDeviceService;
import com.dt.tarmag.service.IPropertyChargeRuleService;
import com.dt.tarmag.service.IStoryService;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.service.IUnitService;
import com.dt.tarmag.vo.KeyDeviceSearchVo;
import com.dt.tarmag.vo.KeyDeviceVo;
import com.dt.tarmag.vo.MenuVo;
import com.dt.tarmag.vo.PropertyChargeRuleVo;


/**
 * 系统参数设置
 * @author yuwei
 * @Time 2015-7-7下午03:05:43
 */
@Controller
public class SysParamsController {
	
	private static Logger logger = Logger.getLogger(SysParamsController.class);
	
	@Autowired
	private IAppMenuService appMenuService;
	@Autowired
	private IKeyDeviceService keyDeviceService;
	@Autowired
	private IUnitService unitService;
	@Autowired
	private IStoryService storyService;
	
	@Autowired
	private IPropertyChargeRuleService propertyChargeRuleService;
	@Autowired
	private IUnitPartitionService unitPartitionService;

	/**
	 * 物业费单价设置
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/property/charges", method = GET)
	public String toSetPropertyCharges(ModelMap model){
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put("errorMsg", "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//获取期数
		List<UnitPartition> unitPartitions = unitPartitionService.getUnitPartitionListByUnitId(unitId);
		
		PropertyChargeRuleVo vo = new PropertyChargeRuleVo();
		vo.setUnitId(unitId);
		
		Map<String , Object> map = new HashMap<String, Object>();
		
		List<Map<String , Object>> lists = this.propertyChargeRuleService.findPropertyChargeRules(vo);
		if(lists != null && !lists.isEmpty()){
			map = lists.get(0);
		}
		//如果没有物业收费规则，则设置收费默认值0
		else {
			map.put("isEffect", 0);//未生效
			map.put("feeArea", 0);
			map.put("feeLift", 0);
			map.put("basementFeeArea", 0);
			map.put("feeAll", 0);
		}
		
		//收费类型
		Map<Byte , String> ctypes = PropertyChargeRule.getCtypes();
		//缴费周期
		Map<Byte , String > cycles = PropertyChargeRule.getCycles();
		//是否有效
		Map<Byte , String > isEffects = PropertyChargeRule.getIsEffects();
		
		model.put("ctypes", ctypes);
		model.put("cycles", cycles);
		model.put("isEffects", isEffects);
		model.put("map", map);
		model.put("unitPartitions", unitPartitions);
		return "to.sys.set.property.charges";
	}
	
	/**
	 * 根据小区期数名称查询物业费规则
	 * @return
	 */
	
	@RequestMapping(value = "/sys/params/property/charges/detail", method = GET)
	@ResponseBody
	public Map<String , Object> findPropertyChargesByPartitionId(@RequestParam(value = "partitionId" , required = true)Long partitionId ){
		
		Map<String , Object> map = new HashMap<String, Object>();
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		
		PropertyChargeRule propertyCR = this.propertyChargeRuleService.getPropertyChargeRuleByPartitionId(unitId, partitionId);
		if(propertyCR == null){
			propertyCR = new PropertyChargeRule();
		}
		
		map.put("entity", propertyCR);
		return map;
		
	}
	
	/**
	 * 保存物业费设置
	 * @return
	 */
	@RequestMapping(value = "/sys/params/property/charges" , method = POST)
	@ResponseBody
	public boolean saveOrUpdatePropertyCharges( PropertyChargeRuleVo vo){
		try{
			
			this.propertyChargeRuleService.saveOrUpdatePropertyChargeRule_tx(vo);
			
			return true;
		} catch ( Exception e ){
			logger.error(e.getMessage() , e);
		}
		return false;
	}

	/**
	 * 车位费单价设置
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/carport/charges", method = GET)
	public String toSetCarportCharges(ModelMap model){
		
		
		return "to.sys.set.carport.charges";
	}

	/**
	 * 物业联系电话设置
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/property/phone", method = GET)
	public String toSetPropertyPhone(ModelMap model){
		
		
		return "to.sys.set.property.phone";
	}

	/**
	 * 角色分配
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/role/setting", method = GET)
	public String toRoleSetting(ModelMap model){
		
		return ActionUtil.redirect("/sys/params/role/list");
	}

	/**
	 * 数据导入
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/data/import", method = GET)
	public String toDataImportSetting(ModelMap model){
		
		
		return "to.sys.data.import.setting";
	}

	/**
	 * 数据导出
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/data/export", method = GET)
	public String toDataExportSetting(ModelMap model){
		
		
		return "to.sys.data.export.setting";
	}

	/**
	 * APP应用下载
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/app/download", method = GET)
	public String toDownloadApp(ModelMap model){
		
		
		return "to.sys.download.app";
	}

	/**
	 * APP菜单管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/app/menu", method = GET)
	public String toManageAppMenu(ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		unitId = unitId == null ? 0 : unitId;
		List<MenuVo> menuList = appMenuService.getAppMenuListByUnitId(unitId);
		model.put("menuList", menuList);
		return "to.sys.manage.app.menu";
	}

	/**
	 * 保存新选择的APP菜单。
	 * menuIds为选择的菜单ID，多个值用半角逗号(,)隔开
	 * @param menuIds
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/app/menu", method = POST)
	@ResponseBody
	public String saveSelectedAppMenus(@RequestParam(value = "menuIds", required = true) String menuIds 
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		unitId = unitId == null ? 0 : unitId;
		
		List<Long> menuIdList = new ArrayList<Long>();
		String[] arr = menuIds.trim().split(",");
		for(String mId : arr) {
			menuIdList.add(Long.parseLong(mId.trim()));
		}
		
		appMenuService.resetAppMenus_tx(unitId, menuIdList);
		return "1";
	}

	/**
	 * 修改APP菜单名和url
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/app/menu/edit", method = POST)
	public String updateAppMenu(@RequestParam(value = "menuId", required = true) long menuId
			, @RequestParam(value = "menuName", required = true) String menuName
			, @RequestParam(value = "linkURL", required = true) String linkURL
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		unitId = unitId == null ? 0 : unitId;
		
		appMenuService.updateAppMenu_tx(unitId, menuId, menuName, linkURL);
		return ActionUtil.redirect("/sys/params/app/menu");
	}

	/**
	 * 系统菜单管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/menu", method = GET)
	public String toManageMenu(ModelMap model){
		
		return "to.sys.manage.menu";
	}

	/**
	 * 小区简介
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/unit/summary", method = GET)
	public String toUnitSummary(ModelMap model){
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		//统计片区楼栋数量
		List<Map<String , Object>> storyCounts = storyService.getStorysCountByUnitId(unitId);
		
		//小区信息
		Map<String, Object> unitInfo = unitService.findUnitInfoById(unitId);
		
		model.put("unitInfo", unitInfo);
		model.put("storyCounts", storyCounts);
		
		return "to.sys.unit.summary";
	}

	/**
	 * 设备钥匙管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/key/device", method = GET)
	public String toManageKeyDevice(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, KeyDeviceSearchVo vo
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		int count = keyDeviceService.getKeyDeviceCount(unitId, vo);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> mapList = keyDeviceService.getKeyDeviceMapList(unitId, vo, pageNo, pageSize);

		model.put("searchVo", vo);
		model.put("page", page);
		model.put("mapList", mapList);
		return "to.sys.manage.key.device";
	}

	/**
	 * 跳转到编辑钥匙设备页面
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/key/device/edit", method = GET)
	public String toEditKeyDevice(@RequestParam(value = "id", required = false) Long keyDeviceId, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		model.put("unitId", unitId == null ? 0 : unitId);
		
		if(keyDeviceId == null) {
			return "to.edit.key.device";
		}
		
		Map<String, Object> map = keyDeviceService.getkeyDeviceToEdit(keyDeviceId);
		if(map == null) {
			return ActionUtil.redirect("/sys/params/key/device/edit");
		}
		
		model.put("map", map);
		model.put("keyDeviceId", keyDeviceId);
		return "to.edit.key.device";
	}

	/**
	 * 保存钥匙设备
	 * @param keyDeviceId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/key/device/edit", method = POST)
	public String saveKeyDevice(@RequestParam(value = "id", required = false) Long keyDeviceId
			, KeyDeviceVo vo, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		vo.setUnitId(unitId);
		
		if(keyDeviceId == null || keyDeviceId <= 0) {
			keyDeviceService.createKeyDevice_tx(vo);
		} else {
			keyDeviceService.updateKeyDevice_tx(keyDeviceId, vo);
		}
		
		return ActionUtil.redirect("/sys/params/key/device");
	}
	
	/**
	 * 钥匙设备详情
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/key/device/{id}", method = GET)
	public String showKeyDeviceDetail(@PathVariable(value = "id") long keyDeviceId, ModelMap model){
		Map<String, Object> detail = keyDeviceService.getKeyDeviceDetail(keyDeviceId);
		model.put("detail", detail);
		return "to.key.device.detail";
	}

	/**
	 * 删除钥匙设备
	 * @param keyDeviceId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/key/device/{id}", method = DELETE)
	@ResponseBody
	public String deleteKeyDevice(@PathVariable(value = "id") long keyDeviceId, ModelMap model) {
		keyDeviceService.deleteKeyDevice_tx(keyDeviceId);
		return "1";
	}
}





