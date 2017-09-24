package com.dt.tarmag.schedule;



import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.MathUtil;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.PropertyChargeBill;
import com.dt.tarmag.model.PropertyChargeRule;
import com.dt.tarmag.service.IHouseService;
import com.dt.tarmag.service.IPropertyChargeService;



/**
 * 计算物业费。
 * 每月1号01:00:00执行。
 * 从物业费收费规则中查询出所有规则，为每一条规则对应的房屋逐一计算费用。
 * 目前共有三种收费规则：
 * 1、按月；
 * 2、按季度；
 * 3、按年。
 * @author yuwei
 * @Time 2015-8-21上午11:51:47
 */
@Component
public class PropertyChargeJob extends AbstractJob {
	private final Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private IPropertyChargeService propertyChargeService;
	@Autowired
	private IHouseService houseService;
	
	
	
	/**
	 * 分批查询时，每一批次查询的数据条数
	 */
	private final static int PAGE_SIZE = 10;
	
	
	
	@Override
	protected void executeWork() {
		int ruleCount = propertyChargeService.getChargeRuleCount(PropertyChargeRule.IS_EFFECT_YES);
		logger.info("总共" + ruleCount + "条规则");
		if(ruleCount <= 0) {
			return;
		}
		int pageCount = ruleCount % PAGE_SIZE == 0 ? ruleCount / PAGE_SIZE : ruleCount / PAGE_SIZE + 1;
		logger.info("分批执行，每批次处理" + PAGE_SIZE + "条。总共" + pageCount + "批");
		
		int currentPageNo = 1;
		while(currentPageNo <= pageCount) {
			logger.info("第" + currentPageNo + "批开始......");
			List<PropertyChargeRule> ruleList = propertyChargeService.getChargeRuleList(PropertyChargeRule.IS_EFFECT_YES, currentPageNo, PAGE_SIZE);
			for(PropertyChargeRule rule: ruleList) {
				executeRule(rule);
			}
			logger.info("第" + currentPageNo + "批结束......");
			currentPageNo++;
		}
	}
	
	
	private void executeRule(PropertyChargeRule rule) {
		if(rule.getCycle() == PropertyChargeRule.CYCLE_MONTH) {
			executeRuleMonth(rule);
		}
		if(rule.getCycle() == PropertyChargeRule.CYCLE_QUARTER) {
			executeRuleQuarter(rule);
		}
		if(rule.getCycle() == PropertyChargeRule.CYCLE_YEAR) {
			executeRuleYear(rule);
		}
	}
	
	/**
	 * 按月收费。
	 * 为上个月计算费用
	 * @param rule
	 */
	private void executeRuleMonth(PropertyChargeRule rule) {
		/**
		 * 取上月第一天和最后一天
		 **/
		Calendar c = Calendar.getInstance();
		c.add(Calendar.MONTH, -1);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date startDate = c.getTime();

		c.add(Calendar.MONTH, 1);
		c.add(Calendar.DAY_OF_MONTH, -1);
		Date endDate = c.getTime();
		
		List<House> houseList = houseService.getHouseListByPartitionId(rule.getPartitionId());
		for(House house: houseList) {
			computeFee(rule, house, 1, startDate, endDate);
		}
	}
	
	/**
	 * 按季收费。
	 * 每年的1月1号、4月1号、7月1号、10月1号计算上一季度的费用。
	 * 注意：Calendar.MONTH是从0~11。0代表1月
	 * @param rule
	 */
	private void executeRuleQuarter(PropertyChargeRule rule) {
		/**
		 * 判断当前日期是否是1月1号、4月1号、7月1号、10月1号
		 **/
		Calendar c = Calendar.getInstance();
		Date curDate = c.getTime();
		
		/**
		 * 1/1
		 **/
		c.set(Calendar.MONTH, 0);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date date11 = c.getTime();
		
		/**
		 * 4/1
		 **/
		c.set(Calendar.MONTH, 3);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date date41 = c.getTime();
		
		/**
		 * 7/1
		 **/
		c.set(Calendar.MONTH, 6);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date date71 = c.getTime();
		
		/**
		 * 10/1
		 **/
		c.set(Calendar.MONTH, 9);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date date101 = c.getTime();
		
		if(!DateUtil.isSameDay(curDate, date11)
				&& !DateUtil.isSameDay(curDate, date41)
				&& !DateUtil.isSameDay(curDate, date71)
				&& !DateUtil.isSameDay(curDate, date101)) {
			return;
		}
		
		
		/**
		 * 取上季度第一天和最后一天
		 **/
		c.setTime(curDate);
		c.add(Calendar.MONTH, -3);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date startDate = c.getTime();

		c.add(Calendar.MONTH, 3);
		c.add(Calendar.DAY_OF_MONTH, -1);
		Date endDate = c.getTime();
		
		List<House> houseList = houseService.getHouseListByPartitionId(rule.getPartitionId());
		for(House house: houseList) {
			computeFee(rule, house, 3, startDate, endDate);
		}
	}
	
	/**
	 * 按年收费。
	 * 每年的1月1号计算上一年的费用
	 * @param rule
	 */
	private void executeRuleYear(PropertyChargeRule rule) {
		/**
		 * 判断当前日期是否是1月1号
		 **/
		Calendar c = Calendar.getInstance();
		Date curDate = c.getTime();
		
		/**
		 * 1/1
		 **/
		c.set(Calendar.MONTH, 0);
		c.set(Calendar.DAY_OF_MONTH, 1);
		Date date11 = c.getTime();
		
		if(!DateUtil.isSameDay(curDate, date11)) {
			return;
		}
		
		
		/**
		 * 取去年第一天和最后一天
		 **/
		c.setTime(curDate);
		c.add(Calendar.YEAR, -1);
		c.set(Calendar.DAY_OF_YEAR, 1);
		Date startDate = c.getTime();

		c.add(Calendar.YEAR, 1);
		c.add(Calendar.DAY_OF_MONTH, -1);
		Date endDate = c.getTime();
		
		List<House> houseList = houseService.getHouseListByPartitionId(rule.getPartitionId());
		for(House house: houseList) {
			computeFee(rule, house, 12, startDate, endDate);
		}
	}
	
	
	private void computeFee(PropertyChargeRule rule, House house, int month, Date startDate, Date endDate){
		double amount = 0;
		if(rule.getCtype() == PropertyChargeRule.CTYPE_AREA) {
			/**
			 ********************************************
			 * 按单位面积收费。
			 ****************************************
			 * 注意事项：
			 * 1、地下室的和地上的收费单价不一样；
			 * 2、且地下室和地上一层无电梯费；
			 * 3、地上2层及以上的电梯费相同
			 ****************************************
			 * 分3种情况计算费用：
			 * 1、地下室
			 * 2、地上一层
			 * 3、地上二层及以上
			 ********************************************
			 **/
			if(house.getFloorNum() < 1) {
				amount = MathUtil.mul(rule.getBasementFeeArea(), house.getArea());
				amount = MathUtil.mul(amount, month);
			} else if(house.getFloorNum() == 1) {
				amount = MathUtil.mul(rule.getFeeArea(), house.getArea());
				amount = MathUtil.mul(amount, month);
			} else {
				amount = MathUtil.mul(MathUtil.add(rule.getFeeArea(), rule.getFeeLift()), house.getArea());
				amount = MathUtil.mul(amount, month);
			}
		} else {
			/**
			 * 按整套房屋收费
			 **/
			amount = rule.getFeeAll();
		}
		
		PropertyChargeBill bill = new PropertyChargeBill();
		bill.setHouseId(house.getId());
		bill.setStartDate(startDate);
		bill.setEndDate(endDate);
		bill.setAmount(amount);
		bill.setRemindTimes(0);
		bill.setStatus(PropertyChargeBill.STATUS_UNCHARGED);
		propertyChargeService.save_tx(bill);
	}
}


