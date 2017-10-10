/**
 * dt-tarmag-domain
 */
package com.dt.tarmag.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dt.tarmag.dao.IAppClickRecDao;
import com.dt.tarmag.dao.IFeedbackDao;
import com.dt.tarmag.model.AppClickRec;
import com.dt.tarmag.model.Feedback;

/**
 * @author 👤wisdom
 *
 */
@Service
public class AppService implements IAppService {
	@Autowired
	private IAppClickRecDao appClickRecDao;

	@Autowired
	private IFeedbackDao feedbackDao;

	@Override
	public void feedback_tx(Feedback feedback) {
		this.feedbackDao.save(feedback);
	}

	@Override
	public void clickrec_tx(AppClickRec appClickRec) {
		this.appClickRecDao.save(appClickRec);
	}
}
