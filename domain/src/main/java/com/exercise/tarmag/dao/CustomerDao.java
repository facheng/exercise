package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.util.PageResult;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class CustomerDao extends DaoImpl<Customer, Long> implements ICustomerDao {

	@Override
	public Customer getCustomer(Customer user) {
		String sql = "SELECT c.* FROM DT_CUSTOMER c WHERE  c.user_name = ? and c.password = ? and c.deleted = 'N'";
		return this.queryForObject(sql, Customer.class, new Object[]{user.getUserName(), user.getPassword()});
	}

	@Override
	public Customer getCustomerByUserName(String userName) {
		if(userName == null || userName.trim().equals("")) {
			return null;
		}
		
		String sql = "SELECT * FROM DT_CUSTOMER WHERE USER_NAME = ?";
		return queryForObject(sql, Customer.class, new Object[]{userName.trim()});
	}

	@Override
	public PageResult<Map<String, Object>> findCustomer(Map<String, Object> params, Page page) {
		String selectSql = "SELECT CR.ID id, CR.USER_NAME userName,C.ID companyId, C.COMPANY_NAME companyName,A.USER_NAME createUserName,CR.CREATE_DATE_TIME creteDateTime";
		String countSql = "SELECT COUNT(1)";
		StringBuffer whereBuf = new StringBuffer(" FROM DT_CUSTOMER CR INNER JOIN DT_COMPANY C ON C.DELETED='N' AND C.ID=CR.COMPANY_ID INNER JOIN DT_SYS_ADMIN A ON A.DELETED='N' AND A.ID=CR.CREATE_USER_ID WHERE CR.DELETED='N' AND CR.IS_ADMIN=:isAdmin");
		params.put("isAdmin", 1);
		if(params.containsKey("companyId")){
			whereBuf.append(" AND CR.COMPANY_ID=:companyId");
		}
		if(params.containsKey("userName")){
			whereBuf.append(" AND CR.USER_NAME LIKE :userName");
			params.put("userName", "%"+params.get("userName")+"%");
		}
		List<Map<String, Object>> customers = this.queryForMapList(selectSql + whereBuf.toString(), page.getCurrentPage(), page.getPageSize(), params);
		int count = this.queryCount(countSql + whereBuf, params);
		page.setRowCount(count);
		return new PageResult<Map<String,Object>>(page, customers);
	}

	@Override
	public List<Customer> getCustomerListByCompanyId(Map<String, Object> params, int pageNo ,int pageSize) {
		StringBuffer sql = new StringBuffer("SELECT * FROM DT_CUSTOMER WHERE COMPANY_ID =:companyId AND IS_ADMIN =:isAdmin AND DELETED = 'N'");
		if(params.containsKey("userName")){
			sql.append(" AND USER_NAME LIKE :userName");
			params.put("userName", "%"+params.get("userName")+"%");
		}
		
		return query(sql.toString(), Customer.class, pageNo, pageSize, params);
	}

	@Override
	public int getCountCustomerListByCompanyId(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("SELECT count(1) FROM DT_CUSTOMER WHERE COMPANY_ID =:companyId AND IS_ADMIN =:isAdmin AND DELETED = 'N'");
		
		if(params.containsKey("userName")){
			sql.append(" AND USER_NAME LIKE :userName");
			params.put("userName", "%"+params.get("userName")+"%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public int getCustomerCountByCompanyId(long companyId, boolean isAdmin, String userName) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(ID) ")
		   .append(" FROM DT_CUSTOMER ")
		   .append(" WHERE COMPANY_ID = :companyId ")
		   .append(" AND IS_ADMIN = :isAdmin ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("isAdmin", isAdmin);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(userName != null && !userName.trim().equals("")) {
			sql.append(" AND USER_NAME LIKE :userName ");
			params.put("userName", "%" + userName.trim() + "%");
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Customer> getCustomerListByCompanyId(long companyId, boolean isAdmin, String userName, int pageNo, int pageSize) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT * ")
		   .append(" FROM DT_CUSTOMER ")
		   .append(" WHERE COMPANY_ID = :companyId ")
		   .append(" AND IS_ADMIN = :isAdmin ")
		   .append(" AND DELETED = :deleted ");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("companyId", companyId);
		params.put("isAdmin", isAdmin);
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(userName != null && !userName.trim().equals("")) {
			sql.append(" AND USER_NAME LIKE :userName ");
			params.put("userName", "%" + userName.trim() + "%");
		}
		
		return query(sql.toString(), Customer.class, params);
	}
}
