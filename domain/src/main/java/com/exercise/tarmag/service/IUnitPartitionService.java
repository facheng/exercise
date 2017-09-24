/*
 * 版权所有 团团科技 沪ICP备14043145号
 * 
 * 团团科技拥有此网站内容及资源的版权，受国家知识产权保护，未经团团科技的明确书面许可，
 * 任何单位或个人不得以任何方式，以中文和任何文字作全部和局部复制、转载、引用。
 * 否则本公司将追究其法律责任。
 * 
 * $Id$
 * $URL$
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.UnitPartition;


/**
 * 小区期数
 *
 * @author Administrator
 * @since 2015年7月7日
 */
public interface IUnitPartitionService {
	
	/**
	 * 分页获取获取小区期数
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> findPageUnitPartition(int pageNo, int pageSize ,Map<String, Object> params);
	
	/**
	 * 获取小区期数总数
	 * @param params
	 * @return
	 */
	int findCountUnitPartition(Map<String, Object> params);
	
	/**
	 * 添加或修改
	 * @param unitPartition
	 * @throws Exception 
	 */
	public void saveOrUpdate_tx(UnitPartition unitPartition) throws Exception;
	
	/**
	 * 删除
	 * @param unitPartition
	 * @throws Exception 
	 */
	public void delUnitPartition_tx(long id) throws Exception;
	
	/**
	 * 根据id查询
	 * @param id
	 * 		主键
	 * @return
	 */
	public List<Map<String, Object>> findUnitPartitionById(Long id);
	
	/**
	 * 根据小区ID和片区名称查询片区
	 * @param unitId
	 * @param partitionName
	 * @return
	 */
	public UnitPartition getPartitionByUnitIdAndPartitionName(Long unitId, String partitionName);
	
	/**
	 * 查询当前小区下所有期数
	 * @param unitId
	 * @return
	 */
	public List<UnitPartition> getUnitPartitionListByUnitId(Long unitId);

	List<Map<String, Object>> getUnitPartitionMapListByUnitId(long unitId);
}
