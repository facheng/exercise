package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dt.framework.util.ImgUploadUtil;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.ApiConstants;
import com.dt.tarmag.model.RepairComment;
import com.dt.tarmag.model.RepairPicture;
import com.dt.tarmag.service.IRepairCommentService;
import com.dt.tarmag.service.IRepairProgressService;
import com.dt.tarmag.service.IRepairService;
import com.dt.tarmag.util.MsgKey;
import com.dt.tarmag.vo.RepairVo;

/**
 * 报修
 * 
 * @author jason
 *
 */
@Controller
@RequestMapping("ihome/repair")
public class IHomeRepairController extends AbstractDtController {

	@Autowired
	private IRepairService repairService;
	@Autowired
	private IRepairCommentService repairCommentService;
	@Autowired
	private IRepairProgressService repairProgressService;

	/**
	 * 报修列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "repairs", method = GET)
	@ResponseBody
	protected MsgResponse list(Long unitId, Long residentId, byte status, int pageNo) {
		MsgResponse response = null;
		try {
			response = new Success("repairs", this.repairService.repairs(unitId, residentId, status, pageNo));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 图片上传
	 * 
	 * @param id
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "picture", method = POST)
	@ResponseBody
	protected MsgResponse picture(MultipartFile uploadfile) {
		MsgResponse response = null;
		try {
			response = new Success("picturePath", ImgUploadUtil.uploadFile(
					ApiConstants.FILE_STORE_URL + File.separator
							+ ApiConstants.IMG_URL + File.separator
							+ RepairPicture.IMG_PATH, uploadfile.getInputStream()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail();
		}
		return response;
	}

	/**
	 * 新增报修
	 * 
	 * @param repair
	 * @param picPaths
	 *            图片数组
	 * @return
	 */
	@RequestMapping(value = "create", method = POST)
	@ResponseBody
	protected MsgResponse addRepair(RepairVo repair, String picPaths) {
		MsgResponse response = null;
		try {
			String[] pics = {};
			if (StringUtils.isNotBlank(picPaths)) {
				pics = picPaths.trim().split("\\|");
			}
			if (StringUtils.isNotBlank(repair.getRemark())
					&& repair.getOrderTime() != null) {
				this.repairService.appCreateRepair_tx(repair, pics);
				response = new Success();
			} else {
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 报修详情
	 * 
	 * @return
	 */
	@RequestMapping(value = "detail", method = GET)
	@ResponseBody
	protected MsgResponse detail(Long repairId) {
		MsgResponse response = null;
		try {
			response = new Success("repair",
					this.repairService.getAppRepairDetail(repairId));
			// response.put("pics", this.re);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 报修进度
	 * 
	 * @return
	 */
	@RequestMapping(value = "progress", method = GET)
	@ResponseBody
	protected MsgResponse progress(Long repairId) {
		MsgResponse response = null;
		try {
			if (repairId != null) {
				response = new Success();
				response.putAll(this.repairProgressService.getRepairProgress(repairId));
			} else {
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 打分
	 * 
	 * @param repair
	 * @return
	 */
	@RequestMapping(value = "score", method = POST)
	@ResponseBody
	protected MsgResponse score(Long repairId, int responseScore,
			int doorScore, int serviceScore, int qualityScore) {
		MsgResponse response = null;
		try {
			if (repairId != null) {
				this.repairService.score_tx(repairId, responseScore, doorScore,
						serviceScore, qualityScore);
				response = new Success();
			} else {
				response = new Fail(MsgKey._000000006);
			}
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}

	/**
	 * 评论
	 * 
	 * @param repair
	 * @return
	 */
	@RequestMapping(value = "comment", method = POST)
	@ResponseBody
	protected MsgResponse comment(Long repairId, Long residentId, String content) {
		MsgResponse response = null;
		try {
			RepairComment comment = new RepairComment();
			comment.setRepairId(repairId);
			comment.setResidentId(residentId);
			comment.setContent(content);
			this.repairCommentService.save_tx(comment);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
	/**
	 * 评论
	 * 
	 * @param repair
	 * @return
	 */
	@RequestMapping(value = "comments", method = GET)
	@ResponseBody
	protected MsgResponse comments(Long repairId) {
		MsgResponse response = null;
		try {
			response = new Success("comments", this.repairService.comments(repairId));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail(MsgKey._000000006);
		}
		return response;
	}
}
