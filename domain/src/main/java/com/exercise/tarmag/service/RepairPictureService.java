package com.dt.tarmag.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IRepairPictureDao;

@Service
public class RepairPictureService implements IRepairPictureService {

	@Autowired
	private IRepairPictureDao repairPictureDao;
}
