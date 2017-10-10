package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.vo.MenuVo;


/**
 * @author yuwei
 * @Time 2015-7-8上午10:21:56
 */
public interface IAppMenuService {
	/**
	 * 查询所有菜单，以及指定小区能显示的APP菜单
	 * @param unitId
	 * @return
	 */
	List<MenuVo> getAppMenuListByUnitId(long unitId);
	
	/**
	 * 查询所有菜单
	 * @return
	 */
	List<MenuVo> getAppMenuList();
	
	/**
	 * 更新菜单(名称和url)
	 * @param unitId
	 * @param menuId
	 * @param menuName
	 * @param linkURL
	 */
	void updateAppMenu_tx(long unitId, long menuId, String menuName, String linkURL);
	
	/**
	 * 重设app菜单
	 * @param unitId
	 * @param menuIdList
	 */
	void resetAppMenus_tx(long unitId, List<Long> menuIdList);
	/**
	 * 删除个人菜单
	 * @param residentId
	 * @param appMenuId
	 */
	void deleteResidentMenu_tx(long residentId,long appMenuId);
	/**
	 * 增加个人菜单
	 * @param residentId
	 * @param appMenuId
	 */
	void addResidentMenu_tx(long residentId,long appMenuId);

	/**
	 * 查询个人所有菜单
	 * @return
	 */
	List<Map<String, Object>> getResidentAppMenuList(long residentId,Long unitId);
	
	/**
	 * 获取生活缴费的app菜单
	 * @return
	 */
	List<Map<String, Object>> getLiveAppMenu();

	/**
	 * 获取生活秘籍
	 * @return
	 */
	List<Map<String, Object>> getLiveCheats();
}