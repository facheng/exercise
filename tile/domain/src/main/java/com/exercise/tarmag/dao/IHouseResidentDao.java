package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.HouseResident;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:44:29
 */
public interface IHouseResidentDao extends Dao<HouseResident, Long> {
	/**
	 * 根据用户id获取绑定的房屋
	 * @param residentId
	 * @return
	 */
	public List<Map<String, Object>> getBindHouses(Long residentId);

	/**
	 * 指定默认房屋
	 * @param id
	 * @param isDefault
	 */
	public void changeDefault(Long id, int isDefault);
	
	/**
	 * 通过房屋和业主ID查询绑定关系
	 * @param houseId
	 * @param residentId
	 * @return
	 */
	public HouseResident getHouseResident(long houseId, long residentId);
	
	/**
	 * 查询房屋绑定关系个数
	 * @param unitId
	 * @param state/房屋状态(全部、0未核准、1已核准、2已驳回)
	 * @param roomNo
	 * @return
	 */
	int getHouseResidentReviewCount(long unitId, Byte state, String roomNo);
	/**
	 * 查询房屋绑定关系
	 * @param unitId
	 * @param state/房屋状态(全部、0未核准、1已核准、2已驳回)
	 * @param roomNo
	 * @return
	 */
	List<HouseResident> getHouseResidentReviewMapList(long unitId, Byte state, String roomNo, int pageNo, int pageSize);

	List<HouseResident> getHouseResidentList(long houseId);
	List<HouseResident> getHouseResidentList(long houseId, List<Byte> typeList);
	
	/**
	 * 获取房屋审核列表
	 * @param unitId
	 * @param state
	 * @param roomNo
	 * @param partitionId
	 * @param userName
	 * @param phoneNum
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getHouseResidentReviewList(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum,
			Integer pageNo,
			Integer pageSize);
	
	/**
	 * 获取房屋审核列表总数
	 * @param unitId
	 * @param state
	 * @param roomNo
	 * @param partitionId
	 * @param userName
	 * @param phoneNum
	 * @return
	 */
	public int getHouseResidentReviewCount(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum);
	/**
	 * 用户使用率统计
	 * @param params
	 * @param page
	 * @return
	 */
	public List<Map<String, Object>> getUsageStatistics(Map<String, Object> params, Page page);
	
	/**
	 * 用户使用率统计小区总数
	 * @param params
	 * @return
	 */
	public int getUsageStatisticsCount(Map<String, Object> params);

}
