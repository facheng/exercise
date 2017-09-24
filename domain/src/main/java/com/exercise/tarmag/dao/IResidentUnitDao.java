package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ResidentUnit;


/**
 * @author yuwei
 * @Time 2015-7-24下午01:59:50
 */
public interface IResidentUnitDao extends Dao<ResidentUnit, Long> {
	
	List<ResidentUnit> getResidentUnits(Long unitId, Long residentId);
}
