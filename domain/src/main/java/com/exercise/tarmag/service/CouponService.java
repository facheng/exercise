package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.ICouponDao;

@Service
public class CouponService implements ICouponService {
	
	@Autowired
	private ICouponDao couponDao;

	@Override
	public int getCouponListCount(Long typeId, String code, Integer isReceived, String phoneNum) {
		
		return couponDao.getCouponListCount(typeId ,code ,isReceived ,phoneNum);
	}

	@Override
	public List<Map<String, Object>> getCouponList(
			Long typeId,
			String code,
			String phoneNum,
			Integer isReceived,
			Integer pageNo,
			Integer pageSize) {
		return couponDao.getCouponList(typeId ,code ,isReceived ,phoneNum ,pageNo ,pageSize);
	}

	@Override
	public void deleteCoupon_tx(Long[] ids) throws Exception {
		try{
			if(ids == null) return;
			for(Long id : ids){
				this.couponDao.deleteLogic(id);
			}
		}catch(Exception e){
			throw new Exception("删除优惠劵失败！");
		}
		
	}

	@Override
	public List<Map<String ,Object>> getCouponInfo(Long cpId) {
		return couponDao.getCouponInfo(cpId);
	}

}
