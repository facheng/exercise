/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ytx.org.apache.http.impl.cookie.DateUtils;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.ImgUploadUtil;
import com.dt.tarmag.Constants;
import com.dt.tarmag.dao.IDeviceManageDao;
import com.dt.tarmag.dao.IInvitationDao;
import com.dt.tarmag.dao.IKeyDeviceDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.DeviceManage;
import com.dt.tarmag.model.Invitation;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.msg.sms.SmsPurpose;
import com.dt.tarmag.msg.sms.XwSmsUtil;
import com.dt.tarmag.push.PushThread;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.InvitationVo;
import com.dt.tarmag.vo.PushVo;

/**
 * @author raymond 邀约
 */
@Service
public class InvitationService implements IInvitationService {
	@Autowired
	private IKeyDeviceDao keyDeviceDao;

	@Autowired
	private IInvitationDao invitationDao;

	@Autowired
	private IResidentDao residentDao;

	@Autowired
	private IDeviceManageDao deviceManageDao;
	
	@Override
	public List<Map<String, Object>> findInvitations(Long inviterId,
			Long houseId, Long inviteeId, int pageNo) {
		List<Map<String, Object>> invitations = this.invitationDao
				.findInvitations(Params.getParams("inviterId", inviterId)
						.add("houseId", houseId).add("inviteeId", inviteeId)
						.filterEmpty(), pageNo);
		// 处理数据
		for (Map<String, Object> invitation : invitations) {
			Date visitTime = (Date) invitation.remove("visitTime");
			Date deadlineTime = (Date) invitation.remove("deadlineTime");
			invitation.put("validTime",
					DateUtil.formatDate(visitTime, "yyyy.MM.dd HH:mm") + "至"
							+ DateUtil.formatDate(deadlineTime, "MM.dd HH:mm"));
			String headImg = (String)invitation.get("headImg");
			if(StringUtils.isNotBlank(headImg)){
				headImg = StringUtils.isBlank(headImg)?"":(ImgUploadUtil.getAccessURL(Constants.FILE_ACCESS_URL+"/"+Constants.IMG_URL+"/"+Resident.IMG_PATH, headImg));
			}else{
				headImg = "";
			}
			invitation.put("headImg", headImg);
		}

		return invitations;
	}

	@Override
	public Map<String, Object> findInvitation(Long id) {
		Map<String, Object> invitation = this.invitationDao.findInvitation(id);
		if(!invitation.isEmpty()){
			Date visitTime = (Date) invitation.remove("visitTime");
			Date deadlineTime = (Date) invitation.remove("deadlineTime");
			invitation.put("visitTime",
					DateUtil.formatDate(visitTime, "yyyy.MM.dd HH:mm"));
			invitation.put("deadlineTime",
					DateUtil.formatDate(deadlineTime, "yyyy.MM.dd HH:mm"));
		}
		return invitation;
	}

	@Override
	public Map<String, Object> findReceptionInvitation(Long id) {
		Map<String, Object> invitation = this.invitationDao
				.findReceptionInvitation(id);
		if(!invitation.isEmpty()){
			invitation.remove("qrCode");
			// 校验该邀约是否过期 deadlineTime
			Date deadlineTime = (Date) invitation.remove("deadlineTime");
			invitation.put("isValid", deadlineTime.getTime() < System.currentTimeMillis()?0:1);//该邀约是否在有效期内
			List<KeyDevice> keyDevices = this.keyDeviceDao
					.findKeyDevice(Long.valueOf(invitation.get("houseId").toString()));
			List<Map<String, Object>> keyDevicesMap = new ArrayList<Map<String, Object>>();
			for (KeyDevice keyDevice : keyDevices) {
				keyDevicesMap.add(keyDevice.toMap(new String[] { "keyName",
						"deviceName", "deviceAddress", "devicePassword", "keyType",
						"category" }));
			}
			invitation.put("beconKeys", keyDevicesMap);
		}
		return invitation;
	}

	@Override
	public void addInvitation_tx(InvitationVo invitationVo) {
		String phoneNum = invitationVo.getPhoneNum();
		Resident invitee = this.residentDao.getResidentByPhoneNum(phoneNum);
		
		String qrCode = UUID.randomUUID().toString();
		Resident inviter = this.residentDao.get(invitationVo.getInviterId());
		
		Resident resident = null;
		if (invitee == null) {// 对于未注册的用户帮助其自动注册 然后短信方式 短地址发送到手机
			resident = new Resident();
			resident.setUserName(invitationVo.getUserName());
			resident.setPhoneNum(invitationVo.getPhoneNum());
			this.residentDao.save(resident);
		} else {
			resident = invitee;
		}
		Invitation invitation = new Invitation();
		invitation.setDeadlineTime(invitationVo.getDeadlineTime());
		invitation.setHouseId(invitationVo.getHouseId());
		invitation.setInviterId(invitationVo.getInviterId());
		invitation.setMessage(invitationVo.getMessage());
		invitation.setVisitTime(invitationVo.getVisitTime());
		// 保存邀约内容
		invitation.setInviteeId(resident.getId());
		invitation.setQrCode(qrCode);
		invitation.setCreateTime(new Date());
		this.invitationDao.save(invitation);
		
		String tempLate = StringUtils.replace(XwSmsUtil.INVITE_TEMPLATE,
				"${name}", StringUtils.trimToEmpty(inviter.getUserName()));
		tempLate = tempLate.replace("${url}", Constants.QR_CODE_URL + "?id=" + invitation.getId()); 
		tempLate = tempLate.replace("${yiName}", invitationVo.getUserName());
		//推送消息
		List<DeviceManage> deviceManages = this.deviceManageDao.getDeviceManagesByUserId(resident.getId());
		List<PushVo> pushVos = new ArrayList<PushVo>();
		for(DeviceManage deviceManage : deviceManages){
			PushVo pushVo = new PushVo();
			pushVo.setId(invitation.getId());
			pushVo.setnToken(deviceManage.getnToken());
			pushVo.setAppType(deviceManage.getAppType());
			pushVo.setDeviceType(deviceManage.getDeviceType());
			pushVo.setDeviceModel(deviceManage.getDeviceModel());
			pushVo.setType("1");
			pushVo.setContent(tempLate);
			pushVos.add(pushVo);
		}
		new Thread(new PushThread(pushVos)).start();
		
		XwSmsUtil.singleSms(phoneNum, tempLate, SmsPurpose.INVITE_ADDRESS);//发送短信
	}
	
	@Override
	public Map<String, Object> getQrCode(Long id){
		Map<String, Object> invitation = this.invitationDao
				.findReceptionInvitation(id);
		if(!invitation.isEmpty()){
			// 校验该邀约是否过期 deadlineTime
			Date deadlineTime = (Date) invitation.remove("deadlineTime");
			invitation.put("isValid", deadlineTime.getTime() < System.currentTimeMillis()?0:1);//该邀约是否在有效期内
			Date createDateTime = (Date)invitation.get("createTime");
			invitation.put("createTime", DateUtils.formatDate(createDateTime, "yyyy-MM-dd HH:mm"));
		}
		return invitation;
	}
}
