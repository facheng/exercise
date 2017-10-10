package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.ResidentUnit;
import com.dt.tarmag.model.ResidentUnitKey;

public interface IResidentUnitKeyService {

	/**
	 * 获取钥匙
	 * 
	 * @param tokenId
	 * @return
	 */
	public List<Map<String, Object>> findKeys(Long unitId,Long residentId);
	
	/**
	 * 查询住户、小区和钥匙的绑定关系中属于楼栋的钥匙个数
	 * @return
	 */
	int getResidentUnitStoryKeyCount();
	/**
	 * 查询住户、小区和钥匙的绑定关系中属于楼栋的钥匙
	 * @return
	 */
	List<ResidentUnitKey> getResidentUnitStoryKeyList(int pageNo, int pageSize);
	ResidentUnit getResidentUnitById(long id);
	/**
	 * 住户是否在指定时间内使用过钥匙
	 * @param residentId
	 * @param keyId
	 * @param fromDate
	 * @param endDate
	 * @return
	 */
	boolean isUsed(long residentId, long keyId, Date fromDate, Date endDate);
	void delete_tx(ResidentUnitKey ruk);
}
