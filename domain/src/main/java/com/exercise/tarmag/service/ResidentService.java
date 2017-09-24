package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.BeanUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.ImgUploadUtil;
import com.dt.framework.util.MathUtil;
import com.dt.framework.util.StringUtils;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.Constants;
import com.dt.tarmag.dao.IApiRequestRecDao;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IHouseResidentDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.dao.ISmsCodeDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.model.ApiRequestRec;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.model.SmsCode;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.msg.model.SmsModel;
import com.dt.tarmag.msg.model.SmsType;
import com.dt.tarmag.msg.sms.SmsProviderFactory;
import com.dt.tarmag.msg.sms.SmsPurpose;
import com.dt.tarmag.util.DataImportUtils;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.ResidentVo;

@Service
public class ResidentService implements IResidentService {

	private static Logger logger = Logger.getLogger(ResidentService.class);

	@Autowired
	private ISmsCodeDao smsCodeDao;
	@Autowired
	private IResidentDao residentDao;
	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IUnitDao unitDao;
	@Autowired
	private IRedisDao redisDao;
	@Autowired
	private IApiRequestRecDao apiRequestRecDao;
	@Autowired
	private IHouseResidentDao houseResidentDao;
	@Autowired
	private IKeyDeviceService keyDeviceService;

	
	
	private static Map<Integer, String> mapField;
	
	
	
	
	@Override
	public void saveApiRequestRec_tx(String tokenId) {
		Long rId = getResidentId(tokenId);
		if(rId == null || rId <= 0) {
			logger.error("找不到用户，用户未登录或tokenId无效");
			return;
		}
		
		ApiRequestRec record = apiRequestRecDao.getLatestLoginRec(rId);
		if(record == null) {
			logger.error("用户未登录，请检查登录流程。。。。。。");
			return;
		}
		
		record.setLatestVisitTime(new Date());
		apiRequestRecDao.update(record);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Long getResidentId(String tokenId) {
		if(tokenId == null) {
			return null;
		}
		
		Map<String, Object> map = (Map<String, Object>) this.redisDao.get("login_" + tokenId);
		if(map == null) {
			return null;
		}
		
		return (Long) map.get(Constant.CACHE_USER_ID);
	}

	@Override
	public MsgResponse getPinCode_tx(String phoneNum) {
		MsgResponse msgResponse = null;
		if (StringUtils.isBlank(phoneNum)) {
			msgResponse = new Fail(MsgKey._000000001);
		} else {
			String pinCode = MathUtil.getRandomNum(4);
			
			SmsModel smsModel = SmsProviderFactory.getSmsModel(phoneNum,
					SmsType.LOGIN_CAPTCHA, new String[] { pinCode, "3" });
			if (!SmsProviderFactory.send(smsModel)) {
				msgResponse = new Fail(MsgKey._000000002);
			} else {
				try {
					// 保存验证码相关信息
					SmsCode smsCode = new SmsCode();
					Date now = new Date();
					smsCode.setCreateTime(now);
					smsCode.setValidTime(new Date(now.getTime()
							+ DateUtil.getTime("3m")));// 有效时间3分钟
					smsCode.setContent(smsModel.getMsg());
					smsCode.setType(SmsPurpose.LOGIN_CAPTCHA.getName());
					smsCode.setPhoneNum(phoneNum);
					smsCode.setCode(pinCode);
					this.smsCodeDao.save(smsCode);
					msgResponse = new Success("pinCode", pinCode);
				} catch (Exception e) {
					logger.error(e);
					msgResponse = new Fail(MsgKey._000000002);
				}
			}
		}
		return msgResponse;
	}

	@Override
	public MsgResponse login_tx(String phoneNum, String pinCode, String tokenId) {
		MsgResponse msgResponse = null;
		if (StringUtils.isBlank(phoneNum)) {// 是否是正确的手机号码
			msgResponse = new Fail(MsgKey._000000001);
		} else {
			Resident resident = this.residentDao
					.getResidentByPhoneNum(phoneNum);
			Date now = new Date();
			if (StringUtils.isNotBlank(pinCode)) {// 登录
				if (this.smsCodeDao.isValid(pinCode)) {// 判断验证码是否失效
					tokenId = MathUtil.generateToken();
					if (resident == null) {// 如果为null 则先注册
						resident = new Resident();
						resident.setUserName(" ");
						resident.setPhoneNum(phoneNum);
						resident.setCreateDateTime(now);
					}else{//如果是登录 先清除缓存原tokenId相关用户信息
						this.redisDao.delete("login_"+resident.getTokenId());
					}
					msgResponse = this.getResponse(resident, now, tokenId);
				} else {
					msgResponse = new Fail(MsgKey._000000005);
				}
			} else if (StringUtils.isNotBlank(tokenId)) {// 自动登录
				if (!tokenId.trim().equals(resident.getTokenId())) {
					msgResponse = new Fail(MsgKey._000000004);
				} else {
					if (!this.redisDao.contain("login_" + tokenId)) {// 令牌时间失效 跳转至登录界面 要求重新登录
						msgResponse = new Fail(MsgKey._000000004);
					} else {
						msgResponse = this.getResponse(resident, now, tokenId);
					}
				}
			} else {
				msgResponse = new Fail(MsgKey._000000003);
			}
			now = new Date();
			if (msgResponse instanceof Success) {// 如果是登录成功
				// 登录信息放置到缓存 令牌信息放置到缓存
				Map<String, Object> loginInfo = new HashMap<String, Object>();
				loginInfo.put(Constant.CACHE_USER_ID, resident.getId());
				loginInfo.put(Constant.CACHE_USER, resident);
				msgResponse.put("keyDevices",
						this.keyDeviceService.findKeys(resident.getId()));
				this.redisDao.save("login_" + tokenId, loginInfo, 7,
						TimeUnit.DAYS);
				
				ApiRequestRec record = new ApiRequestRec();
				record.setResidentId(resident.getId());
				record.setLoginTime(now);
				record.setLatestVisitTime(now);
				apiRequestRecDao.save(record);
			}
		}
		return msgResponse;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, Object> getLoginInfoByTokenId(String tokenId) {
		return (Map<String, Object>) redisDao.get("login_" + tokenId);
	}

	protected MsgResponse getResponse(Resident resident, Date now,
			String tokenId) {
		MsgResponse msgResponse = null;
		resident.setLastLoginTime(now);
		resident.setTokenId(tokenId);
		this.residentDao.saveOrUpdate(resident);
		House defaultHouse = this.houseDao.getDefaultHouse(resident.getId());
		msgResponse = new Success();

		Map<String, Object> user = resident.toMap(new String[] { "id",
				"userName", "nickName", "headImg", "sex", "birthday",
				"phoneNum" });
		msgResponse.put("user", user);
		if (defaultHouse != null) {
			Map<String, Object> house = defaultHouse.toMap(new String[] {
					"storyId", "unitId", "id" });
			Long unitId = defaultHouse.getUnitId();
			Unit unit = this.unitDao.get(unitId);
			house.put("unitName", unit.getUnitName());
			house.put("houseAddress", "");
			house.put("appBackgroundImg", unit.getAppBackgroundImg());
			msgResponse.put("house", house);
		}
		msgResponse.put("tokenId", tokenId);
		return msgResponse;
	}

	@Override
	public void loginOut_tx(String tokenId) {
		@SuppressWarnings("unchecked")
		Resident resident = this.residentDao
				.get((Long) ((Map<String, Object>) this.redisDao.get("login_"
						+ tokenId)).get(Constant.CACHE_USER_ID));
		if (resident != null) {
			// 修改最后一次使用时间
			resident.setLastLoginTime(new Date());
			this.residentDao.update(resident);
		}
		this.redisDao.delete("login_"+tokenId);
	}

	@Override
	public void headimg_tx(Long id, String headimg) {
		Resident resident = this.residentDao.get(id);
		resident.setHeadImg(headimg);
		this.residentDao.update(resident);
	}

	@Override
	public void residetrevise_tx(Resident resident) {
		Resident modify = this.residentDao.get(resident.getId());
		resident.setId(0);
		BeanUtil.copyProperty(resident, modify);
		this.residentDao.update(modify);
	}

	@Override
	public List<Map<String, Object>> getResidentByHouseId(long houseId) {
		return residentDao.getResidentByHouseId(houseId);
	}

	@Override
	public List<Resident> getResident(String houseId, Resident resident) {
		Map<String, Object> paramsMap = new HashMap<String, Object>();
		paramsMap.put("houseId", houseId);
		if (StringUtils.isNotBlank(resident.getUserName())) {
			paramsMap.put("userName", resident.getUserName());
		}
		if (StringUtils.isNotBlank(resident.getPhoneNum())) {
			paramsMap.put("phoneNum", resident.getPhoneNum());
		}
		if (StringUtils.isNotBlank(resident.getIdCard())) {
			paramsMap.put("idCard", resident.getIdCard());
		}
		List<Resident> resultList = residentDao.getResident(paramsMap);
		return resultList;
	}

	@Override
	public Resident getResidentByPhoneNum(String phoneNum) {
		return residentDao.getResidentByPhoneNum(phoneNum);
	}

	@Override
	public void importResident_tx(InputStream inputStream, Long unitId,
			ModelMap model) throws IOException {
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		List<String> msgList = new ArrayList<String>();
		boolean result = DataImportUtils.checkFileImport(hssfSheet, mapField);
		try {
			if (result) {
				model.put("importMsg", "success");
				for (int rowNum = 6; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					HSSFRow hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						msgList.add("导入模版为空 ，请填写导入信息！");
						break;
					}

					HSSFCell cell0 = hssfRow.getCell(0); // 房屋编码*\n（期-楼栋-单元-室）
															// dyCode
					HSSFCell cell1 = hssfRow.getCell(1); // 是否默认房屋* isDefault
					HSSFCell cell2 = hssfRow.getCell(2); // 身份* type
					HSSFCell cell3 = hssfRow.getCell(3); // 姓名* userName
					HSSFCell cell4 = hssfRow.getCell(4); // 性别 sex
					HSSFCell cell5 = hssfRow.getCell(5); // 手机号* phoneNum
					HSSFCell cell6 = hssfRow.getCell(6); // 身份证号 idCard

					Resident resident = new Resident();
					HouseResident houseResident = new HouseResident();
					House house = new House();

					if (cell0 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell0))) {
						String dyCode = DataImportUtils.getValue(cell0);
						house.setUnitId(unitId);
						house.setDyCode(dyCode);
						house = houseDao.getHouseByDyCode(house);
						if (house == null) {
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，房屋编码不存在！");
							continue;
						}
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，房屋编码不能为空！");
						continue;
					}

					if (cell1 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell1))) {
						String isDefault = DataImportUtils.getValue(cell1);
						if (isDefault.equals("否")) {
							houseResident.setIsDefault(HouseResident.IS_DEFAULT_N);
						} else if (isDefault.equals("是")) {
							houseResident.setIsDefault(HouseResident.IS_DEFAULT_Y);
						}

					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，是否默认房屋不能为空！");
						continue;
					}

					if (cell2 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell2))) {
						String type = DataImportUtils.getValue(cell2);
						if (type.equals("业主")) {
							houseResident.setType(HouseResident.TYPE_OWNER);
						} else if (type.equals("家属")) {
							houseResident.setType(HouseResident.TYPE_FAMILY_MEMBER);
						} else if (type.equals("租客")) {
							houseResident.setType(HouseResident.TYPE_RENTER);
						} else if (type.equals("访客")) {
							houseResident.setType(HouseResident.TYPE_VISITOR);
						}
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，住户类型不能为空！");
						continue;
					}

					if (cell3 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
						String userName = DataImportUtils.getValue(cell3);
						resident.setUserName(userName);

					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，住户姓名不能为空！");
						continue;
					}

					if (cell4 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell4))) {
						String sex = DataImportUtils.getValue(cell4);
						if (sex.equals("男")) {
							resident.setSex(Resident.SEX_MALE);
						} else if (sex.equals("女")) {
							resident.setSex(Resident.SEX_FEMALE);
						}
					}

					if (cell5 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell5))) {
						String phoneNum = DataImportUtils.getValue(cell5);
						resident.setPhoneNum(phoneNum);

					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，手机号码不能为空！");
						continue;
					}

					if (cell6 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell6))) {
						String idCard = DataImportUtils.getValue(cell6);
						resident.setIdCard(idCard);
					}

					Resident residentTemp = this.getResidentByPhoneNum(resident
							.getPhoneNum());

					if (residentTemp != null) {
						HouseResident houseResidentTemp = houseResidentDao
								.getHouseResident(house.getId(),
										residentTemp.getId());
						if (houseResidentTemp == null) {
							try {
								houseResident.setHouseId(house.getId());
								houseResident.setResidentId(residentTemp.getId());
								houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
								houseResidentDao.save(houseResident);
							} catch (Exception e) {
								e.printStackTrace();
								msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ， 住户绑定房屋失败！");
								continue;
							}
						} else {
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，该住户已存在！");
							continue;
						}
					} else {
						residentDao.save(resident);
						try {
							Resident res = this.getResidentByPhoneNum(resident.getPhoneNum());
							houseResident.setHouseId(house.getId());
							houseResident.setResidentId(res.getId());
							houseResident.setIsApproved(HouseResident.IS_APPROVED_YES);
							houseResidentDao.save(houseResident);
						} catch (Exception e) {
							msgList.add("第" + String.valueOf(rowNum + 1) + " 住户绑定房屋失败！");
						}
					}
					logger.debug("第" + String.valueOf(rowNum+1)+ " 行导入住户成功！");
				}
			} else {
				model.put("importMsg", "fail");
				msgList.add("校验导入文档格式失败！，请重新填写！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			msgList.removeAll(msgList);
			msgList.add("导入数据失败！");
		}
		if(msgList.size() == 0){
			msgList.add("导入住户数据成功！");
		}
		model.put("msg", msgList);
	}

	/**
	 * Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer, String>();
		mapField.put(0, "房屋编码*\n（期-楼栋-单元-室）");
		mapField.put(1, "是否默认房屋*");
		mapField.put(2, "身份*");
		mapField.put(3, "姓名*");
		mapField.put(4, "性别");
		mapField.put(5, "手机号*");
		mapField.put(6, "身份证号");
	}

	@Override
	public List<ResidentVo> getResidentByHouseIdAndType(long houseId) {
		//设置住户类型为 业主/家属
		List<Byte> ls = new ArrayList<Byte>();
		ls.add(HouseResident.TYPE_OWNER);
		ls.add(HouseResident.TYPE_FAMILY_MEMBER);
		
		List<Map<String , Object>> list = residentDao.getResidentByHouseIdAndType(houseId , ls);
		
		List<ResidentVo> resultList = new ArrayList<ResidentVo>();
		
		HouseResident hr = new HouseResident();
		
		for (Map<String, Object> map : list) {
			ResidentVo rv = new ResidentVo();
			if(map.get("hrId") != null){
				long hrId = Long.valueOf(map.get("hrId").toString());
				rv.setHouseResidentId(hrId);
			}
			
			if(map.get("ID") != null){
				long id = Long.valueOf(map.get("ID").toString());
				rv.setResidentId(id);
			}
			
			if(map.get("hrType") != null){
				Byte hrType = Byte.valueOf(map.get("hrType").toString());
				hr.setType(hrType);
				rv.setResidentType(hr.getTypeName());
			}
			
			if(map.get("USER_NAME") != null){
				rv.setResidentName(map.get("USER_NAME").toString());
			}
			
			if(map.get("PHONE_NUM") != null){
				rv.setPhoneNum(map.get("PHONE_NUM").toString());
			}
		
			resultList.add(rv);
		}
		
		return resultList;
	}
	
	@Override
	public List<Map<String ,Object>> getResidentListByHouseId(long houseId) {
		List<Map<String ,Object>> list = new ArrayList<Map<String ,Object>>();
		List<HouseResident> hrList = houseResidentDao.getHouseResidentList(houseId);
		if(hrList == null || hrList.size() <= 0) {
			return list;
		}
		
		for(HouseResident hr : hrList) {
			Resident resident = residentDao.get(hr.getResidentId());
			if(resident == null || Constant.MODEL_DELETED_Y.equals(resident.getDeleted())) {
				continue;
			}
			
			Map<String ,Object> map = new HashMap<String ,Object>();
			map.put("id", resident.getId());
			map.put("name", resident.getUserName());
			map.put("phone", resident.getPhoneNum());
			list.add(map);
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> getResidentListByUnitId(long unitId) {
		
		List<Map<String, Object>> residentList = new ArrayList<Map<String,Object>>();
		
		List<Resident> residents = this.residentDao.findResidentListByUnitId(unitId);
		
		if(residents != null && !residents.isEmpty()){
			Map<String, Object> map = null;
			for(Resident r : residents){
				map = new HashMap<String, Object>();
				
				String headImg = r.getHeadImg();
				if(StringUtils.isNotBlank(headImg)){
					headImg = StringUtils.isBlank(headImg)?"":(ImgUploadUtil.getAccessURL(Constants.FILE_ACCESS_URL+"/"+Constants.IMG_URL+"/"+Resident.IMG_PATH, headImg));
				}else{
					headImg = "";
				}
				
				map.put("headImg", headImg);
				map.put("nickName", r.getNickName());
				map.put("userName", r.getUserName());
				map.put("phoneNum", r.getPhoneNum());
				residentList.add(map);
			}
		}
		return residentList;
	}

	@Override
	public Map<String, Object> getResidentInfo(String phoneNum) {
		Map<String, Object> data = new HashMap<String, Object>();
		Resident resident = this.getResidentByPhoneNum(phoneNum);

		if (resident != null) {
			if (StringUtils.isNotBlank(resident.getHeadImg())) {
				data.put(
						"headImg",
						ImgUploadUtil.getAccessURL(Constants.FILE_ACCESS_URL + "/" + Constants.IMG_URL + "/"
								+ Resident.IMG_PATH, resident.getHeadImg()));
			}
			else {
				data.put("headImg", "");
			}
			if (StringUtils.isNotBlank(resident.getNickName())) {
				data.put("nickName", resident.getNickName());
			}
			else {
				data.put("nickName", "");
			}
		}
		else {
			data.put("headImg", "");
			data.put("nickName", "");
		}

		return data;
	}
}
