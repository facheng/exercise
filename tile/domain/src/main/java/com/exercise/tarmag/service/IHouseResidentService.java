/**
 * 
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ResidentVo;

/**
 * @author raymond
 *
 */
public interface IHouseResidentService {
	
	HouseResident getHouseResidentById(long houseResidentId);
	
	/**
	 * 获取当前登录用户所有绑定的房屋 i家园获取用户绑定房屋
	 * @param residentId
	 * @return
	 */
	public List<Map<String, Object>> getBindHouses(String tokenId);
	/**
	 * i家园用户绑定房屋
	 * @param residentId
	 * @return
	 */
	public void addBindHouse_tx(String tokenId, Long houseId, byte type, int isDefault);
	
	/**
	 * 指定默认房屋
	 * @param id
	 */
	public void changeDefault_tx(Long id, int isDefault);
	/**
	 * 取消关联房屋
	 * @param id
	 */
	public void delete_tx(Long id);
	
	/**
	 * 通过房屋和业主ID查询绑定关系
	 * @param houseId
	 * @param residentId
	 * @return
	 */
	public HouseResident getHouseResident(long houseId, long residentId);
	
	/**
	 * 将房屋和住户绑定
	 * @param houseId
	 * @param vo
	 */
	void bindHouseResident_tx(long houseId, ResidentVo vo);
	
	/**
	 * 修改房屋住户绑定
	 * @param houseResidentId
	 * @param vo
	 */
	void modifyBindHouseResident_tx(long houseResidentId, ResidentVo vo);
	
	/**
	 * 用户使用情况统计
	 * @param params
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findUsageStatistics(Map<String, Object> params, Page page);
}
