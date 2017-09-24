package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;



public interface ICouponService {
	
	/**
	 * 按优惠类型查询优惠劵总数
	 * @param typeId
	 * @param code
	 * @param isReceived
	 * @param phoneNum
	 * @return
	 */
	public int getCouponListCount(Long typeId, String code, Integer isReceived, String phoneNum);
	
	/**
	 * 按优惠类型查询优惠劵列表
	 * @param typeId
	 * @param code
	 * @param phoneNum
	 * @param isReceived
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getCouponList(
			Long typeId,
			String code,
			String phoneNum,
			Integer isReceived,
			Integer pageNo,
			Integer pageSize);
	
	/**
	 * 删除优惠劵
	 * @param typeId
	 * @return
	 * @throws Exception 
	 */
	public void deleteCoupon_tx(Long[] ids) throws Exception;
	
	/**
	 * 获取优惠劵详情
	 * @param cpId
	 * @return
	 */
	public List<Map<String ,Object>> getCouponInfo(Long cpId);

}
