package com.dt.tarmag.api.guarantee;

import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.model.WorkType;
import com.dt.tarmag.service.IWorkerService;
import com.dt.tarmag.util.MsgKey;

@Controller
@RequestMapping("guarantee")
public class GuaranteeWorkerController extends AbstractDtController {

	@Autowired
	private IWorkerService workerService;
	
	@RequestMapping(value = "login", method = POST)
	@ResponseBody
	protected MsgResponse login(String phoneNum, String password, String tokenId) {
		MsgResponse response = null;
		try{
			response = this.workerService.login_tx(phoneNum, password, tokenId, WorkType.TYPE_REPIAR);
		}catch(Exception e){
			response = new Fail(MsgKey._000000011);
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}

	@RequestMapping(value = "logout", method = GET)
	@ResponseBody
	protected MsgResponse logout(String tokenId) {
		MsgResponse response = null;
		try{
			this.workerService.logout(tokenId);
			response = new Success();
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
}
