package com.dt.tarmag.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import com.dt.tarmag.service.IResidentService;

/**
 * 保存api访问记录
 * @author yuwei
 * @Time 2015-7-19下午01:15:03
 */
public class ApiRequestRecInterceptor implements HandlerInterceptor {
	@Autowired
	private IResidentService residentService;
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String tokenId = request.getParameter("tokenId");
		
		/**
		 * 保存访问记录
		 **/
		residentService.saveApiRequestRec_tx(tokenId);
		
		return true;
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
