package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.vo.CarPortVo;
import com.dt.tarmag.vo.CarVo;



/**
 * @author yuwei
 * @Time 2015-7-30下午01:28:06
 */
public interface ICarService {
	
	/**
	 * 查询车位个数
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	int getCarportCount(long unitId, CarPortVo searchVo);
	/**
	 * 查询车位
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getCarportMapList(long unitId, CarPortVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 查询车位详情
	 * @param portId
	 * @return
	 */
	Map<String, Object> getCarportDetail(long portId);
	
	/**
	 * 修改车位信息
	 * 只有“已租”状态的车位才能修改
	 * @param portId
	 * @param vo
	 */
	void updateCarport_tx(long portId, CarPortVo vo);
	
	/**
	 * 删除车位，只有“空置”状态的车位才可删除
	 * @param portId
	 */
	boolean deleteCarport_tx(long portId);
	
	/**
	 * 车位解绑，只有非“空置”状态的车位才可解绑
	 * @param portId
	 * @return
	 */
	boolean unbindCarport_tx(long portId);
	
	/**
	 * 获取车位信息进行绑定
	 * @param portId
	 * @return
	 */
	Map<String, Object> getCarportToEdit(long portId);
	
	/**
	 * 绑定车位
	 * @param portId
	 * @param vo
	 */
	boolean bindCarport_tx(long portId, CarPortVo vo);
	
	
	/**
	 * 查询车辆个数
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	int getCarCount(long unitId, CarVo searchVo);
	/**
	 * 查询车辆信息
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getCarMapList(long unitId, CarVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 查询车辆详情
	 * @param portId
	 * @return
	 */
	Map<String, Object> getCarDetail(long carId);
	
	/**
	 * 修改车辆信息
	 * @param portId
	 * @param vo
	 */
	void updateCar_tx(Long carId, CarVo vo);
	
	/**
	 * 删除车辆
	 * @param portId
	 */
	boolean deleteCars_tx(List<Long> carIds);
	
	/**
	 * 添加单条车辆信息
	 * @param vo
	 */
	boolean createCar_tx( CarVo vo );
	
	/**
	 * 判断车牌号是否已存在
	 * @param plateNo
	 */
	boolean checkCarIsExist( String plateNo );
	
}