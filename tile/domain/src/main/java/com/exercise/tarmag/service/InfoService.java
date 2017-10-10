package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.CommonUtil;
import com.dt.framework.util.DateUtil;
import com.dt.tarmag.dao.IBroadcastDao;
import com.dt.tarmag.dao.IBroadcastReaderDao;
import com.dt.tarmag.dao.ICustomerDao;
import com.dt.tarmag.dao.IExpressDeliveryDao;
import com.dt.tarmag.dao.IExpressDeliveryReceiverDao;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IHouseResidentDao;
import com.dt.tarmag.dao.INoticeDao;
import com.dt.tarmag.dao.INoticeReceiverDao;
import com.dt.tarmag.dao.IPropertyChargeBillDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.Broadcast;
import com.dt.tarmag.model.BroadcastReader;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.ExpressDelivery;
import com.dt.tarmag.model.ExpressDeliveryReceiver;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.Notice;
import com.dt.tarmag.model.NoticeReceiver;
import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.push.PushThread;
import com.dt.tarmag.push.PushObjectUtil;
import com.dt.tarmag.vo.BroadcastVo;
import com.dt.tarmag.vo.DeliveryVo;
import com.dt.tarmag.vo.NoticeVo;
import com.dt.tarmag.vo.PushVo;
import com.dt.tarmag.vo.ResidentVo;

/**
 * 信息管理
 * @author yuwei
 * @Time 2015-7-9下午01:44:44
 */
@Service
public class InfoService implements IInfoService {
	
	@Autowired
	private IBroadcastDao broadcastDao;
	@Autowired
	private IBroadcastReaderDao broadcastReaderDao;
	@Autowired
	private ICustomerDao customerDao;
	@Autowired
	private IResidentDao residentDao;
	@Autowired
	private INoticeDao noticeDao;
	@Autowired
	private INoticeReceiverDao noticeReceiverDao;
	@Autowired
	private IExpressDeliveryDao expressDeliveryDao;
	@Autowired
	private IExpressDeliveryReceiverDao expressDeliveryReceiverDao;
	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IHouseResidentDao houseResidentDao;
	@Autowired
	private IPropertyChargeBillDao propertyChargeBillDao;
	
	/**
	 * 推送消息
	 * @param id  消息id
	 * @param type 0 公告  1 通知  2快递
	 */
	private void pushMessage(long id,int type){
		//推送消息数据获取       TODO  要重构 
		List<Map<String, Object>> pushs = null;
		if(type == 0){
			pushs = this.broadcastReaderDao.getPushVos(id);
		}else if(type ==1){
			pushs = this.noticeReceiverDao.getPushVos(id);
		}else{
			pushs = this.expressDeliveryReceiverDao.getPushVos(id);
		}
		List<PushVo> pushVos = PushObjectUtil.zhuanhuan(pushs);
		PushThread thread = new PushThread(pushVos);
		try {
			Thread t = new Thread(thread);
		    t.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	@Override
	public int getBroadcastCount(long unitId, Byte type) {
		return broadcastDao.getBroadcastCount(unitId, type);
	}

	@Override
	public List<Map<String, Object>> getBroadcastMapList(long unitId, Byte type, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Broadcast> broadcastList = broadcastDao.getBroadcastList(unitId, type, pageNo, pageSize);
		if(broadcastList == null || broadcastList.size() <= 0) {
			return mapList;
		}
		
		for(Broadcast broadcast : broadcastList) {
			Customer customer = customerDao.get(broadcast.getCreateUserId());
			int readCount = broadcastReaderDao.getReadCountByBroadcastId(broadcast.getId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", broadcast.getId());
			map.put("typeName", broadcast.getFromTypeName());
			map.put("createUserName", customer == null ? "" : customer.getUserName());
			map.put("createTime", DateUtil.formatDate(broadcast.getCreateDateTime(), DateUtil.PATTERN_DATE1));
			map.put("title", CommonUtil.escape(broadcast.getTitle()));
			map.put("readCount", readCount);
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public void deleteBroadcast_tx(List<Long> idList) {
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long broadcastId : idList) {
			broadcastDao.deleteLogic(broadcastId);
		}
	}
	
	@Override
	public Map<String, Object> getBroadcastDetail(long broadcastId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Broadcast broadcast = broadcastDao.get(broadcastId);
		if(broadcast == null) {
			return map;
		}
		
		Customer customer = customerDao.get(broadcast.getCreateUserId());
		
		map.put("typeName", broadcast.getFromTypeName());
		map.put("createUserName", customer == null ? "" : customer.getUserName());
		map.put("title", CommonUtil.escape(broadcast.getTitle()));
		map.put("content", CommonUtil.escape(broadcast.getContent()));
		return map;
	}

	@Override
	public Map<String, Object> getBroadcastToEdit(long broadcastId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Broadcast broadcast = broadcastDao.get(broadcastId);
		if(broadcast == null) {
			return null;
		}
		
		map.put("type", broadcast.getFromType());
		map.put("title", broadcast.getTitle());
		map.put("content", broadcast.getContent());
		return map;
	}
	
	@Override
	public void createBroadcast_tx(BroadcastVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getFromType() < 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				|| vo.getContent() == null || vo.getContent().trim().equals("")) {
			return;
		}
		
		Broadcast broadcast = new Broadcast();
		broadcast.setUnitId(vo.getUnitId());
		broadcast.setFromType(vo.getFromType());
		broadcast.setTitle(vo.getTitle().trim());
		broadcast.setContent(vo.getContent().trim());
		broadcastDao.save(broadcast);
		
		List<Resident> residentList = residentDao.getResidentListByUnitId(vo.getUnitId());
		if(residentList == null || residentList.size() <= 0) {
			return;
		}
		
		Set<Resident> rset = new HashSet<Resident>(residentList);
		for(Resident resident : rset) {
			BroadcastReader br = new BroadcastReader();
			br.setBroadcastId(broadcast.getId());
			br.setResidentId(resident.getId());
			broadcastReaderDao.save(br);
		}
		this.pushMessage(broadcast.getId(), 0);
	}
	
	@Override
	public void updateBroadcast_tx(long broadcastId, BroadcastVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getFromType() < 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				|| vo.getContent() == null || vo.getContent().trim().equals("")) {
			return;
		}
		
		Broadcast broadcast = broadcastDao.get(broadcastId);
		if(broadcast == null) {
			return;
		}

		broadcast.setFromType(vo.getFromType());
		broadcast.setTitle(vo.getTitle().trim());
		broadcast.setContent(vo.getContent().trim());
		broadcastDao.update(broadcast);
	}

	@Override
	public int getReadCountByBroadcastId(long broadcastId) {
		return broadcastReaderDao.getReadCountByBroadcastId(broadcastId);
	}
	
	@Override
	public List<Map<String, Object>> getBroadcastReadList(long broadcastId, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<BroadcastReader> broadcastReadList = broadcastReaderDao.getBroadcastReadList(broadcastId, pageNo, pageSize);
		if(broadcastReadList == null || broadcastReadList.size() <= 0) {
			return mapList;
		}
		
		for(BroadcastReader br : broadcastReadList) {
			Resident resident = residentDao.get(br.getResidentId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("residentName", resident == null ? br.getResidentId() : resident.getUserName());
			map.put("readTime", DateUtil.formatDate(br.getReadTime(), DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public int getNoticeCount(long unitId, Byte type) {
		return noticeDao.getNoticeCount(unitId, type);
	}

	@Override
	public List<Map<String, Object>> getNoticeMapList(long unitId, Byte type, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Notice> noticeList = noticeDao.getNoticeList(unitId, type, pageNo, pageSize);
		if(noticeList == null || noticeList.size() <= 0) {
			return mapList;
		}
		
		for(Notice notice : noticeList) {
			Customer customer = customerDao.get(notice.getCreateUserId());
			int readCount = noticeReceiverDao.getReadCountByNoticeId(notice.getId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", notice.getId());
			map.put("fromTypeName", notice.getFromTypeName());
			map.put("toTypeName", notice.getToTypeName());
			map.put("createUserName", customer == null ? "" : customer.getUserName());
			map.put("createTime", DateUtil.formatDate(notice.getCreateDateTime(), DateUtil.PATTERN_DATE1));
			map.put("title", CommonUtil.escape(notice.getTitle()));
			map.put("readCount", readCount);
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public void deleteNotice_tx(List<Long> idList) {
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long noticeId : idList) {
			noticeDao.deleteLogic(noticeId);
		}
	}
	
	@Override
	public Map<String, Object> getNoticeDetail(long noticeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Notice notice = noticeDao.get(noticeId);
		if(notice == null) {
			return map;
		}
		
		Customer customer = customerDao.get(notice.getCreateUserId());

		map.put("fromTypeName", notice.getFromTypeName());
		map.put("toTypeName", notice.getToTypeName());
		map.put("createUserName", customer == null ? "" : customer.getUserName());
		map.put("title", CommonUtil.escape(notice.getTitle()));
		map.put("content", CommonUtil.escape(notice.getContent()));
		return map;
	}

	@Override
	public Map<String, Object> getNoticeToEdit(long noticeId) {
		Map<String, Object> map = new HashMap<String, Object>();
		Notice notice = noticeDao.get(noticeId);
		if(notice == null) {
			return null;
		}

		map.put("title", notice.getTitle());
		map.put("content", notice.getContent());
		return map;
	}
	
	@Override
	public void createNotice_tx(NoticeVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getFromType() < 0
				|| vo.getToType() < 0
				|| vo.getHouseIdList() == null || vo.getHouseIdList().size() <= 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				|| vo.getContent() == null || vo.getContent().trim().equals("")) {
			return;
		}
		
		Notice notice = new Notice();
		notice.setUnitId(vo.getUnitId());
		notice.setFromType(vo.getFromType());
		notice.setToType(vo.getToType());
		notice.setTitle(vo.getTitle().trim());
		notice.setContent(vo.getContent().trim());
		noticeDao.save(notice);
		
		List<Byte> typeList = new ArrayList<Byte>();
		if(vo.getToType() == Notice.TO_TYPE_ALL) {
			typeList.add(HouseResident.TYPE_OWNER);
			typeList.add(HouseResident.TYPE_FAMILY_MEMBER);
			typeList.add(HouseResident.TYPE_RENTER);
		} else if(vo.getToType() == Notice.TO_TYPE_OWNER) {
			typeList.add(HouseResident.TYPE_OWNER);
			typeList.add(HouseResident.TYPE_FAMILY_MEMBER);
		} else if(vo.getToType() == Notice.TO_TYPE_RENTER) {
			typeList.add(HouseResident.TYPE_RENTER);
		}
		
		/**
		 * 如果一个人在多套房屋中，只给这个人发送一个通知
		 **/
		List<Resident> residentList = residentDao.getResidentList(vo.getHouseIdList(), typeList);
		if(residentList != null && residentList.size() > 0) {
			Set<Resident> rset = new HashSet<Resident>(residentList);
			for(Resident resident : rset) {
				NoticeReceiver nr = new NoticeReceiver();
				nr.setNoticeId(notice.getId());
				nr.setResidentId(resident.getId());
				noticeReceiverDao.save(nr);
			}
		}
		this.pushMessage(notice.getId(), 1);
	}
	
	@Override
	public void updateNotice_tx(long noticeId, NoticeVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				|| vo.getContent() == null || vo.getContent().trim().equals("")) {
			return;
		}
		
		Notice notice = noticeDao.get(noticeId);
		if(notice == null) {
			return;
		}

		notice.setTitle(vo.getTitle().trim());
		notice.setContent(vo.getContent().trim());
		noticeDao.update(notice);
	}

	@Override
	public int getReadCountByNoticeId(long noticeId) {
		return noticeReceiverDao.getReadCountByNoticeId(noticeId);
	}
	
	@Override
	public List<Map<String, Object>> getNoticeReadList(long noticeId, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<NoticeReceiver> noticeReadList = noticeReceiverDao.getNoticeReadList(noticeId, pageNo, pageSize);
		if(noticeReadList == null || noticeReadList.size() <= 0) {
			return mapList;
		}
		
		for(NoticeReceiver nr : noticeReadList) {
			Resident resident = residentDao.get(nr.getResidentId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("residentName", resident == null ? nr.getResidentId() : resident.getUserName());
			map.put("readTime", DateUtil.formatDate(nr.getReadTime(), DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public Map<String, Object> getDeliveryToEdit(long deliveryId) {
		Map<String, Object> map = new HashMap<String, Object>();
		ExpressDelivery delivery = expressDeliveryDao.get(deliveryId);
		if(delivery == null) {
			return null;
		}

		map.put("title", delivery.getTitle());
		map.put("content", delivery.getContent());
		return map;
	}
	
	@Override
	public void createDelivery_tx(DeliveryVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getHouseIdList() == null || vo.getHouseIdList().size() <= 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				) {
			return;
		}
		
		for(long houseId : vo.getHouseIdList()) {
			ExpressDelivery delivery = new ExpressDelivery();
			delivery.setUnitId(vo.getUnitId());
			delivery.setHouseId(houseId);
			delivery.setTitle(vo.getTitle().trim());
			if(vo.getContent() != null) {
				delivery.setContent(vo.getContent().trim());
			}
			expressDeliveryDao.save(delivery);
			
			List<Byte> typeList = new ArrayList<Byte>();
			typeList.add(HouseResident.TYPE_OWNER);
			typeList.add(HouseResident.TYPE_RENTER);
			typeList.add(HouseResident.TYPE_FAMILY_MEMBER);
			
			List<Resident> residentList = residentDao.getResidentList(houseId, typeList);
			if(residentList != null && residentList.size() > 0) {
				for(Resident resident : residentList) {
					ExpressDeliveryReceiver receiver = new ExpressDeliveryReceiver();
					receiver.setDeliveryId(delivery.getId());
					receiver.setResidentId(resident.getId());
					expressDeliveryReceiverDao.save(receiver);
				}
			}
			this.pushMessage(delivery.getId(), 2);
		}
	}
	
	@Override
	public void updateDelivery_tx(long deliveryId, DeliveryVo vo) {
		if(vo == null 
				|| vo.getUnitId() <= 0
				|| vo.getTitle() == null || vo.getTitle().trim().equals("")
				) {
			return;
		}
		
		ExpressDelivery delivery = expressDeliveryDao.get(deliveryId);
		if(delivery == null) {
			return;
		}

		delivery.setTitle(vo.getTitle().trim());
		if(vo.getContent() != null) {
			delivery.setContent(vo.getContent().trim());
		}
		expressDeliveryDao.update(delivery);
	}

	@Override
	public int getDeliveryCount(long unitId) {
		return expressDeliveryDao.getExpressDeliveryCount(unitId);
	}

	@Override
	public List<Map<String, Object>> getDeliveryMapList(long unitId, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<ExpressDelivery> expressDeliveryList = expressDeliveryDao.getExpressDeliveryList(unitId, pageNo, pageSize);
		if(expressDeliveryList == null || expressDeliveryList.size() <= 0) {
			return mapList;
		}

		List<Byte> typeList = new ArrayList<Byte>();
		typeList.add(HouseResident.TYPE_OWNER);
		typeList.add(HouseResident.TYPE_RENTER);
		typeList.add(HouseResident.TYPE_FAMILY_MEMBER);
		for(ExpressDelivery delivery : expressDeliveryList) {
			Customer customer = customerDao.get(delivery.getCreateUserId());
			House house = houseDao.get(delivery.getHouseId());
			Resident receiver = residentDao.get(delivery.getReceiverId());
			int readCount = expressDeliveryReceiverDao.getReadCountByDeliveryId(delivery.getId());
			List<HouseResident> houseResidentList = houseResidentDao.getHouseResidentList(delivery.getHouseId(), typeList);
			
			List<ResidentVo> residentVoList = new ArrayList<ResidentVo>();
			if(houseResidentList != null && houseResidentList.size() > 0) {
				for(HouseResident r : houseResidentList) {
					Resident resident = residentDao.get(r.getResidentId());
					if(resident == null) {
						continue;
					}
					
					ResidentVo vo = new ResidentVo();
					vo.setResidentId(resident.getId());
					vo.setResidentName(resident.getUserName());
					vo.setResidentType(r.getTypeName());
					vo.setIdCard(resident.getIdCard() == null ? "" : resident.getIdCard());
					vo.setPhoneNum(resident.getPhoneNum());
					residentVoList.add(vo);
				}
			}
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", delivery.getId());
			map.put("createTime", DateUtil.formatDate(delivery.getCreateDateTime(), DateUtil.PATTERN_DATE1));
			map.put("title", CommonUtil.escape(delivery.getTitle()));
			map.put("createUserName", customer == null ? "" : customer.getUserName());
			map.put("houseNo", house == null ? "" : house.getDyCode());
			map.put("isReceived", delivery.getReceiverId() > 0 ? "1" : "0");
			map.put("receiverName", receiver == null ? "" : receiver.getUserName());
			map.put("readCount", readCount);
			map.put("residentList", residentVoList);
			mapList.add(map);
		}
		return mapList;
	}

	@Override
	public void deleteDelivery_tx(List<Long> idList) {
		
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long deliveryId : idList) {
			expressDeliveryDao.deleteLogic(deliveryId);
		}
	}
	
	@Override
	public Map<String, Object> getDeliveryDetail(long deliveryId) {
		Map<String, Object> map = new HashMap<String, Object>();
		ExpressDelivery delivery = expressDeliveryDao.get(deliveryId);
		if(delivery == null) {
			return map;
		}
		
		Customer customer = customerDao.get(delivery.getCreateUserId());
		House house = houseDao.get(delivery.getHouseId());
		Resident receiver = residentDao.get(delivery.getReceiverId());

		map.put("createUserName", customer == null ? "" : customer.getUserName());
		map.put("houseNo", house == null ? "" : house.getDyCode());
		map.put("receiverName", receiver == null ? "" : receiver.getUserName());
		map.put("title", CommonUtil.escape(delivery.getTitle()));
		map.put("content", CommonUtil.escape(delivery.getContent()));
		return map;
	}

	@Override
	public int getReadCountByDeliveryId(long deliveryId) {
		return expressDeliveryReceiverDao.getReadCountByDeliveryId(deliveryId);
	}
	
	@Override
	public List<Map<String, Object>> getExpressDeliveryReadList(long deliveryId, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<ExpressDeliveryReceiver> deliveryReadList = expressDeliveryReceiverDao.getExpressDeliveryReadList(deliveryId, pageNo, pageSize);
		if(deliveryReadList == null || deliveryReadList.size() <= 0) {
			return mapList;
		}
		
		for(ExpressDeliveryReceiver edr : deliveryReadList) {
			Resident resident = residentDao.get(edr.getResidentId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("residentName", resident == null ? edr.getResidentId() : resident.getUserName());
			map.put("readTime", DateUtil.formatDate(edr.getReadTime(), DateUtil.PATTERN_DATE_TIME2));
			mapList.add(map);
		}
		return mapList;
	}
	
	@Override
	public String signForDelivery_tx(long deliveryId, long residentId) {
		ExpressDelivery delivery = expressDeliveryDao.get(deliveryId);
		if(delivery == null 
				|| delivery.getReceiverId() > 0) {
			return "0";
		}
		
		delivery.setReceiverId(residentId);
		delivery.setReveiveTime(new Date());
		expressDeliveryDao.update(delivery);

		List<Byte> typeList = new ArrayList<Byte>();
		typeList.add(HouseResident.TYPE_OWNER);
		typeList.add(HouseResident.TYPE_RENTER);
		typeList.add(HouseResident.TYPE_FAMILY_MEMBER);
		
		//再发送一次通知告诉有人签收了
		Resident res = residentDao.get(delivery.getReceiverId());
		ExpressDelivery cdelivery = new ExpressDelivery();
		cdelivery.setUnitId(delivery.getUnitId());
		cdelivery.setHouseId(delivery.getHouseId());
		cdelivery.setTitle("房屋的快递已经被["+res.getUserName()+"]领走，请知悉！");
		cdelivery.setReceiverId(delivery.getReceiverId());
		cdelivery.setReveiveTime(delivery.getReveiveTime());
		expressDeliveryDao.save(cdelivery);
		
		List<Resident> residentList = residentDao.getResidentList(delivery.getHouseId(), typeList);
		if(residentList != null && residentList.size() > 0) {
			for(Resident resident : residentList) {
				ExpressDeliveryReceiver receiver = new ExpressDeliveryReceiver();
				receiver.setDeliveryId(cdelivery.getId());
				receiver.setResidentId(resident.getId());
				expressDeliveryReceiverDao.save(receiver);
			}
		}
		
		return "1";
	}


	@Override
	public void sendPaymentNotice_tx(List<Long> idList, Long unitId) {
		NoticeVo niticeVo = new NoticeVo();
		
		niticeVo.setFromType(Notice.FROM_TYPE_PROPERTY);
		
		niticeVo.setToType(Notice.TO_TYPE_ALL);
		
		niticeVo.setUnitId(unitId);
		
		niticeVo.setTitle("物业缴费通知");
		
		
		if (idList == null || idList.size() <= 0) {
			return;
		}
		for (long pcId : idList) {
			PropertyChargeBill propertyChargeBill = this.propertyChargeBillDao.get(pcId);
			if (propertyChargeBill != null){
				//只给未缴费的用户发送催缴通知
				if(propertyChargeBill.getStatus() == PropertyChargeBill.STATUS_UNCHARGED){
					House house = houseDao.get(propertyChargeBill.getHouseId());
					String content = " 您好，您的房屋  " + house.getDyCode() + " ，" +
							DateUtil.formatDate(propertyChargeBill.getStartDate(), DateUtil.PATTERN_DATE3) + "至"
							+ DateUtil.formatDate(propertyChargeBill.getEndDate(), DateUtil.PATTERN_DATE3) +
							"的物业费账单已在 "+ DateUtil.formatDate(propertyChargeBill.getCreateDateTime(), DateUtil.PATTERN_DATE3)
							+ " 生成，费用总计 " + propertyChargeBill.getAmount()+ " 元，请尽快缴纳！";
					
					String houseIds = String.valueOf(propertyChargeBill.getHouseId());
					niticeVo.setContent(content);
					niticeVo.setHouseIds(houseIds);
					createNotice_tx(niticeVo);
					propertyChargeBill.setRemindTimes(propertyChargeBill.getRemindTimes() + 1);
				}
			
				propertyChargeBillDao.update(propertyChargeBill);
			}else{
				continue;
			}
			
		}
	}
}
