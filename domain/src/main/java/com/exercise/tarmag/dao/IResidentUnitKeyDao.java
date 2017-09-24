package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ResidentUnitKey;


/**
 * @author yuwei
 * @Time 2015-7-24下午02:01:20
 */
public interface IResidentUnitKeyDao extends Dao<ResidentUnitKey, Long> {
	
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
}
