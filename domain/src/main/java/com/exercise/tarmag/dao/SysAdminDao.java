package com.dt.tarmag.dao;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.SysAdmin;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class SysAdminDao extends DaoImpl<SysAdmin, Long> implements
		ISysAdminDao {

	@Override
	public SysAdmin getSysAdmin(final String userName) {
		String sql = "SELECT * FROM DT_SYS_ADMIN WHERE DELETED = 'N' AND USER_NAME=?";
		return this.queryForObject(sql, SysAdmin.class, userName);
	}

}
