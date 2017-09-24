package com.dt.tarmag.model;


import com.dt.framework.model.DtSimpleModel;


/**
 * 报修信息相关照片
 * @author yuwei
 * @Time 2015-7-19上午11:01:09
 */
public class RepairPicture extends DtSimpleModel{

	public static final String IMG_PATH = "repairpicture";//图片上传的相对路径
	/**
	 * 
	 */
	private static final long serialVersionUID = -1688817226908400483L;
	private long repairId;
	private String url;
	
	
	public long getRepairId() {
		return repairId;
	}
	public void setRepairId(long repairId) {
		this.repairId = repairId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
