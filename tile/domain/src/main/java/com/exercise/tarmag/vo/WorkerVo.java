package com.dt.tarmag.vo;


import com.dt.tarmag.model.WorkType;

/**
 * 系统角色  WorkerVo
 *
 * @author jiaosf
 * @since 2015-7-23
 */
public class WorkerVo {
	private Long id;
	private String phoneNum;
	private String userName;
	private String password;
	private String idCard;
	private String birthday;
	private String entryDate;
	
	//扩展属性
	
	/**
	 * DT_WORK_TYPE ID
	 */
	private Long wtId;   
	
	/**
	 * DT_WORK_TYPE TYPE
	 */
	private Byte wtType; // 1 保安 ； 2保修
	
	private String wtName;
	
	private Long partitionId;
	
	private String partitionName;
	
	private Long[] partitionIds;
	
	private String[] partitionNames;
	
	private String typeName;
	
	/**
	 * DT_WORKER_TYPE_PARTITION ID
	 */
	private Long wtpId;
	
	
	private String isChecked;
	
	public String getIsChecked() {
		return isChecked;
	}

	
	public void setIsChecked(String isChecked) {
		this.isChecked = isChecked;
	}

	public String getWorkerTypeName() {
		Byte _wtType = getWtType();
		if (_wtType == WorkType.TYPE_SECURIY) {
			return "保安";
		}
		if (_wtType == WorkType.TYPE_REPIAR) {
			return "保修";
		}

		return String.valueOf(_wtType);
	}
	
	public String getWorkerTypeName(Byte _wtType) {
		if (_wtType == WorkType.TYPE_SECURIY) {
			return "保安";
		}
		if (_wtType == WorkType.TYPE_REPIAR) {
			return "保修";
		}

		return String.valueOf(_wtType);
	}
	
	public Long getId() {
		return id;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

	public String getPhoneNum() {
		return phoneNum;
	}
	
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIdCard() {
		return idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getEntryDate() {
		return entryDate;
	}

	public void setEntryDate(String entryDate) {
		this.entryDate = entryDate;
	}
	
	public Long getWtId() {
		return wtId;
	}
	
	public void setWtId(Long wtId) {
		this.wtId = wtId;
	}

	public Byte getWtType() {
		return wtType;
	}

	public void setWtType(Byte wtType) {
		this.wtType = wtType;
	}
	
	public String getWtName() {
		return wtName;
	}

	public void setWtName(String wtName) {
		this.wtName = wtName;
	}

	public Long getPartitionId() {
		return partitionId;
	}

	public void setPartitionId(Long partitionId) {
		this.partitionId = partitionId;
	}
	
	public String getPartitionName() {
		return partitionName;
	}
	
	public void setPartitionName(String partitionName) {
		this.partitionName = partitionName;
	}
	
	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	public Long getWtpId() {
		return wtpId;
	}

	public void setWtpId(Long wtpId) {
		this.wtpId = wtpId;
	}

	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public Long[] getPartitionIds() {
		return partitionIds;
	}

	public void setPartitionIds(Long[] partitionIds) {
		this.partitionIds = partitionIds;
	}
	
	public String[] getPartitionNames() {
		return partitionNames;
	}
	
	public void setPartitionNames(String[] partitionNames) {
		this.partitionNames = partitionNames;
	}
	
}
