/**
 * 
 */
package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.Province;

/**
 * @author raymond
 *
 */
@Repository
public class ProvinceDao extends DaoImpl<Province, Long> implements IProvinceDao {

	@Override
	public List<Province> getProvinces(Province province) {
		String sql = "SELECT * FROM DT_PROVINCE WHERE LOCALE=:locale";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("locale", province.getLocale());
		return this.query(sql, Province.class, params);
	}

	/**根据ProvinceId获取省
	 * @return
	 */
	@Override
	public List<Province> getProvincebyProvinceId(Province province) {
		String sql = "SELECT * FROM DT_PROVINCE WHERE LOCALE=:locale and PROVINCE_ID = :provinceId";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("locale", province.getLocale());
		params.put("provinceId", province.getProvinceId());
		return this.query(sql, Province.class, params);
	}

}
