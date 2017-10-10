package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IInOutDao;
import com.dt.tarmag.dao.IResidentUnitDao;
import com.dt.tarmag.dao.IResidentUnitKeyDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.model.ResidentUnit;
import com.dt.tarmag.model.ResidentUnitKey;
import com.dt.tarmag.model.Unit;

@Service
public class ResidentUnitKeyService implements IResidentUnitKeyService {
	@Autowired
	private IResidentUnitKeyDao residentUnitKeyDao;
	@Autowired
	private IUnitDao unitDao;
	@Autowired
	private IResidentUnitDao residentUnitDao;
	@Autowired
	private IInOutDao inOutDao;
	

	@Override
	public List<Map<String, Object>> findKeys(Long unitId, Long residentId) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		if(unitId != null){//不为空就一个
			Unit unit = this.unitDao.get(unitId);
			Map<String, Object> unitM = new HashMap<String,Object>();
			unitM.put("unitId", unit.getId());
			unitM.put("unitName", unit.getUnitName());
			unitM.put("isAuto", unit.getIsAuto());
			unitM.put("keyDevices", this.residentUnitKeyDao.findKeys(unitId, residentId));
			result.add(unitM);
		}else{//多个
			List<ResidentUnit> residentUnits = residentUnitDao.getResidentUnits(unitId, residentId);
			if(residentUnits != null && residentUnits.size() > 0){
				for(ResidentUnit residentUnit : residentUnits){
					Unit unit = this.unitDao.get(residentUnit.getUnitId());
					if(unit == null) continue;
					Map<String, Object> unitM = new HashMap<String,Object>();
					unitM.put("unitId", unit.getId());
					unitM.put("unitName", unit.getUnitName());
					unitM.put("isAuto", unit.getIsAuto());
					unitM.put("keyDevices", this.residentUnitKeyDao.findKeys(unit.getId(), residentId));
					result.add(unitM);
				}
			}
		}
		return result;
	}
	
	@Override
	public int getResidentUnitStoryKeyCount() {
		return residentUnitKeyDao.getResidentUnitStoryKeyCount();
	}
	
	@Override
	public List<ResidentUnitKey> getResidentUnitStoryKeyList(int pageNo, int pageSize) {
		return residentUnitKeyDao.getResidentUnitStoryKeyList(pageNo, pageSize);
	}
	
	@Override
	public ResidentUnit getResidentUnitById(long id) {
		return residentUnitDao.get(id);
	}

	@Override
	public void delete_tx(ResidentUnitKey ruk) {
		residentUnitKeyDao.deleteLogic(ruk.getId());
	}

	@Override
	public boolean isUsed(long residentId, long keyId, Date fromDate, Date endDate) {
		return inOutDao.isUsed(residentId, keyId, fromDate, endDate);
	}

}
