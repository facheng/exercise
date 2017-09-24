package com.dt.tarmag.model;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;


/**
 * 车位
 * @author yuwei
 * @Time 2015-7-30下午01:07:33
 */
public class CarPort extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7129076565637169991L;
	private long garageId;
	private String portNo;
	private long bindResidentId;
	private byte bindType;
	private Date bindTime;
	private byte bindRentPeriod;
	
	public static final String TEMPLATE_PATH = "carPort";//模板上传的相对路径
	
	/**
	 * 空置
	 */
	public final static byte BIND_TYPE_IDLE = 0;
	/**
	 * 已售
	 */
	public final static byte BIND_TYPE_SOLD = 1;
	/**
	 * 已租
	 */
	public final static byte BIND_TYPE_RENT = 2;
	
	

	/**
	 * 一个月
	 */
	public final static byte BIND_RENT_PERIOD_1MONTH = 1;
	/**
	 * 一季度
	 */
	public final static byte BIND_RENT_PERIOD_1QUARTER = 2;
	/**
	 * 半年
	 */
	public final static byte BIND_RENT_PERIOD_HALF_YEAR = 3;
	/**
	 * 一年
	 */
	public final static byte BIND_RENT_PERIOD_1YEAR = 4;
	
	
	
	
	
	public static List<Byte> getAllBindTypeKeys() {
		List<Byte> list = new ArrayList<Byte>();
		list.add(BIND_TYPE_IDLE);
		list.add(BIND_TYPE_SOLD);
		list.add(BIND_TYPE_RENT);
		return list;
	}
	public static Map<Byte, String> getAllBindTypes() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});
		map.put(BIND_TYPE_IDLE, getBindTypeNameByCode(BIND_TYPE_IDLE));
		map.put(BIND_TYPE_SOLD, getBindTypeNameByCode(BIND_TYPE_SOLD));
		map.put(BIND_TYPE_RENT, getBindTypeNameByCode(BIND_TYPE_RENT));
		return map;
	}
	/**
	 * 车位绑定操作时，可选择的绑定类型
	 * @return
	 */
	public static Map<Byte, String> getBindTypes() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});
		map.put(BIND_TYPE_SOLD, "出售");
		map.put(BIND_TYPE_RENT, "出租");
		return map;
	}
	public static String getBindTypeNameByCode(byte code){
		if(code == BIND_TYPE_IDLE) {
			return "空置";
		}
		if(code == BIND_TYPE_SOLD) {
			return "已售";
		}
		if(code == BIND_TYPE_RENT) {
			return "已租";
		}
		
		return String.valueOf(code);
	}
	public String getBindTypeName(){
		byte s = getBindType();
		return getBindTypeNameByCode(s);
	}
	
	

	public static Map<Byte, String> getAllBindRentPeriods() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});
		map.put(BIND_RENT_PERIOD_1MONTH, getBindRentPeriodByCode(BIND_RENT_PERIOD_1MONTH));
		map.put(BIND_RENT_PERIOD_1QUARTER, getBindRentPeriodByCode(BIND_RENT_PERIOD_1QUARTER));
		map.put(BIND_RENT_PERIOD_HALF_YEAR, getBindRentPeriodByCode(BIND_RENT_PERIOD_HALF_YEAR));
		map.put(BIND_RENT_PERIOD_1YEAR, getBindRentPeriodByCode(BIND_RENT_PERIOD_1YEAR));
		return map;
	}
	public static String getBindRentPeriodByCode(byte code) {
		if(code == BIND_RENT_PERIOD_1MONTH) {
			return "一个月";
		}
		if(code == BIND_RENT_PERIOD_1QUARTER) {
			return "一季度";
		}
		if(code == BIND_RENT_PERIOD_HALF_YEAR) {
			return "半年";
		}
		if(code == BIND_RENT_PERIOD_1YEAR) {
			return "一年";
		}
		return String.valueOf(code);
	}
	
	
	
	public long getGarageId() {
		return garageId;
	}
	public void setGarageId(long garageId) {
		this.garageId = garageId;
	}
	public String getPortNo() {
		return portNo;
	}
	public void setPortNo(String portNo) {
		this.portNo = portNo;
	}
	public long getBindResidentId() {
		return bindResidentId;
	}
	public void setBindResidentId(long bindResidentId) {
		this.bindResidentId = bindResidentId;
	}
	public byte getBindType() {
		return bindType;
	}
	public void setBindType(byte bindType) {
		this.bindType = bindType;
	}
	public Date getBindTime() {
		return bindTime;
	}
	public void setBindTime(Date bindTime) {
		this.bindTime = bindTime;
	}
	public byte getBindRentPeriod() {
		return bindRentPeriod;
	}
	public void setBindRentPeriod(byte bindRentPeriod) {
		this.bindRentPeriod = bindRentPeriod;
	}
}
