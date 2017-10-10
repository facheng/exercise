/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.profit;

import java.lang.reflect.Modifier;
import java.util.List;

import org.apache.log4j.Logger;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.ProfitBalanceIn;
import com.dt.tarmag.model.ProfitConsumeRec;
import com.dt.tarmag.model.ProfitEcom;

/**
 * @author 👤wisdom
 *
 */
public class ComputeProvider {

	private static Logger logger = Logger.getLogger(ComputeProvider.class);

	/**
	 * 返润计算
	 * @param profitEcom 电商
	 * @param balanceIn 返润计算条件
	 * @param consumeRecs 电商交易日志
	 */
	public static boolean compute(ProfitEcom profitEcom,
			ProfitBalanceIn balanceIn, List<ProfitConsumeRec> consumeRecs) {
		if(isValid(profitEcom, balanceIn, consumeRecs)) return false;
		try {
			// 根据设备类型获取指定的notifier
			Class<?> computerClass = Class.forName(IProfitComputer.class.getPackage()
					.getName()
					+ "."
					+ StringUtils.capitalize(profitEcom.getCode())
					+ "ProfitComputer");
			if (Modifier.isAbstract(computerClass.getModifiers())
					|| computerClass.isAnnotationPresent(Deprecated.class))
				return false;
			IProfitComputer.class.cast(computerClass.newInstance()).compute(
					balanceIn, consumeRecs);
			return true;
		} catch (ClassNotFoundException e) {
			logger.warn(StringUtils.capitalize(profitEcom.getCode()) + "ProfitComputer is not exits!", e);
		} catch (Exception e) {
			logger.info(profitEcom.getEcomName()
					+ "返润计算失败，计算时间段为"
					+ DateUtil.formatDate(balanceIn.getStartTime(),
							"yyyy年MM月dd日")
					+ "至"
					+ DateUtil.formatDate(balanceIn.getEndTime(), "yyyy年MM月dd日"));
			logger.error(e.getLocalizedMessage(), e);
		}
		return false;
	}
	
	protected static boolean isValid(ProfitEcom profitEcom,
			ProfitBalanceIn balanceIn, List<ProfitConsumeRec> consumeRecs){
		return profitEcom==null || balanceIn ==null || consumeRecs == null || consumeRecs.isEmpty();
	}
}
