/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.profit;

import java.math.BigDecimal;
import java.util.List;

import com.dt.tarmag.model.ProfitBalanceIn;
import com.dt.tarmag.model.ProfitConsumeRec;

/**
 * @author 👤wisdom 一号店返润计算
 */
public class YhdProfitComputer implements IProfitComputer {

	@Override
	public void compute(ProfitBalanceIn balanceIn,
			List<ProfitConsumeRec> consumeRecs) {
		if(balanceIn == null || consumeRecs == null) return;
		BigDecimal consumeAmountSum=BigDecimal.valueOf(0),profitAmountSum=BigDecimal.valueOf(0);
		for(ProfitConsumeRec consumeRec : consumeRecs){
			consumeAmountSum = consumeAmountSum.add(BigDecimal.valueOf(consumeRec.getConsumeAmount()));
			profitAmountSum = profitAmountSum.add(BigDecimal.valueOf(consumeRec.getProfitAmount()));
		}
		balanceIn.setConsumeAmount(consumeAmountSum.doubleValue());
		balanceIn.setProfitAmount(profitAmountSum.doubleValue());
	}
}
