/**
 * 
 */
package com.dt.tarmag.dao;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.SmsCode;

/**
 * @author raymond
 * 验证码 数据持久化接口
 */
public interface ISmsCodeDao extends Dao<SmsCode, Long>{
	/**
	 * 判断验证码是否是有效
	 * @param pinCode
	 * @return
	 */
	public boolean isValid(String pinCode);
}