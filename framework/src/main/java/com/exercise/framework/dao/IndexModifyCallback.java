package com.dt.framework.dao;

import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 * @author wei
 *
 */
public class IndexModifyCallback extends IndexParamCallback {
	protected String sql;
	protected Object[] params;
	
	public IndexModifyCallback(String sql, Object ... params) {
		this.sql = sql;
		this.params = params;
	}

	@Override
	public Object doInHibernate(Session session) throws HibernateException, SQLException {
		SQLQuery query = session.createSQLQuery(sql);
		assembleParams(query, params);
		return query.executeUpdate();
	}
}
