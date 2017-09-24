package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 话题回复
 * @author yuwei
 * @Time 2015-7-6下午02:43:04
 */
public class TopicReply extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = 795747659240508865L;
	private long topicId;
	private String content;
	
	
	public long getTopicId() {
		return topicId;
	}
	public void setTopicId(long topicId) {
		this.topicId = topicId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
}
