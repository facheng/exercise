package com.dt.tarmag.vo;

/**
 * 物业费设置vo
 * @author wangfacheng
 * @date 2015年8月21日11:06:43
 */

public class PropertyChargeRuleVo {
	
	private Long partitionId;
	private Byte cycle;
	private Byte ctype;
	private Double feeArea;
	private Double feeLift;
	private Double feeAll;
	private Double basementFeeArea;
	private Byte isEffect;
	
	private Long unitId;//小区id
	
	
	public Long getUnitId() {
		return unitId;
	}

	
	public void setUnitId(Long unitId) {
		this.unitId = unitId;
	}


	
	public Long getPartitionId() {
		return partitionId;
	}


	
	public void setPartitionId(Long partitionId) {
		this.partitionId = partitionId;
	}


	
	public Byte getCycle() {
		return cycle;
	}


	
	public void setCycle(Byte cycle) {
		this.cycle = cycle;
	}


	
	public Byte getCtype() {
		return ctype;
	}


	
	public void setCtype(Byte ctype) {
		this.ctype = ctype;
	}


	
	public Double getFeeArea() {
		return feeArea;
	}


	
	public void setFeeArea(Double feeArea) {
		this.feeArea = feeArea;
	}


	
	public Double getFeeLift() {
		return feeLift;
	}


	
	public void setFeeLift(Double feeLift) {
		this.feeLift = feeLift;
	}


	
	public Double getFeeAll() {
		return feeAll;
	}


	
	public void setFeeAll(Double feeAll) {
		this.feeAll = feeAll;
	}


	
	public Double getBasementFeeArea() {
		return basementFeeArea;
	}


	
	public void setBasementFeeArea(Double basementFeeArea) {
		this.basementFeeArea = basementFeeArea;
	}


	
	public Byte getIsEffect() {
		return isEffect;
	}


	
	public void setIsEffect(Byte isEffect) {
		this.isEffect = isEffect;
	}

	
}
