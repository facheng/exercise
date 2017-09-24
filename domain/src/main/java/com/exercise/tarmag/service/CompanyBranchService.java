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

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Constant;
import com.dt.tarmag.dao.ICompanyBranchDao;
import com.dt.tarmag.dao.IUnitDao;
import com.dt.tarmag.model.CompanyBranch;
import com.dt.tarmag.model.Unit;
import com.dt.tarmag.vo.Tree;


/**
 *组织架构管理
 * @author fxw
 * @since 2015年7月2日
 */
@Service
public class CompanyBranchService implements ICompanyBranchService {
	
	@Autowired
	private ICompanyBranchDao companyBranchDao;

	@Autowired
	private IUnitDao unitDao;


	/**
	 * 分页获取组织架构数据类别
	 * @param pageNo
	 * @param pageSize
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getCompanyBranchList(long companyId,String branchName, int pageNo ,int pageSize) {
		return companyBranchDao.getCompanyBranchList(companyId,branchName,pageNo,pageSize);
	}

	/**
	 * 获取组织架构总数
	 * @param params
	 * @return
	 */
	@Override
	public int getCountCompanyBranch(long companyId,String branchName) {
		return companyBranchDao.getCountCompanyBranch(companyId,branchName);
	}

	/**
	 * 获取组织结构编码（子级）
	 * @param code
	 * 		组织架构编码
	 * @return
	 */
	@Override
	public String getCode(String code) {
		List<CompanyBranch> lists = companyBranchDao.getCompanyBranchByCode(code);
		//如果没有数据 则返回默认值
		if(lists == null || lists.size() == 0){
			return code + "001";
		}
		String chrildCode = lists.get(0).getCode();
		chrildCode = chrildCode.substring(code.length(),chrildCode.length());
		
		int intChrildCode = Integer.parseInt(chrildCode);
		intChrildCode++;
		if (intChrildCode <= 9) {
			chrildCode = "00" + String.valueOf(intChrildCode);
		}else if (intChrildCode <= 99) {
			chrildCode = "0" + String.valueOf(intChrildCode);
		}
		return code + chrildCode;
	}

	/**
	 * 添加或修改组织结构
	 * @param companyBranch
	 */
	@Override
	public void saveOrUpdate_tx(CompanyBranch companyBranch) {
		if(companyBranch.getId() == 0){//新增
			companyBranch.setCode(this.companyBranchDao.getMaxCode(companyBranch.getParentId()));
			companyBranchDao.saveOrUpdate(companyBranch);
		}else{
			CompanyBranch entity = this.companyBranchDao.get(companyBranch.getId());
			entity.setBranchName(companyBranch.getBranchName());
			entity.setRemark(companyBranch.getRemark());
			companyBranchDao.saveOrUpdate(entity);
		}
	}

	/**
	 * 
	 * 删除组织结构及其子级
	 * @param id
	 * 		组织结构主键
	 * @return
	 * 	 	true : 删除成功  false:删除失败
	 */
	@Override
	public int delCompanyBranch_tx(Long id) {
		CompanyBranch companyBranch = this.companyBranchDao.get(id);
		//判断此组织下面是否有其他组织
		//TODO 暂时这么处理，后面要改造
		List<CompanyBranch> companyBranchsByParentId = this.companyBranchDao.getCompanyBranchsByParentId(id);
		if(companyBranchsByParentId.size() > 0){//下面有子节点不能删除
			return 0;
		}
		List<Unit> unitsByBranchId = unitDao.getUnitsByBranchId(id, companyBranch.getCompanyId());
		if(unitsByBranchId.size() > 0){//下面有小区不能删除
			return 0;
		}
		companyBranch.setDeleted(Constant.MODEL_DELETED_Y);//状态删除
		this.companyBranchDao.save(companyBranch);
		return 1;
	}

	
	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	@Override
	public List<Map<String, Object>> findCompanyBranchById(Map<String, Object> params) {
		return companyBranchDao.geCompanyBranchById(params);
	}

	/**
	 * 
	 *根据 id 获取组织架构
	 * @param params
	 * @return
	 */
	@Override
	public CompanyBranch getCompanyBranchById(Long id) {
		return companyBranchDao.get(id);
	}

	@Override
	public List<Tree> getCompanyBranchTreeByCompanyId(long companyId) {
		Set<Tree> set = new TreeSet<Tree>(new Comparator<Tree>() {
            @Override
            public int compare(Tree a, Tree b) {
                return a.getId().compareTo(b.getId());
            }
        });
		
		List<CompanyBranch> cbList = companyBranchDao.getCompanyBranchListByCompanyId(companyId);
		for(CompanyBranch cb : cbList) {
			Tree tree = new Tree();
			tree.setId("" + cb.getId());
			tree.setpId("" + cb.getParentId());
			tree.setName(cb.getBranchName());
			tree.setOpen("false");
			tree.setValid(Tree.VALID_Y);
			set.add(tree);
		}
		
		return new ArrayList<Tree>(set);
	}
}
