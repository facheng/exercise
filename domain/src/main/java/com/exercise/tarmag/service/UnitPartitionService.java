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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Constant;
import com.dt.tarmag.dao.IUnitPartitionDao;
import com.dt.tarmag.model.UnitPartition;


/**
 * 小区期数
 *
 * @author Administrator
 * @since 2015年7月7日
 */
@Service
public class UnitPartitionService implements IUnitPartitionService {
	
	@Autowired
	private IUnitPartitionDao unitPartitionDao;

	/**
	 * 分页获取获取小区期数
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findPageUnitPartition(int pageNo, int pageSize, Map<String, Object> params) {
		return unitPartitionDao.getPageUnitPartition(pageNo, pageSize, params);
	}

	/**
	 * 获取小区期数总数
	 * @param params
	 * @return
	 */
	@Override
	public int findCountUnitPartition(Map<String, Object> params) {
		return unitPartitionDao.getCountUnitPartition(params);
	}

	/**
	 * 添加或修改
	 * @param unitPartition
	 * @throws Exception 
	 */
	@Override
	public void saveOrUpdate_tx(UnitPartition unitPartition) throws Exception {
		try{
			if(unitPartition.getId() != 0){
				UnitPartition unitPartitionTemp = unitPartitionDao.get(unitPartition.getId());
				unitPartitionTemp.setPartitionName(unitPartition.getPartitionName());
				unitPartitionTemp.setAliasName(unitPartition.getAliasName());
				unitPartitionTemp.setRemark(unitPartition.getRemark());
				unitPartitionDao.update(unitPartitionTemp);
			}else{
				unitPartitionDao.save(unitPartition);
			}
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception("添加更新小区期数失败！");
		}
	}

	/**
	 * 删除
	 * @param unitPartition
	 * @throws Exception 
	 */
	@Override
	public void delUnitPartition_tx(long id) throws Exception {
		if(id != 0){
			UnitPartition unitPartitionTemp = unitPartitionDao.get(id);
			unitPartitionTemp.setDeleted(Constant.MODEL_DELETED_Y);
			unitPartitionDao.update(unitPartitionTemp);
		}else{
			throw new Exception("获取小区ID失败！");
		}
	}

	/**
	 * 根据id查询
	 * @param id
	 * 		主键
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findUnitPartitionById(Long id) {
		return unitPartitionDao.getUnitPartitionById(id);
	}

	@Override
	public UnitPartition getPartitionByUnitIdAndPartitionName(Long unitId, String partitionName) {
		return unitPartitionDao.getPartitionByUnitIdAndPartitionName(unitId, partitionName);
	}

	@Override
	public List<UnitPartition> getUnitPartitionListByUnitId(Long unitId) {
		return unitPartitionDao.getUnitPartitionListByUnitId(unitId);
	}
	
	@Override
	public List<Map<String, Object>> getUnitPartitionMapListByUnitId(long unitId) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<UnitPartition> upList = unitPartitionDao.getUnitPartitionListByUnitId(unitId);
		if(upList == null || upList.size() <= 0) {
			return mapList;
		}
		
		for(UnitPartition up : upList) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", up.getId());
			map.put("name", up.getPartitionName());
			map.put("aliasName", up.getAliasName());
			mapList.add(map);
		}
		
		return mapList;
	}

}
