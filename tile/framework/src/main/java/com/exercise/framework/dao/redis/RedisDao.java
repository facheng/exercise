package com.dt.framework.dao.redis;

import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RedisDao implements IRedisDao {
	
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	
	@Override
	public void save(String key, Object value) {
		redisTemplate.opsForValue().set(key, value);
	}

	@Override
	public void save(String key, Object value, long time, TimeUnit unit) {
		redisTemplate.opsForValue().set(key, value);
		redisTemplate.expire(key, time, unit);
	}

	public Object get(String key) {
		return redisTemplate.opsForValue().get(key);
	}

	public void delete(String key) {
		redisTemplate.delete(key);
	}

	@Override
	public boolean contain(String key) {
		Object object = redisTemplate.opsForValue().get(key);
		return object != null;
	}

}
