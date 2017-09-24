package com.dt.tarmag.service;

import java.util.List;

import com.dt.tarmag.model.WorkType;

/**
 * 角色工种 SERVICE
 *
 * @author jiaosf
 * @since 2015-7-23
 */
public interface IWorkerTypeService {
	
	/**
	 * 获取工种
	 * @param workType
	 * @return
	 */
	public List<WorkType> getWorkTypeByType(Byte wtType);

}
