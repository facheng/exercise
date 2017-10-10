package com.dt.tarmag.dao;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.vo.CommonWordsVo;

/**
 * @author yuwei
 * @Time 2015-8-12下午03:31:39
 */
@Repository
public class CommonWordsDao extends DaoImpl<CommonWords, Long> implements ICommonWordsDao {

	@Override
	public int getCommonWordsCount( CommonWordsVo searchVo) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT COUNT(a.ID) FROM DT_COMMON_WORDS a ")
			.append(" LEFT JOIN DT_CUSTOMER b ON a.CREATE_USER_ID = b.ID AND b.DELETED = :deleted ")
			.append(" WHERE a.DELETED = :deleted ")
			.append(" AND a.UNIT_ID = :unitId");
		
		//设置参数
		Map<String , Object > params = new HashMap<String , Object >();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", searchVo.getUnitId());
		
		if( searchVo != null ){
			
			if( searchVo.getType() != 0 ){
				sql.append(" AND a.TYPE = :type");
				params.put("type", searchVo.getType());
			}
			
			if( searchVo.getWords() != null && !"".equals(searchVo.getWords().trim())){
				sql.append(" AND a.WORDS LIKE :words");
				params.put("words", "%" + searchVo.getWords() + "%" );
			}
			
			if( searchVo.getCreaterName() != null && !"".equals(searchVo.getCreaterName().trim())){
				sql.append(" AND b.USER_NAME LIKE :createrName");
				params.put("createrName", "%" + searchVo.getCreaterName() + "%" );
			}
		}
		
		return queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getCommonWordsList(CommonWordsVo searchVo, int pageNo, int pageSize) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.ID commonWordsId , a.TYPE type , a.WORDS words , b.USER_NAME createrName  ")
			.append(" FROM DT_COMMON_WORDS a ")
			.append(" LEFT JOIN DT_CUSTOMER b ON a.CREATE_USER_ID = b.ID AND b.DELETED = :deleted ")
			.append(" WHERE a.DELETED = :deleted ")
			.append(" AND a.UNIT_ID = :unitId");
		
		//设置参数
		Map<String , Object > params = new HashMap<String , Object >();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", searchVo.getUnitId());
		
		if( searchVo != null ){
			
			if( searchVo.getType() != 0 ){
				sql.append(" AND a.TYPE = :type");
				params.put("type", searchVo.getType());
			}
			
			if( searchVo.getWords() != null && !"".equals(searchVo.getWords().trim())){
				sql.append(" AND a.WORDS LIKE :words");
				params.put("words", "%" + searchVo.getWords() + "%" );
			}
			
			if( searchVo.getCreaterName() != null && !"".equals(searchVo.getCreaterName().trim())){
				sql.append(" AND b.USER_NAME LIKE :createrName");
				params.put("createrName", "%" + searchVo.getCreaterName() + "%" );
			}
		}
		
		sql.append(" ORDER BY a.CREATE_DATE_TIME DESC ");
		
		return queryForMapList(sql.toString(), pageNo, pageSize, params);
		
	}

	@Override
	public List<CommonWords> getCommonWordsVoByType(int type , long unitId) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT a.* FROM DT_COMMON_WORDS a WHERE a.TYPE = :type AND a.DELETED = :deleted ")
			.append(" AND a.UNIT_ID = :unitId");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("type", type);
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("unitId", unitId);
		
		return this.query(sql.toString() , CommonWords.class, params);
	}
	
}
