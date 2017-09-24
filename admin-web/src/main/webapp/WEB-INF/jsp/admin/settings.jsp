<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="widget-box" id="settingsContent">
	<div class="widget-content nopadding">
		<form action="${requestPath}tar/user/settings" method="post" class="form-horizontal" id="settingsForm">
			<div class="control-group">
				<label class="control-label">旧&nbsp;密&nbsp;码:</label>
				<div class="controls">
					<input type="password" id="oldPwd" name="oldPwd" value="" class="{required:true,messages:{required:'旧密码不能为空!'}}" placeholder="旧密码" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">新&nbsp;密&nbsp;码:</label>
				<div class="controls">
					<input type="password" id="newPwd" name="newPwd" value="" class="{required:true,minlength:5,messages:{required:'新密码不能为空!'}}" placeholder="新密码" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">确认密码:</label>
				<div class="controls">
					<input type="password" id="confirmPwd" name="confirmPwd" value="" class="{required:true,minlength:5,equalTo:'#newPwd',messages:{required:'确认密码不能为空!',equalTo:'两次输入密码不一致'}}" placeholder="确认密码" />
				</div>
			</div>
		</form>
	</div>
</div>