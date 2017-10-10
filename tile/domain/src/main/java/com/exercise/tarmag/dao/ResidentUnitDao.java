package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.ResidentUnit;

/**
 * @author yuwei
 * @Time 2015-7-24下午02:00:42
 */
@Repository
public class ResidentUnitDao extends DaoImpl<ResidentUnit, Long> implements IResidentUnitDao {

	@Override
	public List<ResidentUnit> getResidentUnits(Long unitId, Long residentId) {
		Map<String, Object> params = new HashMap<String, Object>();
		String sql = "select * from DT_RESIDENT_UNIT where RESIDENT_ID = :residentId and DELETED = 'N' ";
		params.put("residentId", residentId);
		if(unitId != null){
			sql += " and UNIT_ID = :unitId ";
			params.put("unitId", unitId);
		}
		return  this.query(sql, ResidentUnit.class, params);
	}
	
}
