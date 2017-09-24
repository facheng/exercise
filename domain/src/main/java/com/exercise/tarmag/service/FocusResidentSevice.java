package com.dt.tarmag.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IFocusResidentDao;
import com.dt.tarmag.model.FocusResident;
import com.dt.tarmag.vo.FocusResidentVo;

/**
 * 需要关注的业主Srvice
 * @author jiaosf
 * @since 2015-7-17
 */
@Service
public class FocusResidentSevice implements IFocusResidentServie {
	
	@Autowired
	private IFocusResidentDao focusResidentDao;
	
	@Override
	public int getFocusResidentCount(Long unitId, String roomNum ,Byte residentStatus) {
		Map<String, Object> mapParams = new HashMap<String, Object>();
		mapParams.put("unitId", unitId);
		
		if (StringUtils.isNotBlank(roomNum)) {
			mapParams.put("roomNum", roomNum);
		}
		
		if (residentStatus != null) {
			mapParams.put("residentStatus", residentStatus);
		}
		
		return focusResidentDao.getFocusResidentList(mapParams);
	}

	@Override
	public List<Map<String, Object>> getFocusResidentList(Long unitId, String roomNum, Byte residentStatus, Integer pageNo, Integer pageSize) {
		Map<String, Object> mapParams = new HashMap<String, Object>();
		mapParams.put("unitId", unitId);
		if (StringUtils.isNotBlank(roomNum)) {
			mapParams.put("roomNum", roomNum);
		}
		
		if (residentStatus != null) {
			mapParams.put("residentStatus", residentStatus);
		}

		List<Map<String, Object>> resultList = focusResidentDao.getFocusResidentList(mapParams, pageNo, pageSize);

		return resultList;
	}

	@Override
	public FocusResidentVo getFocusResidentInfo(long frId) {
		
		FocusResident fr = focusResidentDao.get(frId);
		
		List<Map<String, Object>> mapList = focusResidentDao.getFocusResidentInfo(fr.getHrId());
		
		FocusResidentVo frV = new FocusResidentVo();
		
		frV.setId(fr.getHrId());
		frV.setHrId(fr.getHrId());
		frV.setResidentStatus(fr.getResidentStatus());
		frV.setRemark(fr.getRemark());
		if(mapList.size() > 0){
			for (Map<String, Object> map : mapList) {
				if(map.get("partitionId") != null){
					String partitionId = map.get("partitionId").toString();
					frV.setPartitionId(Long.valueOf(partitionId));
				}
				
				if(map.get("storyId") != null){
					String storyId = map.get("storyId").toString();
					frV.setStoryId(Long.valueOf(storyId));
				}
				
				if(map.get("houseId") != null){
					String houseId = map.get("houseId").toString();
					frV.setHouseId(Long.valueOf(houseId));
				}
			}
		}
		
		return frV;
	}

	@Override
	public void saveOrUpdate_tx(FocusResidentVo focusResidentVo) throws Exception {
		try{
			if(focusResidentVo.getId() != null && focusResidentVo.getId() == 0){
				FocusResident fr = new FocusResident();
				fr.setHrId(focusResidentVo.getHrId());
				fr.setResidentStatus(focusResidentVo.getResidentStatus());
				fr.setRemark(focusResidentVo.getRemark());
				focusResidentDao.save(fr);
			}else if(focusResidentVo.getId() != null && focusResidentVo.getId() != 0){
				FocusResident fr = focusResidentDao.get(focusResidentVo.getId());
				fr.setHrId(focusResidentVo.getHrId());
				fr.setResidentStatus(focusResidentVo.getResidentStatus());
				fr.setRemark(focusResidentVo.getRemark());
				focusResidentDao.update(fr);
			}
			}catch(Exception e){
				e.printStackTrace();
				throw new Exception("添加修改需要关注的业主失败！");
			}
	}

	@Override
	public void removeFocusResident_tx(List<Long> idList) {
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long frId : idList) {
			FocusResident focusResident = focusResidentDao.get(frId);
			if (focusResident == null
					|| focusResident.getDeleted() == Constant.MODEL_DELETED_Y) {
				continue;
			}
			focusResident.setDeleted(Constant.MODEL_DELETED_Y);
			focusResidentDao.update(focusResident);
		}
		
	}

	@Override
	public List<FocusResident> getfocusResidentByHrId(long hrId) {
		
		List<FocusResident> result = focusResidentDao.getfocusResidentByHrId(hrId);
		
		return result;
	}

}
