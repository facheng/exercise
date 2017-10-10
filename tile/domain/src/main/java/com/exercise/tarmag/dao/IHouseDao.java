package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.House;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:44:58
 */
public interface IHouseDao extends Dao<House, Long> {
	int getHouseCount();
	
	/**
	 * 根据用户小区id 房屋状态的统计
	 * @param unitId 当前登 录用户对应的小区id
	 * @return
	 */
	List<Map<String, Object>> getHouseCount(long unitId);
	
	/**
	 * 根据用户id 获取用户的默认房屋
	 * @param residentId 用户id
	 * @return
	 */
	public House getDefaultHouse(Long residentId);
	
	/**
	 * 根据条件获取房屋列表
	 * @param params
	 * @return
	 */
	public List<House> getHouses(Map<String, Object> params);
	
	/**
	 * 查询房屋数量
	 * @param unitId
	 * @param status
	 * @param roomNo
	 * @return
	 */
	int getHouseCount(long unitId, Byte status, String roomNo ,Long partitionId);
	
	/**
	 * 房屋列表
	 * @param unitId
	 * @param status
	 * @param roomNo
	 * @return
	 */
	List<Map<String ,Object>> getHouseList(long unitId, Byte status, String roomNo , Long partitionId , int pageNo ,int pageSize);
	
	/**
	 * 获取 导出房屋的信息
	 * @param house
	 * @return
	 */
	public List<Map<String, Object>> getHouseInfosExcel(House house) ;
	
	/**
	 * 房屋详细信息查询
	 * @param houseId
	 * @return
	 */
	public List<Map<String, Object>> getHouseInfoById(Long houseId);
	
	/**
	 * 修改房屋信息
	 * @param paramsMap
	 */
	public void updateHouse(Map<String, Object> paramsMap);
	
	/**
	 * 获取用户所有的房屋 用户辅助获取钥匙
	 * @return
	 */
	public List<House> getHouses(Long residentId);
	
	/**
	 * 根据 房屋dycode 和 小区id 获取房屋总数
	 * @return
	 */
	public int getCountHouse(House house);
	
	/**
	 * 根据 房屋dycode 和 小区id 获取房屋信息
	 * @param house
	 * @return
	 */
	public House getHouseByDyCode(House house);

	List<House> getHouseListByStoryId(long storyId);
	List<House> getHouseListByPartitionId(long partitionId);
	List<House> getHouseListByUnitId(long unitId);
	int getHouseCountByUnitId(long unitId);
	int getHouseCountByUnitIdAndStatus(long unitId, byte status);
	
	
	/**
	 * 获取 导出房屋的信息
	 * @param house
	 * @return
	 */
	public List<Map<String, Object>> getHouseInfosForExport(House house) ;
	
}
