<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_role_form").validate();
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">编辑角色</h2>
	</div>
	
	<div class="cont_box_wrap">
		<div class="msgBox category mt20">
			<form method="post" action="/admin/role" autocomplete="off" id="edit_role_form" >
				<c:if test="${not empty roleId}">
					<input type="hidden" name="id" value="${roleId}"/>
				</c:if>
				<div class="category no-border-top">
					<table width="100%" class="table_form">
						<tbody>
							<tr height="50px">
								<th width="150"><label><span class="color-red">*</span>角色名称：</label></th>
								<td vdfld="rname">
									<input type="text" class="form-control" placeholder="请输入角色名称" name="roleName" value="${map.roleName}" validate="isnotEmpty" />
									<div class="tip-normal error" vderr="rname" style="display: none;"><span class="errorIcon"></span>角色名称不能为空</div>
								</td>
							</tr>
							<tr height="50px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="保存" class="btn bntbgGreen btn-submit">保 存</a>
	           						<a href="/admin/role/list" title="取消" class="btn bntbgGreen">取 消</a>	
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
