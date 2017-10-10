package com.dt.tarmag.model;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;
import com.dt.framework.util.DateUtil;

public class RepairStatus extends DtModel{

	private static final long serialVersionUID = 9190676910305307517L;

	private byte status;
	
	
	
	public String getCreateDateTimeStr() {
		Date dt = getCreateDateTime();
		return DateUtil.formatDate(dt, DateUtil.PATTERN_DATE_TIME2);
	}
	

	
	
	/**
	 * 报修状态(待分派)
	 */
	public final static byte STATUS_NOT_ASSIGNED  = 0;
	/**
	 * 报修状态(已分派待接受)
	 */
	public final static byte STATUS_ASSIGNED  = 1;
	/**
	 * 报修状态(已拒绝)
	 */
	public final static byte STATUS_REJECT  = 2;
	/**
	 * 报修状态(已接受)
	 */
	public final static byte STATUS_RECEIVED  = 3;
	/**
	 * 报修状态(已签到)
	 */
	public final static byte STATUS_SIGNED_IN  = 4;
	/**
	 * 报修状态(可修)
	 */
	public final static byte STATUS_REPAIRABLE  = 5;
	/**
	 * 报修状态(不可修)
	 */
	public final static byte STATUS_NOT_REPAIRABLE  = 6;
	/**
	 * 报修状态(已完成)
	 */
	public final static byte STATUS_COMPLETED  = 7;
	/**
	 * 报修状态(已结束)
	 */
	public final static byte STATUS_END  = 8;
	
	
	/**
	 * 参与报修统计的状态
	 * @return
	 */
	public static List<Byte> getAllStatusStatistcKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_RECEIVED);
		list.add(STATUS_COMPLETED);
		list.add(STATUS_END);
		return list;
	}
	/**
	 * 参与报修统计的状态
	 * @return
	 */
	public static Map<Byte, String> getAllStatusStatistcs() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});
		map.put(STATUS_RECEIVED, getStatusNameByCode(STATUS_RECEIVED));
		map.put(STATUS_COMPLETED, getStatusNameByCode(STATUS_COMPLETED));
		map.put(STATUS_END, getStatusNameByCode(STATUS_END));
		return map;
	}
	
	
	public static List<Byte> getAllStatusKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_NOT_ASSIGNED);
		list.add(STATUS_ASSIGNED);
		list.add(STATUS_REJECT);
		list.add(STATUS_RECEIVED);
		list.add(STATUS_SIGNED_IN);
		list.add(STATUS_REPAIRABLE);
		list.add(STATUS_NOT_REPAIRABLE);
		list.add(STATUS_COMPLETED);
		list.add(STATUS_END);
		return list;
	}
	public static Map<Byte, String> getAllStatuses() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(STATUS_NOT_ASSIGNED, "待分派");
		map.put(STATUS_ASSIGNED, "已分派待接受");
		map.put(STATUS_REJECT, "已拒绝");
		map.put(STATUS_RECEIVED, "已接受");
		map.put(STATUS_SIGNED_IN, "已签到");
		map.put(STATUS_REPAIRABLE, "可修");
		map.put(STATUS_NOT_REPAIRABLE, "不可修");
		map.put(STATUS_COMPLETED, "已完成");
		map.put(STATUS_END, "已结束");
		return map;
	}
	public static List<Byte> getUnAssignedStatusKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_NOT_ASSIGNED);
		list.add(STATUS_ASSIGNED);
		list.add(STATUS_REJECT);
		return list;
	}
	public static Map<Byte, String> getUnAssignedStatuses() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(STATUS_NOT_ASSIGNED, "待分派");
		map.put(STATUS_ASSIGNED, "已分派待接受");
		map.put(STATUS_REJECT, "已拒绝");
		return map;
	}
	public static List<Byte> getAssignedStatusKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(STATUS_RECEIVED);
		list.add(STATUS_SIGNED_IN);
		list.add(STATUS_REPAIRABLE);
		list.add(STATUS_NOT_REPAIRABLE);
		list.add(STATUS_COMPLETED);
		list.add(STATUS_END);
		return list;
	}
	public static Map<Byte, String> getAssignedStatuses() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(STATUS_RECEIVED, "已接受");
		map.put(STATUS_SIGNED_IN, "已签到");
		map.put(STATUS_REPAIRABLE, "可修");
		map.put(STATUS_NOT_REPAIRABLE, "不可修");
		map.put(STATUS_COMPLETED, "已完成");
		map.put(STATUS_END, "已结束");
		return map;
	}
	public String getStatusName(){
		byte s = getStatus();
		return getStatusNameByCode(s);
	}
	public static String getStatusNameByCode(byte code){
		if(code == STATUS_NOT_ASSIGNED) {
			return "待分派";
		}
		if(code == STATUS_ASSIGNED) {
			return "已分派待接受";
		}
		if(code == STATUS_REJECT) {
			return "已拒绝";
		}
		if(code == STATUS_RECEIVED) {
			return "已接受";
		}
		if(code == STATUS_SIGNED_IN) {
			return "已签到";
		}
		if(code == STATUS_REPAIRABLE) {
			return "可修";
		}
		if(code == STATUS_NOT_REPAIRABLE) {
			return "不可修";
		}
		if(code == STATUS_COMPLETED) {
			return "已完成";
		}
		if(code == STATUS_END) {
			return "已结束";
		}
		return String.valueOf(code);
	}
	
	public byte getStatus() {
		return status;
	}
	public void setStatus(byte status) {
		this.status = status;
	}
}
