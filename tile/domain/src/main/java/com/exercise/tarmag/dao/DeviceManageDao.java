package com.dt.tarmag.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.tarmag.model.DeviceManage;

@Repository
public class DeviceManageDao extends DaoImpl<DeviceManage, Long> implements IDeviceManageDao {

	@Override
	public DeviceManage getDeviceManageByQuery(DeviceManage deviceManage) {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from DT_DEVICE_MANAGE where APP_TYPE=? and USER_ID=? and DEVICE_TYPE=? ");
		return this.queryForObject(sql.toString(), DeviceManage.class, deviceManage.getAppType(),deviceManage.getUserId(),deviceManage.getDeviceType());
	}

	@Override
	public List<DeviceManage> getDeviceManagesByUserId(Long residentId){
		String sql = "SELECT * FROM DT_DEVICE_MANAGE WHERE DELETED='N' AND USER_ID=?";
		return this.query(sql, DeviceManage.class, new Object[]{residentId});
	}
}
