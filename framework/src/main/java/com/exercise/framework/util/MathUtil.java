package com.dt.framework.util;

import java.util.Random;
import java.util.UUID;

public class MathUtil {
	/**
	 * 返回长度为【strLength】的随机数，在前面补0
	 */
	public final static String getRandomNum(int len) {
		return String.valueOf(
				(1 + new Random().nextDouble()) * Math.pow(10, len)).substring(
				1, len + 1);
	}
	
	/**
	 * 生成手机令牌
	 * @return
	 */
	public final static String generateToken() {
		return UUID.randomUUID().toString().replace("-", "");
	}
}
