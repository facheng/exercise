package com.dt.tarmag.interceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.tarmag.PortalConstants;
import com.dt.tarmag.model.Customer;

/**
 * 如果不是管理员，需要校验是否选择角色
 * @author yuwei
 * @Time 2015-6-30下午06:43:31
 */
public class RoleCheckInterceptor extends AbstractHandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = ActionUtil.getSession();
		Customer customer = (Customer) session.getAttribute(Constant.SESSION_USER);
		
		/**
		 * 如果是管理员，不需要校验是否选择角色
		 **/
		if(customer.getIsAdmin()) {
			return true;
		}
		
		Long roleId = (Long) session.getAttribute(PortalConstants.SESSION_USER_ROLE);
		if(roleId == null || roleId <= 0) {
			if("get".equalsIgnoreCase(ActionUtil.getRequest().getMethod())) {
				response.sendRedirect("/select/unit/role?url=" + getToUrl(request));
			} else {
				response.sendRedirect("/select/unit/role");
			}
			return false;
		}
		
		return true;
	}
}
