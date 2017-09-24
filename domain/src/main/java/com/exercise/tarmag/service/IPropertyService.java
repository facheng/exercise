package com.dt.tarmag.service;

import java.util.List;

import com.dt.tarmag.vo.HouseStatusCount;

/**
 * 物业管理
 * @author yuwei
 * @Time 2015-6-25下午02:46:58
 */
public interface IPropertyService {
	
	/**
	 *  房屋状态统计
	 * @param unitId
	 * 			小区id
	 * @return
	 */
	List<HouseStatusCount> getHouseCount(long unitId) throws Exception;
}
