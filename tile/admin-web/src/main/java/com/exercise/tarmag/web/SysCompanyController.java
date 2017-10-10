package com.dt.tarmag.web;

import java.util.List;

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
import com.dt.tarmag.service.ICompanyService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;

@Controller
@RequestMapping("syscompany")
public class SysCompanyController extends AbstractDtController {
	@Autowired
	private ICompanyService companyService;

	@RequestMapping("index")
	protected String index() {
		return "admin/company/index";
	}
	
	@RequestMapping("all")
	@ResponseBody
	protected List<Company> all() {
		return this.companyService.findAll();
	}

	@RequestMapping("companys")
	@ResponseBody
	protected JSONObject findCompany(final Company company,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.companyService.findCompany(company.toMap(null, true),
							params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}

	@RequestMapping("entity")
	protected String entity(final ModelMap map, Company company) {
		if (company.getId() != 0l) {
			company = this.companyService.findCompanyById(company.getId());
		}
		map.put("entity", company);
		return "admin/company/entity";
	}

	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session, final Company company) {
		try {
			this.companyService.saveCompany_tx(company);
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.companyService.delete_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
}
