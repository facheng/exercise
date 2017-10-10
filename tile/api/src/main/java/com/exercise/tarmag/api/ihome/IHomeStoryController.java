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
import com.dt.tarmag.service.IStoryService;

@RequestMapping("ihome/story")
@Controller
public class IHomeStoryController extends AbstractDtController {

	@Autowired
	private IStoryService storyService;

	/**
	 * 根据小区id获取小区下面所有的楼栋
	 * 
	 * @param districtId
	 * @return
	 */
	@RequestMapping(value = "storys", method = GET)
	@ResponseBody
	protected MsgResponse getStorysByUnitId(Long unitId) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("storys",
					this.storyService.getStorysByUnitId(unitId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
}
