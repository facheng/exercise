package com.dt.tarmag.vo;

import java.util.ArrayList;
import java.util.List;



/**
 * @author yuwei
 * @Time 2015-7-10上午11:37:45
 */
public class NoticeVo {
	private byte fromType;
	private byte toType;
	private String houseIds;
	private String title;
	private String content;
	private long unitId;
	
	
	
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
	
	
	
	public byte getFromType() {
		return fromType;
	}
	public void setFromType(byte fromType) {
		this.fromType = fromType;
	}
	public byte getToType() {
		return toType;
	}
	public void setToType(byte toType) {
		this.toType = toType;
	}
	public String getHouseIds() {
		return houseIds;
	}
	public void setHouseIds(String houseIds) {
		this.houseIds = houseIds;
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
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
}
