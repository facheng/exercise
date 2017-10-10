package com.dt.tarmag.model;




/**
 * 手机app菜单权限(分配至小区)
 * @author yuwei
 * @Time 2015-7-6下午07:34:20
 */
public class AppMenuUnit implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4445650747311984041L;
	private long id;
	private long unitId;
	private long menuId;
	private String menuName;
	private String linkURL;
	private byte isDefault;


	/**
	 * 是否是默认菜单(否)
	 */
	public final static byte IS_DEFAULT_N = 0;
	/**
	 * 是否是默认菜单(是)
	 */
	public final static byte IS_DEFAULT_Y = 1;
	
	
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
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
	public byte getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(byte isDefault) {
		this.isDefault = isDefault;
	}
}
