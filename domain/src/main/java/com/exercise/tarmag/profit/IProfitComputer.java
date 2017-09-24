/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.profit;

import java.util.List;

import com.dt.tarmag.model.ProfitBalanceIn;
import com.dt.tarmag.model.ProfitConsumeRec;

/**
 * @author 👤wisdom
 *
 */
public interface IProfitComputer {
	/**
	 * 计算利润
	 * 
	 * @param balaceIn
	 *            计算条件
	 * @param consumeRecs
	 *            日志
	 */
	public void compute(ProfitBalanceIn balanceIn,
			List<ProfitConsumeRec> consumeRecs);
}
