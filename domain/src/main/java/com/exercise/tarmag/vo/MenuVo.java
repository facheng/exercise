package com.dt.tarmag.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author yuwei
 * @Time 2015-7-8下午08:17:47
 */
public class MenuVo {
	private long id;
	private long menuId;
	private String menuName;
	private String linkURL;
	private String menuIcon;
	private String menuCode;
	private long parentId;
	private byte checked;
	private byte menuType;
	private byte isDefault;
	private List<MenuVo> childMenuList;

	public void addChild(MenuVo child) {
		if (childMenuList == null) {
			childMenuList = new ArrayList<MenuVo>();
		}

		childMenuList.add(child);
	}

	public long getMenuId() {
		return menuId;
	}

	public void setMenuId(long menuId) {
		this.menuId = menuId;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getLinkURL() {
		return linkURL;
	}

	public void setLinkURL(String linkURL) {
		this.linkURL = linkURL;
	}

	public byte getChecked() {
		return checked;
	}

	public void setChecked(byte checked) {
		this.checked = checked;
	}

	public List<MenuVo> getChildMenuList() {
		return childMenuList;
	}

	public void setChildMenuList(List<MenuVo> childMenuList) {
		this.childMenuList = childMenuList;
	}

	public byte getMenuType() {
		return menuType;
	}

	public void setMenuType(byte menuType) {
		this.menuType = menuType;
	}

	public String getMenuIcon() {
		return menuIcon;
	}

	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}

	public long getParentId() {
		return parentId;
	}

	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public byte getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(byte isDefault) {
		this.isDefault = isDefault;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
}
