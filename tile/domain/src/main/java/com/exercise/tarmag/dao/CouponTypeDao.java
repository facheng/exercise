package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.CouponType;

/**
 * @author yuwei
 * @Time 2015-8-10下午02:20:36
 */
@Repository
public class CouponTypeDao extends DaoImpl<CouponType, Long> implements ICouponTypeDao {

	@Override
	public List<Map<String, Object>> coupontypes(Long residentId, int pageNo) {
		String sql = "SELECT CT.ID id,CT.NAME name,CT.REGION region,CT.SPONSOR sponsor,CT.DEADLINE deadline,CT.RULE rule,CT.QUERY_METHOD queryMethod,CT.SERVICE_PHONE servicePhone,case when C.ID is null then 0 else 1 end isReceived,CT.CODE code, CT.REMARK remark, CT.URL url, CT.CTYPE ctype, CT.PRICE price FROM DT_COUPON_TYPE CT LEFT JOIN DT_COUPON C ON C.DELETED='N' AND C.TYPE_ID=CT.ID AND C.RECEIVER_ID=? WHERE CT.DELETED='N' AND CT.ON_SHELF=?";
		return this.queryForMapList(sql, pageNo, 10, new Object[]{residentId, CouponType.ON_SHELF_YES});
	}

	@Override
	public List<Map<String, Object>> coupons(Long residentId, int pageNo) {
		String sql = "SELECT CT.ID id,CT.NAME name,CT.REGION region,CT.SPONSOR sponsor,CT.DEADLINE deadline,CT.RULE rule,CT.QUERY_METHOD queryMethod,CT.SERVICE_PHONE servicePhone,C.CODE code, C.RECEIVED_TIME receivedTime, CT.URL url, CT.CTYPE ctype, CT.PRICE price FROM DT_COUPON_TYPE CT INNER JOIN DT_COUPON C ON C.DELETED='N' AND C.TYPE_ID=CT.ID AND C.RECEIVER_ID=? WHERE CT.DELETED='N' ";
		return this.queryForMapList(sql, pageNo, 10, new Object[]{residentId});
	}
	
	@Override
	public int getCouponTypeListCount(String cptName, String sponsor) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		sql.append("SELECT count(*) FROM DT_COUPON_TYPE A WHERE A.DELETED =:deleted");
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		if(StringUtils.isNotBlank(cptName)){
			sql.append(" AND A.NAME LIKE :cptName");
			paramsMap.put("cptName", "%" + cptName.trim() + "%");
		}
		if(StringUtils.isNotBlank(sponsor)){
			sql.append(" AND A.SPONSOR LIKE :sponsor");
			paramsMap.put("sponsor", "%" + sponsor.trim() + "%");
		}
		
		return queryCount(sql.toString(), paramsMap);
	}

	@Override
	public List<Map<String,Object>> getCouponTypeList(String cptName, String sponsor, Integer pageNo, Integer pageSize) {
		StringBuffer sql = new StringBuffer("");
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		sql.append("SELECT A.ID id ,A.NAME name ,A.CTYPE ctype ,A.PRICE price ,");
			
		sql.append("( CASE WHEN A.CODE = 1  THEN '优惠码'  WHEN A.CODE = 2  THEN '电商广告'  ELSE '未知' END ) AS code ,");
		sql.append("( CASE WHEN A.ON_SHELF = 0 THEN '未上架' WHEN A.ON_SHELF = 1 THEN '已上架' ELSE '未知' END ) AS onShelf,");
		
		sql.append("A.REGION region ,A.SPONSOR sponsor ,A.DEADLINE deadline ,A.RULE rule ,A.QUERY_METHOD queryMethod ,A.SERVICE_PHONE servicePhone FROM DT_COUPON_TYPE A WHERE A.DELETED =:deleted");
		paramsMap.put("deleted", Constant.MODEL_DELETED_N);
		
		if(StringUtils.isNotBlank(cptName)){
			sql.append(" AND A.NAME LIKE :cptName");
			paramsMap.put("cptName", "%" + cptName.trim() + "%");
		}
		if(StringUtils.isNotBlank(sponsor)){
			sql.append(" AND A.SPONSOR LIKE :sponsor");
			paramsMap.put("sponsor", "%" + sponsor.trim() + "%");
		}
		
		return this.queryForMapList(sql.toString() , pageNo , pageSize , paramsMap);
	}
}
