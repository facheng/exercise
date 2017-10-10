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
import com.dt.tarmag.service.INoticeService;
import com.dt.tarmag.util.MsgKey;

/**
 * @author wisdom 通知
 */
@Controller
@RequestMapping("ihome/notice")
public class IHomeNoticeController extends AbstractDtController {

	@Autowired
	private INoticeService noticeService;

	/**
	 * 获取通知列表
	 * 
	 * @param residentId
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "notices", method = GET)
	@ResponseBody
	protected MsgResponse notices(long unitId, long residentId, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("notices", this.noticeService.notices(residentId, unitId, pageNo));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 查看通知详情
	 * 
	 * @param id 公告id
	 * @param residentId
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "notice", method = POST)
	@ResponseBody
	protected MsgResponse notice(long id, long residentId) {
		MsgResponse response = null;
		try {
			response = new Success("notice", this.noticeService.notice_tx(id,
					residentId));
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
			this.noticeService.clean_tx(unitId, residentId);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}