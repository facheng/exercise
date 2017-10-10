package com.dt.tarmag.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.DateUtil;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IProfitBalanceInService;
import com.dt.tarmag.service.IProfitConsumeRecService;
import com.dt.tarmag.service.IProfitEcomService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.ProfitBalanceInVo;
import com.dt.tarmag.vo.ProfitConsumeRecVo;
import com.dt.tarmag.vo.ProfitEcomVo;

/**
 * 电商基本资料
 * @author wangfacheng
 * @Time 2015年8月14日11:18:28
 *
 */
@RequestMapping("sysprofitecom")
@Controller
public class SysProfitEcomController extends AbstractDtController {
	
	@Autowired
	private IProfitEcomService profitEcomService;
	
	@Autowired
	private IProfitConsumeRecService profitConsumeRecService;
	
	@Autowired
	private IProfitBalanceInService profitBalanceInService;
	
	
	/**
	 * 跳转清结算电商管理页面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/profitecom/index";
	}
	
	/**
	 * 加载电商信息列表
	 * @param params
	 * @return
	 */
	@RequestMapping("profitecoms")
	@ResponseBody
	protected JSONObject findProfitecoms(ProfitEcomVo searchVo,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.profitEcomService.findPageProfitEcom(searchVo, params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 添加修改电商信息
	 * @param map
	 * @param profitEcomVo
	 * @return
	 */
	@RequestMapping("entity")
	protected String entity(final ModelMap map, ProfitEcomVo profitEcomVo) {
		
		Map<String , Object > profitEcomMap = new HashMap<String, Object>();
		if (profitEcomVo != null && profitEcomVo.getId() != null && profitEcomVo.getId() > 0) {
			profitEcomMap = this.profitEcomService.getProfitEcomDetailById(profitEcomVo.getId());
		}
		map.put("entity", profitEcomMap);
		return "admin/profitecom/entity";
	}
	
	/**
	 * 修改保存
	 * @param session
	 * @param company
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session, ProfitEcomVo profitEcomVo) {
		try {
			if (profitEcomVo.getId() != null && profitEcomVo.getId() > 0) {
				this.profitEcomService.updateProfitEcom_tx(profitEcomVo.getId(), profitEcomVo);
			}else{
				this.profitEcomService.saveProfitEcom_tx(profitEcomVo);;
			}
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	/**
	 * 删除电商信息
	 * @param ids
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.profitEcomService.deleteProfitEcom_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
	
	/**
	 * 验证电商代码是否重复
	 * @param ids
	 * @return
	 */
	@RequestMapping("code")
	@ResponseBody
	public boolean checkCode( ProfitEcomVo profitEcomVo ) {
		try {
			
			 return this.profitEcomService.checkIsNotExistProfitEcom(profitEcomVo);
			 
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		
		return false;
	}

	/**
	 * 跳转到电商消费日志界面
	 * @return
	 */
	
	@RequestMapping("consumerecIndex")
	public String consumeRec(final ModelMap map , Long ecomId){
		
		String startTime = DateUtil.formatDate(new Date(), DateUtil.PATTERN_DATE1);
		String endTime = DateUtil.formatDate(new Date(), DateUtil.PATTERN_DATE1);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		
		map.put("ecomId", ecomId);
		return "admin/profitecom/consumeRec";
	}
	
	/**
	 * 加载电商消费日志列表
	 * @param params
	 * @return
	 */
	@RequestMapping("consumerecs")
	@ResponseBody
	protected JSONObject findConsumeRec( String startTime , String endTime , long ecomId ,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		
		try {
			
			ProfitConsumeRecVo searchVo = new ProfitConsumeRecVo();
			 
			Date sTime = new Date();
			Date eTime = new Date();
			if( startTime != null && !"".equals(startTime.trim()) ){
				sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
			}
			
			if( endTime != null && !"".equals(endTime.trim())){
				eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
			}
			searchVo.setStartTime(sTime);
			searchVo.setEndTime(eTime);
			searchVo.setEcomId(ecomId);
			
			resultJson = DataTableResult.toJSONObject(params,
					this.profitConsumeRecService.findPageProfitConsumeRec(searchVo, params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 对账[电商 -->团团]
	 * @param session
	 * @param company
	 * @return
	 */
	@RequestMapping("checkamount")
	@ResponseBody
	protected MsgResponse checkAmount(String startTime , String endTime , long ecomId ) {
		try {
			
			ProfitConsumeRecVo vo = new ProfitConsumeRecVo();
			Date sTime = null;
			Date eTime = null;
			if( startTime != null && !"".equals(startTime.trim()) ){
				sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
			}
			
			if( endTime != null && !"".equals(endTime.trim())){
				eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
			}
			vo.setStartTime(sTime);
			vo.setEndTime(eTime);
			vo.setEcomId(ecomId);
			
			//开始对账
			boolean errorFlag = this.profitBalanceInService.checkAmount_tx( vo );
			if(!errorFlag){
				return new Fail(MsgKey._000000002);
			}
			
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	
	/**
	 * 跳转到电商-->团团反润结算记录界面
	 * @return
	 */
	
	@RequestMapping("balanceInIndex")
	public String balanceIn(final ModelMap map , Long ecomId){
		
		String startTime = DateUtil.formatDate(new Date(), DateUtil.PATTERN_DATE1);
		String endTime = DateUtil.formatDate(new Date(), DateUtil.PATTERN_DATE1);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		
		map.put("ecomId", ecomId);
		return "admin/profitecom/balanceIn";
	}
	
	/**
	 * 加载电商反润结算信息列表
	 * @param params 
	 * @return
	 */
	@RequestMapping("balanceIns")
	@ResponseBody
	protected JSONObject findbalanceIns( String startTime , String endTime , long ecomId ,String status,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		
		try {
			
			ProfitBalanceInVo searchVo = new ProfitBalanceInVo();
			 
			Date sTime = null;
			Date eTime = null;
			if( startTime != null && !"".equals(startTime.trim()) ){
				sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
			} 
			
			if( endTime != null && !"".equals(endTime.trim())){
				eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
			} 
			
			searchVo.setStartTime(sTime);
			searchVo.setEndTime(eTime);
			searchVo.setEcomId(ecomId);
			searchVo.setStatus(status);
			
			resultJson = DataTableResult.toJSONObject(params,
					this.profitBalanceInService.findPageProfitBalanceIns(searchVo, params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	
	/**
	 * 更新反润记录[电商 -->团团]为已结算
	 * @return
	 */
	@RequestMapping("balance")
	@ResponseBody
	protected MsgResponse closeBalance(@RequestParam(value="id")Long bId ) {
		try {
			
			ProfitBalanceInVo vo = new ProfitBalanceInVo();
			vo.setId(bId);
			
			this.profitBalanceInService.updateProfitBalanceIn_tx(vo);
			
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	/**
	 * 删除反润记录[电商 -->团团]
	 * @param ids
	 * @return
	 */
	@RequestMapping("deleteBalance")
	@ResponseBody
	public MsgResponse deleteBalance(@RequestParam("ids") final Long[] ids) {
		try {
			this.profitBalanceInService.deletedProfitBalanceIn_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
}
