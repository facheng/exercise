package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.vo.WorkerVo;


/**
 * @author yuwei
 * @Time 2015-7-17下午05:35:13
 */
public interface IWorkerDao extends Dao<Worker, Long> {
	
	/**
	 * 查询系统角色总数
	 * @param unitId
	 * @param userName
	 * @return
	 */
	public int getWorkerCount(Long unitId, WorkerVo worker);
	
	/**
	 * 分页查询系统角色
	 * @param unitId
	 * @param userName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getWorkerList(Long unitId, WorkerVo worker, Integer pageNo, Integer pageSize);
	
	/**
	 * 获取需要修改的的角色信息
	 * jiaosf
	 * @param workId
	 * @return
	 */
	public List<Map<String, Object>> getEditWorker(Long workId);
	
	/**
	 * 手机号码查询保安保修员工
	 * @param phoneNum
	 * @return
	 */
	public Worker getWorkerByPhoneNum(String phoneNum);
	
	/**
	 * 保安保修 登录
	 * @param phoneNum 手机号
	 * @param type 工种 1保安 2保修
	 * @return
	 */
	public Map<String, Object> login(String phoneNum, byte type);
	
	/**
	 * 查询当前小区保修经理
	 * @param unitId
	 * @return
	 */
	public Worker getWorkerManager(Long unitId);
}
