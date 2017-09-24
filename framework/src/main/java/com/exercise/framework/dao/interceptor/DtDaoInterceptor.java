package com.dt.framework.dao.interceptor;


import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.hibernate.EmptyInterceptor;
import org.hibernate.type.Type;

import com.dt.framework.model.DtModel;
import com.dt.framework.util.ActionUtil;
/**
 * 定义Dao Interceptor，base hibernate.
 * @author jason
 *
 */
public class DtDaoInterceptor extends EmptyInterceptor {

	private static final long serialVersionUID = -5673605915698004771L;

	@Override
	public boolean onFlushDirty(Object entity, Serializable id,
			Object[] currentState, Object[] previousState,
			String[] propertyNames, Type[] types) {
		
		if (entity instanceof DtModel) {
			for (int i = 0; i < propertyNames.length; i++) {
				if ("updateDateTime".equals(propertyNames[i])) {
					currentState[i] = new Date();
				} else if ("updateUserId".equals(propertyNames[i])) {
					if(ActionUtil.getSessionUserId() != 0){
						currentState[i] = ActionUtil.getSessionUserId();
					}
				}
			}
		}
		return true;
	}

	@Override
	public boolean onSave(Object entity, Serializable id, Object[] state,
			String[] propertyNames, Type[] types) {
		if (entity instanceof DtModel) {
			for (int i = 0; i < propertyNames.length; i++) {
				if ("createDateTime".equals(propertyNames[i])) {
					if(state[i] == null || StringUtils.isBlank(state[i].toString())){
						state[i] = new Date();
					}
				} else if ("createUserId".equals(propertyNames[i])) {
					if(ActionUtil.getSessionUserId() != 0){
						state[i] = ActionUtil.getSessionUserId();
					}
				}
			}
		}
		return true;
	}

	
}
