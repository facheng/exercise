package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.FocusResident;


/**
 * @author yuwei
 * @Time 2015-7-17下午07:28:30
 */
public interface IFocusResidentDao extends Dao<FocusResident, Long> {
	
	/**
	 * 需要关注的业主列表查询 分页
	 * @param mapParams
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getFocusResidentList(Map<String, Object> mapParams, Integer pageNo, Integer pageSize);
	
	/**
	 * 需要关注的业主总数查询
	 * @param mapParams
	 * @return
	 */
	public int getFocusResidentList(Map<String, Object> mapParams);
	
	/**
	 * 获取修改页面回显数据
	 * @param frId
	 * @return
	 */
	public List<Map<String, Object>> getFocusResidentInfo(long hrId);
	
	/**
	 * 根据业主关系查询需要关注的业主
	 * @param hrId
	 * @return
	 */
	public List<FocusResident> getfocusResidentByHrId(long hrId);
	
}
