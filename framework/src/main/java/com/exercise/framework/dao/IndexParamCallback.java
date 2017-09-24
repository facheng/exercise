package com.dt.framework.dao;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * @author wei
 *
 */
public abstract class IndexParamCallback implements HibernateCallback<Object> {
	protected void assembleParams(Query query, Object ... params) {
		for (int i = 0; i < params.length; i++) {
			query.setParameter(i, params[i]);
		}
	}
}
