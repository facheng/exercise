package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.Topic;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:09:35
 */
@Repository
public class TopicDao extends DaoImpl<Topic, Long> implements ITopicDao {
	
}
