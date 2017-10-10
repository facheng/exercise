<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>分配模块</title>
	<%@include file="/common/css.jsp" %>
</head>
<body>
<div class="widget-box">
	<div class="widget-title">
		<span class="icon"><i class="icon-th"></i></span>
		<h5>分配模块<a href="javascript:void(0);" class="add"></a></h5>
	</div>
	<form action="#" method="post" class="form-horizontal" id="moduleForm">
		<input id="roleId" name="roleId" type="hidden" value="${roleId}"/>
		<input id="owns" type="hidden" value="${owns}"/>
		<div class="widget-content nopadding">
			<table class="table tree table-bordered table-striped table-condensed">
				<thead>
					<tr role="row">
						<th class="ui-state-default center">模块名称</th>
						<th class="ui-state-default center">模块分配</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${menus}" var="menu" varStatus="status">
						<tr class="treegrid-${menu.id} ${menu.parentId ne 0 ? 'treegrid-parent-':''}${menu.parentId ne 0 ? menu.parentId:'' }">
	                   		 <td>${menu.title}
	                   		 </td>
	                   		 <td>
	                   		 	<input class="allotModul" id="${menu.code}" name="mIds" ${menu.isChecked?"checked":""} type="checkbox" value="${menu.id}"/>
	                   		 </td>
		                </tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="form-actions">
			<button type="button" id="saveBtn" class="btn btn-success">保存</button>
			<button type="button" id="backBtn" class="btn btn-danger">返回</button>
		</div>
	</form>
</div>
</body>
<%@include file="/common/js.jsp" %>
<script type="text/javascript" src="${basePath}customer/allocationmodule.js"></script>
</html>