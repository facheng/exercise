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
import com.dt.tarmag.service.IResidentUnitService;
import com.dt.tarmag.util.MsgKey;
/**
 * 用户小区关系
 * @author jason
 *
 */
@Controller
@RequestMapping("ihome/residentunit")
public class IHomeResidentUnitController extends AbstractDtController{

	@Autowired
	private IResidentUnitService residentUnitService;
	/**
	 * 绑定小区
	 * 
	 * @param tokenId
	 * @return
	 */
	@RequestMapping(value = "binding", method = POST)
	@ResponseBody
	protected MsgResponse binding(Long unitId,Long residentId) {
		MsgResponse response = null;
		try {
			if(unitId != null && residentId != null){
				this.residentUnitService.unitBinding_tx(unitId, residentId);
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
