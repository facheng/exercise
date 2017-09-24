package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.vo.CommonWordsVo;


public interface ICommonWordsService {
 
	/**
	 * 查询常用语个数
	 * unitId 小区id
	 * vo 查询参数
	 */
	public int getCommonWordsCount( CommonWordsVo vo);
	
	/**
	 * 分页获取常用语信息
	 * @param unitId
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	
	public List<Map<String, Object>> getCommonWordsList( CommonWordsVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 查询常用语
	 * @param carId
	 * @return
	 */
	public Map<String, Object> getCommonWordsDetail(long commonWordsId);
	
	/**
	 * 修改常用语
	 * @param carId
	 * @param vo
	 */
	public boolean updateCommonWords_tx(Long carId, CommonWordsVo vo);
	
	/**
	 * 删除常用语
	 * @param commonWordsIds
	 */
	public boolean deleteCommonWords_tx(List<Long> commonWordsIds);
	
	/**
	 * 添加常用语
	 * @param vo
	 */
	public boolean createCommonWords_tx( CommonWordsVo vo );
	
	/**
	 * 通过常用语类别查询
	 * @param vo
	 */
	public List<CommonWords> getCommonWordsVoByType( int type , long unitId);
	
}
