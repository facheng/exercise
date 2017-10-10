<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>公司信息</title>
	<%@include file="/common/css.jsp" %>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"> <i class="icon-align-justify"></i>
			</span>
			<h5>公司信息</h5>
		</div>
		<div class="widget-content nopadding">
			<form action="save" method="post" class="form-horizontal" id="companyForm">
				<div class="control-group">
					<label class="control-label">公司名称 :</label>
					<div class="controls">
						<input type="hidden" name="id" value="${entity.id}"/>
						<input type="text" id="companyName" name="companyName" value="${entity.companyName}" class="{required:true,messages:{required:'公司名称不能为空!'}}" placeholder="公司名称" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">公司邮箱 :</label>
					<div class="controls">
						<input type="text" id="email" name="email" value="${entity.email}" class="{required:true,email:true,messages:{required:'公司邮箱不能为空!'}}" placeholder="公司邮箱" />
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">地&nbsp;&nbsp;&nbsp;&nbsp;址:</label>
					<div class="controls">
						<input type="text" id="address" name="address" value="${entity.address}" class="{required:true,messages:{required:'公司地址不能为空!'}}" placeholder="公司地址" />
						<input type="hidden" id="districtId" name="districtId" value="${entity.districtId}"/>
						<input type="hidden" id="code" name="code" value="${entity.code}"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">公司备注 :</label>
					<div class="controls">
						<textarea id="remark" name="remark" rows="3" placeholder="公司备注" >${entity.remark}</textarea>
					</div>
				</div>
				<div class="form-actions">
					<button type="submit" id="saveBtn" class="btn btn-success">保存</button>
					<button type="button" id="backBtn" backUrl="index" class="btn btn-danger">返回</button>
				</div>
			</form>
		</div>
	</div>
</body>
<%@include file="/common/js.jsp" %>
<script type="text/javascript" src="${basePath}defaultEdit.js"></script>
<script type="text/javascript" src="${basePath}wisdom.js"></script>
</html>