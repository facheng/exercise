package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.District;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
@Repository
public class DistrictDao extends DaoImpl<District, Long> implements
		IDistrictDao {

	@Override
	public List<District> getDistricts(District district) {
		StringBuffer sqlBuf = new StringBuffer(
				"SELECT * FROM DT_DISTRICT WHERE LOCALE=:locale");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("locale", district.getLocale());
		if (district.getCityId() != 0) {
			sqlBuf.append(" AND CITY_ID=:cityId");
			params.put("cityId", district.getCityId());
		}
		sqlBuf.append(" ORDER BY CITY_ID");
		return this.query(sqlBuf.toString(), District.class, params);
	}

}
