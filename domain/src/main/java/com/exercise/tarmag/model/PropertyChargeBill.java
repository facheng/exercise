package com.dt.tarmag.model;



import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;


/**
 * 物业缴费单
 * @author yuwei
 * @Time 2015-8-21上午09:41:47
 */
public class PropertyChargeBill extends DtModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6013662648712686526L;
	private long houseId;
	private Date startDate;
	private Date endDate;
	private double amount;
	private int remindTimes;
	private byte status;
	

	
	/**
	 * 状态(未缴费)
	 */
	public final static byte STATUS_UNCHARGED = 0;
	/**
	 * 状态(已缴费)
	 */
	public final static byte STATUS_CHARGED = 1;
	/**
	 * 状态(已缴费且已开发票)
	 */
	public final static byte STATUS_CHARGED_AND_INVOICE = 2;
	
	
	public static List<Byte> getStatusKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_UNCHARGED);
		list.add(STATUS_CHARGED);
		list.add(STATUS_CHARGED_AND_INVOICE);
		return list;
	}
	public static Map<Byte, String> getStatuses() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(STATUS_UNCHARGED, getStatusNameByCode(STATUS_UNCHARGED));
		map.put(STATUS_CHARGED, getStatusNameByCode(STATUS_CHARGED));
		map.put(STATUS_CHARGED_AND_INVOICE, getStatusNameByCode(STATUS_CHARGED_AND_INVOICE));
		return map;
	}
	public String getStatusName(){
		byte c = getStatus();
		return getStatusNameByCode(c);
	}
	public static String getStatusNameByCode(byte code){
		if(code == STATUS_UNCHARGED) {
			return "未缴费";
		}
		if(code == STATUS_CHARGED) {
			return "已缴费";
		}
		if(code == STATUS_CHARGED_AND_INVOICE) {
			return "已缴费且已开发票";
		}
		return String.valueOf(code);
	}
	
	
	
	public long getHouseId() {
		return houseId;
	}
	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public int getRemindTimes() {
		return remindTimes;
	}
	public void setRemindTimes(int remindTimes) {
		this.remindTimes = remindTimes;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}
