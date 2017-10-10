/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.dt.framework.util.StringUtils;
import com.dt.tarmag.dao.IStoryDao;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.model.UnitPartition;
import com.dt.tarmag.util.DataImportUtils;
import com.dt.tarmag.util.Params;
import com.dt.tarmag.vo.Tree;

/**
 * @author raymond
 *
 */
@Service
public class StoryService implements IStoryService {

	@Autowired
	private IStoryDao storyDao;
	@Autowired
	private IUnitPartitionDao unitPartitionDao;
	
	private static Map<Integer ,String> mapField; 
	
	private static Logger logger = Logger.getLogger(StoryService.class);

	@Override
	public List<Map<String, Object>> getStorysByUnitId(Long unitId) {
		List<Map<String, Object>> maps = new ArrayList<Map<String, Object>>();
		for (Story story : this.storyDao.getStorysByUnitId(Params.getParams()
				.add("unitId", unitId))) {
			maps.add(story.toMap(new String[] { "id", "storyNum" }));
		}
		return maps;
	}

	/**
	 * 
	 * 根据楼栋编号 和小区id 获取楼栋
	 * @param story
	 * @return
	 */
	@Override
	public Story findStorysByUnitIdAndStoryNmu(Story story) {
		try {
			return storyDao.getStorysByUnitIdAndStoryNmu(story);
		}
		catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@Override
	public void importStory_tx(InputStream inputStream ,Long unitId , ModelMap model) throws IOException {
		
		HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);
		HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(0);
		List<String> msgList = new ArrayList<String>();
		boolean result = DataImportUtils.checkFileImport(hssfSheet , mapField);
		try{
			if(result){
				model.put("importMsg", "success");
				for (int rowNum = 6; rowNum <= hssfSheet.getLastRowNum(); rowNum++) { 
					HSSFRow hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow == null) {
						msgList.add("导入模版为空 ，请填写导入信息！");
						break;
					}
					HSSFCell cell0 = hssfRow.getCell(0); //片区* partitionName
					HSSFCell cell1 = hssfRow.getCell(1); //楼号* storyNum
					HSSFCell cell2 = hssfRow.getCell(2); //层高* floorCount
					HSSFCell cell3 = hssfRow.getCell(3); //有无电梯* hasLift
					HSSFCell cell4 = hssfRow.getCell(4); //楼栋纬度 lantitude
					HSSFCell cell5 = hssfRow.getCell(5); //楼栋经度 longitude
					
					Story story = new Story();
					story.setUnitId(unitId);
					
					UnitPartition unitPartition = new UnitPartition();
					if(cell0 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell0))){
						String partitionName = DataImportUtils.getValue(cell0);
						unitPartition = unitPartitionDao.getPartitionByUnitIdAndPartitionName(unitId,partitionName);
						if(unitPartition != null){
							story.setPartitionId(unitPartition.getId());
						}else{
							UnitPartition unitPartitionTemp = new UnitPartition();
							try{
								unitPartitionTemp.setUnitId(unitId);
								unitPartitionTemp.setPartitionName(partitionName);
								unitPartitionDao.save(unitPartitionTemp);
								unitPartition = unitPartitionDao.getPartitionByUnitIdAndPartitionName(unitId,partitionName);
								story.setPartitionId(unitPartition.getId());
							}catch(Exception e){
								msgList.add("第" + String.valueOf(rowNum+1)+ "行出错 ，获取片区失败！");
								continue;
							}
						}
					}else{
						msgList.add("第" + String.valueOf(rowNum+1)+ "行未导入 ，片区不能为空！");
						continue;
					}
					if(cell1 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell1))){
						String storyNum = DataImportUtils.getValue(cell1);
						story.setStoryNum(storyNum);
					}else{
						msgList.add("第" + String.valueOf(rowNum+1)+ "行未导入，楼栋号不能为空！");
						continue;
					}
					if(cell2 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell2))){
						String floorCount = DataImportUtils.getValue(cell2);
						story.setFloorCount(Integer.valueOf(floorCount));
					}else{
						msgList.add("第" + String.valueOf(rowNum+1)+ " 行未导入 ，层高不能为空！");
						continue;
					}
					
					if(cell3 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell3))){
						String hasLift = DataImportUtils.getValue(cell3);
						if(hasLift.equals(Story.getHasLiftByCode(Story.HAS_LIFT_NO))){
							story.setHasLift(Story.HAS_LIFT_NO);
						}else if(hasLift.equals(Story.getHasLiftByCode(Story.HAS_LIFT_YES))){
							story.setHasLift(Story.HAS_LIFT_YES);
						}
					}else{
						msgList.add("第" + String.valueOf(rowNum+1)+ " 行未导入 ，有无电梯不能为空！");
						continue;
					}
					
					if(cell4 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell4))){
						String lantitude = DataImportUtils.getValue(cell4);
						story.setLantitude(Double.valueOf(lantitude));
						
					}
					if(cell5 != null && StringUtils.isNotBlank(DataImportUtils.getValue(cell5))){
						String longitude = DataImportUtils.getValue(cell5);
						story.setLongitude(Double.valueOf(longitude));
					}
					
					Story storyTemp = storyDao.getStorysByUnitIdAndStoryNmu(story);
					
					if(storyTemp != null){
						msgList.add("第" + String.valueOf(rowNum+1)+ " 行未导入 ，该楼栋已存在！");
						continue;
					}
					storyDao.save(story);
					logger.debug("第" + String.valueOf(rowNum+1)+ " 行导入楼栋成功！");
				}
			}else{
				model.put("importMsg", "fail");
				msgList.add("校验导入文档格式失败！，请重新填写！");
			}
		}catch(Exception e){
			msgList.removeAll(msgList);
			msgList.add("导入数据失败！");
		}
		if(msgList.size() == 0){
			msgList.add("导入楼栋数据成功！");
		}
		model.put("msg", msgList);
	}
	
	/**
	 * Excel 文档校验
	 */
	static {
		mapField = new HashMap<Integer , String>();
		mapField.put(0, "片区*");
		mapField.put(1, "楼号*");
		mapField.put(2, "层高*");
		mapField.put(3, "有无电梯*");
		mapField.put(4, "楼栋纬度");
		mapField.put(5, "楼栋经度");
	}

	
	@Override
	public List<Tree> getStoryTreeByUnitId(long unitId) {
		Set<Tree> set = new TreeSet<Tree>(new Comparator<Tree>() {
            @Override
            public int compare(Tree a, Tree b) {
                return a.getId().compareTo(b.getId());
            }
        });
		
		List<Story> storyList = storyDao.getStoryListByUnitId(unitId);
		for(Story story : storyList) {
			UnitPartition up = unitPartitionDao.get(story.getPartitionId());
			if(up == null) {
				continue;
			}
			
			Tree sTree = new Tree();
			sTree.setId("" + story.getId());
			sTree.setpId("u" + story.getPartitionId());
			sTree.setName(story.getStoryNum());
			sTree.setOpen("false");
			sTree.setValid(Tree.VALID_Y);
			set.add(sTree);
			
			Tree uTree = new Tree();
			uTree.setId("u" + up.getId());
			uTree.setpId("0");
			uTree.setName(up.getPartitionName());
			uTree.setOpen("false");
			uTree.setValid(Tree.VALID_N);
			set.add(uTree);
		}
		
		return new ArrayList<Tree>(set);
	}

	@Override
	public List<Story> getStoryListByPartitionId(long partitionId) {
		return storyDao.getStoryListByPartitionId(partitionId);
	}
	
	@Override
	public List<Map<String, Object>> getStoryMapListByPartitionId(long partitionId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<Story> storyList = storyDao.getStoryListByPartitionId(partitionId);
		if(storyList == null || storyList.size() <= 0) {
			return mapList;
		}
		
		for(Story story : storyList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", story.getId());
			map.put("storyNum", story.getStoryNum());
			mapList.add(map);
		}
		
		return mapList;
	}

	@Override
	public List<Map<String, Object>> getStorysCountByUnitId(Long unitId) {
		return storyDao.getStorysCountByUnitId(unitId);
	}
}
