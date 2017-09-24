package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.RepairComment;

/**
 * @author yuwei
 * @Time 2015-7-19上午11:13:18
 */
@Repository
public class RepairCommentDao extends DaoImpl<RepairComment, Long> implements IRepairCommentDao {
	
}
