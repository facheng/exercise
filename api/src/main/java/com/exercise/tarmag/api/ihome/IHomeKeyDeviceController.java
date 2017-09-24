package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IKeyDeviceService;
import com.dt.tarmag.util.MsgKey;

@RequestMapping("ihome/keydevice")
@Controller
public class IHomeKeyDeviceController extends AbstractDtController {
	
	@Autowired
	private IKeyDeviceService keyDeviceService;
	
	/**
	 * 获取用户钥匙
	 * @param tokenId
	 */
	@RequestMapping(value = "keys", method = GET)
	@ResponseBody
	public MsgResponse findKeys(String tokenId){
		MsgResponse response = null;
		try {
			response = new Success("keys", this.keyDeviceService.findKeys(tokenId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}
