package com.dt.tarmag.dao;



import java.util.List;
import java.util.Map;

import com.dt.framework.dao.Dao;
import com.dt.framework.util.Page;
import com.dt.tarmag.model.AppClickRec;


/**
 * @author yuwei
 * @Time 2015-7-17下午01:16:45
 */
public interface IAppClickRecDao extends Dao<AppClickRec, Long> {
	
	/**
	 * 分页查询点击记录
	 * @param params
	 * @param page
	 * @return
	 */
	public List<Map<String, Object>> findAppClickRec(Page page);

	public int findAppClickRec();
	
	/**
	 * 统计APP点击率总数
	 * @return
	 */
	public long getSumAppClickRec();
}
