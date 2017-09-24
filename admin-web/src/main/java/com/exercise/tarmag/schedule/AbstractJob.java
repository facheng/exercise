package com.dt.tarmag.schedule;

import org.apache.log4j.Logger;

import com.dt.tarmag.AdminConstants;

public abstract class AbstractJob implements Job {
	protected final Logger logger = Logger.getLogger(this.getClass());
	
	@Override
	public void execute() {
		if(AdminConstants.OPEN_SCHEDULE == false) {
			logger.info("未打开开关，定时程序没有执行！！！！！！");
			return;
		}

		logger.info("线程启动");
		executeWork();
	}

	
	protected abstract void executeWork();
}
