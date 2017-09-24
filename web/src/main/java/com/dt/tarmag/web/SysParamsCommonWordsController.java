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
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.service.ICommonWordsService;
import com.dt.tarmag.vo.CommonWordsVo;


/**
 * 系统参数常用语设置
 * @author wangfacheng
 * @Time 2015年8月12日17:45:21
 */
@Controller
public class SysParamsCommonWordsController {
	
	@Autowired
	private ICommonWordsService commonWordsService;
	
	/**
	 * 常用语设置
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/common/words", method = GET)
	public String showeCommonWords ( CommonWordsVo searchVo
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
		
		searchVo.setUnitId(unitId);
		
		int count = commonWordsService.getCommonWordsCount( searchVo );
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = commonWordsService.getCommonWordsList( searchVo, pageNo, pageSize);

		model.put("searchVo", searchVo);
		model.put("page", page);
		model.put("resultList", resultList);
		return "to.sys.common.words.setting";
	}
	
	
	/**
	 * 跳转到添加常用语页面
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/common/words/new", method = GET)
	public String toEditCommonWords( @RequestParam( value = "id" , required = false)Long commonWordsId , ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		Map<String , Object > map = new HashMap<String, Object>();
		
		if( commonWordsId != null ){
			map = commonWordsService.getCommonWordsDetail(commonWordsId);
		}
		
		model.put("map", map);
		model.put("commonWordsId", commonWordsId);
		return "to.edit.common.words";
	}
	
	/**
	 *	保存常用语
	 * 返回：1成功，0失败
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/common/words", method = POST)
	public String saveCommonWords(@RequestParam(value = "id",required = false ) Long commonWordsId
			, CommonWordsVo vo, ModelMap model){
		
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		if( commonWordsId == null ){
			
			vo.setUnitId(unitId);
			 commonWordsService.createCommonWords_tx(vo);
		} else {
			
			commonWordsService.updateCommonWords_tx(commonWordsId, vo);
		}
		
		return ActionUtil.redirect("/sys/params/common/words");
	}
	
	/**
	 * 常用语详情
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/common/words/{id}/detail", method = GET)
	public String showCommonWordsDetail(@PathVariable(value = "id") long commonWordsId, ModelMap model){
		
		Map<String, Object> map = commonWordsService.getCommonWordsDetail(commonWordsId);

		model.put("map", map);
		return "to.common.words.detail";
	}
	
	/**
	 * 删除常用语
	 * 返回：1成功，0失败
	 * @param portId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/sys/params/common/words", method = DELETE)
	@ResponseBody
	public String deleteCommonWords(@RequestParam(value = "ids" , required = true) String commonWordsIds , ModelMap model){
		
		if(commonWordsIds == null || commonWordsIds.trim().equals("")) {
			return "0";
		}
		String[] arrs = commonWordsIds.trim().split(",");
		if(arrs == null || arrs.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arrs) {
			idList.add(Long.parseLong(id));
		}
		
		boolean b = commonWordsService.deleteCommonWords_tx(idList);
		
		return b ? "1" : "0";
	}
}





