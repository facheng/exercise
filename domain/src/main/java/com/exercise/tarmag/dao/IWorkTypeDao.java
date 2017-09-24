package com.dt.tarmag.dao;



import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.WorkType;


/**
 * @author yuwei
 * @Time 2015-7-17下午03:34:51
 */
public interface IWorkTypeDao extends Dao<WorkType, Long> {
	List<WorkType> getWorkTypeByType(byte type);
}
