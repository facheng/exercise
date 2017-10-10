package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CouponType;


/**
 * @author yuwei
 * @Time 2015-8-10下午02:20:11
 */
public interface ICouponTypeDao extends Dao<CouponType, Long> {
	/**
	 * 获取可以领取的优惠劵列表
	 * @param residentId
	 * @param pageNo
	 * @return
	 */
	public List<Map<String, Object>> coupontypes(Long residentId, int pageNo);
	
	/**
	 * 获取已经领取的优惠劵列表
	 * @param residentId
	 * @param pageNo
	 * @return
	 */
	public List<Map<String, Object>> coupons(Long residentId, int pageNo);
	
	/**
	 * 获取优惠类型总数
	 * @param cpName
	 * @param sponsor
	 * @return
	 */
	public int getCouponTypeListCount(String cptName, String sponsor);
	
	/**
	 * 获取优惠类型列表
	 * @param cpName
	 * @param sponsor
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String,Object>> getCouponTypeList(String cptName, String sponsor, Integer pageNo, Integer pageSize);
}
