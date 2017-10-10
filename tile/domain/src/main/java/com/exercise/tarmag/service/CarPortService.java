package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.ICarGarageDao;
import com.dt.tarmag.dao.ICarPortDao;
import com.dt.tarmag.dao.IResidentDao;
import com.dt.tarmag.model.CarGarage;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.util.DataImportUtils;

@Service
public class CarPortService implements ICarPortService {
	
	@Autowired
	private IResidentDao residentDao;
	
	@Autowired
	private ICarGarageDao carGarageDao;
	
	@Autowired
	private ICarPortDao carPortDao;
	
	private static Map<Integer, String> mapField;
	
	private static Logger logger = Logger.getLogger(CarGarageService.class);
	
	/**
	 * 数据导入 Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer, String>();
		mapField.put(0, "所在车库*");
		mapField.put(1, "车位编码*");
		mapField.put(2, "车位状态*");
		mapField.put(3, "业主手机号");
	}
	

	@Override
	public void importCarPort_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException {
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

					HSSFCell cell0 = hssfRow.getCell(0); // 所在车库*   garageNo
					HSSFCell cell1 = hssfRow.getCell(1); // 车位编码*   portNo
					HSSFCell cell2 = hssfRow.getCell(2); // 车位状态*   bindType
					HSSFCell cell3 = hssfRow.getCell(3); // 业主手机号        phoneNum

					CarPort carPort = new CarPort();
					
					if (cell0 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell0))) {
						String garageNo = DataImportUtils.getValue(cell0);
						CarGarage carGarage = carGarageDao.getCarGarageByUnitIdAndGarageNo(unitId, garageNo);
						
						if(carGarage == null){
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，当前小区下不存在所填写的车库！");
							continue;
						}
						carPort.setGarageId(carGarage.getId());
						
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，所在车库不能为空！");
						continue;
					}

					if (cell1 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell1))) {
						String portNo = DataImportUtils.getValue(cell1);
						
						CarPort carPortTemp = carPortDao.getCarPortByNameAndGarageId(carPort.getGarageId(),portNo);
						
						if(carPortTemp != null && carPortTemp.getId() > 0){
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，所填写的车位编码，已存在！");
							continue;
						}
						carPort.setPortNo(portNo);
						
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，车位编码不能为空！");
						continue;
					}

					if (cell2 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell2))) {
						
						String bindType = DataImportUtils.getValue(cell2);
						
						Map<Byte, String> map = CarPort.getAllBindTypes();
						
						if(bindType.equals(map.get(CarPort.BIND_TYPE_IDLE))){
							carPort.setBindType(CarPort.BIND_TYPE_IDLE);
						}
						if(bindType.equals(map.get(CarPort.BIND_TYPE_SOLD))){
							carPort.setBindType(CarPort.BIND_TYPE_SOLD);
						}
						if(bindType.equals(map.get(CarPort.BIND_TYPE_RENT))){
							carPort.setBindType(CarPort.BIND_TYPE_RENT);
						}
						
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，车位状态不能为空！");
						continue;
					}
					
					if (cell3 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
						String phoneNum = DataImportUtils.getValue(cell3);
						Resident res = residentDao.getResidentByPhoneNum(phoneNum);
						if(res != null && res.getId() > 0){
							carPort.setBindResidentId(res.getId());
							carPort.setBindTime(new Date());
						}
					} 
					try{
						carPortDao.save(carPort);
						logger.debug("第" + String.valueOf(rowNum+1)+ " 行导入车位数据成功！");
					}catch(Exception e){
						throw new Exception("添加车位失败！");
					}
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
			msgList.add("导入车位数据成功！");
		}
		model.put("msg", msgList);
	}


}
