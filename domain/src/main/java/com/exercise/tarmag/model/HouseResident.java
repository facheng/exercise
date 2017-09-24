package com.dt.tarmag.model;

import com.dt.framework.model.DtSimpleModel;



/**
 * 房屋住户关系
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class HouseResident extends DtSimpleModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8361720483187357020L;
	private long houseId;
	private long residentId;
	private byte type;
	private byte isDefault;
	private byte isApproved;
	

	/**
	 * 业主
	 */
	public final static byte TYPE_OWNER = 0;
	/**
	 * 家属
	 */
	public final static byte TYPE_FAMILY_MEMBER = 1;
	/**
	 * 租客
	 */
	public final static byte TYPE_RENTER = 2;
	/**
	 * 访客
	 */
	public final static byte TYPE_VISITOR = 3;
	

	/**
	 * 不是默认房屋
	 */
	public final static byte IS_DEFAULT_N = 0;
	/**
	 * 是默认房屋
	 */
	public final static byte IS_DEFAULT_Y = 1;
	

	/**
	 * 绑定核准状态(未核准)
	 */
	public final static byte IS_APPROVED_NO = 0;
	/**
	 * 绑定核准状态(已核准)
	 */
	public final static byte IS_APPROVED_YES = 1;
	/**
	 * 绑定核准状态(已驳回)
	 */
	public final static byte IS_APPROVED_REJECT = 2;
	

	
	public String getTypeName(){
		byte _type =  getType();
		if(_type == TYPE_OWNER) {
			return "业主";
		}
		if(_type == TYPE_FAMILY_MEMBER) {
			return "家属";
		}
		if(_type == TYPE_RENTER) {
			return "租客";
		}
		if(_type == TYPE_VISITOR) {
			return "访客";
		}
		return String.valueOf(_type);
	}
	
	public String getIsApprovedName(){
		byte _isApproved = getIsApproved();
		if(_isApproved == IS_APPROVED_NO) {
			return "未核准";
		}
		if(_isApproved == IS_APPROVED_YES) {
			return "已核准";
		}
		if(_isApproved == IS_APPROVED_REJECT) {
			return "已驳回";
		}
		return String.valueOf(_isApproved);
	}
	
	
	public long getHouseId() {
		return houseId;
	}
	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public byte getType() {
		return type;
	}
	public void setType(byte type) {
		this.type = type;
	}
	public byte getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(byte isDefault) {
		this.isDefault = isDefault;
	}
	public byte getIsApproved() {
		return isApproved;
	}
	public void setIsApproved(byte isApproved) {
		this.isApproved = isApproved;
	}
}
