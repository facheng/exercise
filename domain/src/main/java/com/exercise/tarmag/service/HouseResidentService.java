/**
 * 
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IHouseResidentDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ResidentVo;

/**
 * @author raymond
 *
 */
@Service
public class HouseResidentService implements IHouseResidentService {

	@Autowired
	private IRedisDao redisDao;
	@Autowired
	private IResidentDao residentDao;
	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IHouseResidentDao houseResidentDao;
	

	@SuppressWarnings("unchecked")
	protected Long getResidentId(String tokenId) {
		return (Long) ((Map<String, Object>) this.redisDao.get("login_"
				+ tokenId)).get(Constant.CACHE_USER_ID);
	}
	
	
	@Override
	public HouseResident getHouseResidentById(long houseResidentId) {
		return houseResidentDao.get(houseResidentId);
	}

	@Override
	public List<Map<String, Object>> getBindHouses(String tokenId) {
		return this.houseResidentDao.getBindHouses(this.getResidentId(tokenId));
	}

	@Override
	public void addBindHouse_tx(String tokenId, Long houseId, byte type,
			int isDefault) {
		Long residentId = this.getResidentId(tokenId);
		HouseResident houseResidentByHouseId = houseResidentDao.getHouseResident(houseId, residentId);
		if(houseResidentByHouseId == null){//不存在
			HouseResident houseResident = new HouseResident();
			houseResident.setResidentId(residentId);
			houseResident.setIsDefault((byte) isDefault);
			houseResident.setHouseId(houseId);
			houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
			houseResident.setType(type);
			this.houseResidentDao.save(houseResident);
			if(isDefault != 0){
				this.houseResidentDao.changeDefault(houseResident.getId(), isDefault);
			}
		}
		
	}

	@Override
	public void changeDefault_tx(Long id, int isDefault) {
		this.houseResidentDao.changeDefault(id, isDefault);
	}

	@Override
	public void delete_tx(Long id) {
		this.houseResidentDao.deleteLogic(id);
	}

	@Override
	public HouseResident getHouseResident(long houseId, long residentId) {
		return houseResidentDao.getHouseResident(houseId, residentId);
	}

	@Override
	public void bindHouseResident_tx(long houseId, ResidentVo vo) {
		if(vo == null
				|| vo.getResidentName() == null || vo.getResidentName().trim().equals("")
				|| vo.getResidentName() == null || vo.getResidentName().trim().equals("")
				|| !CommonUtil.isMobile(vo.getPhoneNum())){
			return;
		}
		
		/**
		 * 如果指定手机号的住户不存在，先创建这个用户
		 **/
		Resident resident = residentDao.getResidentByPhoneNum(vo.getPhoneNum().trim());
		if(resident == null) {
			resident = new Resident();
			resident.setPhoneNum(vo.getPhoneNum());
			resident.setUserName(vo.getResidentName().trim());
			resident.setIdCard(vo.getIdCard().trim());
			residentDao.save(resident);
		} else {
			resident.setUserName(vo.getResidentName().trim());
			resident.setIdCard(vo.getIdCard().trim());
			residentDao.update(resident);
		}
		
		/**
		 * 绑定房屋住户关系
		 **/
		HouseResident houseResident = houseResidentDao.getHouseResident(houseId, resident.getId());
		if(houseResident == null) {
			houseResident = new HouseResident();
			houseResident.setHouseId(houseId);
			houseResident.setResidentId(resident.getId());
			houseResident.setType(vo.getType());
			houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
			houseResidentDao.save(houseResident);
		} else {
			houseResident.setType(vo.getType());
			houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
			houseResidentDao.update(houseResident);
		}
		
		/**
		 * 更新房屋状态
		 **/
		House house = houseDao.get(houseId);
		changeHouseStatus(houseResident, house);
		houseDao.update(house);
	}
	
	@Override
	public void modifyBindHouseResident_tx(long houseResidentId, ResidentVo vo) {
		if(vo == null
				|| vo.getResidentName() == null || vo.getResidentName().trim().equals("")
				|| vo.getResidentName() == null || vo.getResidentName().trim().equals("")
				|| !CommonUtil.isMobile(vo.getPhoneNum())){
			return;
		}
		
		/**
		 * 如果指定手机号的住户不存在，先创建这个用户
		 **/
		Resident resident = residentDao.getResidentByPhoneNum(vo.getPhoneNum().trim());
		if(resident == null) {
			resident = new Resident();
			resident.setPhoneNum(vo.getPhoneNum());
			resident.setUserName(vo.getResidentName().trim());
			resident.setIdCard(vo.getIdCard().trim());
			residentDao.save(resident);
		} else {
			resident.setUserName(vo.getResidentName().trim());
			resident.setIdCard(vo.getIdCard().trim());
			residentDao.update(resident);
		}
		
		/**
		 * 修改房屋住户绑定关系
		 **/
		HouseResident houseResident = houseResidentDao.get(houseResidentId);
		if(houseResident == null) {
			throw new RuntimeException("该绑定关系(id=" + houseResidentId + ")不存在！");
		} else {
			houseResident.setResidentId(resident.getId());
			houseResident.setType(vo.getType());
			houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
			houseResidentDao.update(houseResident);
		}
		
		/**
		 * 更新房屋状态
		 **/
		House house = houseDao.get(houseResident.getHouseId());
		changeHouseStatus(houseResident, house);
		houseDao.update(house);
	}
	
	/**
	 * 针对一个新的住户调整当前房屋的状态。
	 * @param houseResident
	 * @param house
	 */
	private void changeHouseStatus(HouseResident houseResident, House house){
		/**
		 * 如果当前是自住状态，不需要调整
		 **/
		if(house.getStatus() == House.STATUS_SELF) {
			return;
		}
		
		/**
		 * 如果新住户是业主，房屋状态改为自住
		 **/
		if(houseResident.getType() == HouseResident.TYPE_OWNER
				|| houseResident.getType() == HouseResident.TYPE_FAMILY_MEMBER) {
			house.setStatus(House.STATUS_SELF);
			return;
		}

		/**
		 * 如果新住户租客，房屋状态改为出租
		 **/
		if(houseResident.getType() == HouseResident.TYPE_RENTER) {
			house.setStatus(House.STATUS_RENTING);
			return;
		}
	}


	@Override
	public PageResult<Map<String, Object>> findUsageStatistics(Map<String, Object> params, Page page) {
		List<Map<String , Object>> usageStatistics = houseResidentDao.getUsageStatistics(params , page);
		int count = houseResidentDao.getUsageStatisticsCount(params);
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, usageStatistics);
	}
}
