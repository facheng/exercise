/**
 * 
 */
package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.BeanUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.ICompanyBranchDao;
import com.dt.tarmag.dao.ICompanyDao;
import com.dt.tarmag.dao.ICustomerRoleUnitDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.model.CustomerRoleUnit;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.UnitVo;

/**
 * @author raymond
 *
 */
@Service
public class UnitService implements IUnitService {
	
	private  final Logger logger = LoggerFactory.getLogger(UnitService.class);

	@Autowired
	private IUnitDao unitDao;
	@Autowired
	private ICustomerRoleUnitDao customerRoleUnitDao;
	
	@Autowired
	private ICompanyBranchDao companyBranchDao;
	
	@Autowired
	private ICompanyDao companyDao;
	


	@Override
	public List<Map<String, Object>> getUnits(Long districtId) {
		List<Map<String, Object>> units = new ArrayList<Map<String, Object>>();
		for (Unit unit : this.unitDao.getUnits(Params.getParams().add(
				"districtId", districtId))) {
			units.add(unit.toMap(new String[] { "id", "unitName" }));
		}
		return units;
	}

	@Override
	public List<Map<String, Object>> getUnitListByCustmerId(long customerId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Long> unitIdList = customerRoleUnitDao.getUnitListByCustmerId(customerId);
		if(unitIdList == null || unitIdList.size() <= 0) {
			return mapList;
		}
		
		for(long unitId : unitIdList) {
			Unit unit = unitDao.get(unitId);
			if(unit == null) {
				continue;
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("unitId", unitId);
			map.put("unitName", unit.getUnitName());
			mapList.add(map);
		}
		
		return mapList;
	}

	@Override
	public List<CustomerRoleUnit> getCustomerRoleUnitList(long customerId) {
		return customerRoleUnitDao.getCustomerRoleUnitList(customerId);
	}

	/**
	 * 分页获取获取小区
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findPageUnit(int pageNo, int pageSize, Map<String, Object> params) {
		return unitDao.getPageUnit(pageNo, pageSize, params);
	}

	/**
	 * 获取小区总数
	 * @param params
	 * @return
	 */
	@Override
	public int findCountUnit(Map<String, Object> params) {
		return unitDao.getCountUnit(params);
	}
	
	/**
	 * 
	 * 添加或修改小区
	 * @param unit
	 * @throws Exception 
	 */
	public void saveOrUpdate_tx(UnitVo unitVo ,String storeURL) throws Exception{
		
		try{
			Unit unit = new Unit();
			
			unit.setCode(String.valueOf(System.currentTimeMillis()));
			
			if(StringUtils.isNotBlank(storeURL)){
				unit.setAppBackgroundImg(storeURL);
			}
			
			if(unitVo.getBranchId() != 0){
				CompanyBranch cb = companyBranchDao.get( unitVo.getBranchId());
				unit.setCompanyId(cb.getCompanyId());
			}
			
			double  longitude = unitVo.getLongitude() == null ? 0 : unitVo.getLongitude();
			double lantitude = unitVo.getLantitude() == null ? 0 : unitVo.getLantitude();
			
			unit.setUnitName(unitVo.getUnitName());
			unit.setLongitude(longitude);
			unit.setLantitude(lantitude);
			unit.setBranchId(unitVo.getBranchId());
			unit.setDistrictId(unitVo.getDistrictId());
			unit.setAddress(unitVo.getAddress());
			unit.setRemark(unitVo.getRemark());
			
			if(unitVo.getId() != 0){
				
				Unit unitTemp = unitDao.get(unitVo.getId());
				BeanUtil.copyProperty(unit, unitTemp, true);
				unitTemp.setLongitude(longitude);
				unitTemp.setLantitude(lantitude);
				unitDao.update(unitTemp);
				
			}else{
				unitDao.save(unit);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("添加更新小区失败！");
		}
	}

	/**
	 * 删除小区
	 * @param unit
	 */
	@Override
	public void delUnit_tx(Unit unit) {
		if(unit.getId() != 0){
			Unit unitTemp = unitDao.get(unit.getId());
			unitTemp.setDeleted(Constant.MODEL_DELETED_Y);
			unitDao.update(unitTemp);
			logger.info("删除" + unit.getId() + "成功");
		}
	}

	/**
	 *根据 id 获取小区
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findUnitById(Map<String, Object> params) {
		return unitDao.getUnitById(params);
	}
	
	@Override
	public List<Map<String, Object>> getUnitListByBranchId(long branchId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		CompanyBranch branch = companyBranchDao.get(branchId);
		if(branch == null) {
			return mapList;
		}
		
		List<Unit> unitList = unitDao.getUnitsByBranchId(branchId, branch.getCompanyId());
		if(unitList == null || unitList.size() <= 0) {
			return mapList;
		}
		
		for(Unit unit : unitList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", unit.getId());
			map.put("name", unit.getUnitName());
			mapList.add(map);
		}
		
		return mapList;
	}
	
	@Override
	public Unit getUnitById(long unitId) {
		return unitDao.get(unitId);
	}

	@Override
	public Map<String, Object> findUnitInfoById(Long unitId) {
		
		Map<String ,Object> map = new HashMap<String, Object>();
		
		Unit unit = unitDao.get(unitId);
		Company company = companyDao.get(unit.getCompanyId());
		CompanyBranch companyBranch = companyBranchDao.get(unit.getBranchId());
		
		map.put("unitName", unit.getUnitName());
		map.put("address", unit.getAddress());
		map.put("lantitude", unit.getLantitude());
		map.put("longitude", unit.getLongitude());
		map.put("remark", unit.getRemark());
		
		map.put("company", company.getCompanyName());
		map.put("branch", companyBranch.getBranchName());
		
		return map;
		
	}

}
