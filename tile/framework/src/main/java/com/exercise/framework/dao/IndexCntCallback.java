package com.dt.framework.dao;

import java.sql.SQLException;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 * @author wei
 *
 */
public class IndexCntCallback extends IndexParamCallback {
	protected String sql;
	protected Object[] params;
	
	public IndexCntCallback(String sql, Object ... params) {
		this.sql = sql;
		this.params = params;
	}

	@Override
	public Object doInHibernate(Session session) throws HibernateException, SQLException {
		SQLQuery query = session.createSQLQuery(sql);
		assembleParams(query, params);
		return new Integer(query.uniqueResult().toString());
	}
}
