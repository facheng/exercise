package com.dt.tarmag.model;

import net.sf.json.JSONObject;

import com.dt.framework.model.DtModel;


/**
 * 物业公司
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Company extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5826012137040057497L;
	private String companyName;
	private String code;
	private String email;
	private String address;
	private String remark;
	private long districtId;
	
	
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public long getDistrictId() {
		return districtId;
	}
	public void setDistrictId(long districtId) {
		this.districtId = districtId;
	}
	@Override
	public String toString() {
		return JSONObject.fromObject(this).toString();
	}
}
