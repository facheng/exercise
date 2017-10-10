package com.dt.tarmag.vo;

import java.util.ArrayList;
import java.util.List;



/**
 * @author WEI
 * @time 2015-7-11 下午04:13:34
 */
public class DeliveryVo {
	private long unitId;
	private String title;
	private String content;
	private String houseIds;
	
	
	
	public List<Long> getHouseIdList(){
		List<Long> list = new ArrayList<Long>();
		if(houseIds == null || houseIds.trim().equals("")) {
			return list;
		}
		
		String[] arr = houseIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return list;
		}
		
		for(String hId : arr) {
			try{
				list.add(Long.parseLong(hId.trim()));
			} catch (NumberFormatException e) {
			}
		}
		return list;
	}
	
	
	
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getHouseIds() {
		return houseIds;
	}
	public void setHouseIds(String houseIds) {
		this.houseIds = houseIds;
	}
}
