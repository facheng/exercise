package com.dt.tarmag.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.ICommonWordsDao;
import com.dt.tarmag.dao.ICompanyDao;
import com.dt.tarmag.dao.ICustomerDao;
import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.model.Company;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.vo.CommonWordsVo;

/**
 * 
 * @author wangfacheng
 * @DATE 2015年8月12日16:36:53
 * 
 */

@Service
public class CommonWordsService implements ICommonWordsService {

	private final Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private ICommonWordsDao commonWordsDao;
	@Autowired
	private ICustomerDao customerDao;
	@Autowired
	private ICompanyDao companyDao;

	@Override
	public int getCommonWordsCount(CommonWordsVo vo) {

		return commonWordsDao.getCommonWordsCount(vo);
	}

	@Override
	public List<Map<String, Object>> getCommonWordsList(CommonWordsVo searchVo, int pageNo, int pageSize) {

		return commonWordsDao.getCommonWordsList(searchVo, pageNo, pageSize);
	}

	@Override
	public Map<String, Object> getCommonWordsDetail(long commonWordsId) {

		Map<String, Object> commonWordsMap = new HashMap<String, Object>();

		CommonWords commonWords = this.commonWordsDao.get(commonWordsId);
		if (commonWords == null) {
			logger.warn("未查询到id为[" + commonWordsId + "]的常用语信息");
			return commonWordsMap;
		}

		// id
		commonWordsMap.put("commonWordsId", commonWords.getId());
		// 类型名称
		commonWordsMap.put("typeName", commonWords.getTypeName());
		// 类型编码 1通知 2快递 3报修
		commonWordsMap.put("type", commonWords.getType());
		// 常用语内容
		commonWordsMap.put("words", commonWords.getWords());

		// 获取创建人信息
		Customer customer = customerDao.get(commonWords.getCreateUserId());

		if (customer == null) {
			logger.error("未查询到id为[" + commonWords.getCreateUserId() + "]的用户信息");
			return commonWordsMap;
		}

		Company company = companyDao.get(customer.getCompanyId());
		if (company == null) {
			logger.error("未查询到id为[" + customer.getCompanyId() + "]的公司信息");
			return commonWordsMap;
		}
		commonWordsMap.put("createrName", customer.getUserName());
		commonWordsMap.put("companyName", company.getCompanyName());

		return commonWordsMap;
	}

	@Override
	public boolean updateCommonWords_tx(Long commonWordsId, CommonWordsVo vo) {

		if (commonWordsId == null) {
			logger.error("传入参数常用语ID为空");
			return false;
		}
		CommonWords commonWords = this.commonWordsDao.get(commonWordsId);
		if (commonWords == null) {
			logger.error("未查询到id为[" + commonWordsId + "]的常用语");
			return false;
		}

		if (!checkCommonWordsParams(vo))
			return false;

		try {

			commonWords.setType(vo.getType());
			commonWords.setWords(vo.getWords());

			commonWordsDao.update(commonWords);

		}
		catch (Exception e) {

			logger.error("更新id为[" + commonWordsId + "]常用语信息失败", e);
			return false;
		}

		return true;
	}

	@Override
	public boolean deleteCommonWords_tx(List<Long> commonWordsIds) {

		if (commonWordsIds == null || commonWordsIds.size() <= 0) {
			return false;
		}

		try {
			for (Long commonWordsId : commonWordsIds) {
				commonWordsDao.deleteLogic(commonWordsId);
			}
		}
		catch (Exception ex) {

			logger.error("删常用语信息失败", ex);
			return false;
		}
		return true;
	}

	@Override
	public boolean createCommonWords_tx(CommonWordsVo vo) {

		if (!checkCommonWordsParams(vo)) {
			return false;
		}

		CommonWords commonWords = new CommonWords();
		// 参数赋值
		commonWords.setType(vo.getType());
		commonWords.setWords(vo.getWords());
		commonWords.setUnitId(vo.getUnitId());

		try {

			this.commonWordsDao.save(commonWords);

		}
		catch (Exception ex) {
			logger.error("新增常用语失败", ex);
			return false;
		}

		return true;
	}

	private boolean checkCommonWordsParams(CommonWordsVo vo) {

		if (vo == null) {
			logger.error("传入常用语参数为空");
			return false;
		}

		// 常用语类型 1通知 2快递 3报修
		if (!CommonWords.getTypeCodes().contains(vo.getType())) {
			logger.error("传入常用语类型错误");
			return false;
		}

		if (vo.getWords() == null || "".equals(vo.getWords().trim())) {
			logger.error("传入常用语内容为空");
			return false;
		}

		if (vo.getWords().length() > 200) {
			logger.error("传入常用语内容长度大于200");
			return false;
		}

		return true;

	}

	@Override
	public List<CommonWords> getCommonWordsVoByType(int type , long unitId) {

		List<CommonWords> commonWords = new ArrayList<CommonWords>();
		if (type == 0) {
			logger.error("传入常用语类别错误");
			return commonWords;
		}

		return this.commonWordsDao.getCommonWordsVoByType(type , unitId);
	}

}
