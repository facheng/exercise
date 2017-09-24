<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="widget-box">
	<div class="widget-title">
		<span class="icon"> <i class="icon-align-justify"></i>
		</span>
		<h5>用户信息</h5>
	</div>
	<div class="widget-content nopadding">
		<form action="save" method="post" class="form-horizontal"
			id="customerForm">
			<div class="control-group">
				<label class="control-label">公司名称 :</label>
				<div class="controls">
					<input type="hidden" name="id" value="${entity.id}" /> <select
						id="companyId" name="companyId"
						class="{required:true,messages:{required:'请选择公司!'}}"
						data-options="{'url':'${requestPath}syscompany/all', 'valueField':'id', 'textField':'companyName'}"></select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">用户名称 :</label>
				<div class="controls">
					<input type="text" id="userName" name="userName" value="${entity.userName}" placeholder="用户名称" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">用户密码 :</label>
				<div class="controls">
					<input type="password" name="password" id="password"
						value="${entity.password}"
						class="{required:true, messages:{required:'密码不能为空!'}}"
						placeholder="密码" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">确认密码 :</label>
				<div class="controls">
					<input type="password" name="confirm" id="confirm" value="${entity.password}"
						class="{required:true,equalTo:'#password',messages:{required:'确认密码不能为空!', equalTo:'两次密码不一致！'}}"
						placeholder="确认密码" />
				</div>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="${basePath}customer/entity.js"></script>
