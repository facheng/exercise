package com.dt.tarmag.model;


import com.dt.framework.model.DtModel;


/**
 * 手机APP菜单
 * @author yuwei
 * @Time 2015-7-6下午07:29:38
 */
public class AppMenu extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8218690207631422794L;
	private long parentId;
	private String menuName;
	private String menuCode;
	private String menuIcon;
	private byte menuType;
	private String linkURL;
	private int seq;
	private byte isDefault;
	private byte menuFuncType;
	

	public final static int MENU_TYPE_H5 = 1;
	public final static int MENU_TYPE_NATIVE = 2;

	/**
	 * 是否是默认菜单(否)
	 */
	public final static byte IS_DEFAULT_N = 0;
	/**
	 * 是否是默认菜单(是)
	 */
	public final static byte IS_DEFAULT_Y = 1;
	
	
	/**
	 * 便民服务
	 */
	public final static byte MENU_FUNC_TYPE_CONVENIENT = 1;
	/**
	 * 生活缴费
	 */
	public final static byte MENU_FUNC_TYPE_PAY = 2;
	/**
	 * 生活秘籍
	 */
	public final static byte MENU_FUNC_TYPE_LIVE_CHEATS = 3;
	
	
	public long getParentId() {
		return parentId;
	}
	public void setParentId(long parentId) {
		this.parentId = parentId;
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
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getMenuCode() {
		return menuCode;
	}
	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}
	public String getMenuIcon() {
		return menuIcon;
	}
	public void setMenuIcon(String menuIcon) {
		this.menuIcon = menuIcon;
	}
	public byte getMenuType() {
		return menuType;
	}
	public void setMenuType(byte menuType) {
		this.menuType = menuType;
	}
	public byte getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(byte isDefault) {
		this.isDefault = isDefault;
	}
	public byte getMenuFuncType() {
		return menuFuncType;
	}
	public void setMenuFuncType(byte menuFuncType) {
		this.menuFuncType = menuFuncType;
	}
}
