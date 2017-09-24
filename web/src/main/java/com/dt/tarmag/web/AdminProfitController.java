package com.dt.tarmag.web;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.List;
import java.util.Map;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.ProfitBalanceOut;
import com.dt.tarmag.service.ICustomerService;
import com.dt.tarmag.service.IProfitConsumeRecService;
import com.dt.tarmag.service.IProfitService;



/**
 * @author yuwei
 * @Time 2015-8-18上午09:53:31
 */
@Controller
public class AdminProfitController {

	@Autowired
	private ICustomerService customerService;
	@Autowired
	private IProfitService profitService;
	
	@Autowired
	private IProfitConsumeRecService profitConsumeRecService;
	
	
	
	/**
	 * 清结算
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/profit/list", method = GET)
	public String showProfitList(@RequestParam(value = "status", required = false) Byte status
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model) {
		//菜单设置
		model.put("firstMenu", 5);
		model.put("secondMenu", 1);
		
		long userId = ActionUtil.getSessionUserId();
		Customer admin = customerService.findCustomerById(userId);

		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = profitService.getProfitCountByCompanyId(admin.getCompanyId(), status);
		Page page = new Page(count, pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = profitService.getProfitListByCompanyId(admin.getCompanyId(), status, pageNo, pageSize);
		
		model.put("status", status);
		model.put("page", page);
		model.put("resultList", resultList);
		model.put("statusMap", ProfitBalanceOut.getStatuses());
		return "to.show.profit.list";
	}
	
	/**
	 * 物业公司申请反润结算款。
	 * 状态由0未结算变为1申请中
	 * @param id
	 * @param status
	 * @param model
	 * @return
	 * 0失败，1成功
	 */
	@RequestMapping(value = "/admin/profit/out/{id}/apply", method = PUT)
	@ResponseBody
	public String applyProfitBalanceOut(@PathVariable(value = "id") long id, ModelMap model) {
		boolean b = profitService.applyProfitBalanceOut_tx(id);
		return b ? "1" : "0";
	}
	
	/**
	 * 查询物业公司所属小区在相应时间内所有消费金额,
	 * @param id
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/profit/rec/{id}/unitprofit" , method = GET)
	public String unitprofit(@PathVariable(value = "id") Long id ,@RequestParam(value = "unitName" ,required = false) String unitName
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model) {
		
		model.put("firstMenu", 5);
		model.put("secondMenu", 1);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = this.profitConsumeRecService.getProfitConsumeRecsAmountGroupByUnitCount(id,unitName);
		Page page = new Page(count, pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String, Object>> resultList = this.profitConsumeRecService.getProfitConsumeRecsAmountGroupByUnit(id,unitName, pageNo, pageSize);;
		
		model.put("page", page);
		model.put("resultList", resultList);
		model.put("balanceOutId", id);
		model.put("unitName", unitName);
		
		return "to.show.profit.detail";
	}
	
	/**
	 * 查询物业公司所属小区内所有住户在相应时间内所有消费金额,以住户消费金额进行排序
	 * @param id
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/profit/rec/residentprofit" , method = RequestMethod.GET)
	public String residentprofit(@RequestParam(value = "ecomId", required = true) Long ecomId
			, @RequestParam(value = "unitId", required = true) Long unitId
			, @RequestParam(value = "startTime", required = true) String startTime
			, @RequestParam(value = "endTime", required = true) String endTime
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model) {
		
		model.put("firstMenu", 5);
		model.put("secondMenu", 1);
		
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = this.profitConsumeRecService.getProfitConsumeRecsAmountGroupByResidentCount(startTime, endTime, ecomId, unitId);
		Page page = new Page(count, pageNo, pageSize, 10, ActionUtil.getRequest());
		
		List<Map<String, Object>> resultList = 
				this.profitConsumeRecService.getProfitConsumeRecsAmountGroupByResident(startTime, endTime, ecomId, unitId, pageNo, pageSize);
		
		model.put("page", page);
		model.put("resultList", resultList);
		
		return "to.show.profit.ranking";
	}
}



