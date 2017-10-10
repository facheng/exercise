package com.dt.tarmag.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IWorkTypeDao;
import com.dt.tarmag.model.WorkType;

@Service
public class WorkerTypeService implements IWorkerTypeService {
	
	@Autowired
	private IWorkTypeDao workTypeDao;

	@Override
	public List<WorkType> getWorkTypeByType(Byte wtType) {
		
		List<WorkType> resultList = workTypeDao.getWorkTypeByType(wtType);
		return resultList;
	}

}
