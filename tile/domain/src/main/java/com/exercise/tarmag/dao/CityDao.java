package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.City;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
@Repository
public class CityDao extends DaoImpl<City, Long> implements ICityDao {

	@Override
	public List<City> getCitys(City city) {
		StringBuffer sqlBuf = new StringBuffer(
				"SELECT * FROM DT_CITY WHERE LOCALE=:locale");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("locale", city.getLocale());
		if (city.getProvinceId() != 0) {
			sqlBuf.append(" AND PROVINCE_ID=:provinceId");
			params.put("provinceId", city.getProvinceId());
		}
		if (city.getCityId() != 0) {
			sqlBuf.append(" AND city_Id=:cityId");
			params.put("cityId", city.getCityId());
		}
		sqlBuf.append(" ORDER BY PROVINCE_ID");
		return this.query(sqlBuf.toString(), City.class, params);
	}
}
