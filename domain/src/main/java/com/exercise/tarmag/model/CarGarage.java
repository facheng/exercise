package com.dt.tarmag.model;

import com.dt.framework.model.DtModel;


/**
 * 车库
 * @author yuwei
 * @Time 2015-7-30下午01:03:31
 */
public class CarGarage extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4598480951552569891L;
	private String garageNo;
	private long partitionId;
	
	public static final String TEMPLATE_PATH = "carGarage";//模板上传的相对路径
	/**
	 * 纬度
	 */
	private double lantitude;
	/**
	 * 经度
	 */
	private double longitude;
	
	
	public String getGarageNo() {
		return garageNo;
	}
	public void setGarageNo(String garageNo) {
		this.garageNo = garageNo;
	}
	public long getPartitionId() {
		return partitionId;
	}
	public void setPartitionId(long partitionId) {
		this.partitionId = partitionId;
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
}
