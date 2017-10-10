package com.dt.tarmag.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Page;
import com.dt.tarmag.dao.ICustomerDao;
import com.dt.tarmag.dao.IProfitEcomDao;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.ProfitEcomVo;

/**
 * 电商电商基本资料(清结算)
 * 
 * @author wangfacheng
 * @Time 2015年8月14日11:16:18
 */

@Service
public class ProfitEcomService implements IProfitEcomService {

	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IProfitEcomDao profitEcomDao;

	@Autowired
	private ICustomerDao customerDao;

	@Override
	public PageResult<Map<String, Object>> findPageProfitEcom(ProfitEcomVo searchVo, Page page) {

		List<Map<String, Object>> profitEcoms = this.profitEcomDao.findPageProfitEcom(searchVo, page.getCurrentPage(),
				page.getPageSize());

		int count = this.profitEcomDao.getProfitEcomCount(searchVo);
		page.setRowCount(count);

		return new PageResult<Map<String, Object>>(page, profitEcoms);
	}

	@Override
	public void saveProfitEcom_tx(ProfitEcomVo vo) {

		if (!checkProfitEcomParams(vo))
			return;

		ProfitEcom profitEcomTemp = this.profitEcomDao.getProfitEcomBysearchVo(vo);
		if(profitEcomTemp != null ){
			logger.error("电商代码为["+vo.getCode()+"]已存在");
			return;
		}
		
		ProfitEcom profitEcom = new ProfitEcom();

		profitEcom.setCode(vo.getCode());
		profitEcom.setEcomName(vo.getEcomName());
		profitEcom.setAutoCalculate(vo.getAutoCalculate());
		profitEcom.setRemark(vo.getRemark());

		try {
			this.profitEcomDao.save(profitEcom);
		}
		catch (Exception ex) {
			logger.error("保存电商信息时发生错误" + ex.getMessage(), ex);
		}

	}

	@Override
	public void deleteProfitEcom_tx(Long[] ids) {

		if (ids == null || ids.length == 0) {
			logger.error("传入需要删除的电商信息id为空");
			return;
		}

		try {

			for (Long id : ids) {
				this.profitEcomDao.deleteLogic(id);
			}

		}
		catch (Exception e) {
			logger.error("删除电商信息时发生错误" + e.getMessage(), e);
		}
	}

	@Override
	public Map<String, Object> getProfitEcomDetailById(long id) {

		Map<String, Object> profitEcomMap = new HashMap<String, Object>();

		ProfitEcom profitEcom = this.profitEcomDao.get(id);
		if (profitEcom == null) {
			logger.error("为查询到id为[" + id + "]的电商信息");
			return profitEcomMap;
		}

		profitEcomMap.put("id", profitEcom.getId());
		profitEcomMap.put("code", profitEcom.getCode());
		profitEcomMap.put("ecomName", profitEcom.getEcomName());
		profitEcomMap.put("remark", profitEcom.getRemark());
		profitEcomMap.put("autoCalculate",profitEcom.getAutoCalculate());//是否自动清算

		// 获取创建人信息
		Customer customer = customerDao.get(profitEcom.getCreateUserId());

		if (customer == null) {
			logger.error("未查询到id为[" + profitEcom.getCreateUserId() + "]的用户信息");
			return profitEcomMap;
		}

		profitEcomMap.put("createrName", customer.getUserName());

		return profitEcomMap;
	}

	private boolean checkProfitEcomParams(ProfitEcomVo vo) {

		if (vo == null) {
			logger.error("传入参数为空");
			return false;
		}

		if (vo.getCode() == null || "".equals(vo.getCode().trim())) {
			logger.error("传入电商代码参数为空");
			return false;
		}

		if (vo.getEcomName() == null || "".equals(vo.getEcomName().trim())) {
			logger.error("传入电商名称为空");
			return false;
		}
		return true;
	}

	@Override
	public boolean updateProfitEcom_tx(Long profitEcomId, ProfitEcomVo vo) {

		if (profitEcomId == null) {
			logger.error("更新电商信息发生错误，传入电商id为空");
			return false;
		}

		if (!checkProfitEcomParams(vo))
			return false;

		ProfitEcom profitEcom = this.profitEcomDao.get(profitEcomId);
		if( profitEcom == null ){
			logger.error("未查询到id为["+ profitEcomId + "]的电商信息");
			return false;
		}
		
		try {
			
			profitEcom.setCode(vo.getCode());
			profitEcom.setEcomName(vo.getEcomName());
			profitEcom.setAutoCalculate(vo.getAutoCalculate());
			profitEcom.setRemark(vo.getRemark());
			
			this.profitEcomDao.update(profitEcom);
		}
		catch (Exception e) {
			
			logger.error("更新id为[" + profitEcomId + "]的电商信息时发生错误" + e.getMessage() , e);
			return false;
		}

		return true;
	}

	@Override
	public boolean checkIsNotExistProfitEcom(ProfitEcomVo vo) {
		
		if( vo == null ){
			logger.warn("传入电商参数为空");
			return false;
		}
		
		ProfitEcom profitEcom = this.profitEcomDao.getProfitEcomBysearchVo(vo);
		
		if( profitEcom != null ){
			logger.warn("电商代码为[" + vo.getCode() + "]的信息已存在");
			return false;
		}
		
		return true;
	}

}
