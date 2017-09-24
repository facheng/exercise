package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.vo.CommonWordsVo;


/**
 * @author yuwei
 * @Time 2015-8-12下午03:30:59
 */
public interface ICommonWordsDao extends Dao<CommonWords, Long> {
	/**
	 * 
	 *	查询常用语条数
	 * @param unitId 小区id
	 * @param searchVo 查询条件
	 */
	public int getCommonWordsCount( CommonWordsVo searchVo);
	
	/**
	 * 
	 * 查询常用语
	 * @param unitId 小区id
	 * @param searchVo 查询条件
	 * @param pageNo 
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> getCommonWordsList(CommonWordsVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 根据常用语类型查询
	 * @param type
	 * @return
	 */
	
	public List<CommonWords > getCommonWordsVoByType (int type , long unitId);
}
