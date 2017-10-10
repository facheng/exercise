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
import com.dt.tarmag.service.IExpressDeliveryService;
import com.dt.tarmag.util.MsgKey;

@Controller
@RequestMapping("ihome/expressdelivery")
public class IHomeExpressDeliveryController extends AbstractDtController {
	@Autowired
	private IExpressDeliveryService expressDeliveryService;

	/**
	 * 获取是否有授权物业代收快递
	 * 
	 * @param houseId
	 *            房屋id
	 * @return
	 */
	@RequestMapping(value = "security", method = GET)
	@ResponseBody
	public MsgResponse security(Long houseId) {
		MsgResponse response = null;
		try {
			response = new Success("delegateDelivery",
					String.valueOf(this.expressDeliveryService.security(houseId)));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 授权物业代收快递
	 * 
	 * @param houseId
	 *            房屋id
	 * @param delegateDelivery
	 *            授权
	 * @return
	 */
	@RequestMapping(value = "delegate", method = POST)
	@ResponseBody
	public MsgResponse delegate(Long houseId, Integer delegateDelivery) {
		MsgResponse response = null;
		try {
			this.expressDeliveryService.delegate_tx(houseId, delegateDelivery);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000009);
		}
		return response;
	}

	/**
	 * 获取快递列表
	 * 
	 * @param houseId
	 * @return
	 */
	@RequestMapping(value = "expressdeliverys", method = GET)
	@ResponseBody
	public MsgResponse expressdeliverys(Long houseId, Long residentId, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("expressdeliverys",
					this.expressDeliveryService.expressdeliverys(houseId,
							residentId, pageNo));
		} catch (Exception e) {
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}

	@RequestMapping(value = "expressdelivery", method = POST)
	@ResponseBody
	public MsgResponse expressdelivery(Long id, Long residentId) {
		MsgResponse response = null;
		try {
			response = new Success("expressdelivery",
					this.expressDeliveryService.expressdelivery_tx(id, residentId));
		} catch (Exception e) {
			response = new Fail();
			logger.error(e.getLocalizedMessage(), e);
		}
		return response;
	}
	
	/**
	 * 清空已读
	 * @return
	 */
	@RequestMapping(value="clean", method = POST)
	@ResponseBody
	protected MsgResponse clean(Long houseId, Long residentId){
		MsgResponse response = null;
		try {
			this.expressDeliveryService.clean_tx(residentId, houseId);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}
