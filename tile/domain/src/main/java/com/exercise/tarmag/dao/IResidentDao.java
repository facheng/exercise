package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Resident;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:42:50
 */
public interface IResidentDao extends Dao<Resident, Long> {
	/**
	 * 根据手机号获取用户信息
	 * @param phoneNum 手机号
	 * @return
	 */
	public Resident getResidentByPhoneNum(String phoneNum);
	
	/**
	 * 根据房屋 ID 查询业主信息
	 * @param houseId
	 * @return
	 */
	public List<Map<String ,Object>> getResidentByHouseId(long houseId);
	
	/**
	 * 条件查询业主或租客信息
	 * @param paramsMap
	 * @return
	 */
	public List<Resident> getResident(Map<String, Object> paramsMap);
	
	/**
	 * 查询指定小区下所有住户
	 * @param unitId
	 * @return
	 */
	List<Resident> getResidentListByUnitId(long unitId);
	
	/**
	 * 查询指定房屋中的所有住户
	 * @param unitId
	 * @return
	 */
	List<Resident> getResidentListByHouseId(long houseId);
	
	/**
	 * 查询指定房屋中指定居住类别集合的住户
	 * @param houseIdList
	 * @param typeList
	 * @return
	 */
	List<Resident> getResidentList(long houseId, List<Byte> typeList);
	
	/**
	 * 查询指定房屋集合中指定居住类别集合的住户
	 * @param houseIdList
	 * @param typeList
	 * @return
	 */
	List<Resident> getResidentList(List<Long> houseIdList, List<Byte> typeList);
	
	/**
	 * 通过房屋ID查询业主和家属信息
	 * @param houseId
	 * @return
	 */
	public List<Map<String, Object>> getResidentByHouseIdAndType(long houseId ,List<Byte> typeList);
	
	/**
	 * 查询指定小区下所有住户
	 * @param unitId
	 * @return
	 */
	List<Resident> findResidentListByUnitId(long unitId);
}
