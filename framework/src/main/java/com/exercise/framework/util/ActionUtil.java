package com.dt.framework.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * @author wei
 */
public class ActionUtil {
	private ActionUtil() {
	}

	public static String getIpAddr() {
		HttpServletRequest request = getRequest();
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	public static HttpServletRequest getRequest() {
		return ((ServletRequestAttributes) RequestContextHolder
				.getRequestAttributes()).getRequest();
	}

	public static HttpSession getSession() {
		HttpServletRequest request = getRequest();
		return request == null ? null : request.getSession();
	}

	public static String getHttpSessionId() {
		HttpSession session = getSession();
		return session == null ? null : session.getId();
	}

	public static long getSessionUserId() {
		HttpSession session = getSession();
		if (session == null)
			return 0;

		try {
			Long userId = (Long) session.getAttribute(Constant.SESSION_USER_ID);
			return userId == null ? 0 : userId;
		} catch (Exception e) {
			return 0;
		}
	}

	public static void printStr(HttpServletResponse response, Object str) {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = null;
		try {
			out = response.getWriter();
			out.print(str);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	public static String redirect(String url) {
		return "redirect:" + url;
	}

}
