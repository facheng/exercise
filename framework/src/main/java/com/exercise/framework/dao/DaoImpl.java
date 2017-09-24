package com.dt.framework.dao;

import java.util.List;
import java.util.Map;

import java.io.Serializable;

/**
 * @author wei
 *
 * @param <T>
 * @param <PK>
 */
public abstract class DaoImpl<T extends Serializable, PK extends Serializable> extends BaseDaoImpl<T, PK> {
	/**
	 * 查询某个表的所有字段
	 * @param sql
	 * @param clz
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	protected List<T> query(String sql, Class<T> clz, Map<String, Object> params) {
		return (List<T>)getHibernateTemplate().execute(new MapCallback(sql, clz, params));
	}
	/**
	 * 查询某个表的所有字段
	 * @param sql
	 * @param clz
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	protected List<T> query(String sql, Class<T> clz, Object ... params) {
		return (List<T>)getHibernateTemplate().execute(new IndexCallback(sql, clz, params));
	}
	

	/**
	 * 查询某个表的所有字段。分页查询
	 * @param sql
	 * @param clz
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	protected List<T> query(String sql, Class<T> clz, int pageNo, int pageSize, Map<String, Object> params) {
		return (List<T>)getHibernateTemplate().execute(new MapCallback(sql, clz, pageNo, pageSize, params));
	}
	/**
	 * 查询某个表的所有字段。分页查询
	 * @param sql
	 * @param clz
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	protected List<T> query(String sql, Class<T> clz, int pageNo, int pageSize, Object ... params) {
		return (List<T>)getHibernateTemplate().execute(new IndexCallback(sql, clz, pageNo, pageSize, params));
	}
	

	/**
	 * 查询记录的条数
	 * @param sql
	 * @param params
	 * @return
	 */
	protected int queryCount(String sql, Map<String, Object> params) {
		return (Integer) getHibernateTemplate().execute(new MapCntCallback(sql, params));
	}
	/**
	 * 查询记录的条数
	 * @param sql
	 * @param params
	 * @return
	 */
	protected int queryCount(String sql, Object ... params) {
		return (Integer) getHibernateTemplate().execute(new IndexCntCallback(sql, params));
	}
	

	/**
	 * 查询某个表的所有字段。只取单条记录
	 * @param sql
	 * @param clz
	 * @param params
	 * @return
	 */
	protected T queryForObject(String sql, Class<T> clz, Map<String, Object> params) {
		List<T> list = query(sql, clz, params);
		return list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	protected List<Map<String, Object>> queryForMapList(String sql, Map<String, Object> params) {
    	return (List<Map<String, Object>>)getHibernateTemplate().execute(new MapCallback(sql, Map.class, params));
	}

	@SuppressWarnings("unchecked")
	protected List<Map<String, Object>> queryForMapList(String sql, int pageNo, int pageSize, Map<String, Object> params) {
    	return (List<Map<String, Object>>)getHibernateTemplate().execute(new MapCallback(sql, Map.class, pageNo, pageSize, params));
	}
	
	/**
	 * 查询某个表的所有字段。只取单条记录
	 * @param sql
	 * @param clz
	 * @param params
	 * @return
	 */
	protected T queryForObject(String sql, Class<T> clz, Object ... params) {
		List<T> list = query(sql, clz, params);
		return list.size() > 0 ? list.get(0) : null;
	}

	@SuppressWarnings("unchecked")
	protected List<Map<String, Object>> queryForMapList(String sql, Object ... params) {
    	return (List<Map<String, Object>>)getHibernateTemplate().execute(new IndexCallback(sql, Map.class, params));
	}

	@SuppressWarnings("unchecked")
	protected List<Map<String, Object>> queryForMapList(String sql, int pageNo, int pageSize, Object ... params) {
    	return (List<Map<String, Object>>)getHibernateTemplate().execute(new IndexCallback(sql, Map.class, pageNo, pageSize, params));
	}

	/**
	 * 执行增删改操作
	 * @param sql
	 * @param params
	 * @return
	 */
	protected Object execute(String sql, Map<String, Object> params) {
		return getHibernateTemplate().execute(new MapModifyCallback(sql, params));
	}
	/**
	 * 执行增删改操作
	 * @param sql
	 * @param params
	 * @return
	 */
	protected Object execute(String sql, Object ... params) {
		return getHibernateTemplate().execute(new IndexModifyCallback(sql, params));
	}
	
}
