package com.dt.tarmag.dao;



import java.util.List;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.vo.CarPortVo;


/**
 * @author yuwei
 * @Time 2015-7-30下午01:26:21
 */
public interface ICarPortDao extends Dao<CarPort, Long> {
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
	List<CarPort> getCarportList(long unitId, CarPortVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 通过车库ID和车位名称查询车位
	 * @param garageId
	 * @param portNo
	 * @return
	 */
	CarPort getCarPortByNameAndGarageId(long garageId, String portNo);
}
