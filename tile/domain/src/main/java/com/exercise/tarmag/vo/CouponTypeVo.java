package com.dt.tarmag.vo;

/**
 * 优惠类型
 * 
 * @author jiaosf
 * @since 2015-8-11
 */
public class CouponTypeVo {

	private Long id;
	private String name;
	private String region;
	private String sponsor;
	private String deadline;
	private String rule;
	private String queryMethod;
	private String servicePhone;

	private Byte code;
	private String remark;
	private String url;
	private Byte onShelf;
	
	private Byte ctype;
	private Double price;

	/**
	 * 是否已上架(未上架)
	 */
	public final static byte ON_SHELF_NO = 0;
	/**
	 * 是否已上架(已上架)
	 */
	public final static byte ON_SHELF_YES = 1;

	/**
	 * 优惠劵编码
	 */
	private String cpCode;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

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

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
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

	public Byte getCode() {
		return code;
	}

	public void setCode(Byte code) {
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

	public Byte getOnShelf() {
		return onShelf;
	}

	public void setOnShelf(Byte onShelf) {
		this.onShelf = onShelf;
	}

	public String getCpCode() {
		return cpCode;
	}

	public void setCpCode(String cpCode) {
		this.cpCode = cpCode;
	}
	
	
	public Byte getCtype() {
		return ctype;
	}

	
	public void setCtype(Byte ctype) {
		this.ctype = ctype;
	}

	
	public Double getPrice() {
		return price;
	}

	
	public void setPrice(Double price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "CouponTypeVo [id=" + id + ", name=" + name + ", region=" + region + ", sponsor=" + sponsor
				+ ", deadline=" + deadline + ", rule=" + rule + ", queryMethod=" + queryMethod + ", servicePhone="
				+ servicePhone + ", code=" + code + ", remark=" + remark + ", url=" + url + ", onShelf=" + onShelf
				+ ", ctype=" + ctype + ", price=" + price + ", cpCode=" + cpCode + "]";
	}

	
}
