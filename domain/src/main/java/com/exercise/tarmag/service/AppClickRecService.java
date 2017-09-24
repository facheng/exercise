package com.dt.tarmag.service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.framework.util.Page;
import com.dt.tarmag.dao.IAppClickRecDao;
import com.dt.tarmag.dao.IAppMenuDao;
import com.dt.tarmag.model.AppClickRec;
import com.dt.tarmag.model.AppMenu;
import com.dt.tarmag.util.PageResult;
import com.dt.tarmag.vo.AppClickStatisticsVo;

@Service
public class AppClickRecService implements IAppClickRecService {
	
	@Autowired
	private IAppClickRecDao appClickRecDao;
	
	@Autowired
	private IAppMenuDao appMenuDao;

	@Override
	public PageResult<Map<String, Object>> findAppClickRec(Page page) {

		List<Map<String, Object>> appClickRecs = this.appClickRecDao.findAppClickRec(page);

		int count = this.appClickRecDao.findAppClickRec();

		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();

		if (appClickRecs != null && appClickRecs.size() > 0) {

			for (Map<String, Object> map : appClickRecs) {
				AppClickStatisticsVo asVo = new AppClickStatisticsVo();
				Map<String, Object> resultMap = new HashMap<String, Object>();
				Byte type = Byte.parseByte(map.get("type").toString());
				if (type == AppClickRec.TYPE_CLICK_RATE) {
					asVo.setType(AppClickStatisticsVo.TYPE_CLICK);
					asVo.setTypeName(asVo.getTypeName(asVo.getType()));
					asVo.setTypeId(Long.parseLong(map.get("typeId").toString()));
					asVo.setMenuName(asVo.getMenuName(asVo.getTypeId()));
				}
				if (type == AppClickRec.TYPE_TRANSFORM_RATE) {
					asVo.setType(AppClickStatisticsVo.TYPE_TRANSFORM);
					asVo.setTypeName(asVo.getTypeName(asVo.getType()));
					asVo.setTypeId(Long.parseLong(map.get("typeId").toString()));
					AppMenu am = appMenuDao.get(asVo.getTypeId());
					if(am == null || am.getId() == 0){
						asVo.setMenuName("菜单不存在");
					}else{
						asVo.setMenuName(am.getMenuName());
					}
				}
				asVo.setCounts(Long.parseLong(map.get("counts").toString()));
				asVo.setUserCount(Long.parseLong(map.get("userCount").toString()));
				resultMap.put("counts", asVo.getCounts());
				resultMap.put("typeName", asVo.getTypeName());
				resultMap.put("menuName", asVo.getMenuName());
				resultMap.put("userCount", asVo.getUserCount());

				resultList.add(resultMap);
			}

		}
		page.setRowCount(count);
		return new PageResult<Map<String, Object>>(page, resultList);
	}

	@Override
	public long getSumAppClickRec() {
		
		return appClickRecDao.getSumAppClickRec();
	}

}
