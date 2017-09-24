/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IProfitBalanceInDao;
import com.dt.tarmag.dao.IProfitConsumeRecDao;
import com.dt.tarmag.dao.IProfitEcomDao;
import com.dt.tarmag.model.ProfitBalanceIn;
import com.dt.tarmag.model.ProfitConsumeRec;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.profit.ComputeProvider;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitBalanceInVo;
import com.dt.tarmag.vo.ProfitConsumeRecVo;

/**
 * @author 👤wisdom
 *
 */
@Service
public class ProfitBalanceInService implements IProfitBalanceInService {

	private static Logger logger = Logger.getLogger(ProfitBalanceInService.class);
	
	@Autowired
	private IProfitConsumeRecDao profitConsumeRecDao;

	@Autowired
	private IProfitEcomDao profitEcomDao;

	@Autowired
	private IProfitBalanceInDao profitBalanceInDao;

	@Override
	public Map<String, Object> computeProfit(long ecomId, Date startTime,
			Date endTime) {
		Map<String, Object> result = new HashMap<String, Object>();
		ProfitEcom profitEcom = this.profitEcomDao.get(ecomId);
		List<ProfitConsumeRec> consumeRecs = this.profitConsumeRecDao
				.findProfitConsumeRecs(ecomId, startTime, endTime);
		ProfitBalanceIn profitBalanceIn = new ProfitBalanceIn();
		profitBalanceIn.setEcomId(ecomId);
		profitBalanceIn.setStartTime(startTime);
		profitBalanceIn.setEndTime(endTime);
		ComputeProvider.compute(profitEcom, profitBalanceIn, consumeRecs);// 计算返润
//		this.profitBalanceInDao.save(profitBalanceIn);
//		for (ProfitConsumeRec profitConsumeRec : consumeRecs) {
//			profitConsumeRec.setStatus(ProfitConsumeRec.STATUS_APPROVING);
//			this.profitConsumeRecDao.update(profitConsumeRec);
//		}
		result.put("ecom", profitEcom);
		result.put("balance", profitBalanceIn);
		result.put("consumeRecs", consumeRecs);
		return result;
	}

	@Override
	public boolean checkAmount_tx (ProfitConsumeRecVo vo) throws Exception {
		
		logger.info("对账开始[电商-->团团科技 ]");
		
		//1.参数校验
		if(!checkParamsForCheckAmount(vo))return false;
		
		long ecomId = vo.getEcomId();
		Date startTime = vo.getStartTime();
		Date endTime = vo.getEndTime();
		
		try{
			ProfitEcom profitEcom = this.profitEcomDao.get(ecomId);
			if( profitEcom == null ){
				logger.error("对账失败[电商-->团团科技 ],未查询到id为[" + ecomId + "]的电商信息");
				return false;
			}
			
			
			List<ProfitConsumeRec> consumeRecs = this.profitConsumeRecDao.findProfitConsumeRecs(ecomId, startTime, endTime);
			if(consumeRecs == null || consumeRecs.isEmpty()){
				//需要对账的记录为空，对账结束。记录错误日志
				logger.error("对账结束[电商-->团团科技 ],id为[" + ecomId + "]的电商["+profitEcom.getEcomName()
						+ "]在时间段[" + DateUtil.formatDate(startTime, DateUtil.PATTERN_DATE_TIME2) + "]-["
						+ DateUtil.formatDate(endTime, DateUtil.PATTERN_DATE_TIME2) + "]内的交易记录为空");
				return false;
			}
			
			ProfitBalanceIn profitBalanceIn = new ProfitBalanceIn();
			profitBalanceIn.setEcomId(ecomId);
			profitBalanceIn.setStartTime(startTime);
			profitBalanceIn.setEndTime(endTime);
			profitBalanceIn.setStatus(ProfitBalanceIn.STATUS_NOT_SETTLED);//未结算
			
			logger.info("开始计算反润金额");
			
			//2.反润计算
			boolean errorFlag = ComputeProvider.compute(profitEcom, profitBalanceIn, consumeRecs);// 计算返润
			if(!errorFlag){
				logger.error("计算反润值时发生异常");
				return false;
			}
			logger.info("交易金额为["+profitBalanceIn.getConsumeAmount()+"],反润金额为["+profitBalanceIn.getProfitAmount()+"]");
			
			//3.对账结束，插入一条记录到反润结算(电商-->团团科技 )DT_PROFIT_BALANCE_IN表中，初始状态为未结算
			this.profitBalanceInDao.save(profitBalanceIn);
			
			//4.更新交易日志状态为已对账
			for(ProfitConsumeRec consumeRec : consumeRecs){
				consumeRec.setStatus(ProfitConsumeRec.STATUS_APPROVED);
				this.profitConsumeRecDao.update(consumeRec);
			}
			logger.info("对账成功");
			
			return true;
		} catch( Exception e){
			logger.error("对账过程中发生系统故障,"+e.getMessage() , e);
			throw e;
		}
		
	}

	@Override
	public PageResult<Map<String, Object>> findPageProfitBalanceIns(ProfitBalanceInVo searchVo, Page page) {
		
		//|| searchVo.getStartTime() == null || searchVo.getEndTime() == null
		if( searchVo == null ){
			logger.error("查询电商消费日志时出错，传入日期参数为空");
			return null;
		}
		
		long ecomId = searchVo.getEcomId();
		Date startTime = searchVo.getStartTime();
		Date endTime = searchVo.getEndTime();
		String status = searchVo.getStatus();
		
		List<Map<String , Object>> consumeRecs = 
				this.profitBalanceInDao.findPageProfitBalanceIn(ecomId, startTime, endTime,status, page.getCurrentPage(), page.getPageSize());
		int count = this.profitBalanceInDao.getProfitBalanceInCount(ecomId, startTime, endTime,status);
		page.setRowCount(count);
		
		return new PageResult<Map<String, Object>>(page, consumeRecs);

	}

	@Override
	public void updateProfitBalanceIn_tx(ProfitBalanceInVo searchVo) throws Exception{
		if(searchVo == null){
			logger.error("更新电商反润记录时发生错误，传入反润参数为空");
			return ;
		}
		
		Long id = searchVo.getId();
		//获取电商 -- >团团反润记录
		ProfitBalanceIn profitBalanceIn = this.profitBalanceInDao.get(id);
		if(profitBalanceIn == null ){
			logger.error("未查询到id为["+id+"]的电商-->团团反润记录");
			return;
		}
		
		try{
			//如果为未结算，则更新为结算中（发票）。如果状态为结算中，则更新为已结算
			if(ProfitBalanceIn.STATUS_NOT_SETTLED == profitBalanceIn.getStatus()){
				profitBalanceIn.setStatus(ProfitBalanceIn.STATUS_SETTLING);//更新状态为已结算
			} else {
				profitBalanceIn.setStatus(ProfitBalanceIn.STATUS_SETTLED);//更新状态为已结算
			}
			
			this.profitBalanceInDao.update(profitBalanceIn);
			
		} catch (Exception e){
			logger.error("更新电商-->团团反润记录时发生系统异常,"+e.getMessage() , e);
			throw e;
		}
		
		
	}

	private boolean checkParamsForCheckAmount( ProfitConsumeRecVo vo){
		if( vo == null ){
			logger.error("对账失败[电商-->团团科技 ]，传入电商信息为空");
			return false;
		}
		
		if( vo.getStartTime() == null ){
			logger.error("对账失败[电商-->团团科技 ]，传入对账开始日期为空");
			return false;
		}
		if( vo.getEndTime()== null ){
			logger.error("对账失败[电商-->团团科技 ]，传入对账结束日期为空");
			return false;
		}
		return true;
	}

	@Override
	public void deletedProfitBalanceIn_tx(Long[] ids) {
		if (ids == null || ids.length == 0) {
			logger.error("传入需要删除的反润记录id为空");
			return;
		}

		try {

			for (Long id : ids) {
				this.profitBalanceInDao.deleteLogic(id);
			}

		}
		catch (Exception e) {
			logger.error("删除删除的反润记录时发生错误" + e.getMessage(), e);
		}
		
	}
}
