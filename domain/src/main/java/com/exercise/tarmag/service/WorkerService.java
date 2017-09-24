package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.MathUtil;
import com.dt.framework.util.SecurityUtil;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.dao.IWorkTypeDao;
import com.dt.tarmag.dao.IWorkerDao;
import com.dt.tarmag.dao.IWorkerTypePartitionDao;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.model.WorkerTypePartition;
import com.dt.tarmag.vo.UnitPartitionVo;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.WorkerVo;

@Service
public class WorkerService implements IWorkerService {

	@Autowired
	private IWorkerDao workerDao;

	@Autowired
	private IWorkTypeDao workTypeDao;

	@Autowired
	private IWorkerTypePartitionDao workerTypePartitionDao;
	
	@Autowired
	private IUnitPartitionDao unitPartitionDao;

	@Autowired
	private IRedisDao redisDao;

	@Override
	public int getWorkerCount(Long unitId, WorkerVo worker) {
		return workerDao.getWorkerCount(unitId, worker);
	}

	@Override
	public List<Map<String, Object>> getWorkerList(Long unitId , WorkerVo worker ,Integer pageNo,
			Integer pageSize) {
		return workerDao.getWorkerList(unitId, worker, pageNo, pageSize);
	}

	@Override
	public void saveOrUpdate_tx(WorkerVo worker ,Long unitId) throws Exception {
		try {
			if (worker.getId() == null || worker.getId() <= 0) {
				Worker work = new Worker();
				work.setUserName(worker.getUserName());
				work.setPhoneNum(worker.getPhoneNum());
				work.setIdCard(worker.getIdCard());
				if (StringUtils.isNotBlank(worker.getBirthday())) {
					work.setBirthday(DateUtil.parseDate(worker.getBirthday(),DateUtil.PATTERN_DATE1));
				}
				if (StringUtils.isNotBlank(worker.getEntryDate())) {
					work.setEntryDate(DateUtil.parseDate(worker.getEntryDate(),DateUtil.PATTERN_DATE1));
				}
				if (StringUtils.isNotBlank(worker.getPassword())) {
					work.setPassword(SecurityUtil.getMD5(worker.getPassword()));
				}else{
					//设置默认密码为 手机号码后六位
					String password = worker.getPhoneNum().substring(5, 11);
					work.setPassword(SecurityUtil.getMD5(password));
				}
				
				workerDao.save(work);
				Long pIds[] = worker.getPartitionIds();
				for (int i = 0; i < pIds.length; i++) {
					WorkerTypePartition wtp = new WorkerTypePartition();
					wtp.setWorkerId(work.getId());
					wtp.setWtypeId(worker.getWtId());
					wtp.setPartitionId(pIds[i]);
					workerTypePartitionDao.save(wtp);
				}
				
			} else {
				Worker workTemp = workerDao.get(worker.getId());
				workTemp.setUserName(worker.getUserName());
				workTemp.setPhoneNum(worker.getPhoneNum());
				workTemp.setIdCard(worker.getIdCard());

				if (StringUtils.isNotBlank(worker.getBirthday())) {
					workTemp.setBirthday(DateUtil.parseDate(
							worker.getBirthday(), DateUtil.PATTERN_DATE1));
				}
				if (StringUtils.isNotBlank(worker.getEntryDate())) {
					workTemp.setEntryDate(DateUtil.parseDate(
							worker.getEntryDate(), DateUtil.PATTERN_DATE1));
				}
				if (StringUtils.isNotBlank(worker.getPassword())) {
					workTemp.setPassword(SecurityUtil.getMD5(worker.getPassword()));
				}

				workerDao.update(workTemp);
				
				//清空所有关系
				workerTypePartitionDao.deleteAllWorkerTypePartitionByWokerId(worker.getId());
				
				Long pIds[] = worker.getPartitionIds();
				
				for (int i = 0; i < pIds.length; i++) {
					WorkerTypePartition wtpNew = new WorkerTypePartition();
					wtpNew.setWorkerId(worker.getId());
					wtpNew.setWtypeId(worker.getWtId());
					wtpNew.setPartitionId(pIds[i]);
					workerTypePartitionDao.save(wtpNew);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("添加角色失败！");
		}

	}

	@Override
	public WorkerVo getEditWorker(Long workId, Long unitId) throws Exception {
		WorkerVo workVo = new WorkerVo();
		try {
			Worker work = workerDao.get(workId);
			if (work != null) {
				workVo.setId(workId);
				workVo.setUserName(work.getUserName());
				workVo.setPhoneNum(work.getPhoneNum());
				workVo.setIdCard(work.getIdCard());
				if (work.getBirthday() != null) {
					workVo.setBirthday(DateUtil.formatDate(work.getBirthday(),
							DateUtil.PATTERN_DATE1));
				}
				if (work.getEntryDate() != null) {
					workVo.setEntryDate(DateUtil.formatDate(
							work.getEntryDate(), DateUtil.PATTERN_DATE1));
				}
			}

			List<WorkerTypePartition> workerTypePartitions = workerTypePartitionDao.getWorkTypeByWorkId(workId, unitId);

			WorkType wt = workTypeDao.get(workerTypePartitions.get(0).getWtypeId());

			workVo.setWtId(wt.getId());
			workVo.setWtName(wt.getName());
			workVo.setWtType(wt.getType());
			return workVo;
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception("获取帐号信息失败！");
		}

	}

	@Override
	public void deleteWorker_tx(List<Long> idList) {
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long frId : idList) {
			Worker worker = workerDao.get(frId);
			if (worker == null
					|| worker.getDeleted() == Constant.MODEL_DELETED_Y) {
				continue;
			}
			worker.setDeleted(Constant.MODEL_DELETED_Y);
			workerDao.update(worker);
		}

	}

	@Override
	public Worker getWorkerByPhoneNum(String phoneNum) {
		return workerDao.getWorkerByPhoneNum(phoneNum);
	}

	@Override
	public List<UnitPartitionVo> getUnitPartitionListByUnitId(Long workId, Long unitId) {
		List<UnitPartitionVo> resultList = new ArrayList<UnitPartitionVo>();
		List<UnitPartition> ups = unitPartitionDao.getUnitPartitionListByUnitId(unitId);
		
		if(workId == null || workId <= 0){
			for (UnitPartition unitPartition : ups) {
				UnitPartitionVo upVo = new UnitPartitionVo();
				
				upVo.setId(unitPartition.getId());
				upVo.setPartitionName(unitPartition.getPartitionName());
				upVo.setAliasName(unitPartition.getAliasName());
				
				resultList.add(upVo);
			}
			
			return resultList;
		}
		
		List<WorkerTypePartition> workerTypePartitions = workerTypePartitionDao.getWorkTypeByWorkId(workId ,unitId);
		
		for (UnitPartition unitPartition : ups) {
			UnitPartitionVo upVo = new UnitPartitionVo();
			
			upVo.setId(unitPartition.getId());
			upVo.setPartitionName(unitPartition.getPartitionName());
			upVo.setAliasName(unitPartition.getAliasName());
			
			for (WorkerTypePartition workerTypePartition : workerTypePartitions) {
				if(workerTypePartition.getPartitionId() == unitPartition.getId()){
					upVo.setIsChecked(1);
					continue;
				}
			}
			if(upVo.getIsChecked() == null || upVo.getIsChecked() <= 0){
				upVo.setIsChecked(0);
			}
			resultList.add(upVo);
		}
		return resultList;
	}

	@Override
	public MsgResponse login_tx(String phoneNum, String password, String tokenId, byte workerType) {
		MsgResponse response = null;
		if (StringUtils.isBlank(phoneNum)) {
			response = new Fail(MsgKey._000000010);
		} else {
			Map<String, Object> login = this.workerDao.login(phoneNum,workerType);
			if (login == null) {
				response = new Fail(MsgKey._000000010);
			} else {
				Worker worker = this.getWorkerByPhoneNum(phoneNum);
				//如果密码错误返回用户名或密码错误
				if(StringUtils.isBlank(tokenId) && !worker.getPassword().equals(SecurityUtil.getMD5(password))){
					response = new Fail(MsgKey._000000010);
				}else if(StringUtils.isBlank(tokenId) && StringUtils.isNotBlank(tokenId) && !tokenId.equals((String)login.get("tokenId"))){//令牌失效
					response = new Fail(MsgKey._000000004);
				}else{//登录成功
					if(StringUtils.isNotBlank(tokenId)){ //如果存在 则退出 防止多个相同账号同时在线
						this.logout(tokenId);
					}
					tokenId = MathUtil.generateToken();
					// 登录信息放置到缓存 令牌信息放置到缓存
					Map<String, Object> loginInfo = new HashMap<String, Object>();
					loginInfo.put(Constant.CACHE_USER_ID, worker.getId());
					loginInfo.put(Constant.CACHE_USER, worker);
					this.redisDao.save("login_" + tokenId, loginInfo, 3,
							TimeUnit.DAYS);
					worker.setTokenId(tokenId);
					this.workerDao.update(worker);
	
					response = new Success("tokenId", tokenId);
					response.put("unit.unitId", login.remove("unitId"));
					response.put("unit.unitName", login.remove("unitName"));
					response.put("user", login);
				}
			}
		}
		return response;
	}

	@Override
	public void logout(String tokenId){
		this.redisDao.delete("login_" + tokenId);
	}

	@Override
	public Worker getWorkerManager(Long unitId) {
		
		return this.workerDao.getWorkerManager(unitId);
	}
}
