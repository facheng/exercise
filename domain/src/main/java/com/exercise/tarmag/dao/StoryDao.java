package com.dt.tarmag.dao;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Story;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class StoryDao extends DaoImpl<Story, Long> implements IStoryDao {

	@Override
	public List<Story> getStorysByUnitId(Map<String, Object> params) {
		StringBuffer sql = new StringBuffer("SELECT * FROM DT_STORY WHERE DELETED='N'");
		if(params.containsKey("unitId")){
			sql.append(" AND UNIT_ID=:unitId");
		}
		return this.query(sql.toString(), Story.class, params);
	}

	/**
	 * 
	 * 根据楼栋编号 和小区id 获取楼栋
	 * @param story
	 * @return
	 */
	@Override
	public Story getStorysByUnitIdAndStoryNmu(Story story) {
		String sql = "SELECT a.* FROM DT_STORY a WHERE DELETED='N' and a.STORY_NUM = :storyNum and a.UNIT_ID = :unitId";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("storyNum", story.getStoryNum());
		params.put("unitId", story.getUnitId());
		return this.queryForObject(sql, Story.class, params );
	}

	@Override
	public List<Story> getStoryListByPartitionId(long partitionId) {
		String sql = "SELECT * FROM DT_STORY WHERE DELETED = ? AND PARTITION_ID = ?";
		return query(sql, Story.class, new Object[]{Constant.MODEL_DELETED_N, partitionId});
	}

	@Override
	public List<Story> getStoryListByUnitId(long unitId) {
		String sql = "SELECT * FROM DT_STORY WHERE DELETED = ? AND UNIT_ID = ?";
		return query(sql, Story.class, new Object[]{Constant.MODEL_DELETED_N, unitId});
	}

	@Override
	public List<Map<String, Object>> getStorysCountByUnitId(Long unitId) {
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(A.ID) counts , B.ALIAS_NAME aliasName FROM DT_STORY A INNER JOIN DT_UNIT_PARTITION B ON A.PARTITION_ID = B.ID");
		sql.append(" WHERE A.UNIT_ID =:unitId AND A.DELETED=:deleted");
		sql.append(" GROUP BY A.PARTITION_ID");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("unitId", unitId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		return queryForMapList(sql.toString(), params);
	}
}
