package com.dt.tarmag.web;

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
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.service.ICustomerService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.util.Params;

@Controller
@RequestMapping("syscustomer")
public class SysCustomerController extends AbstractDtController {

	@Autowired
	private ICustomerService customerService;

	/**
	 * 跳转用户页面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/customer/index";
	}

	/**
	 * 查找用户信息
	 * 
	 * @param userName
	 * @param companyId
	 * @param params
	 * @return
	 */
	@RequestMapping("customers")
	@ResponseBody
	protected JSONObject findCustomer(String userName, Long companyId,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.customerService.findCustomer(
							Params.getParams().add("userName", userName)
									.add("companyId", companyId).filterEmpty(),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}

	@RequestMapping("entity")
	protected String entity(final ModelMap map, Customer customer) {
		if (customer.getId() != 0l) {
			customer = this.customerService.findCustomerById(customer.getId());
		}
		map.put("entity", customer);
		return "admin/customer/entity";
	}

	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session,
			final Customer customer) {
		try {
			this.customerService.saveCustomer_tx(customer);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}

	@RequestMapping("delete")
	@ResponseBody
	protected MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.customerService.delete_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}

	@RequestMapping("isrepeat")
	@ResponseBody
	protected boolean isRepeat(@RequestParam("userName") String userName) {
		return !this.customerService.isRepeat(userName);
	}

	/**
	 * 分配模块
	 * 
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("allocationmodule")
	protected String allocationmodule(final ModelMap map, long companyId) {
		map.putAll(this.customerService.allocationmodule(companyId));
		return "admin/customer/allocationmodule";
	}

	@RequestMapping("alloteModule")
	@ResponseBody
	protected MsgResponse alloteModule(final Long roleId, final Long[] mIds) {
		try {
			this.customerService.alloteModule_tx(roleId, mIds);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000001);
		}
	}
}
