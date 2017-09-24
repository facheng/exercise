package com.dt.tarmag.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.framework.util.StringUtils;
import com.dt.tarmag.model.Menu;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.util.Params;

/**
 * @author yuwei
 * @Time 2015-6-25下午12:38:21
 */
@Repository
public class MenuDao extends DaoImpl<Menu, Long> implements IMenuDao {

	@Override
	public List<Menu> getFirstLevelMenus(long roleId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT DISTINCT b.* ")
				.append(" FROM DT_ROLE_MENU a ")
				.append(" INNER JOIN DT_MENU b ON a.MENU_ID = b.ID AND b.PARENT_ID <= 0 ")
				.append(" WHERE a.ROLE_ID = ? AND a.DELETED = ? AND b.DELETED = ? ")
				.append(" ORDER BY b.SEQ ");

		return query(sql.toString(), Menu.class, new Object[] {roleId, Constant.MODEL_DELETED_N, Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Menu> getSecondeLevelMenus(long roleId, long parentId) {
		StringBuffer sql = new StringBuffer("");
		sql.append(" SELECT DISTINCT b.* ")
				.append(" FROM DT_ROLE_MENU a ")
				.append(" INNER JOIN DT_MENU b ON a.MENU_ID = b.ID ")
				.append(" WHERE a.ROLE_ID = ? AND b.PARENT_ID = ? AND a.DELETED = ? AND b.DELETED = ? ")
				.append(" ORDER BY b.SEQ ");

		return query(sql.toString(), Menu.class, new Object[] {roleId, parentId, Constant.MODEL_DELETED_N, Constant.MODEL_DELETED_N});
	}

	@Override
	public PageResult<Map<String, Object>> findMenu(Map<String, Object> params,
			Page page) {
		String selectSql = "SELECT M.ID id,M.CODE code,M.TITLE title,M.URL url,M.PARENT_ID parentId,M.CREATE_DATE_TIME createDateTime, P.TITLE parentName";
		String countSql = "SELECT COUNT(1)";
		StringBuffer whereBuf = new StringBuffer(
				" FROM DT_MENU M LEFT JOIN DT_MENU P ON P.DELETED=:deleted AND P.ID=M.PARENT_ID WHERE M.DELETED=:deleted");
		if (params.containsKey("title")) {
			whereBuf.append(" AND M.TITLE LIKE :title");
			params.put("title", "%" + params.get("title") + "%");
		}

		whereBuf.append(" ORDER BY M.CODE");

		List<Map<String, Object>> datas = this.queryForMapList(selectSql
				+ whereBuf, page.getCurrentPage(), page.getPageSize(), params);
		int count = this.queryCount(countSql + whereBuf, params);
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, datas);
	}

	@Override
	public String getMaxCode(Map<String, Object> params) {
		if (params.isEmpty())
			return null;
		String parentCode = "000";
		StringBuffer sqlbuf = new StringBuffer(
				"SELECT MAX(CODE) CODE FROM DT_MENU WHERE DELETED='N'");
		if (params.containsKey("parentId")) {
			if (params.get("parentId") == null) {
				sqlbuf.append(" AND PARENT_ID IS NULL");
			} else {
				parentCode = this.get(
						Long.valueOf(params.get("parentId").toString()))
						.getCode();
				sqlbuf.append(" AND PARENT_ID=:parentId");
			}
		}
		if (params.containsKey("parentCode")) {
			parentCode = params.get("parentCode").toString();
			sqlbuf.append(" AND CODE LIKE :parentCode");
			params.put("parentCode", parentCode + "___");
		}
		String code = StringUtils.EMPTY;
		List<Map<String, Object>> result = this.queryForMapList(
				sqlbuf.toString(), params);

		if (!result.isEmpty() && result.get(0).get("CODE") != null) {
			String maxCode = result.get(0).get("CODE").toString();
			int len = maxCode.length();
			int next = Integer.parseInt(maxCode.substring(len - 3)) + 1;
			code = maxCode.substring(0, len - 3)
					+ StringUtils.replenish(3 - String.valueOf(next).length(),
							'0') + next;
		} else {
			String initCode = "001";
			if (parentCode.isEmpty()) {
				code = initCode;
			} else {
				code = parentCode + initCode;
			}
		}
		return code;
	}

	@Override
	public List<Menu> findAllParents() {
		String sql = "SELECT * FROM DT_MENU WHERE DELETED = ? AND (PARENT_ID IS NULL OR PARENT_ID = 0)";
		return this.query(sql, Menu.class, new Object[]{Constant.MODEL_DELETED_N});
	}

	@Override
	public List<Map<String, Object>> findAll() {
		String sql = "SELECT ID id,TITLE title, CODE code, URL url, SEQ seq, PARENT_ID parentId FROM DT_MENU WHERE DELETED='N' ORDER BY CODE";
		return this.queryForMapList(sql);
	}

	@Override
	public List<Long> findOwns(Long companyId) {
		String sql = "SELECT RM.MENU_ID menuId FROM DT_ROLE_MENU RM INNER JOIN DT_ROLE R ON R.DELETED='N' AND R.IS_ADMIN=:isAdmin AND R.ID=RM.ROLE_ID AND R.COMPANY_ID=:companyId WHERE RM.DELETED='N'";
		List<Map<String, Object>> results = this.queryForMapList(sql, Params
				.getParams("isAdmin", 1).add("companyId", companyId));
		List<Long> menuIds = new ArrayList<Long>();
		for (Map<String, Object> result : results) {
			menuIds.add(Long.valueOf(result.get("menuId").toString()));
		}
		return menuIds;
	}
	
	@Override
	public List<Menu> getSecondMenuList(List<Long> menuIds) {
		if(menuIds == null || menuIds.size() <= 0) {
			return new ArrayList<Menu>();
		}
		String sql = " SELECT * FROM DT_MENU WHERE DELETED = :deleted AND ID IN(:menuIds) AND PARENT_ID > 0 ";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("deleted", Constant.MODEL_DELETED_N);
		params.put("menuIds", menuIds);
		return query(sql, Menu.class, params);
	}
}
