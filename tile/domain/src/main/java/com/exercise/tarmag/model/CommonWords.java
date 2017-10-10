package com.dt.tarmag.model;


import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dt.framework.model.DtModel;


/**
 * 常用语
 * @author yuwei
 * @Time 2015-8-12下午03:24:29
 */
public class CommonWords extends DtModel{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5611359177379803028L;
	private String words;
	private int type;
	private long unitId;
	
	
	/**
	 * 类别(通知)
	 */
	public final static int TYPE_NOTICE = 1;
	/**
	 * 类别(快递)
	 */
	public final static int TYPE_DELIVERY = 2;
	/**
	 * 类别(报修)
	 */
	public final static int TYPE_REPAIR = 3;
	
	

	public static List<Integer> getTypeCodes(){
		List<Integer> list = new ArrayList<Integer>();
		list.add(TYPE_NOTICE);
		list.add(TYPE_DELIVERY);
		list.add(TYPE_REPAIR);
		return list;
	}
	public static Map<Integer, String> getTypes() {
		Map<Integer, String> map = new TreeMap<Integer, String>(new Comparator<Integer>() {
			@Override
			public int compare(Integer o1, Integer o2) {
				return o1 - o2;
			}
		});

		map.put(TYPE_NOTICE, getTypeNameByCode(TYPE_NOTICE));
		map.put(TYPE_DELIVERY, getTypeNameByCode(TYPE_DELIVERY));
		map.put(TYPE_REPAIR, getTypeNameByCode(TYPE_REPAIR));
		return map;
	}
	public String getTypeName(){
		int t = getType();
		return getTypeNameByCode(t);
	}
	public static String getTypeNameByCode(int code){
		if(code == TYPE_NOTICE) {
			return "通知";
		}
		if(code == TYPE_DELIVERY) {
			return "快递";
		}
		if(code == TYPE_REPAIR) {
			return "报修";
		}
		return String.valueOf(code);
	}
	
	
	public String getWords() {
		return words;
	}
	public void setWords(String words) {
		this.words = words;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
}
