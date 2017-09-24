package com.dt.tarmag.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import com.dt.framework.util.ActionUtil;
import com.dt.framework.util.Constant;
import com.dt.framework.util.CookieUtil;
import com.dt.tarmag.model.Customer;
import com.dt.tarmag.service.ICustomerService;


/**
 * @author wei
 */
public class AutoLoginInterceptor extends AbstractHandlerInterceptor {

	@Autowired
	private ICustomerService customerService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = ActionUtil.getSession();
		Customer _customer = (Customer) session.getAttribute(Constant.SESSION_USER);
		if(_customer != null) {
			return true;
		}
		
		String userName = CookieUtil.getUserFromCookie();
		if(userName != null) {
			Customer customer = customerService.getCustomerByUserName(userName);
			if(customer != null) {
				session.setAttribute(Constant.SESSION_USER_ID, customer.getId());
				session.setAttribute(Constant.SESSION_USER, customer);
			}
		}
		
		return true;
	}
}
