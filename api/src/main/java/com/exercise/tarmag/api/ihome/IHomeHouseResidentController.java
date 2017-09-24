package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.IHouseResidentService;

@RequestMapping("ihome/houseresident")
@Controller
public class IHomeHouseResidentController extends AbstractDtController{
	
	@Autowired
	private IHouseResidentService houseResidentService;
	
	/**
	 * 获取当前登录用户所有房屋信息
	 * 
	 * @param tokenId
	 * @return 返回房屋信息
	 */
	@RequestMapping(value = "houses", method = GET)
	@ResponseBody
	public MsgResponse getBindHouses(String tokenId) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("houses", this.houseResidentService.getBindHouses(tokenId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
	
	/**
	 * 新增房屋绑定
	 * 
	 * @param tokenId
	 *            手机令牌
	 * @param houseId
	 *            房屋id
	 * @param type
	 *            居住类型 0：业主 1：家属 2：租客
	 * @param isDefault
	 *            是否为默认房屋
	 * @return
	 */
	@RequestMapping(value = "housebinding", method = POST)
	@ResponseBody
	public MsgResponse addBindHouse(String tokenId, Long houseId, byte type,
			int isDefault) {
		MsgResponse msgResponse = null;
		try {
			this.houseResidentService.addBindHouse_tx(tokenId, houseId, type, isDefault);
			msgResponse = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
	
	/**
	 * 修改默认房屋
	 * @param id
	 * @param isDefault
	 * @return
	 */
	@RequestMapping(value="changedefault", method=POST)
	@ResponseBody
	public MsgResponse changeDefault(Long id, int isDefault){
		MsgResponse msgResponse = null;
		try {
			this.houseResidentService.changeDefault_tx(id, isDefault);
			msgResponse = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
	
	
	/**
	 * 取消关联房屋
	 * @param id
	 * @return
	 */
	@RequestMapping(value="cancelcorrelation", method=POST)
	@ResponseBody
	public MsgResponse cancelcorrelation(Long id){
		MsgResponse msgResponse = null;
		try {
			this.houseResidentService.delete_tx(id);
			msgResponse = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}
	
}
