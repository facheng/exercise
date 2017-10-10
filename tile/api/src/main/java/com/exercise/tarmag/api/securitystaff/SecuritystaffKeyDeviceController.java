package com.dt.tarmag.api.securitystaff;

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

@Controller
@RequestMapping("securitystaff/keydevice")
public class SecuritystaffKeyDeviceController extends AbstractDtController {

	@Autowired
	private IKeyDeviceService keyDeviceService;
	
	@RequestMapping(value = "keys", method = GET)
	@ResponseBody
	public MsgResponse keys(Long unitId) {
		MsgResponse response = null;
		try{
			response = new Success();
			response.put("keys", this.keyDeviceService.getKeys(unitId));
		}catch(Exception e){
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
}
