package com.dt.tarmag.push;

import java.util.List;

import org.apache.log4j.Logger;

import com.dt.tarmag.vo.PushVo;

/**
 * i家园的消息推送
 * 
 * @author jason
 *
 */
public class PushThread implements Runnable {

	private List<PushVo> pushVos;
	public static final Logger logger = Logger.getLogger(PushThread.class);

	public PushThread() {
	}

	public PushThread(List<PushVo> pushVos) {
		super();
		this.pushVos = pushVos;
	};

	@Override
	public void run() {
		for (PushVo pushVo : pushVos) {
			try {
				PushUtil.push(pushVo);
			} catch (Exception e) {
				logger.error(e.getLocalizedMessage(), e); 
			}
		}
	}
}
