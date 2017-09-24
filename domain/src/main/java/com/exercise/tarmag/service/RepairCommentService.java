package com.dt.tarmag.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IRepairCommentDao;
import com.dt.tarmag.model.RepairComment;

@Service
public class RepairCommentService implements IRepairCommentService {

	@Autowired
	private IRepairCommentDao repairCommentDao;
	
	@Override
	public void save_tx(RepairComment comment) {
		comment.setCreateTime(new Date());
		repairCommentDao.save(comment);
	}

	
}
