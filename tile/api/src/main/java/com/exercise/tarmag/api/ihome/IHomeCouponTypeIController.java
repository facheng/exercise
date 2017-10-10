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
import com.dt.tarmag.service.ICouponTypeService;
import com.dt.tarmag.util.MsgKey;

@Controller
@RequestMapping("ihome/coupontype")
public class IHomeCouponTypeIController extends AbstractDtController {
	
	@Autowired
	private ICouponTypeService couponTypeService;

	/**
	 * 获取验证码列表
	 * @return
	 */
	@RequestMapping(value="coupontypes", method=GET)
	@ResponseBody
	public MsgResponse coupontypes(Long residentId, int pageNo) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("coupontypes", this.couponTypeService.coupontypes(residentId, pageNo));
		} catch (Exception e) {
			msgResponse = new Fail(MsgKey._000000006);
			logger.error(e.getLocalizedMessage(), e);
		}
		return msgResponse;
	}
	
	/**
	 * 获取已领取的验证码列表
	 * @return
	 */
	@RequestMapping(value="coupons", method=GET)
	@ResponseBody
	public MsgResponse coupons(Long residentId, int pageNo) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("coupons",this.couponTypeService.coupons(residentId, pageNo));
		} catch (Exception e) {
			msgResponse = new Fail(MsgKey._000000006);
			logger.error(e.getLocalizedMessage(), e);
		}
		return msgResponse;
	}
	
	/**
	 * 获取验证码
	 * @return
	 */
	@RequestMapping(value="coupon", method=POST)
	@ResponseBody
	public MsgResponse coupon(Long residentId, Long typeId) {
		MsgResponse msgResponse = null;
		try {
			msgResponse = new Success("code", this.couponTypeService.coupon_tx(residentId, typeId));
		} catch(UnsupportedOperationException e){
			msgResponse = new Fail(MsgKey._000000012);
		}catch (Exception e) {
			msgResponse = new Fail(MsgKey._000000006);
			logger.error(e.getLocalizedMessage(), e);
		}
		return msgResponse;
	}
}
