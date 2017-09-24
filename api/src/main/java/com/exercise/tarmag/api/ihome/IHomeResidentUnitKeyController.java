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
import com.dt.tarmag.service.IResidentUnitKeyService;
import com.dt.tarmag.util.MsgKey;
/**
 * 用户钥匙关系
 * @author jason
 *
 */
@Controller
@RequestMapping("ihome/residentunitkey")
public class IHomeResidentUnitKeyController extends AbstractDtController{

	@Autowired
	private IResidentUnitKeyService residentUnitKeyService;
	
	/**
	 * 获取用户钥匙
	 * @param unitId
	 * @param residentId
	 */
	@RequestMapping(value = "keys", method = GET)
	@ResponseBody
	public MsgResponse findKeys(Long unitId,Long residentId){
		MsgResponse response = null;
		try {
			if(residentId != null){
				response = new Success("keys", this.residentUnitKeyService.findKeys(unitId,residentId));
			}else{
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}
