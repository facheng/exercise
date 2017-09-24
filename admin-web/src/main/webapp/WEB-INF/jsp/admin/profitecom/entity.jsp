<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>电商信息</title>
	<%@include file="/common/css.jsp" %>
	<%@ include file="/common/taglib.jsp" %>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"> <i class="icon-align-justify"></i>
			</span>
			<h5>电商信息</h5>
		</div>
		<div class="widget-content nopadding">
			<form action="save" method="post" class="form-horizontal" id="profitEcomForm">
				<div class="control-group">
					<label class="control-label">电商代码 :</label>
					<div class="controls">
						<input type="hidden" name="id" value="${entity.id}"/>
						<input type="hidden" id="old_code" value="${entity.code}"/>
						<input type="text" id="code" name="code"  class="{required:true,isRepeat:true,messages:{required:'电商代码不能为空!'}}" value="${entity.code}" placeholder="请输入电商代码 " />
						
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">电商名称 :</label>
					<div class="controls">
						<input type="text" id="ecomName" name="ecomName" value="${entity.ecomName}" class="{required:true,messages:{required:'电商名称不能为空!'}}" placeholder="请输入电商名称" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">是否自动清算 :</label>
					<div class="controls">
						
						
					<c:choose>
						<c:when test="${entity.autoCalculate == 0 || entity.autoCalculate == 1}">
							<label style="display:inline" ><input type="radio" name="autoCalculate" value="0"  <c:if test="${entity.autoCalculate == 0}">checked="checked"</c:if>/> <span>否</span></label>
							&nbsp;&nbsp;&nbsp;
							<label style="display:inline"><input type="radio"  name="autoCalculate" value="1" <c:if test="${entity.autoCalculate == 1}">checked="checked"</c:if> /> <span>是</span></label>
						</c:when>
						<c:otherwise>
							<label style="display:inline" ><input type="radio" name="autoCalculate" value="0" checked="checked" /> <span>否</span></label>
							&nbsp;&nbsp;&nbsp;
							<label style="display:inline"><input type="radio"  name="autoCalculate" value="1"  /> <span>是</span></label>
						</c:otherwise>
					</c:choose>
					
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">备注 :</label>
					<div class="controls">
						<textarea id="remark" name="remark" rows="3" placeholder="备注" >${entity.remark}</textarea>
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
<script type="text/javascript" src="${basePath}profitecom/index.js"></script>
<script type="text/javascript" src="${basePath}profitecom/entity.js"></script>
</html>