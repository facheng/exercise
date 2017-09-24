package com.dt.tarmag.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IKeyDeviceDao;
import com.dt.tarmag.dao.IResidentUnitDao;
import com.dt.tarmag.dao.IResidentUnitKeyDao;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.ResidentUnit;
import com.dt.tarmag.model.ResidentUnitKey;

@Service
public class ResidentUnitService implements IResidentUnitService {
	
	@Autowired
	private IResidentUnitDao residentUnitDao;
	@Autowired
	private IKeyDeviceDao keyDeviceDao;
	@Autowired
	private IResidentUnitKeyDao residentUnitKeyDao;

	@Override
	public void unitBinding_tx(Long unitId, Long residentId) {
		List<ResidentUnit> residentUnits = this.residentUnitDao.getResidentUnits(unitId, residentId);
		if(residentUnits == null || residentUnits.size() <= 0){//没绑定过
			ResidentUnit entity = new ResidentUnit();
			entity.setUnitId(unitId);
			entity.setResidentId(residentId);
			entity.setCreateTime(new Date());
			this.residentUnitDao.save(entity);
			//设备钥匙全给予
			List<KeyDevice> keyDevices = this.keyDeviceDao.getKeyDeviceListByUnitId(unitId);
			if(keyDevices != null && keyDevices.size() > 0){
				for(KeyDevice keyDevice : keyDevices){
					ResidentUnitKey ruk = new ResidentUnitKey();
					ruk.setResidentUnitId(entity.getId());
					ruk.setKeyDeviceId(keyDevice.getId());
					this.residentUnitKeyDao.save(ruk);
				}
			}
		}
	}

}
