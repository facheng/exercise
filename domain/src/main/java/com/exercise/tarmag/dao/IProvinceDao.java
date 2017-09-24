package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Province;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:54
 */
public interface IProvinceDao extends Dao<Province, Long> {
	/**获取省份
	 * @return
	 */
	public List<Province> getProvinces(Province province);
	
	/**根据ProvinceId获取省
	 * @return
	 */
	public List<Province> getProvincebyProvinceId(Province province);
}
