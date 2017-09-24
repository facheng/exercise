package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Coupon;


/**
 * @author yuwei
 * @Time 2015-8-10下午02:19:05
 */
public interface ICouponDao extends Dao<Coupon, Long> {
	/**
	 * 获取未被领取的优惠劵
	 * @return
	 */
	public List<Coupon>  findNotReceivingCoupons(Long typeId);
	
	/**
	 * 根据类型和用户id 获取领取的验证码
	 * @param residentId
	 * @param typeId
	 * @return
	 */
	public List<Coupon> findReceivingCoupon(Long residentId, Long typeId);
	
	/**
	 * 检查优惠卷是否存在
	 * @param Coupon
	 * @return Coupon
	 */
	public Coupon checkCouponIsExist(Coupon coupon);
	
	/**
	 * 按优惠类型查询优惠劵列表
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
	 * @param isReceived
	 * @param phoneNum
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getCouponList(
			Long typeId,
			String code,
			Integer isReceived,
			String phoneNum,
			Integer pageNo,
			Integer pageSize);
	
	/**
	 * 获取优惠劵详情
	 * @param cpId
	 * @return
	 */
	public List<Map<String ,Object>> getCouponInfo(Long cpId);
}
