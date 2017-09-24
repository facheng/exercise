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
import com.dt.tarmag.service.IBroadcastReaderService;
import com.dt.tarmag.util.MsgKey;

/**
 * @author wisdom 公告
 */
@Controller
@RequestMapping("ihome/broadcast")
public class IHomeBroadcastController extends AbstractDtController {
	@Autowired
	private IBroadcastReaderService broadcastReaderService;

	/**
	 * 获取公告列表
	 * 
	 * @param unitId
	 *            小区id
	 * @param residentId
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "broadcasts", method = GET)
	@ResponseBody
	protected MsgResponse broadcasts(long unitId, long residentId, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("broadcasts",
					this.broadcastReaderService.broadcasts(unitId, residentId, pageNo));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 查看公告详情
	 * 
	 * @param id
	 *            公告id
	 * @param residentId
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "broadcast", method = POST)
	@ResponseBody
	protected MsgResponse broadcast(long id, long residentId) {
		MsgResponse response = null;
		try {
			response = new Success("broadcast",
					this.broadcastReaderService.broadcast_tx(id, residentId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	
	/**
	 * 清空已读
	 * @return
	 */
	@RequestMapping(value="clean", method = POST)
	@ResponseBody
	protected MsgResponse clean(Long unitId, Long residentId){
		MsgResponse response = null;
		try {
			this.broadcastReaderService.clean_tx(residentId, unitId);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}
