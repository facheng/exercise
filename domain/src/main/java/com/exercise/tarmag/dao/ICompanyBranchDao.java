package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.tarmag.model.CompanyBranch;


/**
 * @author yuwei
 * @Time 2015-6-25下午12:46:33
 */
public interface ICompanyBranchDao extends Dao<CompanyBranch, Long> {
	/**
	 * 获取顶级组织架构
	 * @return
	 */
	public CompanyBranch getRoot(Long companyId);
	/**
	 * 分页获取组织架构数据类别
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getCompanyBranchList(long companyId,String branchName, int pageNo ,int pageSize);
	
	/**
	 * 获取组织架构总数
	 * @param branchName
	 * @return
	 */
	int getCountCompanyBranch(long companyId,String branchName);
	
	/**
	 * 根据组织架构编码获取 数据（获取的是其子级的数据）
	 * @param code
	 * 		组织架构编码
	 * @return
	 */
	List<CompanyBranch> getCompanyBranchByCode(String code);
	
	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> geCompanyBranchById(Map<String, Object> params);
	
	/**获取最大编码
	 * @return
	 */
	public String getMaxCode(Long parentId);
	/**
	 * 获取父节点下的子对象
	 * @param parentId
	 * @return
	 */
	public List<CompanyBranch> getCompanyBranchsByParentId(Long parentId);
	
	/**
	 * 查询指定公司下的组织集合
	 * @param companyId
	 * @return
	 */
	List<CompanyBranch> getCompanyBranchListByCompanyId(long companyId);
	
}
