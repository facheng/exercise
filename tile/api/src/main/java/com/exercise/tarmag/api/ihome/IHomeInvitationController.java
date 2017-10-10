/**
 * 
 */
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
import com.dt.tarmag.service.IInvitationService;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.InvitationVo;

/**
 * @author wisdom
 *
 */
@RequestMapping("ihome/invite")
@Controller
public class IHomeInvitationController extends AbstractDtController {

	@Autowired
	private IInvitationService invitationService;

	/**
	 * 获取发起的邀约
	 * 
	 * @param inviterId
	 *            邀请人id
	 * @param houseId
	 *            房屋id
	 * @return
	 */
	@RequestMapping(value = "invitations", method = GET)
	@ResponseBody
	public MsgResponse invitations(final Long inviterId, final Long houseId, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("invitations",
					this.invitationService.findInvitations(inviterId, houseId,
							null, pageNo));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 获取收到的邀约
	 * 
	 * @param inviteeId
	 *            受邀请人id
	 * @return
	 */
	@RequestMapping(value = "receptioninvitations", method = GET)
	@ResponseBody
	public MsgResponse invitations(final Long inviteeId, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("invitations",
					this.invitationService.findInvitations(null, null,
							inviteeId, pageNo));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 获取发出的邀约明细
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "invitationdetail", method = GET)
	@ResponseBody
	public MsgResponse invitationDetail(final Long id) {
		MsgResponse response = null;
		try {
			response = new Success("detail",
					this.invitationService.findInvitation(id));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 获取收到的邀约明细
	 * 
	 * @param id
	 *            邀约id
	 * @return
	 */
	@RequestMapping(value = "receptioninvitationdetail", method = GET)
	@ResponseBody
	public MsgResponse receptionInvitationDetail(final Long id) {
		MsgResponse response = null;
		try {
			response = new Success("detail",
					this.invitationService.findReceptionInvitation(id));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 新增邀约
	 * @param invitation
	 * @param resident
	 * @return
	 */
	@RequestMapping(value = "newinvitation", method = POST)
	@ResponseBody
	public MsgResponse newinvitation(InvitationVo invitationVo) {
		MsgResponse response = null;
		try {
			this.invitationService.addInvitation_tx(invitationVo);
			response = new Success(MsgKey._000000007);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000008);
		}
		return response;
	}
}
