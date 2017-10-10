/**
 * 
 */
package com.dt.tarmag.dao;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.SmsCode;

/**
 * @author raymond 验证码 数据持久化操作类
 */
@Repository
public class SmsCodeDao extends DaoImpl<SmsCode, Long> implements ISmsCodeDao {

	@Override
	public boolean isValid(String pinCode) {
		String sql = "SELECT COUNT(1) FROM DT_SMS_CODE SC WHERE SC.`CODE`= ? AND SC.VALID_TIME>NOW()";
		return this.queryCount(sql, pinCode) > 0;
	}

}