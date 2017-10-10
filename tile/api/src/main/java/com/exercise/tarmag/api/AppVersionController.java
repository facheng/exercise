package com.dt.tarmag.api;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dt.framework.util.ImgUploadUtil;
import com.dt.tarmag.ApiConstants;
import com.dt.tarmag.service.IAppVersionService;


/**
 * @author yuwei
 * @Time 2015-6-27下午05:56:43
 */
@Controller
public class AppVersionController {
	
	@Autowired
	private IAppVersionService appVersionService;
	

	@RequestMapping(value = {"/app/version", "/app/version/"}, method = GET)
	public String getCurrentAppVersion(@RequestParam(value = "type", required = true) int type, ModelMap model){
		Map<String, Object> map = appVersionService.getCurrentAppVersion(type);
		model.put("map", map);
		return "json.to.current.app.version";
	}
	

	/**
	 * 
	 * 上传图片测试接口
	 * 
	 * 
	 * 客户端测试代码(*.html)
	 * <form method="post" action="http://localhost:8080/app/version/test/upload/photo" enctype="multipart/form-data">
	 * <input type="file" name="avatar"/>
	 * <input type="submit" name="上传"/>
	 * </form>
	 * 
	 * 
	 * @param avatar
	 * @return
	 */
	@RequestMapping(value = "/app/version/test/upload/photo", method = POST)
	@ResponseBody
	public String testUploadPhoto(MultipartFile avatar){
		if(avatar == null) {
			return "";
		}
		try {
			/**
			 * 数据库中存储路径
			 **/
			String storeURL = ImgUploadUtil.uploadFile(ApiConstants.FILE_STORE_URL, avatar.getInputStream());

			/**
			 * 图片访问全路径
			 **/
			String accessURL = ImgUploadUtil.getAccessURL(ApiConstants.FILE_ACCESS_URL, storeURL);
			return storeURL + "         " + accessURL;
		} catch (IOException e) {
			return "";
		}
	}
}
