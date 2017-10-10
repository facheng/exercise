package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.Event;


/**
 * @author yuwei
 * @Time 2015-7-6下午06:59:34
 */
@Repository
public class EventDao extends DaoImpl<Event, Long> implements IEventDao {
	
}
