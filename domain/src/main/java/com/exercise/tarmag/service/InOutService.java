package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.util.DateUtil;
import com.dt.tarmag.dao.IInOutDao;
import com.dt.tarmag.dao.IKeyDeviceDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.InOut;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.vo.InoutSearchVo;

@Service
public class InOutService implements IInOutService {
	@Autowired
	private IInOutDao inOutDao;
	@Autowired
	private IResidentDao residentDao;
	@Autowired
	private IKeyDeviceDao keyDeviceDao;

	
	@Override
	public void save_tx(Long keyDeviceId, Long residentId, int clickTimes, Long unitId) {
		InOut inOut = new InOut();
		inOut.setResidentId(residentId);
		inOut.setKeyDeviceId(keyDeviceId);
		inOut.setClickTimes(clickTimes);
		inOut.setUnitId(this.keyDeviceDao.getUnitIdByKeyId(keyDeviceId));
		//inOut.setCreateDateTime(DateUtil.parseDate(createDateTime, DateUtil.PATTERN_DATE_T_TIME));
		this.inOutDao.save(inOut);
	}

	@Override
	public int getInoutPasserbyCount(long unitId, InoutSearchVo searchVo) {
		return inOutDao.getInoutPasserbyCount(unitId, searchVo);
	}

	@Override
	public List<Map<String, Object>> getInoutPasserbyList(long unitId, InoutSearchVo searchVo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<InOut> list = inOutDao.getInoutPasserbyList(unitId, searchVo, pageNo, pageSize);
		if(list == null || list.size() <= 0) {
			return mapList;
		}
		
		for(InOut io : list) {
			Resident resident = residentDao.get(io.getResidentId());
			KeyDevice kd = keyDeviceDao.get(io.getKeyDeviceId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("inoutId", io.getId());
			map.put("residentName", resident == null ? "" : resident.getUserName());
			map.put("phoneNum", resident == null ? "" : resident.getPhoneNum());
			map.put("keyName", kd == null ? "" : kd.getKeyName());
			map.put("inoutTime", DateUtil.formatDate(io.getCreateDateTime(), DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}
		return mapList;
	}
	
	@Override
	public void getInoutPasserbyStatistics(Long unitId, Byte timeType, ModelMap model) throws Exception {

		InoutSearchVo searchVo = new InoutSearchVo();
		
		if (timeType != null) {
			searchVo.setTimeFlag((byte) 2);
			searchVo.setTimeType(timeType);
		}
		else {
			searchVo.setTimeFlag((byte) 2);
			searchVo.setTimeType((byte) 1);
		}

		List<KeyDevice> keys = keyDeviceDao.getKeyDeviceListByUnitId(unitId);

		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		// 按日统计
		if (timeType == 1) {
			List<Map<String, Object>> records = inOutDao.getInoutPasserbyStatisticsDay(unitId, searchVo);
			if (records != null && records.size() > 0) {
				for (KeyDevice keyDevice : keys) {

					Map<String, Object> keyMap = new HashMap<String, Object>();
					long dayArray[] = new long[24];

					for (Map<String, Object> map : records) {

						Long keyId = Long.parseLong(map.get("keyId").toString());
						Long counts = Long.parseLong(map.get("counts").toString());
						Integer ct = Integer.parseInt(map.get("ct").toString());
						String keyName = map.get("keyName").toString();

						if (keyDevice.getId() == keyId && keyName.equals(keyDevice.getKeyName())) {
							for (int i = 0; i < dayArray.length; i++) {
								if (ct == i) {
									dayArray[i] = counts;
									break;
								}
							}
						}
					}
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}else{
				long dayArray[] = new long[24];
				for (KeyDevice keyDevice : keys) {
					Map<String, Object> keyMap = new HashMap<String, Object>();
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}
		}
		// 最近 7 天
		if (timeType == 6) {
			
			//获取当前日期序列
			int dayIndex = 0;
			try{
				//SELECT DATE_FORMAT(  NOW(),'%j')  ct
				dayIndex = inOutDao.getNowDays();
			}catch(Exception e){
				e.printStackTrace();
				throw new Exception("获取日期序列失败！");
			}
			
			List<Map<String, Object>> records = inOutDao.getInoutPasserbyStatisticsWeek(unitId, searchVo);
			if (records != null && records.size() > 0) {
				for (KeyDevice keyDevice : keys) {

					Map<String, Object> keyMap = new HashMap<String, Object>();
					long dayArray[] = new long[7];

					for (Map<String, Object> map : records) {

						Long keyId = Long.parseLong(map.get("keyId").toString());
						Long counts = Long.parseLong(map.get("counts").toString());
						Integer ct = Integer.parseInt(map.get("ct").toString());
						String keyName = map.get("keyName").toString();

						if (keyDevice.getId() == keyId && keyName.equals(keyDevice.getKeyName())) {
							for (int i = 0; i < dayArray.length; i++) {
								if (ct == (dayIndex - (6 - i))) {
									dayArray[i] = counts;
									break;
								}
							}
						}
					}
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}else{
				long dayArray[] = new long[7];
				for (KeyDevice keyDevice : keys) {
					Map<String, Object> keyMap = new HashMap<String, Object>();
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}
		}

		// 最近 39 天
		if (timeType == 7) {
			
			List<Map<String, Object>> records = inOutDao.getInoutPasserbyStatisticsMonth(unitId, searchVo);
			
			//获取当前日期序列
			int dayIndex = 0;
			try{
				//SELECT DATE_FORMAT(  NOW(),'%j')  ct
				dayIndex = inOutDao.getNowDays();
			}catch(Exception e){
				e.printStackTrace();
				throw new Exception("获取日期序列失败！");
			}
			
			if (records != null && records.size() > 0) {
				for (KeyDevice keyDevice : keys) {

					Map<String, Object> keyMap = new HashMap<String, Object>();
					long dayArray[] = new long[30];

					for (Map<String, Object> map : records) {

						Long keyId = Long.parseLong(map.get("keyId").toString());
						Long counts = Long.parseLong(map.get("counts").toString());
						Integer ct = Integer.parseInt(map.get("ct").toString());
						String keyName = map.get("keyName").toString();

						if (keyDevice.getId() == keyId && keyName.equals(keyDevice.getKeyName())) {
							for (int i = 0; i < dayArray.length; i++) {
								if (ct == (dayIndex - (29 - i))) {
									dayArray[i] = counts;
									break;
								}
							}
						}
					}
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}else{
				long dayArray[] = new long[30];
				for (KeyDevice keyDevice : keys) {
					Map<String, Object> keyMap = new HashMap<String, Object>();
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}
		}

		// 按年统计
		if (timeType == 5) {
			List<Map<String, Object>> records = inOutDao.getInoutPasserbyStatisticsYear(unitId, searchVo);
			if (records != null && records.size() > 0) {
				for (KeyDevice keyDevice : keys) {

					Map<String, Object> keyMap = new HashMap<String, Object>();
					long dayArray[] = new long[12];

					for (Map<String, Object> map : records) {

						Long keyId = Long.parseLong(map.get("keyId").toString());
						Long counts = Long.parseLong(map.get("counts").toString());
						Integer ct = Integer.parseInt(map.get("ct").toString());
						String keyName = map.get("keyName").toString();

						if (keyDevice.getId() == keyId && keyName.equals(keyDevice.getKeyName())) {
							for (int i = 0; i < dayArray.length; i++) {
								if (ct - 1 == i) {
									dayArray[i] = counts;
									break;
								}
							}
						}
					}

					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}else{
				long dayArray[] = new long[12];
				for (KeyDevice keyDevice : keys) {
					Map<String, Object> keyMap = new HashMap<String, Object>();
					keyMap.put("name", keyDevice.getKeyName());
					keyMap.put("data", dayArray);
					resultList.add(keyMap);
				}
			}
		}

		JSONArray arr = new JSONArray();
		
		for (Map<String, Object> data : resultList) {
			JSONObject obj = JSONObject.fromObject(data);
			arr.add(obj);
		}
		model.put("arr", arr);
		model.put("timeType", timeType);
	}

}
