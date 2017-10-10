package com.dt.tarmag.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IDeviceManageDao;
import com.dt.tarmag.model.DeviceManage;

@Service
public class DeviceManageService implements IDeviceManageService{
	@Autowired
	private IDeviceManageDao deviceManageDao;

	@Override
	public void saveDeviceManage_tx(DeviceManage deviceManage) {
		DeviceManage deviceManageByQuery = this.deviceManageDao.getDeviceManageByQuery(deviceManage);
		if(deviceManageByQuery != null){
			deviceManageByQuery.setnToken(deviceManage.getnToken());
			this.deviceManageDao.update(deviceManageByQuery);
		}else{
			this.deviceManageDao.save(deviceManage);
		}
	}

}
