package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.Page;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.CommonWords;
import com.dt.tarmag.service.ICommonWordsService;
import com.dt.tarmag.service.IInfoService;
import com.dt.tarmag.vo.BroadcastVo;
import com.dt.tarmag.vo.DeliveryVo;
import com.dt.tarmag.vo.NoticeVo;



/**
 * 信息管理
 * @author yuwei
 * @Time 2015-7-9上午09:27:27
 */
@Controller
public class InfoController {
	
	@Autowired
	private IInfoService infoService;
	
	@Autowired
	private ICommonWordsService commonWordsService;

	/**
	 * 公告管理
	 * @param type/公告类别
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcast/list", method = GET)
	public String showBroadcastList(@RequestParam(value = "type", required = false) Byte type
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		int count = infoService.getBroadcastCount(unitId, type);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> broadcastList = infoService.getBroadcastMapList(unitId, type, pageNo, pageSize);

		model.put("type", type);
		model.put("page", page);
		model.put("broadcastList", broadcastList);
		return "to.show.broadcast.list";
	}
	
	/**
	 * 编辑公告
	 * 如果id为空，表示新建公告，否则是修改现有公告
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcast", method = GET)
	public String toEditBroadcast(@RequestParam(value = "id", required = false) Long broadcastId
			, ModelMap model){
		if(broadcastId == null) {
			return "to.edit.broadcast";
		}
		
		Map<String, Object> map = infoService.getBroadcastToEdit(broadcastId);
		if(map == null) {
			return ActionUtil.redirect("/info/broadcast");
		}
		
		model.put("map", map);
		model.put("broadcastId", broadcastId);
		return "to.edit.broadcast";
	}
	
	/**
	 * 保存公告
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcast", method = POST)
	public String saveBroadcast(@RequestParam(value = "id", required = false) Long broadcastId
			, BroadcastVo vo , ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		vo.setUnitId(unitId);
		
		if(broadcastId == null || broadcastId <= 0) {
			infoService.createBroadcast_tx(vo);
		} else {
			infoService.updateBroadcast_tx(broadcastId, vo);
		}
		return ActionUtil.redirect("/info/broadcast/list");
	}
	
	/**
	 * 删除公告
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcasts", method = DELETE)
	@ResponseBody
	public String deleteBroadcast(@RequestParam(value = "broadcastIds", required = true) String broadcastIds, ModelMap model){
		if(broadcastIds == null || broadcastIds.trim().equals("")) {
			return "0";
		}
		String[] arr = broadcastIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		infoService.deleteBroadcast_tx(idList);
		
		return "1";
	}
	
	/**
	 * 公告详细
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcast/{id}", method = GET)
	public String showBroadcastDetail(@PathVariable(value = "id") long broadcastId, ModelMap model){
		Map<String, Object> map = infoService.getBroadcastDetail(broadcastId);
		model.put("broadcastId", broadcastId);
		model.put("map", map);
		return "to.broadcast.detail";
	}
	
	/**
	 * 公告已读记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/broadcast/{id}/read/list", method = GET)
	public String showBroadcastReadList(@PathVariable(value = "id") long broadcastId
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = infoService.getReadCountByBroadcastId(broadcastId);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> mapList = infoService.getBroadcastReadList(broadcastId, pageNo, pageSize);

		model.put("page", page);
		model.put("mapList", mapList);
		return "to.show.broadcast.read.list";
	}

	/**
	 * 通知管理
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notice/list", method = GET)
	public String showNoticeList(@RequestParam(value = "type", required = false) Byte type
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		unitId = unitId == null ? 0 : unitId;
		
		int count = infoService.getNoticeCount(unitId, type);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> noticeList = infoService.getNoticeMapList(unitId, type, pageNo, pageSize);

		model.put("type", type);
		model.put("page", page);
		model.put("noticeList", noticeList);
		return "to.show.notice.list";
	}
	
	/**
	 * 编辑通知
	 * 如果id为空，表示新建通知，否则是修改现有通知
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notice", method = GET)
	public String toEditNotice(@RequestParam(value = "id", required = false) Long noticeId , ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		model.put("unitId", unitId == null ? 0 : unitId);
		
		List< CommonWords > commonWordsList = commonWordsService.getCommonWordsVoByType(CommonWords.TYPE_NOTICE , unitId);
		//常用语
		model.put("commonWordsList", commonWordsList);
		
		if(noticeId == null) {
			return "to.edit.notice";
		}
		
		Map<String, Object> map = infoService.getNoticeToEdit(noticeId);
		if(map == null) {
			return ActionUtil.redirect("/info/notice");
		}
		
		
		model.put("map", map);
		model.put("noticeId", noticeId);
		return "to.edit.notice";
	}
	
	/**
	 * 保存通知
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notice", method = POST)
	public String saveNotice(@RequestParam(value = "id", required = false) Long noticeId
			, NoticeVo vo , ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		vo.setUnitId(unitId);
		
		if(noticeId == null || noticeId <= 0) {
			infoService.createNotice_tx(vo);
		} else {
			infoService.updateNotice_tx(noticeId, vo);
		}
		return ActionUtil.redirect("/info/notice/list");
	}
	
	/**
	 * 删除通知
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notices", method = DELETE)
	@ResponseBody
	public String deleteNotice(
			@RequestParam(value = "noticeIds", required = true) String noticeIds
			, ModelMap model){
		
		if(noticeIds == null || noticeIds.trim().equals("")) {
			return "0";
		}
		String[] arr = noticeIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		infoService.deleteNotice_tx(idList);
		
		return "1";
	}
	
	/**
	 * 通知详细
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notice/{id}", method = GET)
	public String showNoticeDetail(@PathVariable(value = "id") long noticeId, ModelMap model){
		Map<String, Object> map = infoService.getNoticeDetail(noticeId);
		model.put("noticeId", noticeId);
		model.put("map", map);
		return "to.notice.detail";
	}
	
	/**
	 * 通知已读记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/notice/{id}/read/list", method = GET)
	public String showNoticeReadList(@PathVariable(value = "id") long noticeId
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = infoService.getReadCountByNoticeId(noticeId);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> mapList = infoService.getNoticeReadList(noticeId, pageNo, pageSize);

		model.put("page", page);
		model.put("mapList", mapList);
		return "to.show.notice.read.list";
	}

	/**
	 * 快递消息管理
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery/list", method = GET)
	public String showExpressDeliveryList(@RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;

		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		unitId = unitId == null ? 0 : unitId;
		
		int count = infoService.getDeliveryCount(unitId);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> deliveryList = infoService.getDeliveryMapList(unitId, pageNo, pageSize);
		model.put("page", page);
		model.put("deliveryList", deliveryList);
		
		return "to.show.express.delivery.list";
	}

	
	/**
	 * 编辑快递消息
	 * 如果id为空，表示新增快递消息，否则是修改现有快递消息
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery", method = GET)
	public String toEditDelivery(@RequestParam(value = "id", required = false) Long deliveryId
			, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		model.put("unitId", unitId == null ? 0 : unitId);
		
		List< CommonWords > commonWordsList = commonWordsService.getCommonWordsVoByType(CommonWords.TYPE_DELIVERY , unitId);
		//常用语
		model.put("commonWordsList", commonWordsList);
		
		if(deliveryId == null) {
			return "to.edit.express.delivery";
		}
		
		Map<String, Object> map = infoService.getDeliveryToEdit(deliveryId);
		if(map == null) {
			return ActionUtil.redirect("/info/delivery");
		}
		
		model.put("map", map);
		model.put("deliveryId", deliveryId);
		return "to.edit.express.delivery";
	}
	
	/**
	 * 保存快递消息
	 * @param vo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery", method = POST)
	public String saveExpressDelivery(@RequestParam(value = "id", required = false) Long deliveryId
			, DeliveryVo vo, ModelMap model){
		Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
		if(unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		vo.setUnitId(unitId);
		
		if(deliveryId == null || deliveryId <= 0) {
			infoService.createDelivery_tx(vo);
		} else {
			infoService.updateDelivery_tx(deliveryId, vo);
		}
		
		return ActionUtil.redirect("/info/delivery/list");
	}
	
	/**
	 * 删除快递消息
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/deliverys", method = DELETE)
	@ResponseBody
	public String deleteExpressDelivery(@RequestParam(value = "deliveryIds", required = true) String deliveryIds
			, ModelMap model){
		
		if(deliveryIds == null || deliveryIds.trim().equals("")) {
			return "0";
		}
		String[] arr = deliveryIds.trim().split(",");
		if(arr == null || arr.length <= 0) {
			return "0";
		}
		
		List<Long> idList = new ArrayList<Long>();
		for(String id : arr) {
			idList.add(Long.parseLong(id));
		}
		
		infoService.deleteDelivery_tx(idList);
		
		return "1";
	}

	/**
	 * 快递消息详细
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery/{id}", method = GET)
	public String showExpressDeliveryDetail(@PathVariable(value = "id") long deliveryId, ModelMap model){
		Map<String, Object> map = infoService.getDeliveryDetail(deliveryId);
		model.put("deliveryId", deliveryId);
		model.put("map", map);
		return "to.express.delivery.detail";
	}
	
	/**
	 * 快递消息已读记录
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery/{id}/read/list", method = GET)
	public String showExpressDeliveryReadList(@PathVariable(value = "id") long deliveryId
			, @RequestParam(value = "pageNo", required = false) Integer pageNo
			, @RequestParam(value = "pageSize", required = false) Integer pageSize
			, ModelMap model){
		pageNo = pageNo == null ? -1 : pageNo;
		pageSize = pageSize == null ? -1 : pageSize;
		
		int count = infoService.getReadCountByDeliveryId(deliveryId);
		Page page = new Page(count, pageNo, pageSize, 5, ActionUtil.getRequest());
		
		List<Map<String, Object>> mapList = infoService.getExpressDeliveryReadList(deliveryId, pageNo, pageSize);
		model.put("page", page);
		model.put("mapList", mapList);
		
		return "to.show.delivery.read.list";
	}
	
	/**
	 * 签收快递
	 * @param deliveryId
	 * @param residentId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/info/delivery/{id}/sign", method = POST)
	@ResponseBody
	public String signForDelivery(@PathVariable(value = "id") long deliveryId
			, @RequestParam(value = "residentId", required = true) long residentId
			, ModelMap model){
		return infoService.signForDelivery_tx(deliveryId, residentId);
	}
}
