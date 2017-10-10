package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.util.PageResult;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:46:30
 */
public interface ICompanyDao extends Dao<Company, Long> {
	
	/**
	 * 通过条件查询公司
	 * @param params
	 * @return
	 */
	public PageResult<Company> findCompany(final Map<String, Object> params, final Page page);
	
	/**获取最大编码
	 * @return
	 */
	public String getMaxCode();
	
	
	/**
	 * 查询所有公司
	 * @return
	 */
	public List<Company> findAll();
}
