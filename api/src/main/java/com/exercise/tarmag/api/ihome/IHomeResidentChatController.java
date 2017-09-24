package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IResidentService;
import com.dt.tarmag.util.MsgKey;

/**
 * 
 * 用户聊信息查询接口
 *
 * @author jiaosf
 * @since 2015-8-25
 */
@Controller
@RequestMapping("ihome/chat")
public class IHomeResidentChatController extends AbstractDtController{
	
	@Autowired
	private IResidentService residentService;
	
	/**
	 * 获取用户头像和昵称
	 * @param phoneNum
	 * @param pinCode
	 * @param tokenId
	 * @return
	 */
	@RequestMapping(value = "resident", method = GET)
	@ResponseBody
	protected MsgResponse resident(String phoneNum) {
		MsgResponse response = null;
		try{
			Map<String ,Object> data = this.residentService.getResidentInfo(phoneNum);
			response = new Success("resident", data);
		}catch(Exception e){
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	/**
	 * 根据小区id查询住户信息
	 * 
	 * @param unitId
	 *            小区id
	 * @return
	 */
	@RequestMapping(value = "residents", method = GET)
	@ResponseBody
	protected MsgResponse residents(long unitId) {
		MsgResponse response = null;
		try {
			response = new Success("residents", this.residentService.getResidentListByUnitId(unitId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	

}
