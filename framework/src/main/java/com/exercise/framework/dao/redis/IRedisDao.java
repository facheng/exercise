package com.dt.framework.dao.redis;

import java.util.concurrent.TimeUnit;

/**
 * @author yuwei
 * @param <T>
 * @Time 2015-6-25下午06:23:25
 */
public interface IRedisDao {
	void save(String key, Object value);
	void save(String key, Object value, long time, TimeUnit unit);
	Object get(String key);
	boolean contain(String key);
	void delete(String key);
}
