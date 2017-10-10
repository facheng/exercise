package com.dt.tarmag.dao;




import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.ProfitEcom;
import com.dt.tarmag.vo.ProfitEcomVo;

/**
 * @author yuwei
 * @Time 2015-8-13下午05:38:18
 */
@Repository
public class ProfitEcomDao extends DaoImpl<ProfitEcom, Long> implements IProfitEcomDao {

	@Override
	public ProfitEcom getProfitEcomByCode(String code) {
		String sql = "SELECT * FROM DT_PROFIT_ECOM WHERE CODE = ? AND DELETED = ?";
		return queryForObject(sql, ProfitEcom.class, new Object[]{code, Constant.MODEL_DELETED_N});
	}
	

	@Override
	public List<Map<String, Object>> findPageProfitEcom(ProfitEcomVo searchVo, int pageNo, int pageSize) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id ,  A.CODE code , A.ECOM_NAME ecomName , A.AUTO_CALCULATE autoCalculate , A.REMARK remark ")
			.append("  FROM DT_PROFIT_ECOM A WHERE A.DELETED = :deleted  ");
			
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(searchVo != null ){
			if( searchVo.getCode() != null  && !"".equals(searchVo.getCode().trim())){
				sql.append(" AND A.CODE LIKE :code");
				params.put("code", "%" +  searchVo.getCode().trim() + "%");
			}
			
			if( searchVo.getEcomName() != null  && !"".equals(searchVo.getEcomName().trim())){
				sql.append(" AND A.ECOM_NAME LIKE :ecomName");
				params.put("ecomName", "%" + searchVo.getEcomName().trim() + "%");
			}
		}
		
		return this.queryForMapList(sql.toString(), pageNo, pageSize, params);
	}

	@Override
	public int getProfitEcomCount(ProfitEcomVo searchVo) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT COUNT(*) FROM DT_PROFIT_ECOM A WHERE A.DELETED = :deleted ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		if(searchVo != null ){
			if( searchVo.getCode() != null  && !"".equals(searchVo.getCode().trim())){
				sql.append(" AND A.CODE LIKE :code");
				params.put("code", "%" +  searchVo.getCode().trim() + "%");
			}
			
			if( searchVo.getEcomName() != null  && !"".equals(searchVo.getEcomName().trim())){
				sql.append(" AND A.ECOM_NAME LIKE :ecomName");
				params.put("ecomName", "%" + searchVo.getEcomName().trim() + "%");
			}
		}
		
		return this.queryCount(sql.toString(), params);
	}

	@Override
	public List<Map<String, Object>> getProfitEcomDetail(ProfitEcomVo searchVo) {
		
		StringBuffer sql = new StringBuffer("");
		sql.append("SELECT A.ID id , A.CODE code , A.AUTO_CALCULATE autoCalculate, A.ECOM_NAME ecomName , A.REMARK remark , A.CREATE_USER_ID createUserId ")
			.append(" FROM DT_PROFIT_ECOM A WHERE A.DELETED = :deleted ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		
		return this.queryForMapList(sql.toString(), params);
	}

	@Override
	public ProfitEcom getProfitEcomBysearchVo(ProfitEcomVo searchVo) {
		
		StringBuffer  sql = new StringBuffer();
		
		sql.append(" SELECT A.* FROM DT_PROFIT_ECOM A WHERE A.DELETED = :deleted ")
			.append(" AND A.CODE = :code ");
		
		Map<String , Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("code", searchVo.getCode());
		
		return this.queryForObject(sql.toString(), ProfitEcom.class, params);
	}


	@Override
	public List<ProfitEcom> getProfitEcomList() {
		String sql = "SELECT * FROM DT_PROFIT_ECOM A WHERE A.DELETED = ?";
		return this.query(sql, ProfitEcom.class, new Object[]{Constant.MODEL_DELETED_N});
	}


	@Override
	public ProfitEcom getProfitEcomById(Long id) {
		String sql = "SELECT * FROM DT_PROFIT_ECOM A WHERE A.ID = ? AND  A.DELETED = ?";
		return this.queryForObject(sql, ProfitEcom.class, new Object[]{id , Constant.MODEL_DELETED_N});
	}
	
	
	
}
