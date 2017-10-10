package com.dt.tarmag.dao;


import java.sql.SQLException;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.RoleMenu;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class RoleMenuDao extends DaoImpl<RoleMenu, Long> implements IRoleMenuDao {

	@Override
	public void deleteByRoleId(Long roleId) {
		String sql = "DELETE FROM DT_ROLE_MENU WHERE ROLE_ID=?";
		this.execute(sql, roleId);
	}

	@Override
	public List<Long> getMenuIdListByRoleId(final long roleId) {
		final String sql = " SELECT MENU_ID FROM DT_ROLE_MENU WHERE ROLE_ID = ? AND DELETED = ? ";
		
		return getHibernateTemplate().execute(new HibernateCallback<List<Long>>(){
			@SuppressWarnings("unchecked")
			@Override
			public List<Long> doInHibernate(Session session) throws HibernateException, SQLException {
				SQLQuery query = session.createSQLQuery(sql);
				query.setParameter(0, roleId);
				query.setParameter(1, Constant.MODEL_DELETED_N);
				query.addScalar("MENU_ID", Hibernate.LONG);
				return query.list();
			}
		});
	}

	@Override
	public RoleMenu getRoleMenu(long roleId, long menuId) {
		String sql = " SELECT * FROM DT_ROLE_MENU WHERE ROLE_ID = ? AND MENU_ID = ? AND DELETED = ? ";
		return queryForObject(sql, RoleMenu.class, new Object[]{roleId, menuId, Constant.MODEL_DELETED_N});
	}
	
}
