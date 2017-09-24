/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.util.PageResult;

/**
 * @author raymond
 *
 */
public interface ICompanyService {
	/**
	 * 根据条件分页查询公司
	 * @param params
	 * @param page
	 * @return
	 */
	public PageResult<Company> findCompany(final Map<String, Object> params,
			final Page page);
	
	/**
	 * 根据id获取公司
	 * @param id
	 * @return
	 */
	public Company findCompanyById(long id);
	
	/**
	 * 保存公司信息
	 * @param company
	 */
	public void saveCompany_tx(Company company);
	
	/**
	 * 删除公司
	 * @param ids
	 */
	public void delete_tx(Long[] ids);
	
	/**
	 * 查询所有公司
	 * @return
	 */
	public List<Company> findAll();
}
