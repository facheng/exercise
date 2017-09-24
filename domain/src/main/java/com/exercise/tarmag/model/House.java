package com.dt.tarmag.model;

import java.util.ArrayList;
import java.util.List;

import com.dt.framework.model.DtModel;


/**
 * 房屋
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class House extends DtModel{
	
	public static final String TEMPLATE_PATH = "house";//模板上传的相对路径
	
	/**
	 *
	 */
	private static final long serialVersionUID = -7019265357058640339L;
	private int floorNum;
	private String roomNum;
	private String code;
	private String dyCode;
	private long storyId;
	private long unitId;
	private String proNo;
	private double area;
	private double amount;
	private byte status;
	private String remark;
	private byte delegateDelivery;
	
	/**
	 * 自住
	 */
	public final static byte STATUS_SELF = 1;
	/**
	 * 空置
	 */
	public final static byte STATUS_VACANT = 2;
	/**
	 * 待售
	 */
	public final static byte STATUS_FOR_SALE = 3;
	/**
	 * 出租
	 */
	public final static byte STATUS_RENTING = 4;
	/**
	 * 待租
	 */
	public final static byte STATUS_FOR_RENT = 5;
	
	
	/**
	 * 是否可代收快递(未设置)
	 */
	public final static byte DELEGATE_DELIVERY_UNSET = 0;
	/**
	 * 是否可代收快递(可代收)
	 */
	public final static byte DELEGATE_DELIVERY_Y = 1;
	/**
	 * 是否可代收快递(不可代收)
	 */
	public final static byte DELEGATE_DELIVERY_N = 2;
	

	public static List<Byte> getAllStatusList() {
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_SELF);
		list.add(STATUS_VACANT);
		list.add(STATUS_FOR_SALE);
		list.add(STATUS_RENTING);
		list.add(STATUS_FOR_RENT);
		return list;
	}
	public static String getStatusNameByCode(byte code){
		if(code == STATUS_SELF) {
			return "自住";
		}
		if(code == STATUS_VACANT) {
			return "空置";
		}
		if(code == STATUS_FOR_SALE) {
			return "待售";
		}
		if(code == STATUS_RENTING) {
			return "出租";
		}
		if(code == STATUS_FOR_RENT) {
			return "待租";
		}
		return String.valueOf(code);
	}
	public String getStatusName(){
		byte _status =  getStatus();
		return getStatusNameByCode(_status);
	}
	
	
	public String getDelegateDeliveryName(){
		byte _dd = getDelegateDelivery();
		if(_dd == DELEGATE_DELIVERY_UNSET) {
			return "未设置";
		}
		if(_dd == DELEGATE_DELIVERY_Y) {
			return "可代收";
		}
		if(_dd == DELEGATE_DELIVERY_N) {
			return "不可代收";
		}
		return String.valueOf(_dd);
	}
	
	
	public int getFloorNum() {
		return floorNum;
	}
	public void setFloorNum(int floorNum) {
		this.floorNum = floorNum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDyCode() {
		return dyCode;
	}
	public void setDyCode(String dyCode) {
		this.dyCode = dyCode;
	}
	public long getStoryId() {
		return storyId;
	}
	public void setStoryId(long storyId) {
		this.storyId = storyId;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
	public double getArea() {
		return area;
	}
	public void setArea(double area) {
		this.area = area;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	public String getProNo() {
		return proNo;
	}
	public void setProNo(String proNo) {
		this.proNo = proNo;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(String roomNum) {
		this.roomNum = roomNum;
	}
	public byte getDelegateDelivery() {
		return delegateDelivery;
	}
	public void setDelegateDelivery(byte delegateDelivery) {
		this.delegateDelivery = delegateDelivery;
	}
}
