package com.dt.framework.dao;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;

import org.hibernate.LockMode;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.dt.framework.model.DtSimpleModel;
import com.dt.framework.util.Constant;

/**
 * @author wei
 *
 */
public abstract class BaseDaoImpl<T extends Serializable, PK extends Serializable> extends HibernateDaoSupport implements Dao<T, PK> {
	private Class<T> entityClass;

	@SuppressWarnings("unchecked")
	public BaseDaoImpl() {
		this.entityClass = null;
		Class<T> c = (Class<T>) getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}
	
	@Override
	public List<T> getAll() {
		return getHibernateTemplate().loadAll(entityClass);
	}

	@Override
	public T get(PK id) {
		return (T) getHibernateTemplate().get(entityClass, id);
	}

	@Override
	public T get(PK id, LockMode lockMode) {
		return (T) getHibernateTemplate().get(entityClass, id, lockMode);
	}

	@Override
	public void save(T entity) {
		getHibernateTemplate().save(entity);
	}

	@Override
	public void saveOrUpdateAll(Collection<T> entities) {
		getHibernateTemplate().saveOrUpdate(entities);
	}

	@Override
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	@Override
	public void saveOrUpdate(T entity) {
		getHibernateTemplate().saveOrUpdate(entity);
	}
	
	@Override
	public T merge(T entity) {
		return (T)getHibernateTemplate().merge(entity);
	}

	@Override
	public void deleteByKey(PK id) {
		T entity = get(id);
		if(entity != null) {
			getHibernateTemplate().delete(entity);
		}
	}
	
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}
	
	@Override
	public void deleteLogic(PK id) {
		T entity = get(id);
		if(entity == null) {
			return;
		}
		
		if (!(entity instanceof DtSimpleModel)) {
			throw new RuntimeException("不支持逻辑删除");
		}
		
		DtSimpleModel dsm = (DtSimpleModel) entity;
		dsm.setDeleted(Constant.MODEL_DELETED_Y);
		getHibernateTemplate().update(dsm);
	}
	
}
