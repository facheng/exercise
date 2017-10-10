package com.dt.tarmag.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.util.PageResult;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class CompanyDao extends DaoImpl<Company, Long> implements ICompanyDao {

	@Override
	public PageResult<Company> findCompany(final Map<String, Object> params,
			final Page page) {
		String selectSql = "SELECT *";
		String countSql = "SELECT COUNT(1)";
		StringBuffer whereBuf = new StringBuffer(" FROM DT_COMPANY WHERE DELETED=:deleted");
		if(params.containsKey("companyName")){
			whereBuf.append(" AND COMPANY_NAME LIKE :companyName");
			params.put("companyName", "%"+params.get("companyName")+"%");
		}
		List<Company> datas = this.query(selectSql+whereBuf, Company.class,
				page.getCurrentPage(), page.getPageSize(), params);
		int count = this.queryCount(countSql + whereBuf, params);
		page.setRowCount(count);
		return new PageResult<Company>(page, datas);
	}

	@Override
	public String getMaxCode() {
		String sql = "SELECT MAX(CODE) CODE FROM DT_COMPANY";
		List<Map<String, Object>> result = this.queryForMapList(sql);
		String code = "0001";
		if(!result.isEmpty() && result.get(0).get("CODE")!=null){
			code = result.get(0).get("CODE").toString();
			int len = code.length();
			int next = Integer.parseInt(code)+1;
			code = StringUtils.replenish(len - String.valueOf(next).length(), '0') + next;
		}
		return code;
	}

	@Override
	public List<Company> findAll() {
		String sql = "SELECT * FROM DT_COMPANY WHERE DELETED='N'";
		return this.query(sql, Company.class);
	}
}
