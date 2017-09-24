package com.dt.tarmag.api;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dt.framework.util.ActionUtil;


/**
 * @author wei
 * @time 2015-8-2 下午09:17:48
 */
@Controller
public class AppHomeController {
	
	
	@RequestMapping(value = "/", method = GET)
	@ResponseBody
	public String toHome(ModelMap model){
		HttpServletRequest request = ActionUtil.getRequest();
		String requestPath = request.getScheme() + "://" + request.getServerName() + ":"
								+ request.getServerPort() + request.getContextPath();
		System.out.println(requestPath);
		
		String msg = "The server is ok.";
		return msg;
	}
	
}
