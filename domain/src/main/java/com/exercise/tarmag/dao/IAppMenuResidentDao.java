package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.AppMenuResident;


/**
 * @author yuwei
 * @Time 2015-7-19上午10:37:08
 */
public interface IAppMenuResidentDao extends Dao<AppMenuResident, Long> {
	
	
	AppMenuResident getResidentMenuByresidentIdAndAppMenuId(long residentId, long appMenuId);
	
	/**
	 * 查询个人所有菜单
	 * @return
	 */
	List<Map<String, Object>> getResidentAppMenuList(long residentId,Long unitId);
}
