package com.dt.tarmag.model;


import com.dt.framework.model.DtSimpleModel;


/**
 * 物业公司反润比例
 * @author yuwei
 * @Time 2015-8-13下午05:34:29
 */
public class ProfitPer extends DtSimpleModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5630022446353492961L;
	private long companyId;
	private double percent;
	
	
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public double getPercent() {
		return percent;
	}
	public void setPercent(double percent) {
		this.percent = percent;
	}
}
