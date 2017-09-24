package com.dt.tarmag.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.AppMenu;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:37:00
 */
@Repository
public class AppMenuDao extends DaoImpl<AppMenu, Long> implements IAppMenuDao {

	@Override
	public List<AppMenu> getAllFirstLevelMenu(byte menuFuncType) {
		String sql = "SELECT * FROM DT_APP_MENU WHERE PARENT_ID = 0 AND DELETED = ? AND MENU_FUNC_TYPE=?";
		return query(sql, AppMenu.class, new Object[]{Constant.MODEL_DELETED_N, menuFuncType});
	}

	@Override
	public List<AppMenu> getSecondLevelMenuByParendId(long parentId,byte menuFuncType) {
		String sql = "SELECT * FROM DT_APP_MENU WHERE PARENT_ID = ? AND DELETED = ? AND MENU_FUNC_TYPE=?";
		return query(sql, AppMenu.class, new Object[]{parentId, Constant.MODEL_DELETED_N, menuFuncType});
	}
	
	@Override
	public List<AppMenu> getMenus(Long unitId){
		String sql = "SELECT AM.MENU_CODE,AM.MENU_ICON,AM.MENU_TYPE,AMU.MENU_NAME,AMU.LINK_URL FROM DT_APP_MENU AM, DT_APP_MENU_UNIT AMU WHERE AM.ID=AMU.MENU_ID AND AMU.UNIT_ID=? AND MENU_FUNC_TYPE='1'";
		return this.query(sql, AppMenu.class, unitId);
	}

	@Override
	public List<AppMenu> getLiveMenus() {
		String sql = "SELECT AM.MENU_CODE,AM.MENU_ICON,AM.MENU_TYPE,AMU.MENU_NAME,AM.LINK_URL FROM DT_APP_MENU AM WHERE MENU_FUNC_TYPE='2'";
		return this.query(sql, AppMenu.class);
	}
}
