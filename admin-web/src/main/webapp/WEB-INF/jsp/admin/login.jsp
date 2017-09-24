<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
    
<head>
    <title>登录</title>
	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <base href="${requestPath}">
	<%@include file="/common/css.jsp" %>
</head>
<body>
    <div id="loginbox">            
        <form id="loginform" class="form-vertical" method="post" action="${requestPath}sysadmin/login">
 			<div class="control-group normal_text"> <h3><img src="${basePath}common/img/logo.png" alt="Logo" /></h3></div>
            <div class="control-group">
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_lg">
                        	<i class="icon-user"></i>
                        </span>
                        <input name="userName" value="${user.userName}" type="text" placeholder="用户名" class="{required:true,messages:{required:'用户名不能为空!'}}"/>
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_ly"><i class="icon-lock"></i></span>
                        <input name="password" value="${user.password}" type="password" placeholder="密码"  class="{required:true,messages:{required:'密码不能为空!'}}"/>
                    </div>
                </div>
            </div>
            <c:if test="${not empty errmsg}">
            	<div class="control-group errorMsg">
	            	<span>${errmsg}</span>
	            </div>
            </c:if>
            <div class="form-actions">
                <span class="pull-left"><a href="javascript:void(0);" class="flip-link btn btn-info" id="to-recover">忘记密码?</a></span>
                <span class="pull-right"><a id="login" type="submit" href="javascript:void(0);" class="btn btn-success" > 登录</a></span>
            </div>
        </form>
        <form id="recoverform" action="#" class="form-vertical">
				<p class="normal_text">请输入你注册的邮箱地址</p>

                <div class="controls">
                    <div class="main_input_box">
                        <span class="add-on bg_lo">
                        	<i class="icon-envelope"></i>
                        </span>
                        <input type="text" class="required email" placeholder="E-mail address" />
                    </div>
                </div>
           
            <div class="form-actions">
                <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; 返回登录</a></span>
                <span class="pull-right">
                	<a class="btn btn-info" href="javascript:void(0);">确认</a>
                </span>
            </div>
        </form>
    </div>
    
    <%@include file="/common/js.jsp" %>
    <script src="${basePath}matrix.login.js"></script> 
</body>

</html>
