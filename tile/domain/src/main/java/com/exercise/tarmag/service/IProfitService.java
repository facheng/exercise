package com.dt.tarmag.service;

import java.util.List;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.ProfitConsumeRec;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitBalanceOutVo;


/**
 * 清结算
 * @author yuwei
 * @Time 2015-8-14下午04:53:58
 */
public interface IProfitService {
	ProfitEcom getProfitEcomByCode(String code);
	
	/**
	 * 查询指定物业公司的反润记录数
	 * @param companyId
	 * @param status
	 * @return
	 */
	int getProfitCountByCompanyId(long companyId, Byte status);
	/**
	 * 查询指定物业公司的反润记录(按时间倒序)
	 * @param companyId
	 * @param status
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<Map<String, Object>> getProfitListByCompanyId(long companyId, Byte status, int pageNo, int pageSize);
	
	/**
	 * 物业公司申请反润结算款。
	 * 状态由0未结算变为1申请中
	 * @param id
	 * @param status
	 * @return
	 */
	boolean applyProfitBalanceOut_tx(long id);

	void saveProfitConsumeRecord_tx(ProfitConsumeRec rec);
	void updateProfitConsumeRecord_tx(ProfitConsumeRec rec);
	
	/**
	 * 物业结算列表
	 * @param map
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> getPropertyProfitList(Map<String, Object> map ,Page page);
	
	/**
	 * 修改添加返润比例
	 * @param psrofitPerVo
	 */
	public void createProfitPer_tx(Long id,Long cId ,Double percent);
	
	/**
	 * 通过公司ID获取结算信息
	 * @param cId
	 * @return
	 */
	public ProfitBalanceOutVo getBalanceOutInfo(Long cId);
	
	/**
	 * 新增修改物业结算数据
	 * @param profitBalanceOutVo
	 */
	public void addProfitBalanceOut_tx(ProfitBalanceOutVo profitBalanceOutVo);
	
	/**
	 * @param map
	 * @param page
	 * @return
	 */
	public PageResult<Map<String, Object>> getPropertyProfitDetailsList(Long cId ,Byte status ,Page page);
	
	/**
	 * 根据ID获取物业公司
	 * @param cId
	 * @return
	 */
	public Company getCompanyById(Long cId);
	
	/**
	 * 通过 ID 获取物业结算详情
	 * @param pId
	 * @return
	 */
	public ProfitBalanceOutVo getBalanceOutInfoById(Long pId);
	
	/**
	 * 删除物业结算详情
	 * @param ids
	 */
	public void deletePropertyProfitDetail_tx(Long[] ids);
	
	/**
	 * 物业结算
	 * @param ids
	 */
	public void settlementPropertyProfitDetail_tx(Long id);

	ProfitConsumeRec getProfitConsumeRec(long ecomId, String orderId);
	
	/**
	 * 获取电商选择列表
	 * @return
	 */
	public List<ProfitEcom> getProfitEcomList();
}
