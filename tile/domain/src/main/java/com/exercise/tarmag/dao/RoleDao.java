package com.dt.tarmag.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Role;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class RoleDao extends DaoImpl<Role, Long> implements IRoleDao {

	@Override
	public Role findAdminRole(Long companyId) {
		String sql = "SELECT * FROM DT_ROLE WHERE DELETED='N' AND IS_ADMIN=:isAdmin AND COMPANY_ID=:companyId";
		return this.queryForObject(sql, Role.class,
				Params.getParams("isAdmin", 1).add("companyId", companyId));
	}

	@Override
	public int getRoleCount(long companyId, String roleName) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_ROLE ")
		   .append(" WHERE COMPANY_ID = :companyId AND DELETED = :deleted AND IS_ADMIN = :isAdmin ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("isAdmin", false);
		
		if(roleName != null && !roleName.trim().equals("")) {
			sql.append(" AND ROLE_NAME LIKE :roleName");
			params.put("roleName", "%" + roleName.trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Role> getRoleList(long companyId, String roleName, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_ROLE ")
		   .append(" WHERE COMPANY_ID = :companyId AND DELETED = :deleted AND IS_ADMIN = :isAdmin ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("isAdmin", false);
		
		if(roleName != null && !roleName.trim().equals("")) {
			sql.append(" AND ROLE_NAME LIKE :roleName");
			params.put("roleName", "%" + roleName.trim() + "%");
		}
		
		return query(sql.toString(), Role.class, pageNo, pageSize, params);
	}

	@Override
	public List<Role> getRoleListByCompanyId(long companyId, boolean isAdmin) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_ROLE ")
		   .append(" WHERE COMPANY_ID = :companyId AND DELETED = :deleted AND IS_ADMIN = :isAdmin ");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("isAdmin", isAdmin);
		
		return query(sql.toString(), Role.class, params);
	}
}
