package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 楼栋 
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Story extends DtModel{
	
	public static final String TEMPLATE_PATH = "story";//模板上传的相对路径
	
	private static final long serialVersionUID = 3674562298003196459L;
	private String storyNum;
	/**
	 * 楼层数
	 */
	private int floorCount;
	/**
	 * 纬度
	 */
	private double lantitude;
	/**
	 * 经度
	 */
	private double longitude;
	private long partitionId;
	private long unitId;
	private String remark;
	private byte hasLift;
	
	

	/**
	 * 是否有电梯(无)
	 */
	public final static byte HAS_LIFT_NO = 0;
	/**
	 * 是否有电梯(有)
	 */
	public final static byte HAS_LIFT_YES = 1;
	
	public static String getHasLiftByCode(byte code){
		if(code == HAS_LIFT_NO) {
			return "无";
		}
		if(code == HAS_LIFT_YES) {
			return "有";
		}
		return String.valueOf(code);
	}
	
	public String getStoryNum() {
		return storyNum;
	}
	public void setStoryNum(String storyNum) {
		this.storyNum = storyNum;
	}
	public double getLantitude() {
		return lantitude;
	}
	public void setLantitude(double lantitude) {
		this.lantitude = lantitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public long getPartitionId() {
		return partitionId;
	}
	public void setPartitionId(long partitionId) {
		this.partitionId = partitionId;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public int getFloorCount() {
		return floorCount;
	}
	public void setFloorCount(int floorCount) {
		this.floorCount = floorCount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public byte getHasLift() {
		return hasLift;
	}
	public void setHasLift(byte hasLift) {
		this.hasLift = hasLift;
	}
}
