/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.Map;

import com.dt.framework.util.Page;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitBalanceInVo;
import com.dt.tarmag.vo.ProfitConsumeRecVo;

/**
 * @author 👤wisdom 
 *
 */
public interface IProfitBalanceInService {
	
	/**
	 * 返润计算
	 * @param ecomId 电商id
	 * @param startTime 开始时间
	 * @param endTime 结束时间
	 */
	public Map<String, Object> computeProfit(long ecomId, Date startTime,Date endTime);
	
	/**
	 * 对账，反润计算  电商 --> 团团科技
	 * 1.参数校验
	 * 2.反润计算
	 * 3.对账结束，插入一条记录到反润结算(电商-->团团科技 )DT_PROFIT_BALANCE_IN表中，初始状态为未结算
	 * 4.更新交易日志状态为已对账
	 * @throws Exception
	 */
	public boolean checkAmount_tx( ProfitConsumeRecVo profitConsumeRecVo ) throws Exception;
	
	/**
	 * 根据条件分页查询反润结算记录
	 * @return
	 */
	public PageResult<Map<String, Object>> findPageProfitBalanceIns(ProfitBalanceInVo searchVo , Page page);
	
	/**
	 * 更新反润记录为已结算
	 * @param searchVo
	 */
	public void updateProfitBalanceIn_tx(ProfitBalanceInVo searchVo) throws Exception;
	
	/**
	 * 删除反润记录
	 */
	public void deletedProfitBalanceIn_tx(Long[] ids);
}
