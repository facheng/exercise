package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.web.vo.MsgResponse;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.vo.UnitPartitionVo;
import com.dt.tarmag.vo.WorkerVo;


/**
 * 
 * 系统角色设置 SERVICE
 * @author jiaosf
 * @since 2015-7-22
 */
public interface IWorkerService {
	
	/**
	 * 查询系统角色总数
	 * @param unitId
	 * @param userName
	 * @return
	 */
	public int getWorkerCount(Long unitId ,WorkerVo worker);
	
	/**
	 * 分页查询系统角色
	 * @param unitId
	 * @param userName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getWorkerList(Long unitId ,WorkerVo  worker, Integer pageNo, Integer pageSize);
	
	/**
	 * 添加或者修改保安保修员工
	 * @param worker
	 * @throws Exception 
	 */
	public void saveOrUpdate_tx(WorkerVo worker , Long unitId) throws Exception;
	
	/**
	 * 获取需要修改的角色信息
	 * @param workId
	 * @return
	 * @throws Exception 
	 */
	public WorkerVo getEditWorker(Long workId ,Long unitId) throws Exception;
	
	/**
	 * 删除角色信息
	 * @param idList
	 */
	public void deleteWorker_tx(List<Long> idList);
	
	/**
	 * 校验保安保修员工手机号码
	 * @param workerId
	 * @param phoneNum
	 * @return
	 */
	public Worker getWorkerByPhoneNum(String phoneNum);
	

	/**
	 * 获取当期小区下的期数
	 * @param workId
	 * @param unitId
	 * @return
	 */
	public List<UnitPartitionVo> getUnitPartitionListByUnitId(Long workId, Long unitId);
	

	/**保安保修登录
	 * @param phoneNum 手机号
	 * @param password 密码
	 * @return
	 */
	public MsgResponse login_tx(String phoneNum, String password, String tokenId, byte workerType);


	/**
	 * 保安登出
	 * @param tokenId
	 */
	void logout(String tokenId);
	
	/**
	 * 获取当前小区保修经理
	 * @param unitId
	 * @return
	 */
	public Worker getWorkerManager(Long unitId);
}
