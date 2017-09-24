package com.dt.tarmag.dao;



import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Car;
import com.dt.tarmag.vo.CarVo;


/**
 * @author yuwei
 * @Time 2015-7-30下午01:24:11
 */
public interface ICarDao extends Dao<Car, Long> {
	
	/**
	 * 
	 *	查询车辆个数
	 * @param unitId 小区id
	 * @param searchVo 查询条件
	 */
	public int getCarCount(long unitId, CarVo searchVo);
	
	/**
	 * 
	 * 查询车辆信息
	 * @param unitId 小区id
	 * @param searchVo 查询条件
	 * @param pageNo 
	 * @param pageSize
	 * @return
	 */
	public List<Car> getCarList(long unitId, CarVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 
	 * 通过车牌号查询车辆信息
	 * @param unitId 小区id
	 * @param searchVo 查询条件
	 * @param pageNo 
	 * @param pageSize
	 * @return
	 */
	public Car getCarByPlateNo(String plateNo);
	
	
}
