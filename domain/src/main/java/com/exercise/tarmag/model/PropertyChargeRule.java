package com.dt.tarmag.model;


import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;


/**
 * 物业费收费规则
 * @author yuwei
 * @Time 2015-8-20下午05:31:48
 */
public class PropertyChargeRule extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5747068168607225136L;
	private long partitionId;
	private byte cycle;
	private byte ctype;
	private double feeArea;
	private double feeLift;
	private double feeAll;
	private double basementFeeArea;
	private byte isEffect;
	
	
	
	/**
	 * 缴费周期(一个月)
	 */
	public final static byte CYCLE_MONTH = 0;
	/**
	 * 缴费周期(一季)
	 */
	public final static byte CYCLE_QUARTER = 1;
	/**
	 * 缴费周期(一年)
	 */
	public final static byte CYCLE_YEAR = 2;
	
	
	/**
	 * 收费类型(按面积)
	 */
	public final static byte CTYPE_AREA = 0;
	/**
	 * 收费类型(按整套房屋)
	 */
	public final static byte CTYPE_HOUSE = 1;
	

	/**
	 * 是否已生效(未生效)
	 */
	public final static byte IS_EFFECT_NO = 0;
	/**
	 * 是否已生效(已生效)
	 */
	public final static byte IS_EFFECT_YES = 1;
	
	
	public static List<Byte> getCycleKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(CYCLE_MONTH);
		list.add(CYCLE_QUARTER);
		list.add(CYCLE_YEAR);
		return list;
	}
	public static Map<Byte, String> getCycles() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(CYCLE_MONTH, getCycleNameByCode(CYCLE_MONTH));
		map.put(CYCLE_QUARTER, getCycleNameByCode(CYCLE_QUARTER));
		map.put(CYCLE_YEAR, getCycleNameByCode(CYCLE_YEAR));
		return map;
	}
	public String getCycleName(){
		byte c = getCycle();
		return getCycleNameByCode(c);
	}
	public static String getCycleNameByCode(byte code){
		if(code == CYCLE_MONTH) {
			return "一个月";
		}
		if(code == CYCLE_QUARTER) {
			return "一季";
		}
		if(code == CYCLE_YEAR) {
			return "一年";
		}
		return String.valueOf(code);
	}
	
	
	

	public static List<Byte> getCtypeKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(CTYPE_AREA);
		list.add(CTYPE_HOUSE);
		return list;
	}
	public static Map<Byte, String> getCtypes() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(CTYPE_AREA, getCtypeNameByCode(CTYPE_AREA));
		map.put(CTYPE_HOUSE, getCtypeNameByCode(CTYPE_HOUSE));
		return map;
	}
	public String getCtypeName(){
		byte c = getCtype();
		return getCtypeNameByCode(c);
	}
	public static String getCtypeNameByCode(byte code){
		if(code == CTYPE_AREA) {
			return "按面积";
		}
		if(code == CTYPE_HOUSE) {
			return "按整套房屋";
		}
		return String.valueOf(code);
	}
	
	
	

	public static List<Byte> getIsEffectKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(IS_EFFECT_NO);
		list.add(IS_EFFECT_YES);
		return list;
	}
	public static Map<Byte, String> getIsEffects() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(IS_EFFECT_NO, getIsEffectNameByCode(IS_EFFECT_NO));
		map.put(IS_EFFECT_YES, getIsEffectNameByCode(IS_EFFECT_YES));
		return map;
	}
	public String getIsEffectName(){
		byte c = getIsEffect();
		return getIsEffectNameByCode(c);
	}
	public static String getIsEffectNameByCode(byte code){
		if(code == IS_EFFECT_NO) {
			return "未生效";
		}
		if(code == IS_EFFECT_YES) {
			return "已生效";
		}
		return String.valueOf(code);
	}
	
	
	
	
	public long getPartitionId() {
		return partitionId;
	}
	public void setPartitionId(long partitionId) {
		this.partitionId = partitionId;
	}
	public byte getCycle() {
		return cycle;
	}
	public void setCycle(byte cycle) {
		this.cycle = cycle;
	}
	public byte getCtype() {
		return ctype;
	}
	public void setCtype(byte ctype) {
		this.ctype = ctype;
	}
	public double getFeeArea() {
		return feeArea;
	}
	public void setFeeArea(double feeArea) {
		this.feeArea = feeArea;
	}
	public double getFeeLift() {
		return feeLift;
	}
	public void setFeeLift(double feeLift) {
		this.feeLift = feeLift;
	}
	public double getFeeAll() {
		return feeAll;
	}
	public void setFeeAll(double feeAll) {
		this.feeAll = feeAll;
	}
	public double getBasementFeeArea() {
		return basementFeeArea;
	}
	public void setBasementFeeArea(double basementFeeArea) {
		this.basementFeeArea = basementFeeArea;
	}
	public byte getIsEffect() {
		return isEffect;
	}
	public void setIsEffect(byte isEffect) {
		this.isEffect = isEffect;
	}
}
