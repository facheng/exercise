package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.CouponTypeVo;


public interface ICouponTypeService {
	
	/**
	 * 获取可领取的验证码列表
	 * @return
	 */
	List<Map<String, Object>> coupontypes(Long residentId, int pageNo);

	/**
	 * 获取已领取的验证码列表
	 * @param residentId
	 * @return
	 */
	List<Map<String, Object>> coupons(Long residentId, int pageNo);

	/**
	 * 领取验证码
	 * @param residentId
	 * @return
	 */
	String coupon_tx(Long residentId, Long typeId);
	
	
	/**
	 * 获取优惠类型总数
	 * @param cpName
	 * @param sponsor
	 * @return
	 */
	public int getCouponTypeListCount(String cpName, String sponsor);
	
	/**
	 * 获取优惠类型列表
	 * @param cpName
	 * @param sponsor
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String,Object>> getCouponTypeList(String cpName, String sponsor, Integer pageNo, Integer pageSize);
	
	/**
	 * 添加修改页面初始化
	 * @param roleId
	 * @return
	 */
	public CouponTypeVo getCouponTypeEdit(Long typeId);
	
	/**
	 * 添加优惠类型
	 * @param couponType
	 * @throws Exception 
	 */
	public void createCouponType_tx(CouponTypeVo couponTypeVo) throws Exception;
	
	/**
	 * 修改优惠类型
	 * @param cptId
	 * @param couponType
	 * @throws Exception 
	 */
	public void updateCouponType_tx(CouponTypeVo couponTypeVo) throws Exception;
	
	/**
	 * 删除优惠类型
	 * @param typeId
	 * @return
	 * @throws Exception 
	 */
	public void deleteCouponType_tx(Long[] ids) throws Exception;
	
	/**
	 * 获取优惠类型列表
	 * @param cptName
	 * @param sponsor
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findCouponType(String cptName ,String sponsor ,Page page);
	
	/**
	 * 获取优惠劵列表
	 * @param typeId
	 * @param code
	 * @param phoneNum
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findCoupons(Long typeId ,String code ,Integer isReceived ,String phoneNum ,Page page);


}
