/**
 * 
 */
package com.dt.tarmag.api.ihome;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dt.framework.util.Constant;
import com.dt.framework.util.ImgUploadUtil;
import com.dt.framework.web.controller.AbstractDtController;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.framework.web.vo.Success;
import com.dt.tarmag.ApiConstants;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.service.IResidentService;

/**
 * @author wisdom
 *
 */
@Controller
@RequestMapping("ihome")
public class IHomeResidentController extends AbstractDtController {

	@Autowired
	private IResidentService residentService;

	/**
	 * 根据手机号发放验证码
	 * 
	 * @param phoneNum
	 * @return
	 */
	@RequestMapping(value = "pincode", method = POST)
	@ResponseBody
	protected MsgResponse getPinCode(String phoneNum) {
		return this.residentService.getPinCode_tx(phoneNum);
	}

	/**
	 * 根据手机号 和验证码 或者 手机令牌登录
	 * 
	 * @param phoneNum
	 * @param pinCode
	 * @param tokenId
	 * @return
	 */
	@RequestMapping(value = "login", method = POST)
	@ResponseBody
	protected MsgResponse login(String phoneNum, String pinCode, String tokenId) {
		MsgResponse response = this.residentService.login_tx(phoneNum, pinCode,
				tokenId);
		String keys = "user.headImg";
		if (response instanceof Success
				&& StringUtils.isNotBlank(response.get(keys).toString())) {
			response.put(
					keys,
					ImgUploadUtil.getAccessURL(ApiConstants.FILE_ACCESS_URL
							+ "/" + ApiConstants.IMG_URL + "/"
							+ Resident.IMG_PATH, response.get(keys).toString()));
		}
		return response;
	}

	/**
	 * 根据手机号和手机令牌登出
	 * 
	 * @param tokenId
	 * @return
	 */
	@RequestMapping(value = "logout", method = POST)
	@ResponseBody
	protected MsgResponse loginOut(String tokenId) {
		MsgResponse response = null;
		try {
			this.residentService.loginOut_tx(tokenId);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail();
		}
		return response;
	}

	/**
	 * 头像修改
	 * 
	 * @param id
	 *            用户id
	 * @return
	 */
	@RequestMapping(value = "headimg", method = POST)
	@ResponseBody
	protected MsgResponse headimg(MultipartFile uploadfile, Long id) {
		MsgResponse response = null;
		try {
			String reqUrl = ApiConstants.FILE_ACCESS_URL + "/"
					+ ApiConstants.IMG_URL + "/" + Resident.IMG_PATH + "/";
			String headimg = ImgUploadUtil.uploadFile(
					ApiConstants.FILE_STORE_URL + File.separator
							+ ApiConstants.IMG_URL + File.separator
							+ Resident.IMG_PATH + File.separator,
					uploadfile.getInputStream());
			this.residentService.headimg_tx(id, headimg);
			response = new Success("url", reqUrl + headimg
					+ Constant.IMG_TYPE_JPG);
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail();
		}
		return response;
	}

	/**
	 * 修改个人信息
	 * 
	 * @param resident
	 * @return
	 */
	@RequestMapping(value = "residetrevise", method = POST)
	@ResponseBody
	protected MsgResponse resident(Long id,String phoneNum, String userName,
			String nickName, String idCard, String headImg, Integer sex) {
		MsgResponse response = null;
		try {
			Resident resident = new Resident();
			resident.setId(id);
			resident.setPhoneNum(phoneNum);
			resident.setUserName(userName);
			resident.setNickName(nickName);
			resident.setIdCard(idCard);
			resident.setHeadImg(headImg);
			resident.setSex(sex == null ? 0 : Byte.valueOf(sex.toString()));
			this.residentService.residetrevise_tx(resident);
			response = new Success();
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
			response = new Fail();
		}
		return response;
	}
}
