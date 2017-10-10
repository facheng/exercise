package com.dt.tarmag.dao;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.dt.framework.dao.DaoImpl;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.AppMenuResident;


/**
 * @author yuwei
 * @Time 2015-7-19上午10:37:43
 */
@Repository
public class AppMenuResidentDao extends DaoImpl<AppMenuResident, Long> implements IAppMenuResidentDao {

	@Override
	public AppMenuResident getResidentMenuByresidentIdAndAppMenuId(
			long residentId, long appMenuId) {
		String sql = " select * from DT_APP_MENU_RESIDENT where RESIDENT_ID =? and APP_MENU_ID = ? and DELETED = 'N' ";
		return this.queryForObject(sql, AppMenuResident.class, residentId,appMenuId);
	}

	@Override
	public List<Map<String, Object>> getResidentAppMenuList(long residentId, Long unitId) {
		StringBuffer sb = new StringBuffer();
		if(unitId != null){//绑定过房屋能获取小区
			sb.append("select r.ID as id,r.APP_MENU_ID as menuId, ");
			sb.append("case when u.MENU_NAME is null then m.MENU_NAME else u.MENU_NAME end as menuName, ");
			sb.append("case when u.LINK_URL is null then m.LINK_URL else u.LINK_URL end as linkURL, ");
			sb.append("m.MENU_ICON as menuIcon,m.MENU_TYPE as menuType ");
			sb.append("from DT_APP_MENU_RESIDENT r ");
			sb.append("left join DT_APP_MENU_UNIT u on r.APP_MENU_ID = u.MENU_ID ");
			sb.append("left join DT_APP_MENU m on r.APP_MENU_ID = m.ID ");
			sb.append("where u.UNIT_ID = ? and r.RESIDENT_ID = ? and r.DELETED = ?");
			return this.queryForMapList(sb.toString(), unitId,residentId,Constant.MODEL_DELETED_N);
		}else{//没绑定过房屋但是注册了
			sb.append("select r.ID as id,r.APP_MENU_ID as menuId, ");
			sb.append("m.MENU_NAME as menuName, ");
			sb.append("m.LINK_URL as linkURL, ");
			sb.append("m.MENU_ICON as menuIcon,m.MENU_TYPE as menuType ");
			sb.append("from DT_APP_MENU_RESIDENT r ");
			sb.append("left join DT_APP_MENU  m on r.APP_MENU_ID = m.ID ");
			sb.append("where r.RESIDENT_ID = ? and r.DELETED = ? ");
			return this.queryForMapList(sb.toString(), residentId,Constant.MODEL_DELETED_N);
		}
	}
	
}
