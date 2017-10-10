package com.dt.tarmag.dao;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository

public class CompanyBranchDao extends DaoImpl<CompanyBranch, Long> implements ICompanyBranchDao {


	@Override
	public CompanyBranch getRoot(Long companyId) {
		String sql = "SELECT * FROM DT_COMPANY_BRANCH WHERE DELETED='N' AND PARENT_ID=:parentId AND COMPANY_ID=:companyId";
		return this.queryForObject(sql, CompanyBranch.class, Params.getParams()
				.add("companyId", companyId).add("parentId", 0));
	}

	/**
	 * 分页获取组织架构数据类别
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getCompanyBranchList(long companyId,String branchName, int pageNo ,int pageSize) {
		Map<String, Object> params = new HashMap<String, Object>();
		String sql = "select a.ID id,a.CODE code,a.BRANCH_NAME branchName,b.BRANCH_NAME parentName ,a.PARENT_ID parentId from DT_COMPANY_BRANCH a left join DT_COMPANY_BRANCH b on a.PARENT_ID = b.ID where a.DELETED =:deleted and a.COMPANY_ID =:companyId ";
		if(branchName != null && !"".equals(branchName.trim())){
			sql+= " and a.BRANCH_NAME like :branchName";
			params.put("branchName", "%" + branchName.trim() + "%");
		}
		sql += " order by a.CODE ";
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		return this.queryForMapList(sql, pageNo, pageSize, params);
	}

	/**
	 * 获取组织架构总数
	 * @param branchName
	 * @return
	 */
	@Override
	public int getCountCompanyBranch(long companyId,String branchName) {
		Map<String, Object> params = new HashMap<String, Object>();
		String sql = "select count(1) from DT_COMPANY_BRANCH a where a.DELETED =:deleted and a.COMPANY_ID =:companyId ";
		if(branchName != null && !"".equals(branchName.trim())){
			sql+= " and a.BRANCH_NAME like :branchName";
			params.put("branchName", "%" + branchName.trim() + "%");
		}
		params.put("companyId", companyId);
		params.put("deleted", Constant.MODEL_DELETED_N);
		return this.queryCount(sql, params);
	}

	/**
	 * 根据组织架构编码获取 数据（获取的是其子级的数据）
	 * @param code
	 * 		组织架构编码
	 * @return
	 */
	@Override
	public List<CompanyBranch> getCompanyBranchByCode(String code) {
		String sql = "select * from DT_COMPANY_BRANCH a where a.CODE like '"+code+"___' order by a.CODE desc";
		return this.query(sql, CompanyBranch.class);
	}

	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> geCompanyBranchById(Map<String, Object> params) {
		String sql = "select a.ID as id ,  a.CODE as code,a.BRANCH_NAME as branchName ,a.PARENT_ID as parentId ,a.REMARK as remark,"
					  +" (select  b.BRANCH_NAME  from DT_COMPANY_BRANCH b where b.id = a.PARENT_ID) as parentName "
				      +" from DT_COMPANY_BRANCH a where a.ID =:id";
		return this.queryForMapList(sql, params);
	}

	@Override
	public String getMaxCode(Long parentId) {
		CompanyBranch parentBranch = this.get(parentId);//父对象
		String querySql = " select count(1) from DT_COMPANY_BRANCH where PARENT_ID = ? ";
		int queryCount = this.queryCount(querySql, parentId);//父对象下面的子对象数量
		Integer codeNum = new Integer(queryCount + 1);
		DecimalFormat df = new DecimalFormat("000");
	    return parentBranch.getCode() + df.format(codeNum);
	}

	@Override
	public List<CompanyBranch> getCompanyBranchsByParentId(Long parentId) {
		String sql = "select * from DT_COMPANY_BRANCH a where a.PARENT_ID = ?";
		return this.query(sql, CompanyBranch.class,parentId);
	}
	
	@Override
	public List<CompanyBranch> getCompanyBranchListByCompanyId(long companyId) {
		String sql = "SELECT * from DT_COMPANY_BRANCH WHERE COMPANY_ID = ? AND DELETED = ?";
		return query(sql, CompanyBranch.class, new Object[]{companyId, Constant.MODEL_DELETED_N});
	}
	
}
