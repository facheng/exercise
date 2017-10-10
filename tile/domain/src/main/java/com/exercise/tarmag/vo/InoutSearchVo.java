package com.dt.tarmag.vo;



/**
 * 出入记录查询条件
 * @author yuwei
 * @Time 2015-7-29下午02:14:34
 */
public class InoutSearchVo extends TimeSearchVo {
	
	private Long residentId;
	
	/**
	 * 人员姓名
	 */
	private String rname;
	
	
	
	
	
	public String getRname() {
		return rname;
	}
	
	public void setRname(String rname) {
		this.rname = rname;
	}

	
	public Long getResidentId() {
		return residentId;
	}

	
	public void setResidentId(Long residentId) {
		this.residentId = residentId;
	}
	
	
	
}
