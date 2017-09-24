package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.vo.ProfitEcomVo;


/**
 * @author yuwei
 * @Time 2015-8-13下午05:36:51
 */
public interface IProfitEcomDao extends Dao<ProfitEcom, Long> {
	
	ProfitEcom getProfitEcomByCode(String code);
	
	/**
	 * 查询电商信息
	 * @param searchVo
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public List<Map<String, Object>> findPageProfitEcom( ProfitEcomVo searchVo, int pageNo, int pageSize);
	
	/**
	 * 
	 *	查询电商信息个数
	 * @param searchVo 查询条件
	 */
	public int getProfitEcomCount( ProfitEcomVo searchVo);
	
	/**
	 * 
	 *	查询电商详细信息
	 * @param searchVo 查询条件
	 */
	public List<Map<String, Object>> getProfitEcomDetail ( ProfitEcomVo searchVo);
	
	/**
	 * 查询电商信息(用来校验电商代码是否重复)
	 * @param searchVo
	 * @return
	 */
	public ProfitEcom getProfitEcomBysearchVo(ProfitEcomVo searchVo);
	
	/**
	 * 查询电商列表
	 * @return
	 */
	public List<ProfitEcom> getProfitEcomList();
	
	public ProfitEcom getProfitEcomById(Long id);
}
