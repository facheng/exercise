<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#login_form").validate();
});
</script>


    <div class="">
        <div class="loginHeader loginHeader-static">
            <div class="login-statu">
                <a href="/" title="团团官网">团团官网</a>
            </div>
        </div>
		<div class="main">
			<div class="login-form">
				<h1>登录</h1>
				<form method="post" action="/login" autocomplete="off" id="login_form" >
					<c:if test="${not empty url}">
						<input type="hidden" name="url" value="${url}" />
					</c:if>
					
					<div vdfld="un" class="user-box-body">
						<input class="user-box-input" type="text" name="loginName" value="${loginName}" validate="isnotEmpty" placeholder="用户名/手机号" />
						<div class="tip-normal error" vderr="un" style="display: none;"><span class="errorIcon"></span>帐号不能为空</div>
						<c:if test="${not empty loginNameError}">
							<div class="tip-normal2 error"><span class="errorIcon"></span>${loginNameError}</div>
						</c:if>
					</div>
					
					<div vdfld="pa" class="user-box-body">
						<input class="user-box-input auto-submit" type="password" name="password" validate="isPassword" placeholder="用户密码" />
						<div class="tip-normal error" vderr="pa" style="display: none;"><span class="errorIcon"></span>密码不能为空</div>
						<c:if test="${not empty passwordError}">
							<div class="tip-normal2 error"><span class="errorIcon"></span>${passwordError}</div>
						</c:if>
					</div>
					
					<div class="submit">
						<a href="javascript:void(0);" title="登录" id="login" class="loginSubmit btn-submit">登录</a>
					</div>
					<div class="reset-box clearfix">
						<label><input class="checkbox_login" type="checkbox" name="remember" value="1" <c:if test="${remember == 1}">checked="checked"</c:if>/> 下次自动登录</label>
						<p class="fr"><a href="" class="forgot_psd">忘记密码 ?</a></p>
					</div>
				</form>
			</div>
			<div class="copy-right">
			    <p>Copyright @2014 doubletuan.com.All Right Reserved.&nbsp;&nbsp;技术支持：上海团团科技信息有限公司</p> 
			</div>
		</div>
	</div>
