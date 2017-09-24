package com.dt.tarmag.api;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.model.DeviceManage;
import com.dt.tarmag.service.IDeviceManageService;
/**
 * 设备管理
 * @author jason
 *
 */
@Controller
public class AppDeviceManageController extends AbstractDtController{
	@Autowired
	private IDeviceManageService deviceManageService;
	
	/**
	 * 用户反馈
	 * @param feedback
	 * @return
	 */
	@RequestMapping(value="device/manage", method=RequestMethod.POST)
	@ResponseBody
	protected MsgResponse push(DeviceManage deviceManage){
		MsgResponse msgResponse = null;
		try {
			if(StringUtils.isNotBlank(deviceManage.getAppType()) && StringUtils.isNotBlank(deviceManage.getDeviceType()) 
					&& deviceManage.getUserId()!= 0 &&StringUtils.isNotBlank(deviceManage.getnToken())){
				this.deviceManageService.saveDeviceManage_tx(deviceManage);
				msgResponse = new Success();
			}else{
				msgResponse = new Fail();
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
}
