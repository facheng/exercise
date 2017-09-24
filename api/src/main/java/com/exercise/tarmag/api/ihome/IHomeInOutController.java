package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IInOutService;
import com.dt.tarmag.util.MsgKey;
/**
 * 出入记录
 * @author jason
 *
 */
@Controller
public class IHomeInOutController extends AbstractDtController{
	
	@Autowired
	private IInOutService inOutService;

	/**
	 * 出入记录
	 * 
	 * @param tokenId
	 * @return
	 */
	@RequestMapping(value = "ihome/inout", method = POST)
	@ResponseBody
	protected MsgResponse inOut(Long keyDeviceId,Long residentId,int clickTimes, Long unitId) {
		MsgResponse response = null;
		try {
			if(keyDeviceId != null && residentId != null){
				this.inOutService.save_tx(keyDeviceId, residentId, clickTimes, unitId);
				response = new Success();
			}else{
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail();
		}
		return response;
	}
}
