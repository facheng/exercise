package com.dt.framework.web.controller;

import org.apache.log4j.Logger;

import com.dt.framework.model.DtModel;

/**
 * 抽象控制层
 * @author jason
 *
 */
public class AbstractDtController {
	protected static final String CONTENT_TYPE = "application/json;charset=utf8;";
	
	protected static final Logger logger = Logger.getLogger(AbstractDtController.class);
	/**
	 * 手机端保存方法
	 * @param model
	 */
	protected void appSave(DtModel model){
		//缓存取值
		if(model.getId() == 0){//新增
			model.setCreateUserId(0);
		}else{//修改
			model.setUpdateUserId(0);
		}
	}
}
