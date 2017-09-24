package com.dt.tarmag.model;


import com.dt.framework.model.DtSimpleModel;


/**
 * 话题图片
 * @author yuwei
 * @Time 2015-7-6下午02:43:04
 */
public class TopicPicture extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1581064146363592885L;
	private long topicId;
	private String url;
	
	
	public long getTopicId() {
		return topicId;
	}
	public void setTopicId(long topicId) {
		this.topicId = topicId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
