/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IKeyDeviceDao;
import com.dt.tarmag.dao.IStoryDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.util.DataImportUtils;
import com.dt.tarmag.vo.KeyDeviceSearchVo;
import com.dt.tarmag.vo.KeyDeviceVo;

/**
 * @author 👤wisdom
 *
 */
@Service
public class KeyDeviceService implements IKeyDeviceService {
	@Autowired
	private IKeyDeviceDao keyDeviceDao;
	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IRedisDao redisDao;
	@Autowired
	private IUnitDao unitDao;
	@Autowired
	private IStoryDao storyDao;
	@Autowired
	private IUnitPartitionDao unitPartitionDao;
	
	private static Map<Integer, String> mapField;
	
	private static Logger logger = Logger.getLogger(ResidentService.class);

	@SuppressWarnings("unchecked")
	protected Long getResidentId(String tokenId) {
		return (Long) ((Map<String, Object>) this.redisDao.get("login_"
				+ tokenId)).get(Constant.CACHE_USER_ID);
	}

	protected Map<Long, List<Long>> getUnitStorys(Long residentId) {
		List<House> houses = this.houseDao.getHouses(residentId);
		Map<Long, List<Long>> unitStorys = new HashMap<Long, List<Long>>();
		for (House house : houses) {
			Long unitId = house.getUnitId();
			if (!unitStorys.containsKey(unitId)) {
				unitStorys.put(unitId, new ArrayList<Long>());
			}
			Long storyId = house.getStoryId();
			List<Long> sotrys = unitStorys.get(unitId);
			if (sotrys.contains(storyId))
				continue;
			sotrys.add(house.getStoryId());
		}

		return unitStorys;
	}

	@Override
	public List<Map<String, Object>> findKeys(Long residentId) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		for (Map.Entry<Long, List<Long>> unitStory : this.getUnitStorys(
				residentId).entrySet()) {
			// 根据小区id和楼栋id获取钥匙
			result.addAll(this.keyDeviceDao.findkeyDevice(unitStory.getKey(),
					unitStory.getValue()));
		}
		return result;
	}

	@Override
	public List<Map<String, Object>> findKeys(String tokenId) {
		Long residentId = this.getResidentId(tokenId);

		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		Unit defaultUnit = this.unitDao.getDefaultUnit(residentId);
		for (Map.Entry<Long, List<Long>> unitStory : this.getUnitStorys(
				residentId).entrySet()) {
			Map<String, Object> map = new HashMap<String, Object>();
			Long unitId = unitStory.getKey();
			map.put("isDefault", defaultUnit != null
					&& defaultUnit.getId() == unitId.longValue() ? 1 : 0);
			map.put("unitId", unitId);
			Unit unit = this.unitDao.get(unitId);
			map.put("unitName", unit.getUnitName());
			map.put("isAuto", unit.getIsAuto());
			List<Long> storyIds = unitStory.getValue();
			// 根据小区id和楼栋id获取钥匙
			map.put("keyDevices",
					this.keyDeviceDao.findkeyDevice(unitId, storyIds));
			result.add(map);
		}

		return result;
	}

	@Override
	public int getKeyDeviceCount(long unitId, KeyDeviceSearchVo vo) {
		return keyDeviceDao.getKeyDeviceCount(unitId, vo);
	}

	@Override
	public List<Map<String, Object>> getKeyDeviceMapList(long unitId, KeyDeviceSearchVo vo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<KeyDevice> keyDeviceList = keyDeviceDao.getKeyDeviceList(unitId, vo, pageNo, pageSize);
		if (keyDeviceList == null || keyDeviceList.size() <= 0) {
			return mapList;
		}

		for (KeyDevice kd : keyDeviceList) {
			Story story = storyDao.get(kd.getStoryId());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", kd.getId());
			map.put("keyName", kd.getKeyName());
//			map.put("deviceName", kd.getDeviceName());
			map.put("keyTypeName", kd.getKeyTypeName());
			map.put("storyNo", story == null ? "" : story.getStoryNum());
			map.put("deviceAddr", kd.getDeviceAddress());
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public Map<String, Object> getkeyDeviceToEdit(long keyDeviceId) {
		Map<String, Object> map = new HashMap<String, Object>();
		KeyDevice keyDevice = keyDeviceDao.get(keyDeviceId);
		if (keyDevice == null) {
			return null;
		}

		Story story = storyDao.get(keyDevice.getStoryId());

		map.put("keyName", keyDevice.getKeyName());
		map.put("keyType", keyDevice.getKeyType());
		map.put("deviceName", keyDevice.getDeviceName());
		map.put("deviceType", keyDevice.getDeviceType());
		map.put("deviceUuid", keyDevice.getDeviceUuid());
		map.put("deviceAddress", keyDevice.getDeviceAddress());
		map.put("password", keyDevice.getDevicePassword());
		map.put("remark", keyDevice.getRemark());
		map.put("storyId", keyDevice.getStoryId());
		map.put("storyName", story == null ? "" : story.getStoryNum());
		return map;
	}

	@Override
	public void createKeyDevice_tx(KeyDeviceVo vo) {
		if (vo == null
				|| vo.getUnitId() <= 0
				|| vo.getKeyName() == null
				|| vo.getKeyName().trim().equals("")
				|| vo.getKeyType() < 0
//				|| vo.getDeviceName() == null
//				|| vo.getDeviceName().trim().equals("")
				|| vo.getDeviceType() < 0
				|| (vo.getDeviceType() == KeyDevice.DEVICE_TYPE_STORY && vo
						.getStoryId() <= 0) 
//				|| vo.getDeviceUuid() == null || vo.getDeviceUuid().trim().equals("")
				|| vo.getDeviceAddress() == null
				|| vo.getDeviceAddress().trim().equals("")
				|| vo.getPassword() == null || vo.getPassword().equals("")) {
			return;
		}

		KeyDevice kd = new KeyDevice();
		kd.setKeyName(vo.getKeyName().trim());
//		kd.setDeviceName(vo.getDeviceName() == null ? "" : vo.getDeviceName().trim());
		kd.setUnitId(vo.getUnitId());
		kd.setDeviceType(vo.getDeviceType());
		if (vo.getDeviceType() == KeyDevice.DEVICE_TYPE_STORY) {
			kd.setStoryId(vo.getStoryId());
		} else {
			kd.setStoryId(0);
		}
		kd.setRemark(vo.getRemark() == null ? "" : vo.getRemark().trim());
		kd.setDeviceAddress(vo.getDeviceAddress().trim());
		kd.setDevicePassword(vo.getPassword());
		kd.setKeyType(vo.getKeyType());
		kd.setDeviceUuid(UUID.randomUUID().toString());
		keyDeviceDao.save(kd);
	}

	@Override
	public void updateKeyDevice_tx(long id, KeyDeviceVo vo) {
		if (vo == null
				|| vo.getUnitId() <= 0
				|| vo.getKeyName() == null
				|| vo.getKeyName().trim().equals("")
				|| vo.getKeyType() < 0
//				|| vo.getDeviceName() == null
//				|| vo.getDeviceName().trim().equals("")
				|| vo.getDeviceType() < 0
				|| (vo.getDeviceType() == KeyDevice.DEVICE_TYPE_STORY && vo.getStoryId() <= 0) 
//				|| vo.getDeviceUuid() == null || vo.getDeviceUuid().trim().equals("")
				|| vo.getDeviceAddress() == null
				|| vo.getDeviceAddress().trim().equals("")
				|| vo.getPassword() == null || vo.getPassword().equals("")) {
			return;
		}

		KeyDevice kd = keyDeviceDao.get(id);
		if (kd == null) {
			return;
		}

		kd.setKeyName(vo.getKeyName().trim());
//		kd.setDeviceName(vo.getDeviceName() == null ? "" : vo.getDeviceName().trim());
		kd.setUnitId(vo.getUnitId());
		kd.setDeviceType(vo.getDeviceType());
		if (vo.getDeviceType() == KeyDevice.DEVICE_TYPE_STORY) {
			kd.setStoryId(vo.getStoryId());
		} else {
			kd.setStoryId(0);
		}
		kd.setRemark(vo.getRemark() == null ? "" : vo.getRemark().trim());
		kd.setDeviceAddress(vo.getDeviceAddress().trim());
		kd.setDevicePassword(vo.getPassword());
		kd.setKeyType(vo.getKeyType());
//		kd.setDeviceUuid(vo.getDeviceUuid().trim());
		keyDeviceDao.update(kd);
	}

	@Override
	public Map<String, Object> getKeyDeviceDetail(long keyDeviceId) {
		Map<String, Object> map = new HashMap<String, Object>();
		KeyDevice kd = keyDeviceDao.get(keyDeviceId);
		if (kd == null) {
			return map;
		}

		Story story = storyDao.get(kd.getStoryId());
		String storyNo = "";
		String partitionNo = "";
		if (kd.getDeviceType() == KeyDevice.DEVICE_TYPE_STORY) {
			storyNo = story == null ? "" : story.getStoryNum();
			UnitPartition up = unitPartitionDao.get(story == null ? 0 : story
					.getPartitionId());
			partitionNo = up == null ? "" : up.getPartitionName();
		}

		map.put("keyName", kd.getKeyName());
		map.put("keyTypeName", kd.getKeyTypeName());
		map.put("deviceName", kd.getDeviceName());
		map.put("deviceTypeName", kd.getDeviceTypeName());
		map.put("uuid", kd.getDeviceUuid());
		map.put("address", kd.getDeviceAddress());
		map.put("storyNo", storyNo);
		map.put("partitionNo", partitionNo);
		map.put("remark", CommonUtil.escape(kd.getRemark()));
		return map;
	}

	@Override
	public void deleteKeyDevice_tx(long keyDeviceId) {
		keyDeviceDao.deleteLogic(keyDeviceId);
	}
	
	
	/**
	 * 数据导入 Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer, String>();
		mapField.put(0, "钥匙名称*");
		mapField.put(1, "钥匙类型*");
		mapField.put(2, "设备类型*");
		mapField.put(3, "楼栋名称");
		mapField.put(4, "设备地址*");
		mapField.put(5, "设备密码*");
	}
	
	@Override
	public void importKeyDevice_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		List<String> msgList = new ArrayList<String>();
		boolean result = DataImportUtils.checkFileImport(hssfSheet, mapField);
		try {
			if (result) {
				model.put("importMsg", "success");
				for (int rowNum = 6; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					HSSFRow hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						msgList.add("导入模版为空 ，请填写导入信息！");
						break;
					}

					HSSFCell cell0 = hssfRow.getCell(0); // 钥匙名称*  keyName
					HSSFCell cell1 = hssfRow.getCell(1); // 钥匙类型*  keyType
					HSSFCell cell2 = hssfRow.getCell(2); // 设备类型*  deviceType
					HSSFCell cell3 = hssfRow.getCell(3); // 楼栋名称         storyNum
					HSSFCell cell4 = hssfRow.getCell(4); // 设备地址*  deviceAddress
					HSSFCell cell5 = hssfRow.getCell(5); // 设备密码*  devicePassword

					KeyDevice keyDevice = new KeyDevice();
					
					Story story = new Story();
					
					keyDevice.setUnitId(unitId);

					if (cell0 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell0))) {
						String keyName = DataImportUtils.getValue(cell0);
						keyDevice.setKeyName(keyName);
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，钥匙名称不能为空！");
						continue;
					}

					if (cell1 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell1))) {
						String keyType = DataImportUtils.getValue(cell1);
						if (keyType.equals("人行")) {
							keyDevice.setKeyType(KeyDevice.KEY_TYPE_FOOT);
						} else if (keyType.equals("车行")) {
							keyDevice.setKeyType(KeyDevice.KEY_TYPE_CAR);
						}
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，钥匙类型不能为空！");
						continue;
					}

					if (cell2 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell2))) {
						String deviceType = DataImportUtils.getValue(cell2);
						if (deviceType.equals("小区")) {
							keyDevice.setDeviceType(KeyDevice.DEVICE_TYPE_UNIT);
							if (cell3 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
								String storyNum = DataImportUtils.getValue(cell3);
								story.setUnitId(unitId);
								story.setStoryNum(storyNum);
								story = storyDao.getStorysByUnitIdAndStoryNmu(story);
								
								if(story == null || story.getId() == 0){
									msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，楼栋信息不存在！");
									continue;
								}else{
									keyDevice.setStoryId(story.getId());
								}
							}
						} else if (deviceType.equals("楼栋")) {
							keyDevice.setDeviceType(KeyDevice.DEVICE_TYPE_STORY);
							if (cell3 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
								String storyNum = DataImportUtils.getValue(cell3);
								story.setUnitId(unitId);
								story.setStoryNum(storyNum);
								
								story = storyDao.getStorysByUnitIdAndStoryNmu(story);
								
								if(story == null || story.getId() == 0){
									msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，楼栋信息不存在！");
									continue;
								}else{
									keyDevice.setStoryId(story.getId());
								}
							} else {
								msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，楼栋信息不能为空！");
								continue;
							}
						} 
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，设备类型 不能为空！");
						continue;
					}

					if (cell4 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell4))) {
						String deviceAddress = DataImportUtils.getValue(cell4);
						KeyDevice keyDeviceTemp = keyDeviceDao.getKeyDeviceByAddress(deviceAddress);
						if(keyDeviceTemp != null && keyDeviceTemp.getId() != 0){
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，该钥匙设备地址已经存在！");
							continue;
						}
						keyDevice.setDeviceAddress(deviceAddress);
					}else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，设备地址不能为空！");
						continue;
					}

					if (cell5 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell5))) {
						String devicePassword = DataImportUtils.getValue(cell5);
						keyDevice.setDevicePassword(devicePassword);

					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，设备密码不能为空！");
						continue;
					}
					try{
						keyDevice.setDeviceUuid(UUID.randomUUID().toString());
						keyDeviceDao.save(keyDevice);
						logger.debug("第" + String.valueOf(rowNum+1)+ " 行导入钥匙数据成功！");
					}catch(Exception e){
						throw new Exception("添加钥匙失败！");
					}
				}
			} else {
				model.put("importMsg", "fail");
				msgList.add("校验导入文档格式失败！，请重新填写！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			msgList.removeAll(msgList);
			msgList.add("导入数据失败！");
		}
		if(msgList.size() == 0){
			msgList.add("导入钥匙数据成功！");
		}
		model.put("msg", msgList);
		
	}

	@Override
	public Map<String, Object> getKeys(Long unitId) {
		List<Map<String, Object>> keyDevices = this.keyDeviceDao.findkeyDevice(unitId, null);
		Map<String, Object> result = new HashMap<String, Object>();
		for(Map<String, Object> keyDevice : keyDevices){
			result.put("unitId", unitId);
			result.put("unitName", keyDevice.remove("unitName"));
			keyDevice.remove("storyId");
			keyDevice.remove("deviceType");
		}
		result.put("keyDevices", keyDevices);
		return result;
	}

	@Override
	public List<Map<String, Object>> findkeyDevice(Long unitId, Long storyId) {
		
		if(unitId == null || storyId == null){
			logger.error("通过小区id和楼栋id获取钥匙信息失败,传入参数错误");
			return null;
		}
		
		List<Long> storyIds = new ArrayList<Long>();
		storyIds.add(storyId);
		
		return this.keyDeviceDao.findkeyDevice(unitId , storyIds);
	}
}
