package com.dt.tarmag.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.ImgUploadUtil;
import com.dt.tarmag.Constants;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IRepairDao;
import com.dt.tarmag.dao.IRepairPictureDao;
import com.dt.tarmag.dao.IRepairProgressDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.dao.IStoryDao;
import com.dt.tarmag.dao.IWorkTypeDao;
import com.dt.tarmag.dao.IWorkerDao;
import com.dt.tarmag.dao.IWorkerTypePartitionDao;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.Repair;
import com.dt.tarmag.model.RepairPicture;
import com.dt.tarmag.model.RepairProgress;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.model.Worker;
import com.dt.tarmag.model.WorkerTypePartition;
import com.dt.tarmag.vo.RepairSearchVo;
import com.dt.tarmag.vo.RepairVo;

/**
 * @author yuwei
 * @Time 2015-7-21上午10:41:47
 */
@Service
public class RepairService implements IRepairService {
	private final static Logger logger = Logger.getLogger(RepairService.class);

	@Autowired
	private IWorkTypeDao workTypeDao;
	@Autowired
	private IRepairDao repairDao;
	@Autowired
	private IRepairPictureDao repairPictureDao;
	@Autowired
	private IWorkerTypePartitionDao workerTypePartitionDao;
	@Autowired
	private IWorkerDao workerDao;
	@Autowired
	private IStoryDao storyDao;
	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IRepairProgressDao repairProgressDao;
	@Autowired
	private IResidentDao residentDao;

	@Override
	public List<WorkType> getWorkTypeByType(byte type) {
		return workTypeDao.getWorkTypeByType(type);
	}

	@Override
	public void createNewRepair_tx(RepairVo vo) {
		if (vo == null || vo.getRepairType() <= 0 || vo.getHouseId() <= 0
				|| vo.getServiceType() <= 0 || vo.getResidentName() == null
				|| vo.getResidentName().trim().equals("")
				|| !CommonUtil.isMobile(vo.getPhoneNum())
				|| vo.getAddress() == null || vo.getAddress().trim().equals("")
				|| vo.getUrgentState() < 0 || vo.getWorkTypeId() <= 0) {
			logger.error("参数错误");
			throw new RuntimeException("参数错误");
		}

		Date orderTime = null;
		try {
			orderTime = DateUtil.parseDate(vo.getOrderTime(),
					DateUtil.PATTERN_DATE_TIME2);
		} catch (Exception e) {
			logger.error("参数错误    " + e.getLocalizedMessage());
			throw new RuntimeException("参数错误    " + e.getLocalizedMessage());
		}

		/**
		 * 保存报修主体信息
		 **/
		Repair repair = new Repair();
		repair.setUnitId(vo.getUnitId());
		repair.setHouseId(vo.getHouseId());
		repair.setRepairType(vo.getRepairType());
		repair.setServiceType(vo.getServiceType());
		repair.setResidentId(vo.getResidentId());
		repair.setResidentName(vo.getResidentName().trim());
		repair.setPhoneNum(vo.getPhoneNum().trim());
		repair.setOrderTime(orderTime);
		repair.setIsPublic(vo.getIsPublic());
		repair.setAddress(vo.getAddress().trim());
		repair.setRemark(vo.getRemark() == null ? null : vo.getRemark().trim());
		repair.setUrgentState(vo.getUrgentState());
		repair.setWorkTypeId(vo.getWorkTypeId());
		repair.setWorkerId(vo.getWorkerId());
		repair.setStatus(vo.getWorkerId() > 0 ? Repair.STATUS_ASSIGNED
				: Repair.STATUS_NOT_ASSIGNED);
		repairDao.save(repair);

		/**
		 * 初始化报修进度
		 **/
		Worker worker = workerDao.get(repair.getWorkerId());
		RepairProgress rp = new RepairProgress();
		rp.setRepairId(repair.getId());
		rp.setWorkerId(repair.getWorkerId());
		rp.setWorkerName(worker == null ? "" : worker.getUserName());
		rp.setPhoneNum(worker == null ? "" : worker.getPhoneNum());
		rp.setStatus(repair.getStatus());
		rp.setCreateDateTime(new Date());
		rp.setDeleted(Constant.MODEL_DELETED_N);
		if (repair.getWorkerId() > 0) {
			rp.setRemark("报修申请已分派至维修人员" + rp.getWorkerName() + "   联系电话："
					+ rp.getPhoneNum());
		}
		repairProgressDao.save(rp);
	}

	@Override
	public Map<String, Object> getRepairToEdit(long repairId) {
		Repair repair = repairDao.get(repairId);
		if (repair == null
				|| (repair.getStatus() != Repair.STATUS_NOT_ASSIGNED
						&& repair.getStatus() != Repair.STATUS_ASSIGNED && repair
						.getStatus() != Repair.STATUS_REJECT)) {
			return null;
		}

		Worker worker = workerDao.get(repair.getWorkerId());
		House house = houseDao.get(repair.getHouseId());
		List<House> houseList = houseDao.getHouseListByStoryId(house
				.getStoryId());
		Story story = storyDao.get(house.getStoryId());
		List<Story> storyList = storyDao.getStoryListByPartitionId(story
				.getPartitionId());
		List<Map<String, Object>> workerList = getWorkerListByPartitionIdAndWtypeId(
				story.getPartitionId(), repair.getWorkTypeId());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("houseList", houseList);
		map.put("houseId", repair.getHouseId());
		map.put("repairType", repair.getRepairType());
		map.put("serviceType", repair.getServiceType());
		map.put("residentId", repair.getResidentId());
		map.put("residentName", repair.getResidentName());
		map.put("phoneNum", repair.getPhoneNum());
		map.put("orderTime", DateUtil.formatDate(repair.getOrderTime(),
				DateUtil.PATTERN_DATE_TIME2));
		map.put("isPublic", repair.getIsPublic());
		map.put("address", repair.getAddress());
		map.put("remark", repair.getRemark());
		map.put("urgentState", repair.getUrgentState());
		map.put("workTypeId", repair.getWorkTypeId());
		map.put("workerId", repair.getWorkerId());
		map.put("workerName", worker == null ? "" : worker.getUserName());
		map.put("workerList", workerList);
		map.put("status", repair.getStatus());
		map.put("storyList", storyList);
		map.put("storyId", house.getStoryId());
		map.put("partitionId", story.getPartitionId());
		return map;
	}

	@Override
	public void updateRepair_tx(long repairId, RepairVo vo) {
		if (repairId <= 0) {
			logger.error("repairId不能为空");
			throw new RuntimeException("repairId不能为空");
		}
		if (vo == null || vo.getRepairType() <= 0 || vo.getHouseId() <= 0
				|| vo.getServiceType() <= 0 || vo.getResidentName() == null
				|| vo.getResidentName().trim().equals("")
				|| !CommonUtil.isMobile(vo.getPhoneNum())
				|| vo.getAddress() == null || vo.getAddress().trim().equals("")
				|| vo.getUrgentState() < 0 || vo.getWorkTypeId() <= 0) {
			logger.error("参数错误");
			throw new RuntimeException("参数错误");
		}

		Date orderTime = null;
		try {
			orderTime = DateUtil.parseDate(vo.getOrderTime(),
					DateUtil.PATTERN_DATE_TIME2);
		} catch (Exception e) {
			logger.error("参数错误    " + e.getLocalizedMessage());
			throw new RuntimeException("参数错误    " + e.getLocalizedMessage());
		}

		Repair repair = repairDao.get(repairId);
		if (repair == null) {
			logger.error("报修信息(repairId=" + repairId + ")不存在");
			throw new RuntimeException("资料(repairId=" + repairId + ")不存在");
		}
		if (repair.getStatus() != Repair.STATUS_NOT_ASSIGNED
				&& repair.getStatus() != Repair.STATUS_ASSIGNED
				&& repair.getStatus() != Repair.STATUS_REJECT) {
			logger.error("只有“待分派 ”、“已分派待接受 ”和“已拒绝”状态的报修才能修改");
			throw new RuntimeException("只有“待分派 ”、“已分派待接受 ”和“已拒绝”状态的报修才能修改");
		}

		/**
		 * 保存报修主体信息
		 **/
		repair.setHouseId(vo.getHouseId());
		repair.setRepairType(vo.getRepairType());
		repair.setServiceType(vo.getServiceType());
		repair.setResidentId(vo.getResidentId());
		repair.setResidentName(vo.getResidentName().trim());
		repair.setPhoneNum(vo.getPhoneNum().trim());
		repair.setOrderTime(orderTime);
		repair.setIsPublic(vo.getIsPublic());
		repair.setAddress(vo.getAddress().trim());
		repair.setRemark(vo.getRemark() == null ? null : vo.getRemark().trim());
		repair.setUrgentState(vo.getUrgentState());
		repair.setWorkTypeId(vo.getWorkTypeId());
		repair.setWorkerId(vo.getWorkerId());
		if (vo.getWorkerId() > 0) {
			repair.setStatus(Repair.STATUS_ASSIGNED);
		}
		repairDao.update(repair);

		/**
		 * 保存报修进度
		 **/
		Worker worker = workerDao.get(repair.getWorkerId());
		RepairProgress rp = new RepairProgress();
		rp.setRepairId(repair.getId());
		rp.setWorkerId(repair.getWorkerId());
		rp.setWorkerName(worker == null ? "" : worker.getUserName());
		rp.setPhoneNum(worker == null ? "" : worker.getPhoneNum());
		rp.setStatus(repair.getStatus());
		rp.setCreateDateTime(new Date());
		rp.setDeleted(Constant.MODEL_DELETED_N);
		if (repair.getWorkerId() > 0) {
			rp.setRemark("报修申请已分派至维修人员" + rp.getWorkerName() + "   联系电话："
					+ rp.getPhoneNum());
		}
		repairProgressDao.save(rp);
	}

	@Override
	public boolean deleteRepair_tx(long repairId) {
		Repair repair = repairDao.get(repairId);
		if (repair == null) {
			logger.error("报修信息(repairId=" + repairId + ")不存在");
			return false;
		}
		if (repair.getStatus() != Repair.STATUS_NOT_ASSIGNED
				&& repair.getStatus() != Repair.STATUS_ASSIGNED
				&& repair.getStatus() != Repair.STATUS_REJECT) {
			logger.error("只能删除“待分派 ”、“已分派待接受 ”和“已拒绝”状态的报修");
			return false;
		}

		repairDao.deleteLogic(repairId);
		return true;
	}

	@Override
	public List<Map<String, Object>> getWorkerListByPartitionIdAndWtypeId(
			long partitionId, long wtypeId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<WorkerTypePartition> wtpList = workerTypePartitionDao
				.getWorkerListByPartitionIdAndWtypeId(partitionId, wtypeId);
		if (wtpList == null || wtpList.size() <= 0) {
			return mapList;
		}

		for (WorkerTypePartition wtp : wtpList) {
			Worker worker = workerDao.get(wtp.getWorkerId());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", worker.getId());
			map.put("name", worker.getUserName());
			mapList.add(map);
		}

		return mapList;
	}

	@Override
	public int getUnAssignedRepairRecCount(long unitId, RepairSearchVo searchVo) {
		return repairDao.getRepairCount(unitId, searchVo,
				Repair.getUnAssignedStatusKeys());
	}

	@Override
	public List<Map<String, Object>> getUnAssignedRepairRecList(long unitId,
			RepairSearchVo searchVo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Repair> repairList = repairDao.getRepairList(unitId, searchVo,
				Repair.getUnAssignedStatusKeys(), pageNo, pageSize);

		if (repairList == null || repairList.size() <= 0) {
			return mapList;
		}

		for (Repair repair : repairList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("repairId", repair.getId());
			map.put("addr", CommonUtil.escape(repair.getAddress()));
			map.put("rname", repair.getResidentName());
			map.put("phoneNo", repair.getPhoneNum());
			map.put("remark", CommonUtil.escape(CommonUtil.cutString(
					repair.getRemark(), 20)));
			map.put("repairTypeName", repair.getRepairTypeName());
			map.put("statusName", repair.getStatusName());
			map.put("createTime", DateUtil.formatDate(
					repair.getCreateDateTime(), DateUtil.PATTERN_DATE_TIME2));
			map.put("orderTime", DateUtil.formatDate(repair.getOrderTime(),
					DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}

		return mapList;
	}

	@Override
	public int getAssignedRepairRecCount(long unitId, RepairSearchVo searchVo) {
		return repairDao.getRepairCount(unitId, searchVo,
				Repair.getAssignedStatusKeys());
	}

	@Override
	public List<Map<String, Object>> getAssignedRepairRecList(long unitId,
			RepairSearchVo searchVo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Repair> repairList = repairDao.getRepairList(unitId, searchVo,
				Repair.getAssignedStatusKeys(), pageNo, pageSize);

		if (repairList == null || repairList.size() <= 0) {
			return mapList;
		}

		for (Repair repair : repairList) {
			Worker worker = workerDao.get(repair.getWorkerId());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("repairId", repair.getId());
			map.put("addr", CommonUtil.escape(repair.getAddress()));
			map.put("rname", repair.getResidentName());
			map.put("phoneNo", repair.getPhoneNum());
			map.put("remark", CommonUtil.escape(CommonUtil.cutString(
					repair.getRemark(), 20)));
			map.put("repairTypeName", repair.getRepairTypeName());
			map.put("serviceTypeName", repair.getServiceTypeName());
			map.put("statusName", repair.getStatusName());
			map.put("createTime", DateUtil.formatDate(
					repair.getCreateDateTime(), DateUtil.PATTERN_DATE_TIME2));
			map.put("orderTime", DateUtil.formatDate(repair.getOrderTime(),
					DateUtil.PATTERN_DATE_TIME2));
			map.put("workerName", worker == null ? "" : worker.getUserName());
			map.put("oscore", repair.getOverallScore());
			mapList.add(map);
		}

		return mapList;
	}

	@Override
	public Map<String, Object> getRepairDetail(long repairId,
			String imgAccessUrlPre) {
		Map<String, Object> map = new HashMap<String, Object>();
		Repair repair = repairDao.get(repairId);
		if (repair == null) {
			logger.error("报修信息(repairId=" + repairId + ")不存在");
			return map;
		}

		boolean canAssign = false;
		if (repair.getStatus() == Repair.STATUS_NOT_ASSIGNED
				|| repair.getStatus() == Repair.STATUS_ASSIGNED
				|| repair.getStatus() == Repair.STATUS_REJECT) {
			canAssign = true;
		}

		List<Map<String, Object>> pictures = new ArrayList<Map<String, Object>>();
		List<RepairPicture> pictList = repairPictureDao
				.getPicturesByRepairId(repairId);
		if (pictList != null && pictList.size() > 0) {
			for (RepairPicture pic : pictList) {
				String accessUrl = ImgUploadUtil
						.getAccessURL(imgAccessUrlPre + File.separator
								+ RepairPicture.IMG_PATH, pic.getUrl());

				Map<String, Object> picture = new HashMap<String, Object>();
				picture.put("id", pic.getId());
				picture.put("accessUrl", accessUrl);
				pictures.add(picture);
			}
		}

		List<RepairProgress> rpList = repairProgressDao
				.getRepairProgress(repairId);
		List<Map<String, Object>> progressList = new ArrayList<Map<String, Object>>();
		if (rpList != null && rpList.size() > 0) {
			for (RepairProgress rp : rpList) {
				String accessUrl = "";
				if (rp.getImg() != null && !rp.getImg().equals("")) {
					accessUrl = ImgUploadUtil.getAccessURL(imgAccessUrlPre
							+ File.separator + RepairProgress.IMG_PATH,
							rp.getImg());
				}

				Map<String, Object> progressMap = new HashMap<String, Object>();
				progressMap.put("id", rp.getId());
				progressMap.put("statusName", rp.getStatusName());
				progressMap.put("createDateTimeStr", rp.getCreateDateTimeStr());
				progressMap.put("remark", rp.getRemark());
				progressMap.put("accessUrl", accessUrl);
				progressList.add(progressMap);
			}
		}

		map.put("rname", repair.getResidentName());
		map.put("phoneNo", repair.getPhoneNum());
		map.put("repairTypeName", repair.getRepairTypeName());
		map.put("serviceTypeName", repair.getServiceTypeName());
		map.put("createTime", DateUtil.formatDate(repair.getCreateDateTime(),
				DateUtil.PATTERN_DATE_TIME2));
		map.put("orderTime", DateUtil.formatDate(repair.getOrderTime(),
				DateUtil.PATTERN_DATE_TIME2));
		map.put("addr", CommonUtil.escape(repair.getAddress()));
		map.put("remark", CommonUtil.escape(repair.getRemark()));
		map.put("statusName", repair.getStatusName());
		map.put("canAssign", canAssign ? "1" : "0");
		map.put("pictures", pictures);
		map.put("progressList", progressList);
		map.put("isScored", repair.isScored() ? "1" : "0");
		map.put("scoreResponse", repair.getScoreResponse());
		map.put("scoreDoor", repair.getScoreDoor());
		map.put("scoreService", repair.getScoreService());
		map.put("scoreQuality", repair.getScoreQuality());
		return map;
	}

	@Override
	public void appCreateRepair_tx(RepairVo vo, String[] picPaths) {
		Date orderTime = null;
		try {
			orderTime = DateUtil.parseDate(vo.getOrderTime(),
					DateUtil.PATTERN_DATE_TIME2);
		} catch (Exception e) {
			logger.error("参数错误    " + e.getLocalizedMessage());
			throw new RuntimeException("参数错误    " + e.getLocalizedMessage());
		}

		/**
		 * 保存报修主体信息
		 **/
		Repair repair = new Repair();
		repair.setHouseId(vo.getHouseId());
		repair.setUnitId(vo.getUnitId());
		repair.setRepairType(vo.getRepairType());
		repair.setServiceType(vo.getServiceType());
		repair.setResidentId(vo.getResidentId());
		Resident resident = this.residentDao.get(vo.getResidentId());
		repair.setResidentName(resident.getUserName());
		repair.setPhoneNum(resident.getPhoneNum());
		repair.setOrderTime(orderTime);
		repair.setIsPublic(vo.getIsPublic());
		repair.setAddress(vo.getAddress()==null?StringUtils.EMPTY:vo.getAddress().trim());
		repair.setRemark(vo.getRemark() == null ? null : vo.getRemark().trim());
		repair.setUrgentState(vo.getUrgentState());
		repair.setStatus(Repair.STATUS_NOT_ASSIGNED);
		repairDao.save(repair);

		/**
		 * 初始化报修进度
		 **/
		RepairProgress rp = new RepairProgress();
		rp.setRepairId(repair.getId());
		rp.setWorkerName("");
		rp.setPhoneNum("");
		rp.setStatus(repair.getStatus());
		repairProgressDao.save(rp);

		/**
		 * 报修图片
		 */
		for (String picPath : picPaths) {
			RepairPicture picture = new RepairPicture();
			picture.setRepairId(repair.getId());
			picture.setUrl(picPath);
			this.repairPictureDao.save(picture);
		}
	}

	@Override
	public void score_tx(Long repairId, int responseScore, int doorScore,
			int serviceScore, int qualityScore) {
		Repair repair = this.repairDao.get(repairId);
		repair.setScoreResponse(responseScore);
		repair.setScoreDoor(doorScore);
		repair.setScoreService(serviceScore);
		repair.setScoreQuality(qualityScore);
		repair.setStatus(Repair.STATUS_END);
		this.repairDao.save(repair);
	}

	@Override
	public Map<String, Object> getAppRepairDetail(long repairId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Repair repair = repairDao.get(repairId);
		if (repair == null) {
			logger.error("报修信息(repairId=" + repairId + ")不存在");
			return map;
		}
		map.put("orderTime", DateUtil.formatDate(repair.getOrderTime(),
				DateUtil.PATTERN_DATE_TIME2));
		map.put("statusName", repair.getStatusName());
		return map;
	}

	@Override
	public int getRepairWorkersCount(long unitId, Byte status,
			List<Byte> defaultStatusList, int year, int month) {
		return repairDao.getRepairWorkersCount(unitId, status,
				defaultStatusList, year, month);
	}

	@Override
	public List<Map<String, Object>> getRepairWorkerList(long unitId,
			Byte status, List<Byte> defaultStatusList, int year, int month,
			int pageNo, int pageSize) {
		return repairDao.getRepairWorkerList(unitId, status, defaultStatusList,
				year, month, pageNo, pageSize);
	}

	@Override
	public List<Map<String, Object>> repairs(Long unitId, Long residentId,
			byte status, int pageNo) {
		List<Map<String, Object>> repairs = this.repairDao.repairs(unitId,
				residentId, status, pageNo);
		String basepic = Constants.FILE_ACCESS_URL + "/" + Constants.IMG_URL
				+ "/" + RepairPicture.IMG_PATH + "/";
		for (Map<String, Object> repair : repairs) {
			Long repairId = Long.valueOf(repair.get("repairId").toString());
			List<RepairPicture> pictures = this.repairPictureDao
					.getPicturesByRepairId(repairId);
			List<String> picUrls = new ArrayList<String>();
			for (RepairPicture repairPicture : pictures) {
				if (StringUtils.isNotBlank(repairPicture.getUrl())) {
					picUrls.add(basepic + repairPicture.getUrl()
							+ Constant.IMG_TYPE_JPG);
				}
			}
			Date createDateTime = (Date) repair.get("createDateTime");
			repair.put("createDateTime",
					DateUtil.formatDate(createDateTime, "yyyy-MM-dd HH:mm"));
			repair.put("picUrls", picUrls);
			String headImg = (String) repair.get("headImg");
			if (StringUtils.isNotBlank(headImg)) {
				headImg = StringUtils.isBlank(headImg) ? "" : (ImgUploadUtil
						.getAccessURL(Constants.FILE_ACCESS_URL + "/"
								+ Constants.IMG_URL + "/" + Resident.IMG_PATH,
								headImg));
			} else {
				headImg = "";
			}
			repair.put("headImg", headImg);
			String nickName = (String) repair.get("nickName");
			repair.put("nickName", StringUtils.isBlank(nickName) ? "匿名"
					: nickName);
		}
		return repairs;
	}

	@Override
	public int getRepairStatisticCount(long unitId, long workerId,
			List<Byte> statusList) {
		return repairDao.getRepairStatisticCount(unitId, workerId, statusList);
	}

	@Override
	public List<Map<String, Object>> getRepairStatisticList(long unitId,
			long workerId, List<Byte> statusList, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Repair> rList = repairDao.getRepairStatisticList(unitId, workerId,
				statusList, pageNo, pageSize);
		if (rList == null || rList.size() <= 0) {
			return mapList;
		}

		for (Repair r : rList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("repairId", r.getId());
			map.put("remark", CommonUtil.escape(r.getRemark()));
			map.put("residentName", r.getResidentName());
			map.put("scoreResponse", r.getScoreResponse());
			map.put("scoreDoor", r.getScoreDoor());
			map.put("scoreService", r.getScoreService());
			map.put("scoreQuality", r.getScoreQuality());
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public List<Map<String, Object>> comments(Long repairId) {
		List<Map<String, Object>> comments = this.repairDao.comments(repairId);
		for (Map<String, Object> comment : comments) {
			Date createDateTime = (Date) comment.get("createTime");
			comment.put("createDateTime",
					DateUtil.formatDate(createDateTime, "yyyy-MM-dd HH:mm"));
			String nickName = (String) comment.get("nickName");
			comment.put("nickName", StringUtils.isBlank(nickName) ? "匿名"
					: nickName);
			String headimg = (String) comment.get("headImg");
			headimg = StringUtils.isBlank(headimg) ? "" : (ImgUploadUtil
					.getAccessURL(Constants.FILE_ACCESS_URL + "/"
							+ Constants.IMG_URL + "/" + Resident.IMG_PATH,
							headimg));
			comment.put("headImg", headimg);
		}
		return comments;
	}

	@Override
	public List<Map<String, Object>> repairs(Long workerId, int status,
			int pageNo) {
		List<Map<String, Object>> repairs = this.repairDao.reparis(workerId,
				status, pageNo);
		for (Map<String, Object> repair : repairs) {
			Date createDateTime = (Date) repair.get("createDateTime");
			repair.put("createDateTime",
					DateUtil.formatDate(createDateTime, "yyyy/MM/dd HH:mm:ss"));
		}
		return repairs;
	}

	@Override
	public void oper_tx(Long workerId, Long repairId, int status, String remark) {
		Repair repair = this.repairDao.get(repairId);
		workerId = repair.getWorkerId();
		Worker worker = this.workerDao.get(workerId);
		RepairProgress progress = new RepairProgress();
		progress.setRepairId(repairId);
		progress.setRemark(remark);
		progress.setStatus((byte) status);
		progress.setWorkerId(workerId);
		progress.setWorkerName(worker.getUserName());
		progress.setPhoneNum(worker.getPhoneNum());

		this.repairProgressDao.save(progress);

		repair.setStatus((byte) status);
		this.repairDao.update(repair);
	}

	@Override
	public Map<String, Object> pictures(Long workerId, Long repairId, int status) {
		Map<String, Object> pictures = new HashMap<String, Object>();
		Map<String, Object> repairedPic = this.repairProgressDao.pictures(
				workerId, repairId, status);
		String base = Constants.FILE_ACCESS_URL;
		String img = (String) repairedPic.get("img");
		if (StringUtils.isNotBlank(img)) {
			img = base + "/" + RepairProgress.IMG_PATH + "/" + img
					+ Constant.IMG_TYPE_JPG;
		}else{
			img = StringUtils.EMPTY;
		}
		pictures.put("repairedpic", img);
		List<RepairPicture> repairPics = this.repairPictureDao
				.getPicturesByRepairId(repairId);
		List<String> repairpics = new ArrayList<String>();
		for (RepairPicture rp : repairPics) {
			String url = rp.getUrl();
			if (StringUtils.isNotBlank(url)) {
				url = base + "/" + RepairPicture.IMG_PATH + "/" + url
						+ Constant.IMG_TYPE_JPG;
			}
			repairpics.add(url);
		}
		pictures.put("repairpics", repairpics);
		return pictures;
	}

	@Override
	public Map<String, Object> scores(Long repairId) {
		return this.repairDao.get(repairId).toMap(
				new String[] { "scoreResponse", "scoreDoor", "scoreService",
						"scoreQuality" });
	}
}
