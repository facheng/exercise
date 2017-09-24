package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 住户
 * @author yuwei
 * @Time 2015-6-25上午10:57:16
 */
public class Resident extends DtModel{
	
	public static final String IMG_PATH = "head";//图片上传的相对路径
	public static final String TEMPLATE_PATH = "resident";//模板上传的相对路径
	
	private static final long serialVersionUID = 939206815335860794L;
	private String phoneNum;
	private String userName;
	private String nickName;
	private String idCard;
	private String headImg;
	private byte sex;
	private Date birthday;
	private String tokenId;
	private Date lastLoginTime;
	
	/**
	 * 性别 （未知）
	 */
	public final static byte SEX_UNKNOW = 0;
	/**
	 * 性别 男
	 */
	public final static byte SEX_MALE = 1;
	/**
	 * 性别 女
	 */
	public final static byte SEX_FEMALE = 2;
	
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getHeadImg() {
		return headImg;
	}
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	public byte getSex() {
		return sex;
	}
	public void setSex(byte sex) {
		this.sex = sex;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public String getTokenId() {
		return tokenId;
	}
	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}
	public Date getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(Date lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getIdCard() {
		return idCard;
	}
	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}
	
	

	
	public int hashCode(){
		return new Long(getId()).hashCode();
	}
	
	public boolean equals(Object obj) {
		if(!(obj instanceof Resident)) return false;
		
		Resident r = (Resident) obj;
		return this.getId() == r.getId();
	}
}
