package com.dt.tarmag.web;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.service.ICouponService;
import com.dt.tarmag.service.ICouponTypeService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.CouponTypeVo;

@RequestMapping("syscoupon")
@Controller
public class SysCouponController extends AbstractDtController {
	
	@Autowired
	private ICouponTypeService couponTypeService;
	
	@Autowired
	private ICouponService couponService;
	
	/**
	 * 跳转优惠劵管理页面
	 * 
	 * @return
	 */
	@RequestMapping("index")
	protected String index() {
		return "admin/coupon/index";
	}
	
	/**
	 * 加载优惠劵类型列表
	 * @param userName
	 * @param phoneNum
	 * @param params
	 * @return
	 */
	@RequestMapping("couponTypes")
	@ResponseBody
	protected JSONObject findCouponTypes(String cptName, String sponsor,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.couponTypeService.findCouponType(cptName ,sponsor ,params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 添加修改优惠类型
	 * @param map
	 * @param company
	 * @return
	 */
	@RequestMapping("entity")
	protected String entity(final ModelMap map, CouponTypeVo couponTypeVo) {
		if (couponTypeVo != null && couponTypeVo.getId() != null && couponTypeVo.getId() > 0) {
			couponTypeVo = this.couponTypeService.getCouponTypeEdit(couponTypeVo.getId());
		}
		map.put("entity", couponTypeVo);
		return "admin/coupon/entity";
	}
	
	/**
	 * 修改保存
	 * @param session
	 * @param company
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	protected MsgResponse save(final HttpSession session, final CouponTypeVo couponTypeVo) {
		try {
			if (couponTypeVo.getId() != null && couponTypeVo.getId() > 0) {
				this.couponTypeService.updateCouponType_tx(couponTypeVo);
			}else{
				this.couponTypeService.createCouponType_tx(couponTypeVo);
			}
			return new Success(MsgKey._000000001);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Fail(MsgKey._000000002);
		}
	}
	
	/**
	 * 删除优惠劵类型
	 * @param ids
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public MsgResponse delete(@RequestParam("ids") final Long[] ids) {
		try {
			this.couponTypeService.deleteCouponType_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}
	
	/**
	 * 跳转优惠劵管理页面
	 * 
	 * @return
	 */
	@RequestMapping("couponIndex")
	protected String coupons(final ModelMap map , Long typeId) {
		map.put("typeId", typeId);
		return "admin/coupon/coupons";
	}
	
	
	/**
	 * 加载优惠劵类型列表
	 * @param userName
	 * @param phoneNum
	 * @param params
	 * @return
	 */
	@RequestMapping("coupons")
	@ResponseBody
	protected JSONObject findCoupons(Long typeId ,String code ,Integer isReceived ,String phoneNum,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.couponTypeService.findCoupons(typeId ,code ,isReceived ,phoneNum ,params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}
	
	/**
	 * 删除优惠劵
	 * @param ids
	 * @return
	 */
	@RequestMapping("deleteCoupon")
	@ResponseBody
	public MsgResponse deleteCoupon(@RequestParam("ids") final Long[] ids) {
		try {
			this.couponService.deleteCoupon_tx(ids);
			return new Success(MsgKey._000000003);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			return new Success(MsgKey._000000004);
		}
	}

}
