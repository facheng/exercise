package com.dt.tarmag.model;

import java.util.Date;

import com.dt.framework.model.DtModel;


/**
 * 优惠券类型
 * @author yuwei
 * @Time 2015-8-10下午02:15:21
 */
public class CouponType extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5917468712194874861L;
	private String name;
	private String region;
	private String sponsor;
	private Date deadline;
	private String rule;
	private String queryMethod;
	private String servicePhone;
	private byte code;
	private String remark;
	private String url;
	private byte onShelf;
	private byte ctype;
	private double price;
	
	

	/**
	 * 类型编码(优惠码)
	 */
	public final static byte CODE_DISCOUNT_CODE = 1;
	/**
	 * 类型编码(电商广告)
	 */
	public final static byte CODE_ADV = 2;
	

	/**
	 * 是否已上架(未上架)
	 */
	public final static byte ON_SHELF_NO = 0;
	/**
	 * 是否已上架(已上架)
	 */
	public final static byte ON_SHELF_YES = 1;
	
	
	/**
	 * 类型(家政宝)
	 */
	public final static byte CTYPE_HOUSE_KEEP = 1;
	/**
	 * 类型(生活宝)
	 */
	public final static byte CTYPE_LIFE = 2;
	/**
	 * 类型(商旅宝)
	 */
	public final static byte CTYPE_BIZ_TRAVEL = 3;
	/**
	 * 类型(爱车宝)
	 */
	public final static byte CTYPE_CAR = 4;
	/**
	 * 类型(生活缴费)
	 */
	public final static byte CTYPE_LIFE_PAYMENT = 5;
	/**
	 * 类型(生活秘籍)
	 */
	public final static byte CTYPE_LIFE_CHEATS = 6;
	
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getSponsor() {
		return sponsor;
	}
	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}
	public Date getDeadline() {
		return deadline;
	}
	public void setDeadline(Date deadline) {
		this.deadline = deadline;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public String getQueryMethod() {
		return queryMethod;
	}
	public void setQueryMethod(String queryMethod) {
		this.queryMethod = queryMethod;
	}
	public String getServicePhone() {
		return servicePhone;
	}
	public void setServicePhone(String servicePhone) {
		this.servicePhone = servicePhone;
	}
	public byte getCode() {
		return code;
	}
	public void setCode(byte code) {
		this.code = code;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public byte getOnShelf() {
		return onShelf;
	}
	public void setOnShelf(byte onShelf) {
		this.onShelf = onShelf;
	}
	public byte getCtype() {
		return ctype;
	}
	public void setCtype(byte ctype) {
		this.ctype = ctype;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
}
