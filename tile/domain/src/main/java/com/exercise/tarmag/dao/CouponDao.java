package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.Coupon;

/**
 * @author yuwei
 * @Time 2015-8-10下午02:19:42
 */
@Repository
public class CouponDao extends DaoImpl<Coupon, Long> implements ICouponDao {

	@Override
	public List<Coupon> findNotReceivingCoupons(Long typeId) {
		return this.findReceivingCoupon(0l, typeId);
	}

	@Override
	public List<Coupon> findReceivingCoupon(Long residentId, Long typeId) {
		String sql = "SELECT * FROM DT_COUPON WHERE TYPE_ID=? AND RECEIVER_ID=?";
		return this.query(sql, Coupon.class, new Object[] { typeId, residentId });
	}

	@Override
	public Coupon checkCouponIsExist(Coupon coupon) {
		String sql = "SELECT * FROM DT_COUPON WHERE TYPE_ID=? AND CODE=? AND DELETED=?";
		return this.queryForObject(sql, Coupon.class, new Object[] { coupon.getTypeId(), coupon.getCode() ,Constant.MODEL_DELETED_N });
	}

	@Override
	public int getCouponListCount(Long typeId, String code, Integer isReceived, String phoneNum) {
		StringBuffer sql = new StringBuffer("");
		
		sql.append("SELECT COUNT(*) FROM DT_COUPON A  INNER JOIN DT_COUPON_TYPE B ON A.TYPE_ID = B.ID LEFT JOIN DT_RESIDENT C ON A.RECEIVER_ID = C.ID WHERE A.DELETED =:deleted AND B.DELETED =:deleted ");
		
		sql.append(" AND A.TYPE_ID =:typeId ");
		
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("typeId", typeId);
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		
		if (isReceived  != null && isReceived == 0) {
			sql.append(" AND A.RECEIVER_ID = 0 ");
		}
		
		if (isReceived  != null && isReceived == 1) {
			sql.append(" AND A.RECEIVER_ID != 0 ");
		}
		
		if(StringUtils.isNotBlank(code)){
			sql.append(" AND A.CODE LIKE :code");
			paramsMap.put("code", "%" + code.trim() + "%");
		}
		
		if(StringUtils.isNotBlank(phoneNum)){
			sql.append(" AND C.PHONE_NUM LIKE :phoneNum");
			paramsMap.put("phoneNum", "%" + phoneNum.trim() + "%");
		}
		return this.queryCount(sql.toString(), paramsMap);
	}

	@Override
	public List<Map<String, Object>> getCouponList(
			Long typeId,
			String code,
			Integer isReceived,
			String phoneNum,
			Integer pageNo,
			Integer pageSize) {

		StringBuffer sql = new StringBuffer("");

		sql.append("SELECT A.ID id ,A.CODE code, B.NAME typeName ,C.USER_NAME userName , C.PHONE_NUM phoneNum  ,A.RECEIVED_TIME receivedTime FROM DT_COUPON A");
		sql.append(" INNER JOIN DT_COUPON_TYPE B ON A.TYPE_ID = B.ID LEFT JOIN DT_RESIDENT C ON A.RECEIVER_ID = C.ID WHERE A.DELETED =:deleted AND B.DELETED =:deleted");
		sql.append(" AND A.TYPE_ID =:typeId ");

		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("typeId", typeId);
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		
		if (isReceived  != null && isReceived == 0) {
			sql.append(" AND A.RECEIVER_ID = 0 ");
		}
		
		if (isReceived  != null && isReceived == 1) {
			sql.append(" AND A.RECEIVER_ID != 0 ");
		}
		
		if(StringUtils.isNotBlank(code)){
			sql.append(" AND A.CODE LIKE :code");
			paramsMap.put("code", "%" + code.trim() + "%");
		}
		if (StringUtils.isNotBlank(phoneNum)) {
			sql.append(" AND C.PHONE_NUM LIKE :phoneNum");
			paramsMap.put("phoneNum", "%" + phoneNum.trim() + "%");
		}

		return this.queryForMapList(sql.toString(), pageNo, pageSize, paramsMap);
	}

	@Override
	public List<Map<String ,Object>> getCouponInfo(Long cpId) {
		String sql = "SELECT A.ID id ,A.CODE code, B.NAME typeName ,C.USER_NAME userName ,C.PHONE_NUM phoneNum ,A.RECEIVED_TIME receivedTime FROM DT_COUPON A  INNER JOIN DT_COUPON_TYPE B ON A.TYPE_ID = B.ID LEFT JOIN DT_RESIDENT C ON A.RECEIVER_ID = C.ID WHERE A.DELETED = ? AND B.DELETED = ? AND A.ID = ?";
		return this.queryForMapList(sql,new Object[]{Constant.MODEL_DELETED_N , Constant.MODEL_DELETED_N , cpId});
	}
}
