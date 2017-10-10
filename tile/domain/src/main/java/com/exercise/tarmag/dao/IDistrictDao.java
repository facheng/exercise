package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.District;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
public interface IDistrictDao extends Dao<District, Long> {
	/**
	 * 根据城市id获取所有区县
	 * @param cityId
	 * @return
	 */
	public List<District> getDistricts(District district);
}
