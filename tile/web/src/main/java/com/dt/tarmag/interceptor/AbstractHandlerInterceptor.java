package com.dt.tarmag.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.SecurityUtil;

public abstract class AbstractHandlerInterceptor extends HandlerInterceptorAdapter {
	
	/**
	 * 获得被拦截前用户试图访问的url
	 * @param request
	 * @return
	 */
	protected String getToUrl(HttpServletRequest request) {
		String url = ActionUtil.getRequest().getRequestURI();
		String pram = ActionUtil.getRequest().getQueryString();
		if(pram != null && !pram.trim().equals("")) {
			url += "?" + pram;
		}
		return SecurityUtil.encode(url);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
