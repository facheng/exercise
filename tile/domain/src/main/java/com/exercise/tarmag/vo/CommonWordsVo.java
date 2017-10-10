package com.dt.tarmag.vo;

/**
 * @author wangfacheng
 * @Time 2015年8月12日16:14:18
 */

public class CommonWordsVo {
	
	private String words; //常用语
	
	private int type; //类别(1通知，2快递，3报修)
	
	private long unitId;
	
	private String createrName ; 
	
	
	/**
	 * @return the unitId
	 */
	public long getUnitId() {
		return unitId;
	}

	
	/**
	 * @param unitId the unitId to set
	 */
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}

	public String getCreaterName() {
		return createrName;
	}

	public void setCreaterName(String createrName) {
		this.createrName = createrName;
	}

	public String getWords() {
		return words;
	}
	
	public void setWords(String words) {
		this.words = words;
	}
	
	public int getType() {
		return type;
	}
	
	public void setType(int type) {
		this.type = type;
	}
	
	
}
