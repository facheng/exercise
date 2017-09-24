package com.dt.tarmag.api;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.ApiConstants;
import com.dt.tarmag.model.AppClickRec;
import com.dt.tarmag.model.Feedback;
import com.dt.tarmag.qrcode.QRCodeUtil;
import com.dt.tarmag.service.IAppService;
import com.dt.tarmag.service.IInvitationService;

/**
 * 手机端接口服务
 * 
 * @author jason
 *
 */
@Controller
@RequestMapping("app")
public class AppController extends AbstractDtController {

	@Autowired
	private IAppService appService;

	@Autowired
	private IInvitationService invitationService;

	/**
	 * 用户反馈
	 * 
	 * @param feedback
	 * @return
	 */
	@RequestMapping(value = "feedback", method = RequestMethod.POST)
	@ResponseBody
	protected MsgResponse feedback(Feedback feedback) {
		MsgResponse msgResponse = null;
		try {
			this.appService.feedback_tx(feedback);
			msgResponse = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}

	/**
	 * 点击率
	 * 
	 * @param appClickRec
	 * @return
	 */
	@RequestMapping(value = "clickrec", method = RequestMethod.POST)
	@ResponseBody
	protected MsgResponse clickrec(byte type,long typeId,Long residentId) {
		MsgResponse msgResponse = null;
		try {
			AppClickRec appClickRec = new AppClickRec();
			appClickRec.setType(type);
			appClickRec.setTypeId(typeId);
			if(residentId != null){
				appClickRec.setCreateUserId(residentId);
			}
			this.appService.clickrec_tx(appClickRec);
			msgResponse = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			msgResponse = new Fail();
		}
		return msgResponse;
	}

	/**
	 * 邀约二维码
	 * 
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "invite/qrcode", method = GET)
	public String qrcode(final ModelMap map, final Long id) {
		HttpServletRequest request = ActionUtil.getRequest();
		String requestPath = request.getScheme() + "://" + request.getServerName() + ":"
		+ request.getServerPort() + request.getContextPath() + "/";
		map.put("requestPath", requestPath);
		map.put("invitation", this.invitationService.getQrCode(id));
		return "to.invitation.qrcode";
	}

	@RequestMapping(value = "qrcode", method = GET)
	@ResponseBody
	public void qrcode(HttpServletRequest request,
			HttpServletResponse response, String msg, String logourl) {
		if (StringUtils.isBlank(logourl)) {
			logourl = ApiConstants.QR_CODE_LOGO_URL;//i家园logo
		}
		if(StringUtils.isBlank(msg)) return;
		OutputStream os = null;
		try {
			os = response.getOutputStream();
			os.write(QRCodeUtil.qrcode(msg, logourl));
			os.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(os != null){
				try {
					os.close();
					os = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
