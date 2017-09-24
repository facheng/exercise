package com.dt.tarmag.model;


import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;


/**
 * 房屋报修信息
 * @author yuwei
 * @Time 2015-7-19上午09:29:59
 */
public class Repair extends RepairStatus{

	private static final long serialVersionUID = -8187342095641676612L;
	private long unitId;
	private long houseId;
	private byte repairType;
	private byte serviceType;
	private long residentId;
	private String residentName;
	private String phoneNum;
	private Date orderTime;
	private byte isPublic;
	private String address;
	private String remark;
	private byte urgentState;
	private long workTypeId;
	private long workerId;
	private int scoreResponse;
	private int scoreDoor;
	private int scoreService;
	private int scoreQuality;
	
	

	public boolean isScored(){
		return scoreResponse > 0 || scoreDoor > 0 || scoreService > 0 || scoreQuality > 0;
	}

	/**
	 * 根据四项评分计算综合评分(0-5)
	 * @return
	 */
	public int getOverallScore(){
		return (scoreResponse + scoreDoor + scoreService + scoreQuality) / 4;
	}
	
	
	/**
	 * 报修类型(个人)
	 */
	public final static byte REPAIR_TYPE_PRIVATE = 1;
	/**
	 * 报修类型(公共)
	 */
	public final static byte REPAIR_TYPE_PUBLIC = 2;
	
	public static List<Byte> getAllRepairTypeKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(REPAIR_TYPE_PRIVATE);
		list.add(REPAIR_TYPE_PUBLIC);
		return list;
	}
	public static Map<Byte, String> getAllRepairTypes() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(REPAIR_TYPE_PRIVATE, getRepairTypeNameByCode(REPAIR_TYPE_PRIVATE));
		map.put(REPAIR_TYPE_PUBLIC, getRepairTypeNameByCode(REPAIR_TYPE_PUBLIC));
		return map;
	}
	public String getRepairTypeName(){
		byte rt = getRepairType();
		return getRepairTypeNameByCode(rt);
	}
	public static String getRepairTypeNameByCode(byte code){
		if(code == REPAIR_TYPE_PRIVATE) {
			return "个人";
		}
		if(code == REPAIR_TYPE_PUBLIC) {
			return "公共";
		}
		return String.valueOf(code);
	}
	

	/**
	 * 维修类型(供配电)
	 */
	public final static byte SERVICE_TYPE_POWER_SUPPLY = 1;
	/**
	 * 维修类型(用水排水(下水道))
	 */
	public final static byte SERVICE_TYPE_SEWER = 2;
	/**
	 * 维修类型(家用电器)
	 */
	public final static byte SERVICE_TYPE_ELECTRIC = 3;
	/**
	 * 维修类型(燃气照明)
	 */
	public final static byte SERVICE_TYPE_GAS_LIGHT = 4;
	/**
	 * 维修类型(其它)
	 */
	public final static byte SERVICE_TYPE_OTHER = 99;
	

	public static List<Byte> getAllServiceTypeKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(SERVICE_TYPE_POWER_SUPPLY);
		list.add(SERVICE_TYPE_SEWER);
		list.add(SERVICE_TYPE_ELECTRIC);
		list.add(SERVICE_TYPE_GAS_LIGHT);
		list.add(SERVICE_TYPE_OTHER);
		return list;
	}
	public static Map<Byte, String> getAllServiceTypes() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(SERVICE_TYPE_POWER_SUPPLY, getServiceTypeNameByCode(SERVICE_TYPE_POWER_SUPPLY));
		map.put(SERVICE_TYPE_SEWER, getServiceTypeNameByCode(SERVICE_TYPE_SEWER));
		map.put(SERVICE_TYPE_ELECTRIC, getServiceTypeNameByCode(SERVICE_TYPE_ELECTRIC));
		map.put(SERVICE_TYPE_GAS_LIGHT, getServiceTypeNameByCode(SERVICE_TYPE_GAS_LIGHT));
		map.put(SERVICE_TYPE_OTHER, getServiceTypeNameByCode(SERVICE_TYPE_OTHER));
		return map;
	}
	public String getServiceTypeName(){
		byte st = getServiceType();
		return getServiceTypeNameByCode(st);
	}
	public static String getServiceTypeNameByCode(byte code){
		if(code == SERVICE_TYPE_POWER_SUPPLY) {
			return "供配电";
		}
		if(code == SERVICE_TYPE_SEWER) {
			return "用水排水(下水道)";
		}
		if(code == SERVICE_TYPE_ELECTRIC) {
			return "家用电器";
		}
		if(code == SERVICE_TYPE_GAS_LIGHT) {
			return "燃气照明";
		}
		if(code == SERVICE_TYPE_OTHER) {
			return "其它";
		}
		return String.valueOf(code);
	}
	
	
	/**
	 * 是否公开(是)
	 */
	public final static byte IS_PUBLIC_Y = 0;
	/**
	 * 是否公开(否)
	 */
	public final static byte IS_PUBLIC_N = 1;
	
	public static List<Byte> getAllPublicPolicyKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(IS_PUBLIC_Y);
		list.add(IS_PUBLIC_N);
		return list;
	}
	public static Map<Byte, String> getAllPublicPolicies() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(IS_PUBLIC_Y, getIsPublicNameByCode(IS_PUBLIC_Y));
		map.put(IS_PUBLIC_N, getIsPublicNameByCode(IS_PUBLIC_N));
		return map;
	}
	public String getIsPublicName(){
		byte ip = getIsPublic();
		return getIsPublicNameByCode(ip);
	}
	public static String getIsPublicNameByCode(byte code){
		if(code == IS_PUBLIC_Y) {
			return "是";
		}
		if(code == IS_PUBLIC_N) {
			return "否";
		}
		return String.valueOf(code);
	}
	
	
	/**
	 * 紧急程度(一般)
	 */
	public final static byte URGENT_STATE_GENERAL = 0;
	/**
	 * 紧急程度(紧急)
	 */
	public final static byte URGENT_STATE_EMERGENCY = 1;
	/**
	 * 紧急程度(非常紧急)
	 */
	public final static byte URGENT_STATE_VERY_URGENT = 2;
	
	public static List<Byte> getAllUrgentStateKeys(){
		List<Byte> list = new ArrayList<Byte>();
		list.add(URGENT_STATE_GENERAL);
		list.add(URGENT_STATE_EMERGENCY);
		list.add(URGENT_STATE_VERY_URGENT);
		return list;
	}
	public static Map<Byte, String> getAllUrgentStates() {
		Map<Byte, String> map = new TreeMap<Byte, String>(new Comparator<Byte>() {
			@Override
			public int compare(Byte o1, Byte o2) {
				return o1 - o2;
			}
		});

		map.put(URGENT_STATE_GENERAL, getUrgentStateNameByCode(URGENT_STATE_GENERAL));
		map.put(URGENT_STATE_EMERGENCY, getUrgentStateNameByCode(URGENT_STATE_EMERGENCY));
		map.put(URGENT_STATE_VERY_URGENT, getUrgentStateNameByCode(URGENT_STATE_VERY_URGENT));
		return map;
	}
	public String getUrgentStateName(){
		byte us = getUrgentState();
		return getUrgentStateNameByCode(us);
	}
	public static String getUrgentStateNameByCode(byte code){
		if(code == URGENT_STATE_GENERAL) {
			return "一般";
		}
		if(code == URGENT_STATE_EMERGENCY) {
			return "紧急";
		}
		if(code == URGENT_STATE_VERY_URGENT) {
			return "非常紧急";
		}
		return String.valueOf(code);
	}
	
	
	
	
	public long getHouseId() {
		return houseId;
	}
	public void setHouseId(long houseId) {
		this.houseId = houseId;
	}
	public byte getRepairType() {
		return repairType;
	}
	public void setRepairType(byte repairType) {
		this.repairType = repairType;
	}
	public byte getServiceType() {
		return serviceType;
	}
	public void setServiceType(byte serviceType) {
		this.serviceType = serviceType;
	}
	public long getResidentId() {
		return residentId;
	}
	public void setResidentId(long residentId) {
		this.residentId = residentId;
	}
	public String getResidentName() {
		return residentName;
	}
	public void setResidentName(String residentName) {
		this.residentName = residentName;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	public Date getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(Date orderTime) {
		this.orderTime = orderTime;
	}
	public byte getIsPublic() {
		return isPublic;
	}
	public void setIsPublic(byte isPublic) {
		this.isPublic = isPublic;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public byte getUrgentState() {
		return urgentState;
	}
	public void setUrgentState(byte urgentState) {
		this.urgentState = urgentState;
	}
	public long getWorkTypeId() {
		return workTypeId;
	}
	public void setWorkTypeId(long workTypeId) {
		this.workTypeId = workTypeId;
	}
	public long getWorkerId() {
		return workerId;
	}
	public void setWorkerId(long workerId) {
		this.workerId = workerId;
	}
	public int getScoreResponse() {
		return scoreResponse;
	}
	public void setScoreResponse(int scoreResponse) {
		this.scoreResponse = scoreResponse;
	}
	public int getScoreDoor() {
		return scoreDoor;
	}
	public void setScoreDoor(int scoreDoor) {
		this.scoreDoor = scoreDoor;
	}
	public int getScoreService() {
		return scoreService;
	}
	public void setScoreService(int scoreService) {
		this.scoreService = scoreService;
	}
	public int getScoreQuality() {
		return scoreQuality;
	}
	public void setScoreQuality(int scoreQuality) {
		this.scoreQuality = scoreQuality;
	}
	public long getUnitId() {
		return unitId;
	}
	public void setUnitId(long unitId) {
		this.unitId = unitId;
	}
}
