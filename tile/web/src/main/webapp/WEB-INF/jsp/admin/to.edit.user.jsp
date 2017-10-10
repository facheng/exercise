<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>



<script type="text/javascript">
$(document).ready(function() {
	$("#edit_user_form").validate({validateAjax: true, submitReset: true});

	
	var setting = {
		check: {
			enable: false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		view: {
			fontCss: setFontCss
		},
		callback:{
			onClick: onClick
		}
	};
	
	$('[js="showCompanyBranchTree"]').on("click", function(){
		var zNodes = [];
		$.ajax({
			url: "/ajax/company/${companyId}/branches",
            type: "get",
            dataType: "json",
            success: function(data){
				$.fn.zTree.init($("#treeDemos"), setting, data);
        		$("#treeChoicebox").show();
        		$('.black-opacity').fadeIn();
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});

	$('[js="selectBranch"]').live("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});

	$('[js="closeBranchTree"]').live("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});

	$(".change-pwd").live("click", function(){
		var v = $(this).val();
		if(v == 0) {
			$(".pwd1-hid").hide();
			$(".pwd2-hid").hide();
			$(".pwd1-hid td input").removeAttr("validate");
			$(".pwd2-hid td input").removeAttr("validate");
		} else {
			$(".pwd1-hid").show();
			$(".pwd2-hid").show();
			$(".pwd1-hid td input").attr("validate", "isPassword");
			$(".pwd2-hid td input").attr("validate", "confirmPassword");
		}
	});
});

function setFontCss(treeId, treeNode) {
	
};

function onClick(e, treeId, treeNode){
	if(treeNode.valid == 1) {
		$("#branch_id").val(treeNode.id);
		$("#branch_name").val(treeNode.name);
	}
}
</script>



<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">添加用户信息</h2>
		<div class="rightNav-sub">
			<a href="/admin/user/list"  title="返回" class="cur">返回</a>
		</div>
	</div>
	
	<div class="cont_box_wrap">
		<div class="msgBox category mt20">
			<form action="/admin/user" method="post" autocomplete="off" id="edit_user_form">
				<c:if test="${not empty customerId}">
					<input type="hidden" name="id" value="${customerId}" />
				</c:if>
				
				<div class="category no-border-top">
					<table style="width:100%" class="table_form">
						<tbody>
							<tr height="50px">
								<th width="150"><span class="color-red">*</span>用户名：</th>
								<td vdfld="un">
									<c:if test="${empty customerId}">
										<input class="form-control" type="text" name="userName" value="${map.customerName}" validate="ajaxValid" vdOpt="url:'/ajax/user/nc',key:'name'"/>
									</c:if>
									<c:if test="${not empty customerId}">
										<input class="form-control" type="text" name="userName" value="${map.customerName}" validate="ajaxValid" vdOpt="url:'/ajax/user/nc?id=${customerId}',key:'name'"/>
									</c:if>
									<div vdErr="un" class="tip-normal error error-tooltip" style="display: none;">
										<span class="isNull" style="display: none;">用户名不能为空</span>
										<span class="checkObj" style="display: none;">该用户名已存在</span>
									</div>
								</td>
							</tr>
							<tr height="50px">
								<th>真实姓名：</th>
								<td>
									<input type="text" name="realName" value="${map.realName}" class="form-control"/>
								</td>
							</tr>
							
							<c:if test="${empty customerId}">
								<tr height="50px">
									<th><span class="color-red">*</span>密码：</th>
									<td vdfld="pw">
										<input type="password" id="password-pop" class="form-control" name="password" validate="isPassword" />
										<div class="tip-normal error" vderr="pw" style="display: none;">请输入密码</div>
									</td>
								</tr>
								<tr height="50px">
									<th><span class="color-red">*</span>确认密码：</th>
									<td vdfld="confirm-pw">
										<input type="password" class="form-control" vdOpt="pw:'#password-pop'" validate="confirmPassword"/>
										<div class="tip-normal error" vderr="confirm-pw" style="display: none;">两次输入密码不一致</div>
									</td>
								</tr>
							</c:if>
							<c:if test="${not empty customerId}">
								<tr height="50px">
									<th>修改密码：</th>
									<td class="noticeType-choice">
										<label><input type="radio" name="changePassword" value="0" checked="checked" class="wuye-radio change-pwd" /><span>不修改</span></label>
										<label><input type="radio" name="changePassword" value="1" class="wuye-radio change-pwd" /><span>修改</span></label>
									</td>
								</tr>
								<tr height="50px" class="pwd1-hid" style="display: none;">
									<th><span class="color-red">*</span>密码：</th>
									<td vdfld="pw">
										<input type="password" id="password-pop" class="form-control" name="password"/>
										<div class="tip-normal error" vderr="pw" style="display: none;">请输入密码</div>
									</td>
								</tr>
								<tr height="50px" class="pwd2-hid" style="display: none;">
									<th><span class="color-red">*</span>确认密码：</th>
									<td vdfld="confirm-pw">
										<input type="password" class="form-control" vdOpt="pw:'#password-pop'"/>
										<div class="tip-normal error" vderr="confirm-pw" style="display: none;">两次输入密码不一致</div>
									</td>
								</tr>
							</c:if>
							
							<tr height="50px" >
								<th><span class="color-red">*</span>公司架构：</th>
								<td vdfld="bid">
									<div class="user-box-body form-relative-input">
										<input type="text" id="branch_name" class="form-control" value="${map.branchName}" placeholder="选择组织架构" disabled="disabled">
										<span class="msgAddBtn" js="showCompanyBranchTree"></span>
									</div>
									<input type="hidden" id="branch_id" name="branchId" value="${map.branchId}" validate="isIntLargerThanZero"/>
									<div class="tip-normal error" vderr="bid" style="display: none;"><span class="errorIcon"></span>组织架构不能为空</div>
								</td>
							</tr>
							<tr height="50px" >
								<th>身份证：</th>
								<td>
									<input type="text" name="idCard" value="${map.idCard}" class="form-control"/>
								</td>
							</tr>
							<tr height="80px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="保存" class="btn btn-success btn-submit">保 存</a>
		       						<a href="/admin/user/list" title="取消" class="btn btn-primary">取 消</a>	
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</form>
		</div>
	</div>
</div>



<!-- 弹出层开始 -->
<div class="dialog dialog-choose-obj" id="treeChoicebox" style="display: none; width: 450px;">
	<div class="dialog-container">
		<div class="importInfoTitle"><span>选择组织架构</span></div>
		<div class="choose-obj-dialog-con">
			<div class="zTreeDemoBackground left">
				<ul id="treeDemos" class="ztree"></ul>
			</div>
		</div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="selectBranch" class="btn bntbgGreen">确 定</a>
			<a href="javascript:void(0);" title="关闭" js="closeBranchTree" class="btn bntbgGreen dialog-close">关 闭</a>
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<!-- 弹出层结束 -->

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
