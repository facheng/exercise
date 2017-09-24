package com.dt.tarmag.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.WorkType;

/**
 * @author yuwei
 * @Time 2015-7-17下午03:35:30
 */
@Repository
public class WorkTypeDao extends DaoImpl<WorkType, Long> implements IWorkTypeDao {

	@Override
	public List<WorkType> getWorkTypeByType(byte type) {
		String sql = "SELECT * FROM DT_WORK_TYPE WHERE TYPE = ?";
		return query(sql, WorkType.class, new Object[]{type});
	}
	
}
