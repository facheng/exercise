package com.dt.framework.dao;

import java.sql.SQLException;
import java.util.Map;

import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

/**
 * @author wei
 *
 */
public class MapModifyCallback extends MapParamCallback {
	protected String sql;
	protected Map<String, Object> params;
	
	public MapModifyCallback(String sql, Map<String, Object> params) {
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
