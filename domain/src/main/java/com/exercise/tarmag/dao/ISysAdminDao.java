package com.dt.tarmag.dao;


import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.SysAdmin;


public interface ISysAdminDao extends Dao<SysAdmin, Long> {
	/**
	 * 通过用户名获取管理员
	 * @param userName
	 * @return
	 */
	public SysAdmin getSysAdmin(String userName);
}
