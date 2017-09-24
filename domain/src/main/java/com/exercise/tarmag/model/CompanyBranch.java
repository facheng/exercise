package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 物业公司组织架构
 * @author yuwei
 * @Time 2015-6-25上午10:58:27
 */
public class CompanyBranch extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5200134789303384446L;
	private long companyId;
	private String code;
	private String branchName;
	private long parentId;
	private String remark;
	
	
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
