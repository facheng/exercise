package com.dt.tarmag.interceptor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.web.vo.Fail;
import com.dt.framework.web.vo.MsgResponse;
import com.dt.tarmag.ApiConstants;
import com.dt.tarmag.service.IResidentService;

/**
 * @author yuwei 登录拦截器
 * @Time 2015-6-27下午03:44:31
 */
public class LoginCheckInterceptor implements HandlerInterceptor {
	@Autowired
	private IResidentService residentService;
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		//如果开启了调试
		String tokenId = request.getParameter("tokenId");
		if (ApiConstants.IS_DEBUGGER) {
			MsgResponse.IS_DEBUGGER = ApiConstants.IS_DEBUGGER;
			checkParameter(getParameters(request), handler);
		}
		if (StringUtils.isBlank(tokenId) || residentService.getLoginInfoByTokenId(tokenId) == null) {
			ActionUtil.printStr(response, new Fail("not.login").toString());
			return false;
		}
		//设置H5的跨域Header 允许
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods",
				"POST, GET, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with");
		return true;
	}
	
	protected Map<String, String> getParameters(HttpServletRequest request) {
		@SuppressWarnings("unchecked")
		Map<String, String[]> parameterMap =request.getParameterMap();
		Map<String, String> parameters = new HashMap<String, String>();
		for (Entry<String, String[]> entry : parameterMap.entrySet()) {
			parameters.put(entry.getKey(), Arrays.toString(entry.getValue()));
		}
		return parameters;
	}

	protected Map<String, Object> checkParameter(Map<String, String> receive, Object handler) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (handler instanceof HandlerMethod) {
			List<String> demand = new ArrayList<String>();
			List<String> deficiency = new ArrayList<String>();
			HandlerMethod method = (HandlerMethod) handler;
			MethodParameter[] methodParameters = method.getMethodParameters();
			for (MethodParameter methodParameter : methodParameters) {
				String parameterName = methodParameter.getParameterName();
				demand.add(methodParameter.getParameterIndex(), parameterName);
				if (!receive.containsKey(parameterName)) {
					deficiency.add(parameterName);
				}
			}
			map.put("demand", demand);// server需要的参数
			map.put("receive", receive);// 接收到的参数
			map.put("deficiency", deficiency);// 缺失的
			String uri = ActionUtil.getRequest().getRequestURI();
			ActionUtil.getRequest().setAttribute(uri, map);
			System.out.println("api=>" + map);
		}
		return map;
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
