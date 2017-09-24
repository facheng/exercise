package com.dt.tarmag.util;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;


public class DataImportUtils {
	
	/**
	 * 导入文件格式校验
	 * @param inputStream
	 * @throws IOException 
	 */
	public static boolean checkFileImport(HSSFSheet hssfSheet ,Map<Integer ,String> mapField) throws IOException{
		boolean result = false;
		if(hssfSheet != null && hssfSheet.getLastRowNum() > 5){
			HSSFRow hssfRow = hssfSheet.getRow(5);
			for (int i = 0; i < hssfRow.getLastCellNum() ; i++) {
				if(hssfRow.getCell(i) != null ){
					HSSFCell cell = hssfRow.getCell(i); 
					String cellValue = getValue(cell);
					if(cellValue.trim().equals(mapField.get(i))){
						continue;
					}else{
						return result;
					}
				}
			}
			result = true;
		}
		return result;
	}
	
	/**
	 * Excel 数据处理
	 * @param hssfCell
	 * @return
	 */
	@SuppressWarnings("static-access")
	public static String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			// 返回布尔类型的值
			return String.valueOf(hssfCell.getBooleanCellValue()).trim();
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			// 返回数值类型的值
			DecimalFormat df = new DecimalFormat("0");

			String str = df.format(hssfCell.getNumericCellValue());
			return str.trim();
		} else {
			// 返回字符串类型的值
			return String.valueOf(hssfCell.getStringCellValue()).trim();
		}
	}

}
