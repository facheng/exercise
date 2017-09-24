package com.dt.tarmag.service;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.DateUtil;
import com.dt.framework.util.Page;
import com.dt.tarmag.dao.ICompanyDao;
import com.dt.tarmag.dao.IProfitBalanceOutDao;
import com.dt.tarmag.dao.IProfitConsumeRecDao;
import com.dt.tarmag.dao.IProfitEcomDao;
import com.dt.tarmag.dao.IProfitPerDao;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.ProfitBalanceOut;
import com.dt.tarmag.model.ProfitConsumeRec;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.model.ProfitPer;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitBalanceOutVo;


/**
 * @author yuwei
 * @Time 2015-8-14下午04:54:51
 */
@Service
public class ProfitService implements IProfitService {
	@Autowired
	private IProfitEcomDao profitEcomDao;
	@Autowired
	private IProfitConsumeRecDao profitConsumeRecDao;
	@Autowired
	private IProfitPerDao profitPerDao;
	@Autowired
	private IProfitBalanceOutDao profitBalanceOutDao;
	@Autowired
	private ICompanyDao companyDao;
	
	

	@Override
	public ProfitEcom getProfitEcomByCode(String code) {
		return profitEcomDao.getProfitEcomByCode(code);
	}

	@Override
	public int getProfitCountByCompanyId(long companyId, Byte status) {
		return profitBalanceOutDao.getProfitCountByCompanyId(companyId, status);
	}

	@Override
	public List<Map<String, Object>> getProfitListByCompanyId(long companyId, Byte status, int pageNo, int pageSize) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		List<ProfitBalanceOut> list = profitBalanceOutDao.getProfitListByCompanyId(companyId, status, pageNo, pageSize);
		if(list == null || list.size() <= 0) {
			return mapList;
		}
		
		for(ProfitBalanceOut pbo : list) {
//			ProfitEcom ecom = profitEcomDao.get(pbo.getEcomId());
			ProfitEcom ecom = profitEcomDao.getProfitEcomById(pbo.getEcomId());
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", pbo.getId());
			map.put("ecomName", ecom == null ? "" : ecom.getEcomName());
			map.put("startTime", DateUtil.formatDate(pbo.getStartTime(), DateUtil.PATTERN_DATE1));
			map.put("endTime", DateUtil.formatDate(pbo.getEndTime(), DateUtil.PATTERN_DATE1));
			map.put("consumeAmount", pbo.getConsumeAmount());
			map.put("totalProfitAmount", pbo.getTotalProfitAmount());
			map.put("profitAmount", pbo.getProfitAmount());
			map.put("status", pbo.getStatus());
			map.put("statusName", pbo.getStatusName());
			
			//判断物业管理端管理员清结算是否有权限进入详情页（电商为自动清算 + 已结算才出现） 进行排序 0不可以 1可以
			if(ecom.getAutoCalculate() == ProfitEcom.AUTO_CALCULATE_YES && pbo.getStatus() == ProfitBalanceOut.STATUS_SETTLED){
				map.put("isDetail", 1);
			} else {
				map.put("isDetail", 0);
			}
			
			mapList.add(map);
		}
		return mapList;
	}
	
	@Override
	public boolean applyProfitBalanceOut_tx(long id) {
		ProfitBalanceOut balanceOut = profitBalanceOutDao.get(id);
		if(balanceOut == null || balanceOut.getStatus() != ProfitBalanceOut.STATUS_NOT_SETTLED) {
			return false;
		}
		
		balanceOut.setStatus(ProfitBalanceOut.STATUS_APPLYING);
		balanceOut.setApplyTime(new Date());
		profitBalanceOutDao.update(balanceOut);
		
		return true;
	}


	@Override
	public void saveProfitConsumeRecord_tx(ProfitConsumeRec rec) {
		profitConsumeRecDao.save(rec);
	}

	@Override
	public void updateProfitConsumeRecord_tx(ProfitConsumeRec rec) {
		profitConsumeRecDao.update(rec);
	}

	@Override
	public PageResult<Map<String, Object>> getPropertyProfitList(Map<String, Object> params, Page page) {
		List<Map<String, Object>> propertyProfits = this.profitPerDao.getPropertyProfitList(params , page);

		int count = this.profitPerDao.getPropertyProfitListCount(params);
		
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, propertyProfits);
	}
	
	@Override
	public void createProfitPer_tx(Long id,Long cId ,Double percent) {
		
		if (id == 0) {
			ProfitPer profitPer = new ProfitPer();
			profitPer.setCompanyId(cId);
			profitPer.setPercent(percent);
			this.profitPerDao.save(profitPer);
		}
		else {
			ProfitPer profitPer = this.profitPerDao.get(id);
			profitPer.setPercent(percent);
			this.profitPerDao.update(profitPer);
		}
		
		
	}
	
	@Override
	public ProfitBalanceOutVo getBalanceOutInfo(Long cId) {
		
		Company company = this.companyDao.get(cId);
		ProfitPer profitPer = this.profitPerDao.getProfitPerByCompanyId(cId);
		ProfitBalanceOutVo pbovo = new ProfitBalanceOutVo();
		pbovo.setCompanyId(cId);
		pbovo.setCompanyName(company.getCompanyName());
		pbovo.setPercent(profitPer.getPercent());
		
		return pbovo;
	}

	@Override
	public void addProfitBalanceOut_tx(ProfitBalanceOutVo profitBalanceOutVo) {
		if(profitBalanceOutVo.getId() != null && profitBalanceOutVo.getId() > 0){
			ProfitBalanceOut profitBalanceOut = profitBalanceOutDao.get(profitBalanceOutVo.getId());
			profitBalanceOut.setEcomId(profitBalanceOutVo.getEcomId());
			profitBalanceOut.setStartTime(DateUtil.parseDate(profitBalanceOutVo.getStartTime(), DateUtil.PATTERN_DATE1));
			profitBalanceOut.setEndTime(DateUtil.parseDate(profitBalanceOutVo.getEndTime(), DateUtil.PATTERN_DATE1));
			profitBalanceOut.setConsumeAmount(profitBalanceOutVo.getConsumeAmount());
			profitBalanceOut.setTotalProfitAmount(profitBalanceOutVo.getTotalProfitAmount());
			profitBalanceOut.setProfitAmount(profitBalanceOutVo.getProfitAmount());
			profitBalanceOutDao.update(profitBalanceOut);
		}else{
			ProfitBalanceOut profitBalanceOut = new ProfitBalanceOut();
			profitBalanceOut.setCompanyId(profitBalanceOutVo.getCompanyId());
			profitBalanceOut.setEcomId(profitBalanceOutVo.getEcomId());
			profitBalanceOut.setStartTime(DateUtil.parseDate(profitBalanceOutVo.getStartTime(), DateUtil.PATTERN_DATE1));
			profitBalanceOut.setEndTime(DateUtil.parseDate(profitBalanceOutVo.getEndTime(), DateUtil.PATTERN_DATE1));
			profitBalanceOut.setConsumeAmount(profitBalanceOutVo.getConsumeAmount());
			profitBalanceOut.setTotalProfitAmount(profitBalanceOutVo.getTotalProfitAmount());
			profitBalanceOut.setProfitAmount(profitBalanceOutVo.getProfitAmount());
			profitBalanceOut.setStatus(ProfitBalanceOut.STATUS_NOT_SETTLED);
			profitBalanceOutDao.save(profitBalanceOut);
		}
	}

	@Override
	public PageResult<Map<String, Object>> getPropertyProfitDetailsList(Long cId, Byte status, Page page) {
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		
		
		List<ProfitBalanceOut> list = profitBalanceOutDao.getProfitListByCompanyId(cId, status, page.getCurrentPage(), page.getPageSize());
		if(list == null || list.size() <= 0) {
			new PageResult<Map<String, Object>>(page, mapList);
		}
		
		for(ProfitBalanceOut pbo : list) {
			ProfitEcom ecom = profitEcomDao.get(pbo.getEcomId());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", pbo.getId());
			map.put("ecomName", ecom == null ? "" : ecom.getEcomName());
			map.put("startTime", DateUtil.formatDate(pbo.getStartTime(), DateUtil.PATTERN_DATE1));
			map.put("endTime", DateUtil.formatDate(pbo.getEndTime(), DateUtil.PATTERN_DATE1));
			map.put("consumeAmount", pbo.getConsumeAmount());
			map.put("profitAmount", pbo.getProfitAmount());
			map.put("totalProfitAmount", pbo.getTotalProfitAmount());
			map.put("statusName", pbo.getStatusName());
			mapList.add(map);
			
		}

		int count = this.profitBalanceOutDao.getProfitCountByCompanyId(cId, status);
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, mapList);
	}

	@Override
	public Company getCompanyById(Long cId) {
		return companyDao.get(cId);
	}

	@Override
	public ProfitBalanceOutVo getBalanceOutInfoById(Long pId) {
		ProfitBalanceOut profitBalanceOut = profitBalanceOutDao.get(pId);
		Company company = this.companyDao.get(profitBalanceOut.getCompanyId());
		ProfitPer profitPer = this.profitPerDao.getProfitPerByCompanyId(profitBalanceOut.getCompanyId());
		ProfitBalanceOutVo pbovo = new ProfitBalanceOutVo();
		
		pbovo.setId(profitBalanceOut.getId());
		pbovo.setCompanyId(profitBalanceOut.getCompanyId());
		pbovo.setCompanyName(company.getCompanyName());
		pbovo.setPercent(profitPer.getPercent());
		pbovo.setEcomId(profitBalanceOut.getEcomId());
		pbovo.setConsumeAmount(profitBalanceOut.getConsumeAmount());
		pbovo.setTotalProfitAmount(profitBalanceOut.getTotalProfitAmount());
		pbovo.setProfitAmount(profitBalanceOut.getProfitAmount());
		pbovo.setStartTime(DateUtil.formatDate(profitBalanceOut.getStartTime(), DateUtil.PATTERN_DATE1));
		pbovo.setEndTime(DateUtil.formatDate(profitBalanceOut.getEndTime(), DateUtil.PATTERN_DATE1));
		return pbovo;
		
	}

	@Override
	public void deletePropertyProfitDetail_tx(Long[] ids) {
		if(ids == null) return;
		for(Long id : ids){
			this.profitBalanceOutDao.deleteLogic(id);
		}
	}

	@Override
	public void settlementPropertyProfitDetail_tx(Long id) {
		if(id != null && id > 0){
			
			ProfitBalanceOut profitBalanceOut = profitBalanceOutDao.getPropertyProfitById(id);
			
			if(profitBalanceOut.getStatus() == ProfitBalanceOut.STATUS_APPLYING){
				profitBalanceOut.setStatus(ProfitBalanceOut.STATUS_SETTLING);
			}else if(profitBalanceOut.getStatus() == ProfitBalanceOut.STATUS_SETTLING){
				profitBalanceOut.setStatus(ProfitBalanceOut.STATUS_SETTLED);
				profitBalanceOut.setSettledTime(new Date());
			}
			
			profitBalanceOutDao.update(profitBalanceOut);
		}else{
			return;
		}
	}

	@Override
	public ProfitConsumeRec getProfitConsumeRec(long ecomId, String orderId) {
		return profitConsumeRecDao.getProfitConsumeRec(ecomId, orderId);
	}

	@Override
	public List<ProfitEcom> getProfitEcomList() {
		return profitEcomDao.getProfitEcomList();
	}
}
