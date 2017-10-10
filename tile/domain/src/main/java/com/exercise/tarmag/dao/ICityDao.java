package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.City;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
public interface ICityDao extends Dao<City, Long> {
	/**
	 * 根据省id获取城市
	 * @param provinceId
	 * @return
	 */
	public List<City> getCitys(City city);
	
}
