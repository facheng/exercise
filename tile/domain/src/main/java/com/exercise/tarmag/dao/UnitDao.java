package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.LocaleUtil;
import com.dt.tarmag.model.Unit;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class UnitDao extends DaoImpl<Unit, Long> implements IUnitDao {

	@Override
	public List<Unit> getUnits(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("SELECT * FROM DT_UNIT WHERE DELETED='N'");
		if(params.containsKey("districtId")){
			sql.append(" AND DISTRICT_ID=:districtId");
		}
		return this.query(sql.toString(), Unit.class, params);
	}

	/**
	 * 分页获取获取小区
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getPageUnit(int pageNo, int pageSize, Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		
		params.put("locale", LocaleUtil.getLocale().toString());
		
		sql.append("SELECT A.ID id ,A.UNIT_NAME unitName ,B.COMPANY_NAME companyName,C.BRANCH_NAME branchName,D.DISTRICT_NAME districtName FROM DT_UNIT A"); 
		sql.append(" LEFT JOIN DT_COMPANY B ON A.COMPANY_ID = B.ID"); 
		sql.append(" LEFT JOIN DT_COMPANY_BRANCH C ON A.BRANCH_ID = C.ID"); 
		sql.append(" LEFT JOIN DT_DISTRICT D ON A.DISTRICT_ID = D.DISTRICT_ID AND D.LOCALE=:locale WHERE A.DELETED = 'N'"); 
		if(params.containsKey("companyId")){
			sql.append(" AND A.COMPANY_ID=:companyId");
		}
		if(params.containsKey("unitName")){
			sql.append(" AND A.UNIT_NAME LIKE :unitName");
		}
		List<Map<String, Object>> list = queryForMapList(sql.toString(), pageNo, pageSize, params);
		
		return list;
	}

	/**
	 * 获取小区总数
	 * @param params
	 * @return
	 */
	@Override
	public int getCountUnit(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT COUNT(1) FROM DT_UNIT A"); 
		sql.append(" WHERE A.DELETED = 'N' ");
		if(params.containsKey("companyId")){
			sql.append(" AND A.COMPANY_ID=:companyId");
		}
		if(params.containsKey("unitName")){
			sql.append(" AND A.UNIT_NAME LIKE :unitName");
		}
		
		return this.queryCount(sql.toString(), params);
	}

	/**
	 *根据 id 获取小区详情
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getUnitById(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT A.ID id ,A.UNIT_NAME unitName,A.LANTITUDE lantitude,A.LONGITUDE longitude ,A.ADDRESS address,A.REMARK remark,B.COMPANY_NAME companyName,A.COMPANY_ID companyId ,C.BRANCH_NAME branchName,A.BRANCH_ID branchId,D.DISTRICT_NAME districtName,D.CITY_ID cityId,A.DISTRICT_ID districtId FROM DT_UNIT A"); 
		sql.append(" LEFT JOIN DT_COMPANY B ON A.COMPANY_ID = B.ID"); 
		sql.append(" LEFT JOIN DT_COMPANY_BRANCH C ON A.BRANCH_ID = C.ID"); 
		sql.append(" LEFT JOIN DT_DISTRICT D ON A.DISTRICT_ID = D.DISTRICT_ID AND D.LOCALE=:locale WHERE A.DELETED = 'N'"); 
		sql.append(" AND A.ID = :id");
		return this.queryForMapList(sql.toString(), params);
	}

	@Override
	public Unit getDefaultUnit(Long residentId) {
		String sql = "SELECT U.* FROM DT_UNIT U, DT_HOUSE_RESIDENT HR, DT_HOUSE H WHERE U.DELETED='N' AND HR.DELETED='N' AND H.DELETED='N' AND HR.IS_DEFAULT=? AND U.ID=H.UNIT_ID AND HR.HOUSE_ID=H.ID AND HR.RESIDENT_ID=?";
		return this.queryForObject(sql, Unit.class, 1, residentId);
	}

	@Override
	public List<Unit> getUnitsByBranchId(long branchId, long companyId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_UNIT ")
		   .append(" WHERE DELETED = :deleted AND COMPANY_ID = :companyId ")
		   .append(" AND BRANCH_ID IN ")
		   .append(" ( ")
		   .append("     SELECT ID ")
		   .append("     FROM DT_COMPANY_BRANCH ")
		   .append("     WHERE DELETED = :deleted AND COMPANY_ID = :companyId ")
		   .append("     AND CODE LIKE CONCAT((SELECT CODE FROM DT_COMPANY_BRANCH WHERE ID = :branchId AND COMPANY_ID = :companyId AND DELETED = :deleted), '%') ")
		   .append(" )");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("branchId", branchId);
		params.put("companyId", companyId);
		
		return this.query(sql.toString(), Unit.class, params);
	}
}
