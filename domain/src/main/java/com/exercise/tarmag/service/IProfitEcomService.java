package com.dt.tarmag.service;


import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitEcomVo;


/**
 * 电商电商基本资料(清结算)
 * @author wangfacheng
 * @Time 2015年8月14日11:16:18
 *
 */
public interface IProfitEcomService {

	/**
	 * 根据条件分页查询电商信息
	 * @param searchVo
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> findPageProfitEcom(final ProfitEcomVo searchVo,
			final Page page);
	
	/**
	 * 根据id获取电商信息
	 * @param id
	 * @return
	 */
	public Map<String , Object> getProfitEcomDetailById(long id);
	
	/**
	 * 保存电商信息
	 * @param  vo
	 */
	public void saveProfitEcom_tx(ProfitEcomVo vo);
	
	/**
	 * 删除电商
	 * @param ids
	 */
	public void deleteProfitEcom_tx(Long[] ids);
	
	/**
	 * 更新电商信息
	 * @param commonWordsId
	 * @param vo
	 * @return
	 */
	public boolean updateProfitEcom_tx(Long profitEcomId, ProfitEcomVo vo);
	
	/**
	 * 检查电商代码是否重复
	 */
	public boolean checkIsNotExistProfitEcom(ProfitEcomVo vo);
	
}
