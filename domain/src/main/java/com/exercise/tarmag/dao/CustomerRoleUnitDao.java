package com.dt.tarmag.dao;


import java.sql.SQLException;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.CustomerRoleUnit;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class CustomerRoleUnitDao extends DaoImpl<CustomerRoleUnit, Long> implements ICustomerRoleUnitDao {

	@SuppressWarnings("unchecked")
	@Override
	public List<Long> getUnitListByCustmerId(final long customerId) {
		final String sql = "SELECT DISTINCT UNIT_ID FROM DT_CUSTOMER_ROLE_UNIT WHERE CUSTOMER_ID = ? AND DELETED = ?";
		
		return getHibernateTemplate().execute(new HibernateCallback<List<Long>>(){
			@Override
			public List<Long> doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter(0, customerId);
				query.setParameter(1, Constant.MODEL_DELETED_N);
				query.addScalar("UNIT_ID", Hibernate.LONG);
				return query.list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Long> getRoleListByCustomerAndUnit(final long customerId, final long unitId) {
		final String sql = "SELECT DISTINCT ROLE_ID FROM DT_CUSTOMER_ROLE_UNIT WHERE CUSTOMER_ID = ? AND UNIT_ID = ? AND DELETED = ?";
		
		return getHibernateTemplate().execute(new HibernateCallback<List<Long>>(){
			@Override
			public List<Long> doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter(0, customerId);
				query.setParameter(1, unitId);
				query.setParameter(2, Constant.MODEL_DELETED_N);
				query.addScalar("ROLE_ID", Hibernate.LONG);
				return query.list();
			}
		});
	}

	@Override
	public CustomerRoleUnit getCustomerRoleUnit(long customerId, long roleId, long unitId) {
		String sql = "SELECT * FROM DT_CUSTOMER_ROLE_UNIT WHERE CUSTOMER_ID = ? AND ROLE_ID = ? AND UNIT_ID = ? AND DELETED = ?";
		return queryForObject(sql, CustomerRoleUnit.class, new Object[]{customerId, roleId, unitId, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<CustomerRoleUnit> getCustomerRoleUnitList(long customerId) {
		String sql = "SELECT * FROM DT_CUSTOMER_ROLE_UNIT WHERE CUSTOMER_ID = ? AND DELETED = ?";
		return query(sql, CustomerRoleUnit.class, new Object[]{customerId, Constant.MODEL_DELETED_N});
	}
	
	@Override
	public int getCountByRoleId(long roleId) {
		String sql = "SELECT COUNT(ID) FROM DT_CUSTOMER_ROLE_UNIT WHERE ROLE_ID = ? AND DELETED = ?";
		return queryCount(sql, new Object[]{roleId, Constant.MODEL_DELETED_N});
	}
}
