package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.UnitPartition;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:27
 */
@Repository
public class UnitPartitionDao extends DaoImpl<UnitPartition, Long> implements IUnitPartitionDao {

	/**
	 * 分页获取获取小区期数
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getPageUnitPartition(int pageNo, int pageSize, Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		
		sql.append("select a.ID id,a.UNIT_ID unitId,b.UNIT_NAME unitName,a.PARTITION_NAME partitionName,a.ALIAS_NAME aliasName,a.REMARK remark"); 
		sql.append(" from DT_UNIT_PARTITION a "); 
		sql.append(" left join DT_UNIT b on b.ID = a.UNIT_ID where a.DELETED='N'"); 
		
		if (params.containsKey("unitId")) {
			sql.append(" and a.UNIT_ID=:unitId");
		}
		if (params.containsKey("aliasName")) {
			sql.append(" and a.ALIAS_NAME like :aliasName");
		}
		if (params.containsKey("id")) {
			sql.append(" and a.ID = :id");
		}
		
		List<Map<String, Object>> list = queryForMapList(sql.toString(), pageNo, pageSize, params);
		
		return list;
	}

	/**
	 * 获取小区期数总数
	 * @param params
	 * @return
	 */
	@Override
	public int getCountUnitPartition(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer();
		sql.append("select count(1) from DT_UNIT_PARTITION a"); 
		sql.append(" left join DT_UNIT b on b.ID = a.UNIT_ID where a.DELETED='N'"); 

		if (params.containsKey("unitId")) {
			sql.append(" and a.UNIT_ID=:unitId");
		}
		if (params.containsKey("aliasName")) {
			sql.append(" and a.ALIAS_NAME like :aliasName");
		}
		if (params.containsKey("id")) {
			sql.append(" and a.ID = :id");
		}
		
		return this.queryCount(sql.toString(), params);
	}

	/**
	 * 根据id查询
	 * @param id
	 * 		主键
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getUnitPartitionById(Long id) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		return this.getPageUnitPartition(-1, 1, params);
	}

	@Override
	public UnitPartition getPartitionByUnitIdAndPartitionName(Long unitId, String partitionName) {
		String sql = "SELECT * FROM DT_UNIT_PARTITION A WHERE A.DELETED = 'N' AND A.UNIT_ID = ? AND A.PARTITION_NAME = ?";
		return this.queryForObject(sql, UnitPartition.class, unitId, partitionName);
	}
	
	@Override
	public List<UnitPartition> getUnitPartitionListByUnitId(long unitId) {
		String sql = "SELECT * FROM DT_UNIT_PARTITION WHERE DELETED = ? AND UNIT_ID = ?";
		return query(sql, UnitPartition.class, new Object[]{Constant.MODEL_DELETED_N, unitId});
	}
	
}
