package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;



/**
 * 宣传的照片
 * @author yuwei
 * @Time 2015-7-6下午06:11:29
 */
public class PublicityPicture extends DtSimpleModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1188600693742675685L;
	private long publicityId;
	private String url;
	
	
	public long getPublicityId() {
		return publicityId;
	}
	public void setPublicityId(long publicityId) {
		this.publicityId = publicityId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
