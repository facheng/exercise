package com.dt.tarmag.dto;

import java.io.Serializable;
import java.util.List;

/**
 * @author yuwei
 * @Time 2015-6-29下午04:54:52
 */
public class MenuDto implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5275782835155675361L;
	private String title;
	private String code;
	private String url;
	private List<MenuDto> childMenuList;
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public List<MenuDto> getChildMenuList() {
		return childMenuList;
	}
	public void setChildMenuList(List<MenuDto> childMenuList) {
		this.childMenuList = childMenuList;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
}
