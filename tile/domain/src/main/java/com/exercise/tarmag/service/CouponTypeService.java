/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.ICouponDao;
import com.dt.tarmag.dao.ICouponTypeDao;
import com.dt.tarmag.model.Coupon;
import com.dt.tarmag.model.CouponType;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.CouponTypeVo;

/**
 * @author 👤wisdom
 *
 */
@Service
public class CouponTypeService implements ICouponTypeService {
	
	@Autowired
	private ICouponTypeDao couponTypeDao;
	
	@Autowired
	private ICouponDao couponDao;

	@Override
	public List<Map<String, Object>> coupontypes(Long residentId, int pageNo) {
		List<Map<String, Object>> coupontypes = this.couponTypeDao.coupontypes(residentId, pageNo);
		this.disposeTime(coupontypes);
		return coupontypes;
	}
	
	protected void disposeTime(List<Map<String, Object>> results){
		if(results == null) return;
		for(Map<String, Object> result : results){
			Object deadline = result.get("deadline");
			if(deadline != null){
				result.put("deadline", DateUtil.formatDate((Date)deadline, "yyyy年MM月dd日"));
			}
			Object receivedTime = result.get("receivedTime");
			if(receivedTime != null){
				result.put("receivedTime", DateUtil.formatDate((Date)receivedTime, "yyyy年MM月dd日"));
			}
		}
	}

	@Override
	public List<Map<String, Object>> coupons(Long residentId, int pageNo) {
		List<Map<String, Object>> coupons = this.couponTypeDao.coupons(residentId, pageNo);
		this.disposeTime(coupons);
		return coupons;
	}

	@Override
	public synchronized String coupon_tx(Long residentId, Long typeId) {
		CouponType couponType = this.couponTypeDao.get(typeId);
		if(couponType.getOnShelf() == CouponType.ON_SHELF_NO){
			throw new UnsupportedOperationException();
		}
		List<Coupon> couList = this.couponDao.findReceivingCoupon(residentId, typeId);
		String code = StringUtils.EMPTY;
		if(couList.isEmpty()){//如果还未领取
			Coupon coupon = null;
			switch(couponType.getCode()){
				case CouponType.CODE_DISCOUNT_CODE://优惠券
					List<Coupon> coupons = this.couponDao.findNotReceivingCoupons(typeId);
					if(!coupons.isEmpty()){
						coupon = coupons.get(0);
					}
					break;
				case CouponType.CODE_ADV://广告
					coupon = new Coupon();
					coupon.setTypeId(couponType.getId());
					coupon.setCode(StringUtils.EMPTY);
					break;
				default:
					break;
			}
			if(coupon != null){
				coupon.setReceivedTime(new Date());
				coupon.setReceiverId(residentId);
				code = coupon.getCode();
				this.couponDao.saveOrUpdate(coupon);
			}
		}else{//领取过直接返回已领取的code 如果是广告code为空
			code = couList.get(0).getCode();
		}
		return code;
	}

	@Override
	public int getCouponTypeListCount(String cpName, String sponsor) {
		return couponTypeDao.getCouponTypeListCount(cpName , sponsor);
	}

	@Override
	public List<Map<String,Object>> getCouponTypeList(String cpName, String sponsor, Integer pageNo, Integer pageSize) {
		List<Map<String,Object>> resultList = couponTypeDao.getCouponTypeList(cpName , sponsor , pageNo ,pageSize);
		this.disposeTime(resultList);
		return resultList;
	}

	@Override
	public CouponTypeVo getCouponTypeEdit(Long typeId) {
		CouponType couponType = couponTypeDao.get(typeId);
		CouponTypeVo cptVo = new CouponTypeVo();
		if(couponType != null && couponType.getId() > 0) {
			cptVo.setId(couponType.getId());
			cptVo.setName(couponType.getName());
			cptVo.setOnShelf(couponType.getOnShelf());
			cptVo.setCode(couponType.getCode());
			cptVo.setRegion(couponType.getRegion());
			cptVo.setRule(couponType.getRule());
			cptVo.setServicePhone(couponType.getServicePhone());
			cptVo.setSponsor(couponType.getSponsor());
			cptVo.setQueryMethod(couponType.getQueryMethod());
			cptVo.setUrl(couponType.getUrl());
			cptVo.setRemark(couponType.getRemark());
			
			cptVo.setCtype(couponType.getCtype());		
			cptVo.setPrice(couponType.getPrice());	
			
			if(couponType.getDeadline() != null){
				cptVo.setDeadline(DateUtil.formatDate(couponType.getDeadline(), DateUtil.PATTERN_DATE1));
			}
			return cptVo;
		}
		return null;
	}

	@Override
	public void createCouponType_tx(CouponTypeVo couponTypeVo) throws Exception {
		try{
			CouponType couponType = new CouponType();
			
			couponType.setName(couponTypeVo.getName());
			couponType.setOnShelf(couponTypeVo.getOnShelf());
			couponType.setRegion(couponTypeVo.getRegion());
			couponType.setSponsor(couponTypeVo.getSponsor());
			couponType.setRule(couponTypeVo.getRule());
			couponType.setQueryMethod(couponTypeVo.getQueryMethod());
			couponType.setServicePhone(couponTypeVo.getServicePhone());
			couponType.setCode(couponTypeVo.getCode());
			couponType.setUrl(couponTypeVo.getUrl());
			couponType.setRemark(couponTypeVo.getRemark());
			
			couponType.setCtype(couponTypeVo.getCtype());		
			couponType.setPrice(couponTypeVo.getPrice());
			
			if(StringUtils.isNotBlank(couponTypeVo.getDeadline())){
				couponType.setDeadline(DateUtil.parseDate(couponTypeVo.getDeadline(), DateUtil.PATTERN_DATE1));
			}
			couponTypeDao.save(couponType);
			
			//导入优惠劵
			if(couponTypeVo.getCpCode() != null){
				String[] cpCodes = couponTypeVo.getCpCode().split("\n");
				if(cpCodes.length > 0){
					for (String code : cpCodes) {
						if(StringUtils.isNotBlank(code)){
							Coupon cp = new Coupon();
							cp.setTypeId(couponType.getId());
							cp.setCode(code.trim());
							couponDao.save(cp);
						}
					
					}
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("添加优惠类型失败！");
		}
	}

	@Override
	public void updateCouponType_tx(CouponTypeVo couponTypeVo) throws Exception {
		try{
			CouponType couponType = couponTypeDao.get(couponTypeVo.getId());
			couponType.setName(couponTypeVo.getName());
			couponType.setOnShelf(couponTypeVo.getOnShelf());
			couponType.setRegion(couponTypeVo.getRegion());
			couponType.setSponsor(couponTypeVo.getSponsor());
			couponType.setRule(couponTypeVo.getRule());
			couponType.setQueryMethod(couponTypeVo.getQueryMethod());
			couponType.setServicePhone(couponTypeVo.getServicePhone());
			couponType.setCode(couponTypeVo.getCode());
			couponType.setUrl(couponTypeVo.getUrl());
			couponType.setRemark(couponTypeVo.getRemark());
			couponType.setCtype(couponTypeVo.getCtype());		
			couponType.setPrice(couponTypeVo.getPrice());
			
			if(StringUtils.isNotBlank(couponTypeVo.getDeadline())){
				couponType.setDeadline(DateUtil.parseDate(couponTypeVo.getDeadline(), DateUtil.PATTERN_DATE1));
			}
			
			couponTypeDao.update(couponType);
			
			//导入优惠劵
			if(couponTypeVo.getCpCode() != null){
				String[] cpCodes = couponTypeVo.getCpCode().split("\n");
				if(cpCodes.length > 0){
					for (String code : cpCodes) {
						if(StringUtils.isNotBlank(code)){
							Coupon cp = new Coupon();
							cp.setTypeId(couponType.getId());
							cp.setCode(code.trim());
							
							//判断优惠劵是否存在
							Coupon cpTemp = couponDao.checkCouponIsExist(cp);
							
							if(cpTemp != null && cpTemp.getId() > 0){
								continue;
							}else{
								couponDao.save(cp);
							}
						}
					}
				}
			}
		
		}catch(Exception e){
			throw new Exception("修改优惠类型失败！");
		}
	}

	@Override
	public void deleteCouponType_tx(Long[] ids) throws Exception {
		try{
			if(ids == null) return;
			for(Long id : ids){
				this.couponTypeDao.deleteLogic(id);
			}
		}catch(Exception e){
			throw new Exception("删除优惠类型失败！");
		}
	}

	@Override
	public PageResult<Map<String, Object>> findCouponType(String cptName ,String sponsor ,Page page) {
		List<Map<String , Object>> couponTypes = couponTypeDao.getCouponTypeList(cptName, sponsor, page.getCurrentPage(), page.getPageSize());
		int count = couponTypeDao.getCouponTypeListCount(cptName, sponsor);
		this.disposeTime(couponTypes);
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, couponTypes);
	}

	@Override
	public PageResult<Map<String, Object>> findCoupons(Long typeId, String code,Integer isReceived, String phoneNum, Page page) {
		List<Map<String , Object>> coupons = couponDao.getCouponList(typeId , code, isReceived, phoneNum, page.getCurrentPage(), page.getPageSize());
		int count = couponDao.getCouponListCount(typeId ,code ,isReceived ,phoneNum);
		this.disposeTime(coupons);
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, coupons);
	}
	
}
