package com.dt.tarmag.dao;


import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppMenuUnit;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:37:29
 */
public interface IAppMenuUnitDao extends Dao<AppMenuUnit, Long> {
	AppMenuUnit getAppMenuUnit(long unitId, long menuId);
	
	/**
	 * 删除指定小区的所有菜单
	 * @param unitId
	 */
	void deleteByUnitId(long unitId);
}
