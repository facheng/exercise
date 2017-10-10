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
import com.dt.tarmag.service.IHouseService;

@RequestMapping("ihome/house")
@Controller
public class IHomeHouseController extends AbstractDtController {

	@Autowired
	private IHouseService houseService;

	/**
	 * 通过楼栋获取房屋列表
	 * 
	 * @param storyId
	 * @return
	 */
	@RequestMapping(value = "houses", method = GET)
	@ResponseBody
	public MsgResponse getHousesByStoryId(long storyId, String tokenId) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("houses",
					this.houseService.getHousesByStoryId(storyId, tokenId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}

}
