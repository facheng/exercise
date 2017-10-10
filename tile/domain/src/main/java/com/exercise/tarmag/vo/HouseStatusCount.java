package com.dt.tarmag.vo;

/**
 * 房屋状态的统计
 * 
 * @author fxw
 *
 */
public class HouseStatusCount {

	private String status;//状态
	private String memo;//状态（中文）
	private Integer count;//对应状态下的房屋总数
	private String precent;//百分比
	private Integer countAll;//房屋总数

	public HouseStatusCount() {
		super();
	}

	public HouseStatusCount(String status, Integer count, String precent) {
		super();
		this.status = status;
		this.count = count;
		this.precent = precent;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getPrecent() {
		return precent;
	}

	public void setPrecent(String precent) {
		this.precent = precent;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public Integer getCountAll() {
		return countAll;
	}

	public void setCountAll(Integer countAll) {
		this.countAll = countAll;
	}

}
