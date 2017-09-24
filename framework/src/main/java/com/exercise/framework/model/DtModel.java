package com.dt.framework.model;

import java.util.Date;

/**
 * 底层model
 * @author jason
 *
 */
public class DtModel extends DtSimpleModel{

	private static final long serialVersionUID = 174892095712108992L;
	/**
	 * 创建人
	 */
	private long createUserId;
	/**
	 * 创建时间
	 */
	private Date createDateTime;
	/**
	 * 更新人
	 */
	private long updateUserId;
	/**
	 * 更新时间
	 */
	private Date updateDateTime;
	public long getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(long createUserId) {
		this.createUserId = createUserId;
	}
	public Date getCreateDateTime() {
		return createDateTime;
	}
	public void setCreateDateTime(Date createDateTime) {
		this.createDateTime = createDateTime;
	}
	public long getUpdateUserId() {
		return updateUserId;
	}
	public void setUpdateUserId(long updateUserId) {
		this.updateUserId = updateUserId;
	}
	public Date getUpdateDateTime() {
		return updateDateTime;
	}
	public void setUpdateDateTime(Date updateDateTime) {
		this.updateDateTime = updateDateTime;
	}
}
