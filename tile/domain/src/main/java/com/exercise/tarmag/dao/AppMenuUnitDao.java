package com.dt.tarmag.dao;


import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.AppMenuUnit;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:38:00
 */
@Repository
public class AppMenuUnitDao extends DaoImpl<AppMenuUnit, Long> implements IAppMenuUnitDao {

	@Override
	public AppMenuUnit getAppMenuUnit(long unitId, long menuId) {
		String sql = "SELECT * FROM DT_APP_MENU_UNIT WHERE UNIT_ID = ? AND MENU_ID = ?";
		return queryForObject(sql, AppMenuUnit.class, new Object[]{unitId, menuId});
	}

	@Override
	public void deleteByUnitId(long unitId) {
		String sql = "DELETE FROM DT_APP_MENU_UNIT WHERE UNIT_ID = ?";
		execute(sql, new Object[]{unitId});
	}
	
}
