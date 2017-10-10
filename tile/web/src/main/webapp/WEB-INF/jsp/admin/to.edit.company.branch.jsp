<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_branch_form").validate();
});
</script>
<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">组织信息</h2>
	</div>
        
	<div class="cont_box_wrap">
		<div class="msgBox category mt20">
			<form method="post" action="/admin/company/branch" autocomplete="off" id="edit_branch_form" >
				<c:if test="${not empty branch.id}">
					<input type="hidden" name="id" value="${branch.id}" />
				</c:if>
				<div class="category no-border-top">
					<table width="100%" class="inv-table">
						<tbody>
							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label>上级组织</label></th>
								<td >
									<c:if test="${not empty parentBranch.id}">
										<input type="hidden" name="parentId" value="${parentBranch.id}" />
									</c:if>
									<input type="text" class="form-control" placeholder=""  value="${parentBranch.branchName}"  disabled="disabled" />
								</td>
							</tr>
							<tr height="50px" class="wuye-content-hide">
								<th><label><span class="color-red">*</span>组织名称</label></th>
								<td vdfld="rname">
									<input type="text" class="form-control" placeholder="" name="branchName" value="${branch.branchName}" validate="isnotEmpty" />
									<div class="tip-normal error" vderr="rname" style="display: none;"><span class="errorIcon"></span>组织名称不能为空</div>
								</td>
							</tr>
							<tr height="50px" class="wuye-content-hide">
								<th><label>备注</label></th>
								<td vdfld="fnum">
									<textarea name="remark" class="form-control" style="height: 100px;">${branch.remark}</textarea>
								</td>
							</tr>
							<tr class="wuye-content-hide" height="80px">
								<th></th>
								<td>
									<a href="javascript:void(0);"  title="保存" class="btn bntbgGreen btn-submit">保 存</a>
	           						<a href="/admin/company/branch/list" title="取消" class="btn bntbgGreen">取 消</a>	
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

