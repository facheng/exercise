package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;



import com.dt.tarmag.vo.InoutSearchVo;

public interface IInOutService {

	void save_tx(Long keyDeviceId,Long residentId,int clickTimes, Long unitId);
	
	/**
	 * 查询出入记录条数
	 * @param unitId
	 * @param searchVo
	 * @return
	 */
	int getInoutPasserbyCount(long unitId, InoutSearchVo searchVo);
	
	/**
	 * 查询出入记录
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getInoutPasserbyList(long unitId, InoutSearchVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 行人出入记录统计
	 * @param unitId
	 * @param searchVo
	 * @return
	 * @throws Exception 
	 */
	public void getInoutPasserbyStatistics(Long unitId, Byte timeType ,ModelMap model) throws Exception;
}
