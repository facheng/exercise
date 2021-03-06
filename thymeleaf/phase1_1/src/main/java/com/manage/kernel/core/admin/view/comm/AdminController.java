package com.manage.kernel.core.admin.view.comm;

import com.manage.base.utils.StringUtil;
import com.manage.base.utils.WebUtil;
import com.manage.kernel.jpa.entity.LoginLog;
import com.manage.kernel.jpa.repository.LoginLogRepo;
import com.manage.kernel.spring.annotation.AuthUserAon;
import com.manage.kernel.spring.config.security.AuthUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.manage.base.supplier.page.ResponseInfo;
import com.manage.base.enums.ResponseStatus;
import com.manage.base.exception.CoreException;
import com.manage.kernel.spring.comm.Messages;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private static final Logger LOGGER = LogManager.getLogger(AdminController.class);

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private SessionAuthenticationStrategy sessionStrategy;

    @Autowired
    private LoginLogRepo loginLogRepo;

    @ResponseBody
    @GetMapping("/ajax/login")
    public ResponseInfo login(String account, String password, HttpServletRequest request,
                              HttpServletResponse response) {
        ResponseInfo responseInfo = new ResponseInfo();
        UsernamePasswordAuthenticationToken authRequest;
        boolean loginStatus = false;
        String message = null;
        try {
            if (StringUtil.isEmptyAny(account, password)) {
                throw new CoreException();
            }

            authRequest = new UsernamePasswordAuthenticationToken(account, password);
            Authentication authentication = authenticationManager.authenticate(authRequest);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            HttpSession session = request.getSession();
            session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
            sessionStrategy.onAuthentication(authentication, request, response);
            responseInfo.status = ResponseStatus.SUCCESS;
            loginStatus = true;
        } catch (Exception e) {
            LOGGER.info("login failed", e);
            responseInfo.status = ResponseStatus.ERROR;
            responseInfo.message = Messages.get("login.user.or.password.error");
            message = responseInfo.message;
        } finally {
            recordLoginInfo(account, request, loginStatus, message);
        }
        return responseInfo;
    }

    private void recordLoginInfo(String account, HttpServletRequest request, boolean status, String message) {
        LoginLog login = new LoginLog();
        login.setAccount(account);
        login.setClientIP(WebUtil.remoteIP(request));
        login.setSuccess(status);
        login.setMessage(message);
        loginLogRepo.save(login);
    }

    @GetMapping("/loginOut")
    public String loginOut(String account, String password, HttpServletRequest request,
                           HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/admin/login";
    }

    @RequestMapping("/index")
    public ModelAndView index(@AuthUserAon AuthUser user) {
        return new ModelAndView("admin/index");
    }
}
