package com.dt.framework.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import com.dt.framework.util.SecurityUtil;

/**
 * @author wei
 */
public class CookieUtil {
	public final static String COOKIE_NAME = "cookie.member.name";
	public final static int COOKIE_MAXAGE_1W = 60 * 60 * 24 * 7;// 1 week


	public static void addUserToCookie(HttpServletResponse response, String userName) {
		Cookie cookie = new Cookie(COOKIE_NAME, SecurityUtil.encode(userName));
		cookie.setMaxAge(COOKIE_MAXAGE_1W);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	
	public static String getUserFromCookie() {
		Cookie[] cookies = ActionUtil.getRequest().getCookies();
		if (cookies == null || cookies.length <= 0) {
			return null;
		}
		for (int i = 0; i < cookies.length; i++) {
			if (cookies[i].getName().equals(COOKIE_NAME)) {
				return SecurityUtil.decode(cookies[i].getValue());
			}
		}
		return null;
	}
	
	public static void invalidate(HttpServletResponse response) {
		Cookie[] cookies = ActionUtil.getRequest().getCookies();
		if (cookies != null) {
			for(int i = 0; i < cookies.length; i++) {
				Cookie cookie = new Cookie(cookies[i].getName(), null);
				cookie.setValue("");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				response.addCookie(cookie);
			}
		}
	}
}
