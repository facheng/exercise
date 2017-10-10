package com.dt.framework.dao;

import java.util.Collection;
import java.util.Iterator;
import java.util.Map;

import org.hibernate.Query;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * @author wei
 *
 */
public abstract class MapParamCallback implements HibernateCallback<Object> {
	protected void assembleParams(Query query, Map<String, Object> params) {
		if(params == null || params.size() <= 0) return;
		Iterator<String> itr = params.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			Object value = params.get(key);
			
			if(value instanceof Collection<?>) {
				query.setParameterList(key, (Collection<?>)value);
			} else {
				query.setParameter(key, value);
			}
		}
	}
}
