/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import com.dt.tarmag.model.AppClickRec;
import com.dt.tarmag.model.Feedback;

/**
 * @author 👤wisdom 
 *
 */
public interface IAppService {
	
	/**
	 * 用户反馈
	 * @param feedback
	 */
	public void feedback_tx(Feedback feedback);
	
	/**
	 * 点击率
	 * @param appClickRec
	 */
	public void clickrec_tx(AppClickRec appClickRec);
}
