package com.dt.tarmag.dao;

import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.DeviceManage;

public interface IDeviceManageDao extends Dao<DeviceManage, Long> {

	/**
	 * 查询是否存在
	 * @param deviceManage
	 * @return
	 */
	public DeviceManage getDeviceManageByQuery(DeviceManage deviceManage);

	/**
	 * 根据用户获取其登陆设备
	 * @param residentId
	 * @return
	 */
	List<DeviceManage> getDeviceManagesByUserId(Long residentId);
}
