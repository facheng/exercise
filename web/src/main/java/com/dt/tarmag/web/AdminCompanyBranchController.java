package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

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
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.service.ICompanyBranchService;
import com.dt.tarmag.vo.Tree;



@Controller
public class AdminCompanyBranchController {   
	
	@Autowired
	private ICompanyBranchService companyBranchService; 
	
	
	/**
	 * 组织列表
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/company/branch/list", method = GET)
	public String companyBranchList (@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, @RequestParam(value="branchName" , required = false) String branchName 
			, ModelMap model){
		model.put("firstMenu", 1);
		model.put("secondMenu", 1);
		//登陆用户
		Customer customer = (Customer) ActionUtil.getSession().getAttribute(Constant.SESSION_USER);
		//分页设置
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		//获取数据
		int count = companyBranchService.getCountCompanyBranch(customer.getCompanyId(), branchName);
		Page page = new Page(count,  pageNo, pageSize, 10, ActionUtil.getRequest());
		List<Map<String ,Object>> branchList = companyBranchService.getCompanyBranchList(customer.getCompanyId(), branchName, pageNo, pageSize);
		
		model.put("branchName", branchName);
		model.put("page", page);
		model.put("branchList", branchList);
		return "to.show.company.branch.list";
	}
	
	/**
	 * 修改组织
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/company/branch", method = GET)
	public String editCompanyBranch(
			@RequestParam(value="parentId" , required = false) Long parentId,
			@RequestParam(value="branchId" , required = false) Long branchId,ModelMap model){
		model.put("firstMenu", 1);
		model.put("secondMenu", 1);
		CompanyBranch parentBranch = companyBranchService.getCompanyBranchById(parentId);
		model.put("parentBranch", parentBranch);
		if(branchId == null){
			return "to.edit.company.branch";
		}
		CompanyBranch companyBranch = companyBranchService.getCompanyBranchById(branchId);
		model.put("branch", companyBranch);
		return "to.edit.company.branch";
	}
	
	/**
	 * 保存组织
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/company/branch", method = POST)
	public String saveCompanyBranch(CompanyBranch companyBranch , ModelMap model){
		//登陆用户
		Customer customer = (Customer) ActionUtil.getSession().getAttribute(Constant.SESSION_USER);
		companyBranch.setCompanyId(customer.getCompanyId());
		this.companyBranchService.saveOrUpdate_tx(companyBranch);
		return ActionUtil.redirect("/admin/company/branch/list");
	}
	
	/**
	 * 删除组织
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin/company/branch/{id}", method = DELETE)
	@ResponseBody
	public int deleteCompanyBranch(@PathVariable(value = "id") Long branchId, ModelMap model){
		return this.companyBranchService.delCompanyBranch_tx(branchId);
	}

	/**
	 * 查询指定公司下的所有组织
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/ajax/company/{companyId}/branches", method = GET)
	public String getCompanyBranches(@PathVariable(value = "companyId") long companyId, ModelMap model){
		List<Tree> trees = companyBranchService.getCompanyBranchTreeByCompanyId(companyId);
		model.put("trees", trees);
		return "ajax.get.company.branches";
	}

}
