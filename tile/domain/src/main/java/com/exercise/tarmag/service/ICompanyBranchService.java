/*
 * 版权所有 团团科技 沪ICP备14043145号
 * 
 * 团团科技拥有此网站内容及资源的版权，受国家知识产权保护，未经团团科技的明确书面许可，
 * 任何单位或个人不得以任何方式，以中文和任何文字作全部和局部复制、转载、引用。
 * 否则本公司将追究其法律责任。
 * 
 * $Id$
 * $URL$
 */
package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.vo.Tree;


/**
 *组织架构管理
 * @author fxw
 * @since 2015年7月2日
 */
public interface ICompanyBranchService {
	
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
	 * 获取组织结构编码（子级）
	 * @param code
	 * 		组织架构编码
	 * @return
	 */
	public String getCode(String code) ;
	
	/**
	 * 添加或修改组织结构
	 * @param companyBranch
	 */
	public void saveOrUpdate_tx(CompanyBranch companyBranch);
	
	/**
	 * 
	 * 删除组织结构及其子级
	 * @param id
	 * 		组织结构主键
	 * @return
	 * 	 	true : 删除成功  false:删除失败
	 */
	public int delCompanyBranch_tx(Long id);
	
	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	List<Map<String, Object>> findCompanyBranchById(Map<String, Object> params);
	
	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	CompanyBranch getCompanyBranchById(Long id);

	/**
	 * 查询指定公司下的组织架构树
	 * @param unitId
	 * @return
	 */
	List<Tree> getCompanyBranchTreeByCompanyId(long companyId);

}
