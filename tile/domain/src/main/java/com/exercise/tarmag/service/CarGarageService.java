package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
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
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.CarGarage;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.util.DataImportUtils;

@Service
public class CarGarageService implements ICarGarageService {
	
	@Autowired
	private ICarGarageDao carGarageDao;
	
	@Autowired
	private IUnitPartitionDao unitPartitionDao;
	
	private static Map<Integer, String> mapField;
	
	private static Logger logger = Logger.getLogger(CarGarageService.class);
	
	/**
	 * 数据导入 Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer, String>();
		mapField.put(0, "片区*");
		mapField.put(1, "车库号*");
		mapField.put(2, "车库纬度");
		mapField.put(3, "车库经度");
	}
	

	@Override
	public void importCarGarage_tx(InputStream inputStream, Long unitId, ModelMap model) throws IOException {
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

					HSSFCell cell0 = hssfRow.getCell(0); // 片区*     partitionId
					HSSFCell cell1 = hssfRow.getCell(1); // 车库号*   garageNo
					HSSFCell cell2 = hssfRow.getCell(2); // 车库纬度       lantitude
					HSSFCell cell3 = hssfRow.getCell(3); // 车库经度        longitude

					CarGarage carGarage = new CarGarage();

					if (cell0 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell0))) {
						String partition = DataImportUtils.getValue(cell0);
						UnitPartition up = unitPartitionDao.getPartitionByUnitIdAndPartitionName(unitId, partition);
						
						if(up != null && up.getId() > 0){
							carGarage.setPartitionId(up.getId());
						}else{
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，当前小区下不存在所填写的片区！");
							continue;
						}
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，片区不能为空！");
						continue;
					}

					if (cell1 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell1))) {
						String garageNo = DataImportUtils.getValue(cell1);
						
						CarGarage CarGarageTemp = carGarageDao.getGarageByPartitionIdAndGarageNo(carGarage.getPartitionId(),garageNo);
						if(CarGarageTemp != null && CarGarageTemp.getId() > 0){
							msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，片区下该车库号已存在！");
							continue;
						}
						
						carGarage.setGarageNo(garageNo);
					} else {
						msgList.add("第" + String.valueOf(rowNum + 1) + " 行未导入 ，车库号不能为空！");
						continue;
					}

					if (cell2 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell2))) {
						String lantitude = DataImportUtils.getValue(cell2);
						carGarage.setLantitude(Double.parseDouble(lantitude));
					} 
					if (cell3 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell3))) {
						String longitude = DataImportUtils.getValue(cell3);
						carGarage.setLongitude(Double.parseDouble(longitude));
					} 
					try{
						carGarageDao.save(carGarage);
						logger.debug("第" + String.valueOf(rowNum+1)+ " 行导入车库数据成功！");
					}catch(Exception e){
						throw new Exception("添加车库失败！");
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
			msgList.add("导入车库数据成功！");
		}
		model.put("msg", msgList);
	}

}
