/**
 * 
 */
package com.dt.tarmag.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.dao.redis.IRedisDao;
import com.dt.framework.util.Constant;
import com.dt.framework.util.StringUtils;
import com.dt.framework.util.TextUtil;
import com.dt.tarmag.convert.ViewTransfer;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IHouseResidentDao;
import com.dt.tarmag.dao.IKeyDeviceDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.dao.IStoryDao;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.HouseResident;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.util.DataImportUtils;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.HouseVo;
import com.dt.tarmag.vo.Tree;

/**
 * @author raymond
 *
 */
@Service
public class HouseService implements IHouseService {

	@Autowired
	private IHouseDao houseDao;
	@Autowired
	private IHouseResidentDao houseResidentDao;
	@Autowired
	private IStoryDao storyDao;
	@Autowired
	private IUnitPartitionDao unitPartitionDao;
	@Autowired
	private IResidentDao residentDao;
	@Autowired
	private IRedisDao redisDao;
	
	@Autowired
	private IKeyDeviceDao keyDeviceDao;

	private static Map<Integer, String> mapField;
	
	private static Logger logger = Logger.getLogger(HouseService.class);


	@SuppressWarnings("unchecked")
	protected Long getResidentId(String tokenId) {
		return (Long) ((Map<String, Object>) this.redisDao.get("login_"
				+ tokenId)).get(Constant.CACHE_USER_ID);
	}

	@Override
	public List<Map<String, Object>> getHousesByStoryId(long storyId,
			String tokenId) {

		List<Map<String, Object>> houses = new ArrayList<Map<String, Object>>();
		for (House house : this.houseDao.getHouses(Params.getParams(
				"residentId",
				this.getResidentId(tokenId)).add("storyId", storyId))) {
			houses.add(house.toMap(new String[] { "id", "dyCode", "roomNum" }));
		}
		return houses;
	}

	/**
	 * 获取 导出房屋的信息
	 * 
	 * @param house
	 * @param path
	 *            模板路径
	 * @return
	 */
	@Override
	public HSSFWorkbook findHouseInfosExcel(House house, String path)
			throws Exception {
		List<Map<String, Object>> lists = houseDao.getHouseInfosExcel(house);

		InputStream is = new FileInputStream(path);

		HSSFWorkbook wb = new HSSFWorkbook(is);
		
		HSSFSheet sheet = wb.getSheet("Sheet1");

		HSSFFont font = wb.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 10);
		// 设置excel导出信息样式
		HSSFCellStyle centerstyle = wb.createCellStyle();
		centerstyle.setFont(font);
		centerstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		centerstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		centerstyle.setBorderLeft((short) 1);
		centerstyle.setBorderRight((short) 1);
		centerstyle.setBorderTop((short) 1);
		centerstyle.setBorderBottom((short) 1);
		centerstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单元格的边框为粗体
		centerstyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		centerstyle.setFillForegroundColor(HSSFColor.WHITE.index);// 设置单元格的背景颜色．
		int num = 0;
		if (lists != null && lists.size() != 0) {
			for (int i = 0; i < lists.size(); i++) {

				Map<String, Object> map = lists.get(i);

				HSSFRow row = sheet.createRow(i + 8);

				HSSFCell cell21 = row.createCell(0);

				num += 1;
				cell21.setCellValue(num);// 序号
				cell21.setCellStyle(centerstyle);

				HSSFCell cell22 = row.createCell(1);
				cell22.setCellValue(isNotBlank(map.get("proNo")));// 房屋产证
				cell22.setCellStyle(centerstyle);

				HSSFCell cell23 = row.createCell(2);
				cell23.setCellValue(isNotBlank(map.get("area")));// *房屋面积
				cell23.setCellStyle(centerstyle);

				HSSFCell cell24 = row.createCell(3);
				cell24.setCellValue(ViewTransfer
						.getHouseStatusMemo(isNotBlank(map.get("status"))));// *房屋状态
				cell24.setCellStyle(centerstyle);

				HSSFCell cell25 = row.createCell(4);
				cell25.setCellValue(isNotBlank(map.get("storyNum")));// 所在楼栋
				cell25.setCellStyle(centerstyle);

				HSSFCell cell26 = row.createCell(5);
				cell26.setCellValue(isNotBlank(map.get("dyCode")));// 门派号
				cell26.setCellStyle(centerstyle);

				HSSFCell cell27 = row.createCell(6);
				cell27.setCellValue(isNotBlank(map.get("floorNum")));// 所在楼层
				cell27.setCellStyle(centerstyle);

				HSSFCell cell28 = row.createCell(7);
				cell28.setCellValue(getType(map.get("type")));// 身份
				cell28.setCellStyle(centerstyle);

				HSSFCell cell29 = row.createCell(8);
				cell29.setCellValue(isNotBlank(map.get("userName")));// 姓名
				cell29.setCellStyle(centerstyle);

				HSSFCell cell30 = row.createCell(9);
				cell30.setCellValue(isNotBlank(map.get("idCard")));// 身份证
				cell30.setCellStyle(centerstyle);

				HSSFCell cell31 = row.createCell(10);
				cell31.setCellValue(isNotBlank(map.get("phoneNum")));// 电话号码
				cell31.setCellStyle(centerstyle);

				HSSFCell cell32 = row.createCell(11);
				Double amounts = 0.0;
				String strAmouants = isNotBlank(map.get("amount"));
				if (StringUtils.isNotBlank(strAmouants)) {
					amounts = Double.valueOf(strAmouants);
				}
				cell32.setCellValue(amounts);// 金额
				cell32.setCellStyle(centerstyle);

				HSSFCell cell33 = row.createCell(12);
				cell33.setCellValue(isNotBlank(map.get("remark")));// 备注
				cell33.setCellStyle(centerstyle);
			}
		}
		return wb;

	}

	private String isNotBlank(Object obj) {
		return obj == null ? "" : obj.toString();
	}

	private String getType(Object obj) {
		
		String type = isNotBlank(obj);
		
		if ("0".equals(type)) {
			return "业主";
		} else if ("1".equals(type)) {
			return "家属";
		} else if ("2".equals(type)) {
			return "租客";
		} else if ("3".equals(type)) {
			return "访客";
		}
		return "";

	}

	@Override
	public int getHouseCount(long unitId, Byte status, String roomNo , Long partitionId) {
		return houseDao.getHouseCount(unitId, status, roomNo , partitionId);
	}

	@Override
	public List<Map<String, Object>> getHouseList(long unitId, Byte status,
			String roomNo , Long partitionId , int pageNo, int pageSize) {
		
		List<Map<String ,Object>> houseList = houseDao.getHouseList(unitId, status, roomNo, partitionId ,pageNo, pageSize);

		//List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		//加入房屋对应的钥匙信息
		
		List<Long> storyIds = new ArrayList<Long>();
		
		for(Map<String , Object > house : houseList){
			
			String storyId = house.get("storyId").toString();
			List<KeyDevice> keyMap = this.keyDeviceDao.findkeyDeviceByUnitAndStory(unitId, Long.parseLong(storyId));
			
			storyIds.clear();
			house.put("keyMap", keyMap);
		}
		
		return houseList;
	}

	@Override
	public House getHouseById(long houseId) {
		return houseDao.get(houseId);
	}

	@Override
	public void removeHouse_tx(Long houseId) {
		houseDao.deleteLogic(houseId);
	}

	/**
	 * 根据 房屋dycode 和 小区id 获取房屋总数
	 * 
	 * @return
	 */
	@Override
	public int findCountHouse(House house) {
		try {
			return houseDao.getCountHouse(house);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	@Override
	public int getHouseResidentReviewCount(long unitId, Byte state,
			String roomNo) {
		return houseResidentDao.getHouseResidentReviewCount(unitId, state,
				roomNo);
	}

	@Override
	public List<Map<String, Object>> getHouseResidentReviewMapList(long unitId,
			Byte state, String roomNo, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<HouseResident> hrrList = houseResidentDao
				.getHouseResidentReviewMapList(unitId, state, roomNo, pageNo,
						pageSize);
		if (hrrList == null || hrrList.size() <= 0) {
			return mapList;
		}

		for (HouseResident hrr : hrrList) {
			House house = houseDao.get(hrr.getHouseId());
			Story story = storyDao.get(house.getStoryId());
			UnitPartition unitPartition = unitPartitionDao.get(story
					.getPartitionId());
			Resident resident = residentDao.get(hrr.getResidentId());

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", hrr.getId());
			map.put("aliasName", unitPartition.getAliasName());
			map.put("storyNum", story.getStoryNum());
			map.put("dyCode", house.getDyCode());
			map.put("roomNo", house.getRoomNum());
			map.put("isDefault",
					hrr.getIsDefault() == HouseResident.IS_DEFAULT_Y ? TextUtil
							.getText("common.yes") : TextUtil
							.getText("common.no"));
			map.put("typeName", hrr.getTypeName());
			map.put("residentName", resident.getUserName());
			map.put("phoneNum", resident.getPhoneNum());
			map.put("isApproved", hrr.getIsApproved());
			map.put("isApprovedName", hrr.getIsApprovedName());
			mapList.add(map);
		}

		return mapList;
	}

	@Override
	public void doHouseResidentReview_tx(List<Long> houseResidentIdList,
			byte isApproved) {
		if (houseResidentIdList == null || houseResidentIdList.size() <= 0) {
			return;
		}

		for (long houseResidentId : houseResidentIdList) {
			HouseResident houseResident = houseResidentDao.get(houseResidentId);
			if (houseResident == null
					|| houseResident.getIsApproved() != HouseResident.IS_APPROVED_NO) {
				continue;
			}
			houseResident.setIsApproved(isApproved);
			houseResidentDao.update(houseResident);
			
			if(isApproved == HouseResident.IS_APPROVED_YES && houseResident.getIsDefault() == HouseResident.IS_DEFAULT_Y){//如果是核准，房屋又是默认
				houseResidentDao.changeDefault(houseResident.getId(), HouseResident.IS_DEFAULT_Y);
			}
		}
	}

	/**
	 * Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer, String>();
		mapField.put(0, "所在楼栋*");
		mapField.put(1, "房屋编码*\n（期-楼栋-单元-室）");
		mapField.put(2, "所在楼层*");
		mapField.put(3, "室*");
		mapField.put(4, "房屋状态*");
		mapField.put(5, "房屋面积");
		mapField.put(6, "房屋产证");
		mapField.put(7, "金额（万）");
	}

	@Override
	public void importHouse_tx(InputStream inputStream, Long unitId,
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
					HSSFCell cell0 = hssfRow.getCell(0); // 所在楼栋* storyNum
					HSSFCell cell1 = hssfRow.getCell(1); // 房屋编码*（期-楼栋-单元-室）
															// dyCode
					HSSFCell cell2 = hssfRow.getCell(2); // 所在楼层* floorNum
					HSSFCell cell3 = hssfRow.getCell(3); // 室* roomNum
					HSSFCell cell4 = hssfRow.getCell(4); // 房屋状态* status
					HSSFCell cell5 = hssfRow.getCell(5); // 房屋面积 area
					HSSFCell cell6 = hssfRow.getCell(6); // 房屋产证 proNo
					HSSFCell cell7 = hssfRow.getCell(7); // 金额（万） amount

					House house = new House();
					house.setUnitId(unitId);

					if (cell0 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell0))) {
						Story story = new Story();
						try {
							String storyNum = DataImportUtils.getValue(cell0);
							story.setStoryNum(storyNum);
							story.setUnitId(unitId);
							Story storyTemp = storyDao.getStorysByUnitIdAndStoryNmu(story);
							house.setStoryId(storyTemp.getId());
						} catch (Exception e) {
							msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入，不存在所填写的楼栋！");
							continue;
						}
					} else {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，所在楼栋不能为空！");
						continue;
					}
					if (cell1 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell1))) {
						String dyCode = DataImportUtils.getValue(cell1);
						house.setDyCode(dyCode);
					} else {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，房屋编码不能为空！");
						continue;
					}
					if (cell2 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell2))) {
						String floorNum = DataImportUtils.getValue(cell2);
						house.setFloorNum(Integer.valueOf(floorNum));
					} else {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，所在楼层不能为空！");
						continue;
					}
					if (cell3 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
						String roomNum = DataImportUtils.getValue(cell3);
						house.setRoomNum(roomNum);
						house.setCode(roomNum);
					} else {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，室不能为空！");
						continue;
					}
					if (cell4 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell4))) {
						String status = DataImportUtils.getValue(cell4);
						// 状态(1自住，2空置，3待售，4出租，5待租)
						if (status.equals("自住")) {
							house.setStatus(House.STATUS_SELF);
						} else if (status.equals("空置")) {
							house.setStatus(House.STATUS_VACANT);
						} else if (status.equals("待售")) {
							house.setStatus(House.STATUS_FOR_SALE);
						} else if (status.equals("出租")) {
							house.setStatus(House.STATUS_RENTING);
						} else if (status.equals("待租")) {
							house.setStatus(House.STATUS_FOR_RENT);
						}
					} else {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，房屋状态不能为空！");
						continue;
					}
					if (cell5 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell5))) {
						String area = DataImportUtils.getValue(cell5);
						house.setArea(Double.valueOf(area));
					}
					if (cell6 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell6))) {
						String proNo = DataImportUtils.getValue(cell6);
						house.setProNo(proNo);
					}
					if (cell7 != null
							&& StringUtils.isNotBlank(DataImportUtils.getValue(cell7))) {
						String amount = DataImportUtils.getValue(cell7);
						house.setAmount(Double.valueOf(amount));
					}
					int houseTemp = houseDao.getCountHouse(house);
					if (houseTemp != 0) {
						msgList.add("第 " + String.valueOf(rowNum + 1) + " 行未导入 ，房屋信息已存在！");
						continue;
					}
					house.setCode(String.valueOf(System.currentTimeMillis()));
					houseDao.save(house);
					logger.debug("第 " + String.valueOf(rowNum+1)+ " 行导入房屋信息成功！");
				}
			} else {
				model.put("importMsg", "fail");
				msgList.removeAll(msgList);
				msgList.add("校验导入文档格式失败！，请重新填写！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			msgList.add("导入数据失败！");
		}
		if(msgList.size() == 0){
			msgList.add("导入房屋数据成功！");
		}
		model.put("msg", msgList);
	}

	/**
	 * 排序
	 * 
	 * @param set
	 * @return
	 */
	private Set<Tree> sortSeq(Set<Tree> set) {
		Set<Tree> result = new TreeSet<Tree>(new Comparator<Tree>() {
			@Override
			public int compare(Tree a, Tree b) {
				return a.getId().compareTo(b.getId());
			}
		});
		result.addAll(set);
		return result;
	}

	@Override
	public List<Tree> getHouseTreeByUnitId(long unitId) {
		Set<Tree> set = new HashSet<Tree>();
		List<House> houseList = houseDao.getHouseListByUnitId(unitId);
		for (House house : houseList) {
			Story story = storyDao.get(house.getStoryId());
			if (story == null) {
				continue;
			}

			UnitPartition up = unitPartitionDao.get(story.getPartitionId());
			if (up == null) {
				continue;
			}

			Tree hTree = new Tree();
			hTree.setId("" + house.getId());
			hTree.setpId("s" + house.getStoryId());
			hTree.setName(house.getRoomNum());
			hTree.setOpen("false");
			hTree.setValid(Tree.VALID_Y);
			set.add(hTree);

			Tree sTree = new Tree();
			sTree.setId("s" + story.getId());
			sTree.setpId("u" + story.getPartitionId());
			sTree.setName(story.getStoryNum());
			sTree.setOpen("false");
			sTree.setValid(Tree.VALID_N);
			set.add(sTree);

			Tree uTree = new Tree();
			uTree.setId("u" + up.getId());
			uTree.setpId("0");
			uTree.setName(up.getAliasName());
			uTree.setOpen("false");
			uTree.setValid(Tree.VALID_N);
			set.add(uTree);
		}

		List<Tree> list = new ArrayList<Tree>();
		list.addAll(sortSeq(set));
		return list;
	}
	
	@Override
	public List<Tree> getStoryHouseByStoryId(long storyId) {
		Set<Tree> set = new TreeSet<Tree>(new Comparator<Tree>() {
            @Override
            public int compare(Tree a, Tree b) {
                return a.getId().compareTo(b.getId());
            }
        });

		List<House> houseList = houseDao.getHouseListByStoryId(storyId);
		for(House house : houseList) {
			Tree sTree = new Tree();
			sTree.setId("" + house.getId());
			sTree.setpId("s" + storyId);
			sTree.setName(house.getRoomNum());
			sTree.setOpen("false");
			sTree.setValid(Tree.VALID_Y);
			set.add(sTree);
		}
		return new ArrayList<Tree>(set);
	}

	@Override
	public Map<String, Object> getHouseToEdit(long houseId) {
		Map<String, Object> map = new HashMap<String, Object>();
		House house = houseDao.get(houseId);
		if (house == null) {
			return map;
		}

		map.put("roomNum", house.getRoomNum());
		map.put("floorNum", house.getFloorNum());
		map.put("proNo", house.getProNo());
		map.put("area", house.getArea());
		map.put("status", house.getStatus());
		map.put("delegate", house.getDelegateDelivery());
		return map;
	}

	@Override
	public void updateHouse_tx(long houseId, HouseVo vo) {
		if(vo == null 
				|| vo.getRoomNum() == null || vo.getRoomNum().trim().equals("")
				|| vo.getFloorNum() <= 0
				|| vo.getArea() <= 0) {
			return;
		}
		
		House house = houseDao.get(houseId);
		if (house == null) {
			return;
		}

		house.setRoomNum(vo.getRoomNum().trim());
		house.setFloorNum(vo.getFloorNum());
		house.setProNo(vo.getProNo());
		house.setArea(vo.getArea());
		house.setStatus(vo.getStatus());
		house.setDelegateDelivery(vo.getDelegateDelivery());
		houseDao.update(house);
	}

	@Override
	public HouseResident getHouseResident(long houseId, String mobile) {
		Resident resident = residentDao.getResidentByPhoneNum(mobile);
		if (resident == null) {
			return null;
		}

		return houseResidentDao.getHouseResident(houseId, resident.getId());
	}

	@Override
	public List<House> getHouseListByStoryId(long storyId) {
		return houseDao.getHouseListByStoryId(storyId);
	}

	@Override
	public List<House> getHouseListByPartitionId(long partitionId) {
		return houseDao.getHouseListByPartitionId(partitionId);
	}

	@Override
	public List<Map<String, Object>> getHouseResidentReviewList(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum,
			Integer pageNo,
			Integer pageSize) {
		List<Map<String ,Object>> hrList = houseResidentDao.getHouseResidentReviewList(unitId, state, roomNo,
				partitionId , userName , phoneNum ,pageNo, pageSize);

		return hrList;
	}

	@Override
	public int getHouseResidentReviewCount(
			Long unitId,
			Byte state,
			String roomNo,
			Long partitionId,
			String userName,
			String phoneNum) {
		return houseResidentDao.getHouseResidentReviewCount(unitId, state,
				roomNo , partitionId , userName , phoneNum);
	}
	
	@Override
	public int getHouseCountByUnitId(long unitId) {
		return houseDao.getHouseCountByUnitId(unitId);
	}
	
	@Override
	public List<Map<String, Object>> getHouseStatistics(long unitId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		
		int totalCount = houseDao.getHouseCountByUnitId(unitId);
		
		List<Byte> statusList = House.getAllStatusList();
		for(byte status : statusList) {
			int count = houseDao.getHouseCountByUnitIdAndStatus(unitId, status);
			if(count <= 0) {
				continue;
			}
			
			String percent = new BigDecimal(count * 100.0 / totalCount).setScale(3, BigDecimal.ROUND_HALF_UP).toString();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("status", status);
			map.put("statusName", House.getStatusNameByCode(status));
			map.put("count", count);
			map.put("percent", percent);
			mapList.add(map);
		}
		
		return mapList;
	}
	
	@Override
	public JSONArray getHouseStatisticsJson(long unitId) {
		List<Map<String, Object>> list = getHouseStatistics(unitId);
		JSONArray arr = new JSONArray();
		if(list == null || list.size() <= 0) {
			return arr;
		}
		
		for(Map<String, Object> map : list) {
			JSONObject obj = JSONObject.fromObject(map);
			arr.add(obj);
		}
		
		return arr;
	}

	@Override
	public HSSFWorkbook getHouseInfosForExport(House house) throws Exception {
		
		//参数校验
		if(house == null ){
			logger.error("导出房屋信息发生错误");
			throw new Exception("导出房屋信息发生错误");
		}
		
		HSSFWorkbook wb = null;

		try{
			
			List<Map<String, Object>> lists = houseDao.getHouseInfosForExport(house);
			
			String [] firstRowVals = {"序号" ,  "房屋产证" ,"房屋面积" ,"房屋状态" ,
									  "所在片区" , "所在楼栋" ,"门牌号（单元编码）" ,
									  "所在楼层" , "室"   , "身份"  ,"姓名" ,
									  "身份证号" ,"手机号"  , "备注" };
			wb = getHSSFSheetInfo(lists ,  firstRowVals);
			
		} catch ( Exception e ){
			logger.error("导出房屋信息发生错误" , e);
			throw e;
		} 
		return wb;
	}

	/*
	 * 组装excel文件
	 * firstRowVals 第一行标题
	 */
	private HSSFWorkbook getHSSFSheetInfo(List<Map<String, Object>> lists , String [] firstRowVals) throws IOException {
		HSSFWorkbook wb = new HSSFWorkbook();

		HSSFSheet sheet = wb.createSheet("sheet1");
		
		HSSFFont font = wb.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 10);
		
		// 设置excel导出信息样式
		HSSFCellStyle centerstyle = wb.createCellStyle();
		centerstyle.setFont(font);
		centerstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		centerstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		centerstyle.setBorderLeft((short) 1);
		centerstyle.setBorderRight((short) 1);
		centerstyle.setBorderTop((short) 1);
		centerstyle.setBorderBottom((short) 10);
		centerstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单元格的边框为粗体
		centerstyle.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		centerstyle.setFillForegroundColor(HSSFColor.WHITE.index);// 设置单元格的背景颜色．
		
		//组装第一行内容
		getFirstRowForExcel( wb, sheet , firstRowVals);
		
		Map<BigInteger , Object > tempIds = new HashMap<BigInteger, Object>();
		
		int num = 0;
		if (lists != null && lists.size() != 0) {
			
			for ( int i = 0 ; i < lists.size(); i ++) {

				Map<String, Object> map = lists.get(i);
				
				BigInteger houseId = (BigInteger) map.get("id");
				if( tempIds.containsKey(houseId) ){
					
					//合并单元格，如果房屋id相同则合并
					for(int n = 0 ; n < 9 ; n++ ){
						sheet.addMergedRegion(new CellRangeAddress(i, i + 1, n , n));
					}
				} else {
				
					tempIds.put(houseId, houseId);
					num ++;
				
				}
				
				HSSFRow row = sheet.createRow( i + 1);

				HSSFCell cell11 = row.createCell(0);

				cell11.setCellValue(num);// 序号
				cell11.setCellStyle(centerstyle);

				HSSFCell cell12 = row.createCell(1);
				cell12.setCellValue(isNotBlank(map.get("proNo")));// 房屋产证
				cell12.setCellStyle(centerstyle);

				HSSFCell cell13 = row.createCell(2);
				cell13.setCellValue(isNotBlank(map.get("area")));// *房屋面积
				cell13.setCellStyle(centerstyle);

				HSSFCell cell14 = row.createCell(3);
				cell14.setCellValue(ViewTransfer
						.getHouseStatusMemo(isNotBlank(map.get("status"))));// *房屋状态
				cell14.setCellStyle(centerstyle);

				HSSFCell cell15 = row.createCell(4);
				cell15.setCellValue(isNotBlank(map.get("partitionName")));// 所在片区
				cell15.setCellStyle(centerstyle);
				
				HSSFCell cell16 = row.createCell(5);
				cell16.setCellValue(isNotBlank(map.get("storyNum")));// 所在楼栋
				cell16.setCellStyle(centerstyle);

				HSSFCell cell17 = row.createCell(6);
				cell17.setCellValue(isNotBlank(map.get("dyCode")));// 门牌号
				cell17.setCellStyle(centerstyle);

				HSSFCell cell18 = row.createCell(7);
				cell18.setCellValue(isNotBlank(map.get("floorNum")));// 所在楼层
				cell18.setCellStyle(centerstyle);

				HSSFCell cell19 = row.createCell(8);
				cell19.setCellValue(isNotBlank(map.get("roomNum")));// 室
				cell19.setCellStyle(centerstyle);
				
				
				HSSFCell cell20 = row.createCell(9);
				cell20.setCellValue(getType(map.get("type")));// 身份
				cell20.setCellStyle(centerstyle);

				HSSFCell cell21 = row.createCell(10);
				cell21.setCellValue(isNotBlank(map.get("userName")));// 姓名
				cell21.setCellStyle(centerstyle);

				HSSFCell cell22 = row.createCell(11);
				cell22.setCellValue(isNotBlank(map.get("idCard")));// 身份证
				cell22.setCellStyle(centerstyle);

				HSSFCell cell23 = row.createCell(12);
				cell23.setCellValue(isNotBlank(map.get("phoneNum")));// 电话号码
				cell23.setCellStyle(centerstyle);

//				HSSFCell cell34 = row.createCell(13);
//				Double amounts = 0.0;
//				String strAmouants = isNotBlank(map.get("amount"));
//				if (StringUtils.isNotBlank(strAmouants)) {
//					amounts = Double.valueOf(strAmouants);
//				}
//				cell34.setCellValue(amounts);// 金额
//				cell34.setCellStyle(centerstyle);

				HSSFCell cell24 = row.createCell(13);
				cell24.setCellValue(isNotBlank(map.get("remark")));// 备注
				cell24.setCellStyle(centerstyle);
				
			}
			
		  }
			
		return wb;
	}

	/*
	 * 组装excel文件第一行
	 * firstRowsVal 第一行各个cel值
	 */
	private void getFirstRowForExcel(HSSFWorkbook wb, HSSFSheet sheet , String [] firstRowsVal) {
		
		HSSFFont font = wb.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 11);
		
		//创建头单元格
		HSSFRow row0 = sheet.createRow(0);
		// 设置excel导出头样式
		HSSFCellStyle centerstyle0 = wb.createCellStyle();
		
		
		centerstyle0.setFont(font);
		centerstyle0.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		centerstyle0.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		centerstyle0.setBorderLeft((short) 1);
		centerstyle0.setBorderRight((short) 1);
		centerstyle0.setBorderTop((short) 1);
		centerstyle0.setBorderBottom((short) 10);
		centerstyle0.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 设置单元格的边框为粗体
		centerstyle0.setBottomBorderColor(HSSFColor.BLACK.index); // 设置单元格的边框颜色．
		centerstyle0.setFillForegroundColor(HSSFColor.WHITE.index);// 设置单元格的背景颜色．
		
		centerstyle0.setFont(font);
		centerstyle0.setFillForegroundColor(IndexedColors.TURQUOISE.getIndex());// 设置单元格的背景颜色．
		centerstyle0.setFillPattern(CellStyle.SOLID_FOREGROUND);
		
		//标题头信息
		for(int i =0 ; i < firstRowsVal.length ; i++){
			
			HSSFCell cell00 = row0.createCell(i);
			cell00.setCellValue(firstRowsVal[i]);
			cell00.setCellStyle(centerstyle0);
			if( i == 0 ){
				//设置宽度
				sheet.setColumnWidth(i, 10 * 256);
			} else {
				sheet.setColumnWidth(i, 20 * 256);
			}
		}
		
		//设置头单元格高度
		row0.setHeightInPoints(30);
	}

}
