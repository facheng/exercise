package com.dt.tarmag.web;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.DateUtil;
import com.dt.framework.util.FileUploadUtil;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.CarGarage;
import com.dt.tarmag.model.CarPort;
import com.dt.tarmag.model.House;
import com.dt.tarmag.model.KeyDevice;
import com.dt.tarmag.model.Resident;
import com.dt.tarmag.model.Story;
import com.dt.tarmag.service.ICarGarageService;
import com.dt.tarmag.service.ICarPortService;
import com.dt.tarmag.service.IHouseService;
import com.dt.tarmag.service.IKeyDeviceService;
import com.dt.tarmag.service.IResidentService;
import com.dt.tarmag.service.IStoryService;

/**
 * 系统参数数据导入导出
 * @author jiaosf
 * @since 2015-7-8
 */
@Controller
public class SysParamsDataController {
	
	private static final Logger logger = LoggerFactory.getLogger(SysParamsDataController.class);
	
	@Autowired
	private IStoryService storyService;
	
	@Autowired
	private IHouseService houseService;
	
	@Autowired
	private IResidentService residentService;
	
	@Autowired
	private IKeyDeviceService keyDeviceService;
	
	@Autowired
	private ICarGarageService carGarageService;
	
	@Autowired
	private ICarPortService carPortService;
	 
	/**
	 * 导入楼栋信息
	 * @param request
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/story/import", method = POST)
	public String importStory(HttpServletRequest request, MultipartFile file, ModelMap model) throws IOException {
		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}

		// 模版上传目录
		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator +PortalConstants.TEMPLATE_URL + File.separator + Story.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		storyService.importStory_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");
		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}

		return "to.sys.data.import.setting";
	}
	
	/**
	 * 导入房屋信息
	 * @param file
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/house/import", method = POST)
	public String importHoues(MultipartFile file, ModelMap model) throws IOException {

		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}

		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator +PortalConstants.TEMPLATE_URL + File.separator + House.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		houseService.importHouse_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");

		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}

		return "to.sys.data.import.setting";
	}
	
	
	/**
	 * 导入住户信息
	 * @param file
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/resident/import", method = POST)
	public String importResident(MultipartFile file, ModelMap model) throws IOException {

		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}

		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator + PortalConstants.TEMPLATE_URL + File.separator + Resident.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		residentService.importResident_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");

		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}

		return "to.sys.data.import.setting";
	}
	
	/**
	 * 钥匙数据导入
	 * @param file
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/key/import", method = POST)
	public String importKeyDevice(MultipartFile file, ModelMap model) throws IOException {
		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator + PortalConstants.TEMPLATE_URL + File.separator + KeyDevice.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		keyDeviceService.importKeyDevice_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");

		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}
		
		return "to.sys.data.import.setting";
	}
	
	/**
	 * 车库数据导入
	 * @param file
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/garage/import", method = POST)
	public String importGarageDevice(MultipartFile file, ModelMap model) throws IOException {
		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator + PortalConstants.TEMPLATE_URL + File.separator + CarGarage.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		carGarageService.importCarGarage_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");

		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}
		
		return "to.sys.data.import.setting";
	}
	
	/**
	 * 车位数据导入
	 * @param file
	 * @param model
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/sys/params/port/import", method = POST)
	public String importPortDevice(MultipartFile file, ModelMap model) throws IOException {
		// 获取登录信息
		HttpSession session = ActionUtil.getSession();
		Long unitId = (Long) session.getAttribute(PortalConstants.SESSION_USER_UNIT);
		Long userId = ActionUtil.getSessionUserId();
		if (unitId == null || unitId <= 0) {
			model.put(Constant.KEY_ERR_MESSAGE, "用户未选择小区！");
			return Constant.GLOBAL_TO_ERROR;
		}
		
		String fileUpload = PortalConstants.FILE_STORE_URL + File.separator + PortalConstants.TEMPLATE_URL + File.separator + CarPort.TEMPLATE_PATH + File.separator + unitId
				+ File.separator;

		// 数据导入
		carPortService.importCarPort_tx(file.getInputStream(), unitId, model);

		// 上传文件
		Date now = new Date();
		String fileName = fileUpload + userId + "_" + DateUtil.formatDate(now, DateUtil.PATTERN_DATE_TIME3);

		String fileFlag = (String) model.get("importMsg");

		if (fileFlag.equals("success")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_success.xls");
		}
		else if (fileFlag.equals("fail")) {
			FileUploadUtil.fileUpload(file.getInputStream(), fileName + "_fail.xls");
		}
		
		return "to.sys.data.import.setting";
	}
	
	/**
	 * 房屋管理-导出
	 * 
	 * @param request
	 * @param response
	 * @param map
	 * @param houseInfo
	 */
	@RequestMapping("/sys/params/house/export")
    @ResponseBody
	public void houseInfoImport(HttpServletRequest request,
			HttpServletResponse response, ModelMap model  , House house) {
		
		BufferedOutputStream out = null;
		
		try {
			Long unitId = (Long) ActionUtil.getSession().getAttribute(PortalConstants.SESSION_USER_UNIT);
			
			if( unitId != null ){
				house.setUnitId( unitId );
			}
			
			HSSFWorkbook wb = houseService.getHouseInfosForExport(house);
			
			response.setHeader( "content-disposition", "attachment;filename=houseInfoExport.xls");
			out = new BufferedOutputStream( response.getOutputStream());
			wb.write(out);
			out.flush();
			
		} catch (Exception e) {
			
			logger.error( e.getMessage() , e);
			model.put("memo", "系统管理");
		} finally {
			
			if(out != null ){
				try{
					out.close();
				}catch(Exception ex){}
			}
			
		}
	}

		
}
