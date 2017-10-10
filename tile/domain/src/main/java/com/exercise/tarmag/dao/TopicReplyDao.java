package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.TopicReply;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:12:57
 */
@Repository
public class TopicReplyDao extends DaoImpl<TopicReply, Long> implements ITopicReplyDao {
	
}
