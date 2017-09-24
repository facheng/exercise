<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>
<div class="widget-box">
	<div class="widget-content nopadding">
		<form action="save" method="post" class="form-horizontal" id="menuForm">
			<div class="control-group">
				<label class="control-label">父级菜单:</label>
				<div class="controls">
					<select id="parentId" name="parentId" 
							data-options="{'url':'all', 'valueField':'id', 'textField':'title', 'value':'${entity.parentId}'}" >
						</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">菜单名称 :</label>
				<div class="controls">
					<input type="hidden" name="id" value="${entity.id}"/>
					<input type="text" name="title" id="title" value="${entity.title}" class="{required:true,messages:{required:'菜单名称不能为空!'}}" placeholder="菜单名称" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">菜单路径:</label>
				<div class="controls">
					<input type="text" name="url" id="url" value="${entity.url}" placeholder="菜单路径" />
				</div>
			</div>
		</form>
	</div>
</div>