package com.dt.tarmag.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.tarmag.model.Customer;

/**
 * @author yuwei
 * 需要登录后访问的资源，如果被拦截后强制登录，则在登录完成后跳转到目标资源继续访问(仅限get访问方式)
 * @Time 2015-6-16下午12:56:31
 */
public class LoginCheckInterceptor extends AbstractHandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = ActionUtil.getSession();
		Customer customer = (Customer) session.getAttribute(Constant.SESSION_USER);
		if(customer == null) {
			if("get".equalsIgnoreCase(ActionUtil.getRequest().getMethod())) {
				response.sendRedirect("/login?url=" + getToUrl(request));
			} else {
				response.sendRedirect("/login");
			}
			return false;
		}
		
		/**
		 * 如果是管理员，只能访问/admin打头的资源；
		 * 如果不是管理员，不能访问非/admin打头的资源
		 **/
		String url = ActionUtil.getRequest().getRequestURI();
		if(customer.getIsAdmin() && !url.startsWith("/admin")) {
			response.sendRedirect("/admin");
			return false;
		} else if(!customer.getIsAdmin() && url.startsWith("/admin")) {
			response.sendRedirect("/");
			return false;
		}
		
		return true;
	}
}
