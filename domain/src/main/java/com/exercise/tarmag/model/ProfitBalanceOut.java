package com.dt.tarmag.model;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;


/**
 * 反润结算(团团->物业公司)
 * @author yuwei
 * @Time 2015-8-13下午05:30:24
 */
public class ProfitBalanceOut extends DtModel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5553471307812862002L;
	private long companyId;
	private long ecomId;
	private Date startTime;
	private Date endTime;
	private double consumeAmount;
	private double totalProfitAmount;
	private double profitAmount;
	private byte status;
	private Date applyTime;
	private Date settledTime;
	

	/**
	 * 状态(未结算)
	 */
	public final static byte STATUS_NOT_SETTLED = 0;
	/**
	 * 状态(申请中)
	 */
	public final static byte STATUS_APPLYING = 1;
	/**
	 * 状态(结算中(发票))
	 */
	public final static byte STATUS_SETTLING = 2;
	/**
	 * 状态(已结算)
	 */
	public final static byte STATUS_SETTLED = 3;
	
	

	public static List<Byte> getStatusKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_NOT_SETTLED);
		list.add(STATUS_APPLYING);
		list.add(STATUS_SETTLING);
		list.add(STATUS_SETTLED);
		return list;
	}
	public static Map<Byte, String> getStatuses() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(STATUS_NOT_SETTLED, getStatusNameByCode(STATUS_NOT_SETTLED));
		map.put(STATUS_APPLYING, getStatusNameByCode(STATUS_APPLYING));
		map.put(STATUS_SETTLING, getStatusNameByCode(STATUS_SETTLING));
		map.put(STATUS_SETTLED, getStatusNameByCode(STATUS_SETTLED));
		return map;
	}
	public String getStatusName(){
		byte s = getStatus();
		return getStatusNameByCode(s);
	}
	public static String getStatusNameByCode(byte code){
		if(code == STATUS_NOT_SETTLED) {
			return "未结算";
		}
		if(code == STATUS_APPLYING) {
			return "申请中";
		}
		if(code == STATUS_SETTLING) {
			return "结算中(发票)";
		}
		if(code == STATUS_SETTLED) {
			return "已结算";
		}
		return String.valueOf(code);
	}
	
	
	
	public long getCompanyId() {
		return companyId;
	}
	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	public long getEcomId() {
		return ecomId;
	}
	public void setEcomId(long ecomId) {
		this.ecomId = ecomId;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public double getConsumeAmount() {
		return consumeAmount;
	}
	public void setConsumeAmount(double consumeAmount) {
		this.consumeAmount = consumeAmount;
	}
	public double getProfitAmount() {
		return profitAmount;
	}
	public void setProfitAmount(double profitAmount) {
		this.profitAmount = profitAmount;
	}
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
	public Date getApplyTime() {
		return applyTime;
	}
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	public Date getSettledTime() {
		return settledTime;
	}
	public void setSettledTime(Date settledTime) {
		this.settledTime = settledTime;
	}
	public double getTotalProfitAmount() {
		return totalProfitAmount;
	}
	public void setTotalProfitAmount(double totalProfitAmount) {
		this.totalProfitAmount = totalProfitAmount;
	}
}
