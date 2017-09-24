/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.BeanUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.ICompanyBranchDao;
import com.dt.tarmag.dao.ICompanyDao;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.util.PageResult;

/**
 * @author raymond
 *
 */
@Service
public class CompanyService implements ICompanyService {
	@Autowired
	private ICompanyDao companyDao;
	
	@Autowired
	private ICompanyBranchDao companyBranchDao;

	@Override
	public PageResult<Company> findCompany(Map<String, Object> params, Page page) {
		return this.companyDao.findCompany(params, page);
	}

	@Override
	public Company findCompanyById(long id) {
		return this.companyDao.get(id);
	}

	@Override
	public void saveCompany_tx(Company company) {
		if(company.getId() == 0l){
			company.setCode(this.companyDao.getMaxCode());
			this.companyDao.save(company);
			
			//公司组织根节点
			CompanyBranch branch = new CompanyBranch();
			branch.setCompanyId(company.getId());
			branch.setBranchName(company.getCompanyName());
			branch.setCode("001");
			branch.setRemark(company.getCompanyName());
			this.companyBranchDao.save(branch);
		}else{
			Company entity = this.companyDao.get(company.getId());
			BeanUtil.copyProperty(company, entity);
			this.companyDao.update(entity);
		}
	}

	@Override
	public void delete_tx(Long[] ids) {
		if(ids == null) return;
		for(Long id : ids){
			this.companyDao.deleteLogic(id);
		}
	}

	@Override
	public List<Company> findAll() {
		return this.companyDao.findAll();
	}
}
