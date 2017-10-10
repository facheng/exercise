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
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.service.IUnitPartitionService;
import com.dt.tarmag.service.IUnitService;


/**
 *小区期数
 * @author Administrator
 * @since 2015年7月7日
 */
@Controller
public class AdminUnitPartitionController {
	
	@Autowired
	private IUnitPartitionService unitPartitionService;
	
	@Autowired
	private IUnitService unitService;
	
	/**
	 * 
	 * 返回分页后的结果.
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/partition/list", method = GET)
	public String findPageUnitPartition (@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value = "unitId", required = true) long unitId
			, @RequestParam(value = "serachAliasName", required = false) String serachAliasName
			, ModelMap model){
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		if(unitId != 0){
			params.put("unitId", unitId);
		}
		if(StringUtils.isNotBlank(serachAliasName)){
			params.put("aliasName", "%" + serachAliasName + "%");
		}
		
		int count = unitPartitionService.findCountUnitPartition(params);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> resultList = unitPartitionService.findPageUnitPartition(pageNo, pageSize, params);
		
		model.put("unitPartitions", resultList);
		model.put("unitId", unitId);
		model.put("page", page);
		model.put("serachAliasName", serachAliasName);
		
		return "to.show.partition.list";
		
	}
	
	/**
	 * 跳转到添加页或编辑面
	 * @return
	 */
	@RequestMapping("/admin/partition/init")
	public String toAddunitPartitionPage(ModelMap model,UnitPartition unitPartition){
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		//id 不等于0 表示编辑
		if(unitPartition.getId() != 0){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", unitPartition.getId());
			
			List<Map<String, Object>> unitPartitions = unitPartitionService.findUnitPartitionById(unitPartition.getId());
			if(unitPartitions != null && unitPartitions.size() > 0){
				model.put("unitPartition", unitPartitions.get(0));
			}
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", unitPartition.getUnitId());
		params.put("locale", "zh_CN");
		List<Map<String, Object>> units = unitService.findUnitById(params);
		if(units != null && units.size() > 0){
			model.put("unit", units.get(0));
		}
		
		return "to.edit.partition";
	}
	
	/**
	 * 
	 * 添加或修改小区期数
	 * @param companyBranch
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value = "/admin/partition/edit")
	public String saveOrUpdateUnitPartition (@RequestParam(value = "unitId", required = true) long unitId
			,UnitPartition unitPartition
			,ModelMap model) throws Exception {
		
		unitPartitionService.saveOrUpdate_tx(unitPartition);
		
		return ActionUtil.redirect("/admin/partition/list?unitId="+unitId);
	} 
	
	/**
	 * 删除小区期数
	 * @param id
	 * 			主键
	 * @return
	 */
	@RequestMapping(value = "/admin/partition/del")
	public @ResponseBody
	Map<String, Object> delUnitInfo(@RequestParam(value = "id", required = true) Long id ,
			@RequestParam(value = "unitId", required = true) Long unitId 
			, ModelMap model) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			unitPartitionService.delUnitPartition_tx(id);
			map.put("flag", true);
			model.put("unitId", unitId);
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
	@RequestMapping("/admin/partition/info")
	public String toUnitPartitionInfoPage(ModelMap model,UnitPartition unitPartition){
		//菜单设置
		model.put("firstMenu", 2);
		model.put("secondMenu", 1);
		
		if(unitPartition.getId() != 0){
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("id", unitPartition.getId());
			
			List<Map<String, Object>> unitPartitions = unitPartitionService.findUnitPartitionById(unitPartition.getId());
			if(unitPartitions != null && unitPartitions.size() > 0){
				model.put("unitPartition", unitPartitions.get(0));
				model.put("unitId", unitPartition.getUnitId());
			}else{
				model.put("unitPartition", null);
				model.put("unitId", unitPartition.getUnitId());
			}
		}
		return "to.show.partition.info";
	}
	
	/**
	 * 检查期数是否存在，1不存在，0存在
	 * @param name
	 * @return
	 */
	@RequestMapping(value = "/ajax/admin/partition", method = POST)
	@ResponseBody
	public String checkUserName(@RequestParam(value = "unitId", required = true) Long unitId
			, @RequestParam(value = "partitionName", required = true) String partitionName
			, @RequestParam(value = "id", required = false) Long partitionId
			){
		if(partitionName == null || partitionName.trim().equals("")) {
			return "0";
		}
		
		UnitPartition unitPartition = unitPartitionService.getPartitionByUnitIdAndPartitionName(unitId , partitionName);
		if(unitPartition == null) {
			return unitPartition == null ? "1" : "0";
		} else {
			return unitPartition == null || unitPartition.getId() == partitionId ? "1" : "0";
		}
	}

}
