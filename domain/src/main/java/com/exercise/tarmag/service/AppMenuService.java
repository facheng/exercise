package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IAppMenuDao;
import com.dt.tarmag.dao.IAppMenuResidentDao;
import com.dt.tarmag.dao.IAppMenuUnitDao;
import com.dt.tarmag.model.AppMenu;
import com.dt.tarmag.model.AppMenuResident;
import com.dt.tarmag.model.AppMenuUnit;
import com.dt.tarmag.vo.MenuVo;

/**
 * @author yuwei
 * @Time 2015-7-8上午10:22:37
 */
@Service
public class AppMenuService implements IAppMenuService {

	@Autowired
	private IAppMenuDao appMenuDao;
	@Autowired
	private IAppMenuUnitDao appMenuUnitDao;
	@Autowired
	private IAppMenuResidentDao appMenuResidentDao;

	@Override
	public List<MenuVo> getAppMenuList() {
		List<MenuVo> voList = new ArrayList<MenuVo>();
		List<AppMenu> fMenuList = appMenuDao
				.getAllFirstLevelMenu(AppMenu.MENU_FUNC_TYPE_CONVENIENT);
		if (fMenuList == null || fMenuList.size() <= 0) {
			return voList;
		}

		for (AppMenu fMenu : fMenuList) {
			MenuVo fMenuVo = new MenuVo();
			fMenuVo.setMenuId(fMenu.getId());
			fMenuVo.setMenuName(fMenu.getMenuName());
			fMenuVo.setLinkURL(fMenu.getLinkURL());
			fMenuVo.setMenuIcon(fMenu.getMenuIcon());
			fMenuVo.setParentId(fMenu.getParentId());
			fMenuVo.setChecked((byte) 1);
			fMenuVo.setMenuType(fMenu.getMenuType());
			fMenuVo.setMenuCode(fMenu.getMenuCode());
			fMenuVo.setIsDefault(fMenu.getIsDefault());

			List<AppMenu> sMenuList = appMenuDao.getSecondLevelMenuByParendId(
					fMenu.getId(), AppMenu.MENU_FUNC_TYPE_CONVENIENT);
			for (AppMenu sMenu : sMenuList) {
				MenuVo sMenuVo = new MenuVo();
				sMenuVo.setMenuId(sMenu.getId());
				sMenuVo.setMenuName(sMenu.getMenuName());
				sMenuVo.setLinkURL(sMenu.getLinkURL());
				sMenuVo.setMenuIcon(sMenu.getMenuIcon());
				sMenuVo.setParentId(sMenu.getParentId());
				sMenuVo.setChecked((byte) 1);
				sMenuVo.setMenuType(sMenu.getMenuType());
				sMenuVo.setMenuCode(sMenu.getMenuCode());
				sMenuVo.setIsDefault(sMenu.getIsDefault());
				fMenuVo.addChild(sMenuVo);
			}
			voList.add(fMenuVo);
		}
		return voList;
	}

	@Override
	public List<MenuVo> getAppMenuListByUnitId(long unitId) {
		List<MenuVo> voList = new ArrayList<MenuVo>();
		List<AppMenu> fMenuList = appMenuDao
				.getAllFirstLevelMenu(AppMenu.MENU_FUNC_TYPE_CONVENIENT);

		if (fMenuList == null || fMenuList.size() <= 0) {
			return voList;
		}

		for (AppMenu fMenu : fMenuList) {
			AppMenuUnit fMenuUnit = appMenuUnitDao.getAppMenuUnit(unitId,
					fMenu.getId());

			String fMenuName = "";
			if (fMenuUnit != null && fMenuUnit.getMenuName() != null) {
				fMenuName = fMenuUnit.getMenuName();
			} else {
				fMenuName = fMenu.getMenuName();
			}

			String fLinkURL = "";
			if (fMenuUnit != null && fMenuUnit.getLinkURL() != null) {
				fLinkURL = fMenuUnit.getLinkURL();
			} else {
				fLinkURL = fMenu.getLinkURL() == null ? "" : fMenu.getLinkURL();
			}

			MenuVo fMenuVo = new MenuVo();
			fMenuVo.setMenuId(fMenu.getId());
			fMenuVo.setMenuName(fMenuName);
			fMenuVo.setLinkURL(fLinkURL);
			fMenuVo.setMenuIcon(fMenu.getMenuIcon());
			fMenuVo.setParentId(fMenu.getParentId());
			fMenuVo.setChecked(fMenuUnit != null ? (byte) 1 : 0);
			fMenuVo.setMenuType(fMenu.getMenuType());
			fMenuVo.setMenuCode(fMenu.getMenuCode());
			fMenuVo.setIsDefault(fMenuUnit != null ? fMenuUnit.getIsDefault()
					: fMenu.getIsDefault());

			List<AppMenu> sMenuList = appMenuDao.getSecondLevelMenuByParendId(
					fMenu.getId(), AppMenu.MENU_FUNC_TYPE_CONVENIENT);
			for (AppMenu sMenu : sMenuList) {
				AppMenuUnit sMenuUnit = appMenuUnitDao.getAppMenuUnit(unitId,
						sMenu.getId());

				String sMenuName = "";
				if (sMenuUnit != null && sMenuUnit.getMenuName() != null) {
					sMenuName = sMenuUnit.getMenuName();
				} else {
					sMenuName = sMenu.getMenuName();
				}

				String sLinkURL = "";
				if (sMenuUnit != null && sMenuUnit.getLinkURL() != null) {
					sLinkURL = sMenuUnit.getLinkURL();
				} else {
					sLinkURL = sMenu.getLinkURL() == null ? "" : sMenu
							.getLinkURL();
				}

				MenuVo sMenuVo = new MenuVo();
				sMenuVo.setMenuId(sMenu.getId());
				sMenuVo.setMenuName(sMenuName);
				sMenuVo.setLinkURL(sLinkURL);
				sMenuVo.setMenuIcon(sMenu.getMenuIcon());
				sMenuVo.setParentId(sMenu.getParentId());
				sMenuVo.setChecked(sMenuUnit != null ? (byte) 1 : 0);
				sMenuVo.setMenuType(sMenu.getMenuType());
				sMenuVo.setMenuCode(sMenu.getMenuCode());
				sMenuVo.setIsDefault(sMenuUnit != null ? sMenuUnit
						.getIsDefault() : sMenu.getIsDefault());
				fMenuVo.addChild(sMenuVo);
			}
			voList.add(fMenuVo);
		}
		return voList;
	}

	@Override
	public void updateAppMenu_tx(long unitId, long menuId, String menuName,
			String linkURL) {
		AppMenuUnit sMenuUnit = appMenuUnitDao.getAppMenuUnit(unitId, menuId);
		AppMenu appMenu = appMenuDao.get(menuId);

		if (sMenuUnit == null || appMenu == null || menuName == null
				|| menuName.trim().equals("")
				|| appMenu.getMenuType() == AppMenu.MENU_TYPE_H5
				&& (linkURL == null || linkURL.trim().equals(""))) {
			return;
		}

		sMenuUnit.setMenuName(menuName.trim());
		if (appMenu.getMenuType() == AppMenu.MENU_TYPE_H5) {
			sMenuUnit.setLinkURL(linkURL.trim());
		}
		appMenuDao.update(appMenu);
	}

	@Override
	public void resetAppMenus_tx(long unitId, List<Long> menuIdList) {
		if (unitId <= 0 || menuIdList == null || menuIdList.size() <= 0) {
			return;
		}

		appMenuUnitDao.deleteByUnitId(unitId);
		for (long menuId : menuIdList) {
			AppMenu appMenu = appMenuDao.get(menuId);
			if (appMenu == null) {
				continue;
			}

			AppMenuUnit appMenuUnit = appMenuUnitDao.getAppMenuUnit(unitId,
					menuId);
			if (appMenuUnit == null) {
				appMenuUnit = new AppMenuUnit();
				appMenuUnit.setUnitId(unitId);
				appMenuUnit.setMenuId(menuId);
				appMenuUnitDao.save(appMenuUnit);
			}

			if (appMenu.getParentId() > 0) {
				AppMenuUnit parentAppMenuUnit = appMenuUnitDao.getAppMenuUnit(
						unitId, appMenu.getParentId());
				if (parentAppMenuUnit == null) {
					parentAppMenuUnit = new AppMenuUnit();
					parentAppMenuUnit.setUnitId(unitId);
					parentAppMenuUnit.setMenuId(appMenu.getParentId());
					appMenuUnitDao.save(parentAppMenuUnit);
				}
			}
		}
	}

	@Override
	public void deleteResidentMenu_tx(long residentId, long appMenuId) {
		AppMenuResident residentMenuByresidentIdAndAppMenuId = this.appMenuResidentDao
				.getResidentMenuByresidentIdAndAppMenuId(residentId, appMenuId);
		if (residentMenuByresidentIdAndAppMenuId != null) {
			this.appMenuResidentDao
					.deleteLogic(residentMenuByresidentIdAndAppMenuId.getId());
		}
	}

	@Override
	public void addResidentMenu_tx(long residentId, long appMenuId) {
		AppMenuResident residentMenuByresidentIdAndAppMenuId = this.appMenuResidentDao
				.getResidentMenuByresidentIdAndAppMenuId(residentId, appMenuId);
		if (residentMenuByresidentIdAndAppMenuId == null) {
			AppMenuResident entity = new AppMenuResident();
			entity.setResidentId(residentId);
			entity.setAppMenuId(appMenuId);
			this.appMenuResidentDao.save(entity);
		}

	}

	@Override
	public List<Map<String, Object>> getResidentAppMenuList(long residentId,
			Long unitId) {
		return this.appMenuResidentDao.getResidentAppMenuList(residentId,
				unitId);
	}
	@Override
	public List<Map<String, Object>> getLiveAppMenu() {
		List<Map<String, Object>> maps = new ArrayList<Map<String,Object>>();
		List<AppMenu> appMenus = this.appMenuDao.getAllFirstLevelMenu(AppMenu.MENU_FUNC_TYPE_PAY);
		for(AppMenu appMenu : appMenus){
			List<AppMenu> secondMenus = this.appMenuDao.getSecondLevelMenuByParendId(appMenu.getId(), AppMenu.MENU_FUNC_TYPE_PAY);
			for(AppMenu secondMenu : secondMenus){
				maps.add(secondMenu.toMap(new String[]{"menuName", "menuCode", "menuIcon", "menuType", "linkURL"}));
			}
		}
		return maps;
	}
	
	@Override
	public List<Map<String, Object>> getLiveCheats(){
		List<Map<String, Object>> maps = new ArrayList<Map<String,Object>>();
		List<AppMenu> appMenus = this.appMenuDao.getAllFirstLevelMenu(AppMenu.MENU_FUNC_TYPE_LIVE_CHEATS);
		for(AppMenu appMenu : appMenus){
			maps.add(appMenu.toMap(new String[]{"menuName", "menuCode", "menuType", "linkURL"}));
		}
		return maps;
	}
}
