package com.dt.tarmag.web;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.web.controller.AbstractDtController;
import com.dt.tarmag.service.IAppClickRecService;
import com.dt.tarmag.util.DataTableParams;
import com.dt.tarmag.util.DataTableResult;

@RequestMapping("sysappclickrec")
@Controller
public class SysAppClickRecController extends AbstractDtController {
	
	@Autowired
	private IAppClickRecService appClickRecService;
	
	/**
	 * 跳转到点击率统计页面
	 * @return
	 */
	@RequestMapping("index")
	protected String index( final ModelMap map ) {
		
		try {
			long clicks = this.appClickRecService.getSumAppClickRec();
			map.put("clicks", clicks + "次");
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		
		return "admin/appclickrec/index";
	}
	
	/**
	 * 加载点击率统计列表
	 * @param type
	 * @param typeId
	 * @param params
	 * @return
	 */
	@RequestMapping("appclickrecs")
	@ResponseBody
	protected JSONObject findCustomer(Byte type, Long typeId,
			final DataTableParams params) {
		JSONObject resultJson = new JSONObject();
		try {
			resultJson = DataTableResult.toJSONObject(params,
					this.appClickRecService.findAppClickRec(params.getPage()));
		} catch (Exception e) {
			logger.error(e.getLocalizedMessage(), e);
		}
		return resultJson;
	}

}
