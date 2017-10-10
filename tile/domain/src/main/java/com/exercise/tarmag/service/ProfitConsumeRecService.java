package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IHouseDao;
import com.dt.tarmag.dao.IProfitBalanceOutDao;
import com.dt.tarmag.dao.IProfitConsumeRecDao;
import com.dt.tarmag.dao.IProfitEcomDao;
import com.dt.tarmag.model.ProfitBalanceOut;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitConsumeRecVo;

/**
 * 从电商处获得的消费日志
 * @author wangfacheng
 * @time 2015年8月18日10:35:06
 */

@Service
public class ProfitConsumeRecService implements IProfitConsumeRecService {
	
	private  static Logger logger = Logger.getLogger(ProfitConsumeRecService.class);
	
	@Autowired
	private IProfitConsumeRecDao profitConsumeRecDao;
	
	@Autowired
	private IProfitEcomDao profitEcomDao;
	
	@Autowired
	private IProfitBalanceOutDao profitBalanceOutDao;
	
	@Autowired
	private IHouseDao houseDao;

	@Override
	public PageResult<Map<String, Object>> findPageProfitConsumeRec(ProfitConsumeRecVo searchVo, Page page) {
		
		if( searchVo == null || searchVo.getStartTime() == null || searchVo.getEndTime() == null ){
			logger.error("查询电商消费日志时出错，传入日期参数为空");
			return null;
		}
		
		long ecomId = searchVo.getEcomId();
		Date startTime = searchVo.getStartTime();
		Date endTime = searchVo.getEndTime();
		
		List<Map<String , Object>> consumeRecs = 
				this.profitConsumeRecDao.findPageProfitConsumeRecs(ecomId, startTime, endTime, page.getCurrentPage(), page.getPageSize());
		int count = this.profitConsumeRecDao.getProfitConsumeRecsCount(ecomId, startTime, endTime);
		page.setRowCount(count);
		
		return new PageResult<Map<String, Object>>(page, consumeRecs);
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmount(
			String startTime,
			String endTime,
			Long ecomId,
			Long companyId) {
		
		List<Map<String, Object>>  mapList = new ArrayList<Map<String,Object>>();
		
		if(!checkParamsForFindAmount(startTime,endTime,ecomId,companyId))return mapList;
		
		ProfitEcom profitEcom = this.profitEcomDao.get(ecomId);
		if(profitEcom == null || profitEcom.getAutoCalculate() == ProfitEcom.AUTO_CALCULATE_NO){
			logger.error("获取电商id为["+ecomId+"]的电商消费金额出错，电商信息为空或该电商为非自动清算");
			return mapList;
		}
		
		Date sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
		Date eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
		
		mapList = this.profitConsumeRecDao.getProfitConsumeRecsAmount(sTime, eTime, ecomId, companyId);
		
		return mapList;
	}

	private boolean checkParamsForFindAmount(String startTime,String endTime,Long ecomId,Long companyId){
		
		if(startTime == null || "".equals(startTime.trim())){
			logger.error("传入参数错误，开始时间为空");
			return false;
		}
		if(endTime == null || "".equals(endTime.trim())){
			logger.error("传入参数错误，结束时间为空");
			return false;
		}
		if(ecomId == null ){
			logger.error("传入参数错误，电商id为空");
			return false;
		}
		
		if(companyId == null ){
			logger.error("传入参数错误，物业公司id为空");
			return false;
		}
		
		return true;
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByResident(
			String startTime,
			String endTime,
			Long ecomId,
			Long unitId , int pageNo, int pageSize) {
		
		List<Map<String, Object>> mapList = new ArrayList<Map<String,Object>>();
		if(startTime == null || "".equals(startTime.trim()) || endTime == null || "".equals(endTime.trim())){
			logger.error("传入参数错误，开始时间或结束时间为空");
			return mapList;
		}
		
		if(ecomId == null ||  ecomId == null ){
			logger.error("传入参数错误，电商id或小区id为空");
			return mapList;
		}
		
		Date sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
		Date eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
		mapList = this.profitConsumeRecDao.getProfitConsumeRecsAmountGroupByResident(sTime, eTime, ecomId, unitId , pageNo, pageSize);
		
		return mapList;
	}

	@Override
	public int getProfitConsumeRecsAmountGroupByResidentCount(String startTime, String endTime, Long ecomId, Long unitId) {
		
		int count = 0;
		
		if(startTime == null || "".equals(startTime.trim()) || endTime == null || "".equals(endTime.trim())){
			logger.error("传入参数错误，开始时间或结束时间为空");
			return count;
		}
		
		if(ecomId == null ||  ecomId == null ){
			logger.error("传入参数错误，电商id或小区id为空");
			return count;
		}
		
		Date sTime = DateUtil.parseDate(startTime, DateUtil.PATTERN_DATE1);
		Date eTime = DateUtil.parseDate(endTime, DateUtil.PATTERN_DATE1);
		count = this.profitConsumeRecDao.getProfitConsumeRecsAmountGroupByResidentCount(sTime, eTime, ecomId, unitId);
		
		return count;
	}

	@Override
	public List<Map<String, Object>> getProfitConsumeRecsAmountGroupByUnit(Long balanceOutId  ,String unitName , int pageNo, int pageSize) {
		
		
		List<Map<String, Object>> mapList = new ArrayList<Map<String,Object>>();
		
		if( balanceOutId == null ){
			logger.error("传入反润结算(团团->物业公司)记录id为空");
			return mapList;
		}
		
		//获取反润结算(团团->物业公司)记录
		ProfitBalanceOut balanceOut = this.profitBalanceOutDao.get(balanceOutId);
		if(balanceOut == null ){
			logger.error("未查询到id为["+balanceOutId+"]的反润结算(团团->物业公司)记录");
			return mapList;
		}
		
		Date startTime = balanceOut.getStartTime();
		Date endTime = balanceOut.getEndTime();
		Long ecomId = balanceOut.getEcomId();
		Long companyId = balanceOut.getCompanyId();
		
		mapList = this.profitConsumeRecDao.getProfitConsumeRecsAmountGroupByUnit(startTime, endTime, ecomId, companyId ,unitName, pageNo, pageSize);

		if(mapList != null && !mapList.isEmpty()){
			for(Map<String, Object> map : mapList){
				map.put("startTime", DateUtil.formatDate(startTime, DateUtil.PATTERN_DATE1));
				map.put("endTime", DateUtil.formatDate(endTime, DateUtil.PATTERN_DATE1));
				
				ProfitEcom profitEcom = this.profitEcomDao.get(Long.parseLong(map.get("ecomId").toString()));
				if(profitEcom != null){
					map.put("ecomName", profitEcom.getEcomName());
				}
				
			}
		}
		
		return mapList;
	}

	@Override
	public int getProfitConsumeRecsAmountGroupByUnitCount(Long balanceOutId  ,String unitName) {
		
		int count = 0;
		
		if( balanceOutId == null ){
			logger.error("传入反润结算(团团->物业公司)记录id为空");
			return count;
		}
		
		//获取反润结算(团团->物业公司)记录
		ProfitBalanceOut balanceOut = this.profitBalanceOutDao.get(balanceOutId);
		if(balanceOut == null ){
			logger.error("未查询到id为["+balanceOutId+"]的反润结算(团团->物业公司)记录");
			return count;
		}
		
		Date startTime = balanceOut.getStartTime();
		Date endTime = balanceOut.getEndTime();
		Long ecomId = balanceOut.getEcomId();
		Long companyId = balanceOut.getCompanyId();
		
		count = this.profitConsumeRecDao.getProfitConsumeRecsAmountGroupByUnitCount(startTime, endTime, ecomId, companyId,unitName);
		
		return count;
	}
}
