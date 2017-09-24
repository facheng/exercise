package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.EventJoiner;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:03:23
 */
@Repository
public class EventJoinerDao extends DaoImpl<EventJoiner, Long> implements IEventJoinerDao {
	
}
