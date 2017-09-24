package com.dt.framework.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.LockMode;

/**
 * @author wei
 *
 * @param <T>
 * @param <PK>
 */
public interface Dao<T extends Serializable, PK extends Serializable> {
	List<T> getAll();
	T get(PK id);
	T get(PK id, LockMode lockMode);
	void save(T entity);
	void saveOrUpdateAll(Collection<T> entities);
	void update(T entity);
	void saveOrUpdate(T entity);
	T merge(T entity);
	void deleteByKey(PK id);
	void delete(T entity);
	void deleteLogic(PK id);
}
