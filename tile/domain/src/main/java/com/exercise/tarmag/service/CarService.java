package com.dt.tarmag.service;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.tarmag.dao.ICarDao;
import com.dt.tarmag.dao.ICarPortDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.Car;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.vo.CarPortVo;
import com.dt.tarmag.vo.CarVo;



/**
 * @author yuwei
 * @Time 2015-7-30下午01:28:34
 */
@Service
public class CarService implements ICarService {
	protected final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private ICarPortDao carPortDao;
	@Autowired
	private IResidentDao residentDao;
	
	@Autowired
	private ICarDao carDao;
	

	@Override
	public int getCarportCount(long unitId, CarPortVo searchVo) {
		return carPortDao.getCarportCount(unitId, searchVo);
	}

	@Override
	public List<Map<String, Object>> getCarportMapList(long unitId, CarPortVo searchVo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<CarPort> carportList = carPortDao.getCarportList(unitId, searchVo, pageNo, pageSize);
		if(carportList == null || carportList.size() <= 0) {
			return mapList;
		}
		
		for(CarPort carport : carportList) {
			Resident resident = residentDao.get(carport.getBindResidentId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("portId", carport.getId());
			map.put("portNo", carport.getPortNo());
			map.put("bindTypeName", carport.getBindTypeName());
			map.put("bindType", carport.getBindType());

			if(resident != null) {
				map.put("residentName", resident.getUserName());
				map.put("idCard", resident.getIdCard());
				map.put("phoneNum", resident.getPhoneNum());
			}
			mapList.add(map);
		}
		return mapList;
	}
	
	@Override
	public Map<String, Object> getCarportDetail(long portId) {
		Map<String, Object> map = new HashMap<String, Object>();
		CarPort carPort = carPortDao.get(portId);
		if(carPort == null) {
			return null;
		}
		
		Resident resident = residentDao.get(carPort.getBindResidentId());

		map.put("portNo", carPort.getPortNo());
		map.put("bindTypeName", carPort.getBindTypeName());
		map.put("bindType", carPort.getBindType());
		
		if(resident != null) {
			map.put("residentName", resident.getUserName());
			map.put("idCard", resident.getIdCard());
			map.put("phoneNum", resident.getPhoneNum());
			map.put("bindTime", carPort.getBindTime() == null ? "" : DateUtil.formatDate(carPort.getBindTime(), DateUtil.PATTERN_DATE1));
		}
		return map;
	}
	
	@Override
	public void updateCarport_tx(long portId, CarPortVo vo) {
		CarPort carPort = carPortDao.get(portId);
		if(vo == null
				|| vo.getPno() == null || vo.getPno().trim().equals("")
				|| carPort == null
				|| carPort.getBindType() != CarPort.BIND_TYPE_RENT) {
			logger.error("只有“已租”状态的车位才能修改");
			return;
		}
		
		carPort.setPortNo(vo.getPno().trim());
		
		/**
		 * 如果改为空置状态
		 **/
		if(vo.getBtype() == CarPort.BIND_TYPE_IDLE) {
			unbindCarport_tx(portId);
		}
		
		/**
		 * 如果改为已售状态
		 **/
		if(vo.getBtype() == CarPort.BIND_TYPE_SOLD) {
			carPort.setBindType(CarPort.BIND_TYPE_SOLD);
			carPort.setBindRentPeriod((byte) 0);
		}
		
		carPortDao.update(carPort);
	}
	
	@Override
	public boolean deleteCarport_tx(long portId) {
		CarPort carPort = carPortDao.get(portId);
		if(carPort == null
				|| carPort.getBindType() != CarPort.BIND_TYPE_IDLE) {
			logger.error("只有“空置”状态的车位才可删除");
			return false;
		}
		
		carPortDao.deleteLogic(portId);
		return true;
	}
	
	@Override
	public boolean unbindCarport_tx(long portId) {
		CarPort carPort = carPortDao.get(portId);
		if(carPort == null
				|| carPort.getBindType() == CarPort.BIND_TYPE_IDLE) {
			logger.error("只有非“空置”状态的车位才可解绑");
			return false;
		}
		
		carPort.setBindType(CarPort.BIND_TYPE_IDLE);
		carPort.setBindResidentId(0);
		carPort.setBindTime(null);
		carPort.setBindRentPeriod((byte) 0);
		carPortDao.update(carPort);
		return true;
	}
	
	@Override
	public Map<String, Object> getCarportToEdit(long portId) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		CarPort carPort = carPortDao.get(portId);
		if(carPort == null) {
			logger.error("车位不存在");
			return map;
		}

		map.put("bindType", carPort.getBindType());
		map.put("bindRentPeriod", carPort.getBindRentPeriod());
		map.put("bindResidentId", carPort.getBindResidentId());
		if(carPort.getBindType() != CarPort.BIND_TYPE_IDLE) {
			
		}
		return map;
	}
	
	@Override
	public boolean bindCarport_tx(long portId, CarPortVo vo) {
		CarPort carPort = carPortDao.get(portId);
		if(carPort == null) {
			logger.error("车位不存在");
			return false;
		}
		
		if(vo == null 
				|| vo.getBtype() == null || (vo.getBtype() != CarPort.BIND_TYPE_SOLD && vo.getBtype() != CarPort.BIND_TYPE_RENT)
				|| (vo.getBtype() == CarPort.BIND_TYPE_RENT && (vo.getRperiod() == null || vo.getRperiod() <= 0))
				|| vo.getResidentId() <= 0) {
			logger.error("资料不完整");
			return false;
		}

		carPort.setBindResidentId(vo.getResidentId());
		carPort.setBindType(vo.getBtype());
		carPort.setBindTime(new Date());
		if(vo.getBtype() == CarPort.BIND_TYPE_RENT) {
			carPort.setBindRentPeriod(vo.getRperiod());
		} else {
			carPort.setBindRentPeriod((byte) 0);
		}
		carPortDao.update(carPort);
		return true;
	}
	
	@Override
	public int getCarCount(long unitId, CarVo searchVo) {
		
		return carDao.getCarCount(unitId, searchVo);
	}

	@Override
	public List<Map<String, Object>> getCarMapList(long unitId, CarVo searchVo, int pageNo, int pageSize) {
		
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Car> carList = carDao.getCarList(unitId, searchVo, pageNo, pageSize);
		if(carList == null || carList.size() <= 0) {
			return mapList;
		}
		
		for(Car car : carList) {
			if(car == null )continue;
			
			//获取业主信息
			Resident resident = residentDao.get(car.getResidentId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("carId", car.getId());
			map.put("plateNo", car.getPlateNo());

			if(resident != null) {
				map.put("residentName", resident.getUserName());
				map.put("idCard", resident.getIdCard());
				map.put("phoneNum", resident.getPhoneNum());
			}
			mapList.add(map);
		}
		
		return mapList;
	}

	@Override
	public Map<String, Object> getCarDetail(long carId) {
		
		Map<String, Object> carMap = new HashMap<String, Object>();
		
		Car car = this.carDao.get(carId);
		if( car == null ){
			logger.warn(  "未查询到id为[" + carId + "]的车辆信息" );
			return carMap ;
		}
		
		carMap.put("carId", car.getId());
		carMap.put("plateNo", car.getPlateNo());
		
		//获取车主信息
		Resident resident = residentDao.get(car.getResidentId());
		
		if(resident == null ){
			logger.warn(  "未查询到车牌号为[" + car.getPlateNo() + "]的车主信息" );
			return carMap ;
		}
		
		carMap.put("residentName", resident.getUserName());
		carMap.put("idCard", resident.getIdCard());
		carMap.put("phoneNum", resident.getPhoneNum());
		
		return carMap;
	}

	@Override
	public void updateCar_tx(Long carId, CarVo vo) {
		
		if(carId == null ){
			logger.error("传入参数车辆ID为空");
			return;
		}
		Car car = carDao.get(carId);
		if(car == null ){
			logger.error("未查询到id为[" + carId + "]的车辆信息");
			return;
		}
		
		if(!checkCarParams(vo)) return;
		
		try{
			
			car.setPlateNo(vo.getPlateNo());
			Long residentId = vo.getResidentId();
			
			if(residentId != null ){
				
				//查询住户信息是否存在,不存在不予修改车辆信息
				Resident resident = residentDao.get(residentId);
				if(resident == null ){
					logger.error("未获取到id为[" + residentId + "]的住户信息");
					return;
				}
				
				car.setResidentId(residentId);
			}
			carDao.update(car);
			
		} catch (Exception e){
			logger.error("更新车牌号为[" + vo.getPlateNo() + "]车辆信息失败" , e);
		}
		return ;
		
	}

	@Override
	public boolean deleteCars_tx(List<Long> carIds) {
		
		if(carIds == null || carIds.size() <= 0){
			return false;
		}
		
		try{
			for(Long carId : carIds){
				carDao.deleteLogic(carId);
			}
		}catch(Exception ex){
			
			logger.error(  "删除车辆信息失败" , ex);
			return false;
		}
		return true;
	}

	@Override
	public boolean createCar_tx(CarVo vo) {
		
		if( !checkCarParams(vo) ){
			return false;
		}
		
		//车牌号不可重复
		if(carDao.getCarByPlateNo(vo.getPlateNo()) != null ){
			logger.error("车牌号重复");
			return false;
		}
		
		Car car = new Car();
		//参数赋值
		BeanUtils.copyProperties(vo, car);
		
		try{ 
			
			this.carDao.save(car);
			logger.info("新增车牌号" + vo.getPlateNo() + "为车辆信息");
		}catch(Exception ex) {
			
			logger.error("新增车牌号" + vo.getPlateNo() + "为车辆信息失败" , ex);
			return false;
		}
		return true;
	}
	
	//参数校验
	private boolean checkCarParams(CarVo vo){
		
		if( vo == null ){
			logger.error("传入车辆信息为空");
			return false;
		}
		
		if( vo.getPlateNo() == null || "".equals(vo.getPlateNo().trim()) ){
			logger.error("传入车牌号错误");
			return false;
		}
		
		return true;
	}

	@Override
	public boolean checkCarIsExist(String plateNo) {
		if(plateNo == null || "".equals(plateNo.trim()) ){
			return false;
		}
		if(carDao.getCarByPlateNo(plateNo) != null ){
			logger.error("车牌号重复");
			return true;
		}
		return false;
	}
	
}
