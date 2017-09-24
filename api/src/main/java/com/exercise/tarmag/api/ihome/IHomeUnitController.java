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
import com.dt.tarmag.service.IUnitService;

@RequestMapping("ihome/unit")
@Controller
public class IHomeUnitController extends AbstractDtController {

	@Autowired
	private IUnitService unitService;

	/**
	 * 根据地区编码获取地区下所有小区
	 * 
	 * @param districtId
	 * @return
	 */
	@RequestMapping(value = "units", method = GET)
	@ResponseBody
	protected MsgResponse getUnitsByDistrictId(Long districtId) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("units",
					this.unitService.getUnits(districtId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail(e.getLocalizedMessage());
		}
		return msgResponse;
	}
}
