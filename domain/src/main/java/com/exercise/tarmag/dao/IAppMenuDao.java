package com.dt.tarmag.dao;


import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppMenu;


/**
 * @author yuwei
 * @Time 2015-7-6下午07:36:36
 */
public interface IAppMenuDao extends Dao<AppMenu, Long> {
	List<AppMenu> getAllFirstLevelMenu(byte menuFuncType);
	List<AppMenu> getSecondLevelMenuByParendId(long parendId,byte menuFuncType);
	/**获取小区的菜单 便民服务
	 * @param unitId
	 * @return
	 */
	List<AppMenu> getMenus(Long unitId);
	
	/**
	 * 获取生活缴费菜单
	 * @return
	 */
	List<AppMenu> getLiveMenus();
}
