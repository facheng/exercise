/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import org.springframework.ui.ModelMap;

import com.dt.tarmag.model.Story;
import com.dt.tarmag.vo.Tree;

/**
 * @author raymond
 *
 */
public interface IStoryService {
	/**
	 * 根据小区获取小区下面的楼栋
	 * @param unitId
	 * @return
	 */
	public List<Map<String, Object>> getStorysByUnitId(Long unitId) ;
	
	/**
	 * 
	 * 根据楼栋编号 和小区id 获取楼栋
	 * @param story
	 * @return
	 */
	public Story findStorysByUnitIdAndStoryNmu(Story story);

	/**
	 * 楼栋信息导入
	 * @param inputStream
	 * @param unitId 
	 * @throws IOException
	 */
	public void importStory_tx(InputStream inputStream, Long unitId ,ModelMap model) throws IOException;
	
	/**
	 * 查询指定小区下所有楼栋
	 * @param unitId
	 * @return
	 */
	List<Tree> getStoryTreeByUnitId(long unitId);
	
	/**
	 * 获取当前小区 期数下的所有楼栋
	 * @param partitionId
	 * @return
	 */
	public List<Story> getStoryListByPartitionId(long partitionId);
	
	List<Map<String, Object>> getStoryMapListByPartitionId(long partitionId);
	
	/**
	 * 统计当前小区下所有期数下的楼栋数量
	 * @param unitId
	 * @return
	 */
	public List<Map<String, Object>> getStorysCountByUnitId(Long unitId);
}
