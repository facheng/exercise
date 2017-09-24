/*
 * 版权所有 团团科技 沪ICP备14043145号
 * 
 * 团团科技拥有此网站内容及资源的版权，受国家知识产权保护，未经团团科技的明确书面许可，
 * 任何单位或个人不得以任何方式，以中文和任何文字作全部和局部复制、转载、引用。
 * 否则本公司将追究其法律责任。
 * 
 * $Id$
 * $URL$
 */
package com.dt.tarmag.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.ICityDao;
import com.dt.tarmag.dao.IDistrictDao;
import com.dt.tarmag.dao.IProvinceDao;
import com.dt.tarmag.model.City;
import com.dt.tarmag.model.District;
import com.dt.tarmag.model.Province;


/**
 * 省、市、区 管理
 *
 * @author Administrator
 * @since 2015年7月6日
 */
@Service
public class AreaService implements IAreaService {

	@Autowired
	private IProvinceDao provinceDao;
	
	@Autowired
	private ICityDao cityDao;
	
	@Autowired
	private IDistrictDao districtDao;
	
	/**
	 * 获取城市
	 * @return
	 */
	@Override
	public List<Province> findProvinces(Province province) {
		return provinceDao.getProvinces(province);
	}

	/**
	 * 根据省id获取城市
	 * @return
	 */
	@Override
	public List<City> findCitys(City city) {
		return cityDao.getCitys(city);
	}

	/**
	 * 根据市id获取县
	 * @return
	 */
	@Override
	public List<District> findDistricts(District district) {
		return districtDao.getDistricts(district);
	}



	/**根据ProvinceId获取省
	 * @return
	 */
	@Override
	public List<Province> findProvincebyProvinceId(Province province) {
		return provinceDao.getProvincebyProvinceId(province);
	}

}
