package com.dt.tarmag.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.service.IProfitConsumeRecService;
import com.dt.tarmag.service.IProfitService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.ProfitBalanceOutVo;

@Controller
@RequestMapping("sysprofitper")
public class SysProfitPerController extends AbstractDtController {
	
	@Autowired
	private IProfitService profitService;
	
	@Autowired
	private IProfitConsumeRecService profitConsumeRecService;
	
	/**
	 * 跳转至物业结算比例列表页面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/profitper/index";
	}
	
	/**
	 * 加载物业结算比例列表
	 * @param companyName
	 * @param params
	 * @return
	 */
	@RequestMapping("profitpers")
	@ResponseBody
	protected JSONObject showPropertyProfit(String companyName,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.profitService.getPropertyProfitList(Params.getParams().add("companyName",
							companyName).filterEmpty(),params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 修改保存物业结算比例
	 * @param id
	 * @param cId
	 * @param percent
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session, 
			Long id ,Long cId ,Double percent) {
		try {
			this.profitService.createProfitPer_tx(id ,cId ,percent);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	/**
	 * 获取所选结算信息显示至修改页面
	 * @param map
	 * @param cId
	 * @param pId
	 * @return
	 */
	@RequestMapping("balance")
	protected String balance(final ModelMap map, Long cId ,Long pId) {
		
		List<ProfitEcom> peList = this.profitService.getProfitEcomList();
		
		if(pId != null && pId > 0){
			ProfitBalanceOutVo profitBalanceOutVo = this.profitService.getBalanceOutInfoById(pId);
			map.put("pbovo", profitBalanceOutVo);
		}else{
			ProfitBalanceOutVo profitBalanceOutVo = this.profitService.getBalanceOutInfo(cId);
			map.put("pbovo", profitBalanceOutVo);
		}
		
		map.put("peList", peList);
		
		return "admin/profitper/balance";
	}
	
	/**
	 * 添加修改结算详情
	 * @param session
	 * @param profitBalanceOutVo
	 * @return
	 */
	@RequestMapping("profitBalanceOutSave")
	@ResponseBody
	protected MsgResponse profitBalanceOutSave(final HttpSession session, 
			ProfitBalanceOutVo profitBalanceOutVo) {
		try {
			this.profitService.addProfitBalanceOut_tx(profitBalanceOutVo);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	/**
	 * 跳转所选物业公司结算详情列表
	 * @param map
	 * @param cId
	 * @return
	 */
	@RequestMapping("profitperDetailIndex")
	protected String coupons(final ModelMap map , Long cId) {
		Company company = profitService.getCompanyById(cId);
		map.put("companyName", company.getCompanyName());
		map.put("cId", cId);
		return "admin/profitper/details";
	}
	
	/**
	 * 加载物业结算详情列表
	 * @param type
	 * @param typeId
	 * @param params
	 * @return
	 */
	@RequestMapping("propertyProfitDetails")
	@ResponseBody
	protected JSONObject showPropertyProfitDetails(Long cId , Byte status,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.profitService.getPropertyProfitDetailsList(cId ,status ,params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 确认已结算
	 * @param id
	 * @return
	 */
	@RequestMapping("settlement")
	@ResponseBody
	public MsgResponse settlement(@RequestParam("id") final Long id) {
		try {
			this.profitService.settlementPropertyProfitDetail_tx(id);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
	
	/**
	 * 删除物业结算详情
	 * @param ids
	 * @return
	 */
	@RequestMapping("deleteDetail")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.profitService.deletePropertyProfitDetail_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额和反润金额
	 * @param startTime 开始时间  endTime 结束时间  ecomId电商id companyId物业公司id
	 * @return
	 */
	@RequestMapping("amounts")
	@ResponseBody
	public Map<String , Object> amount(String startTime ,  String endTime , Long ecomId , Long companyId) {
		
		Map<String , Object>  amounts = new HashMap<String, Object>();
		try {
			
			List<Map<String , Object>> amountList = this.profitConsumeRecService.getProfitConsumeRecsAmount(startTime, endTime, ecomId, companyId);
			if(amountList != null && !amountList.isEmpty()){
				amounts = amountList.get(0);
			}
			
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return amounts;
	}
}
