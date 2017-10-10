<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#phoneNum").attr("vdOpt", "url:'/sys/params/role/phone/validate?workerId=${workId}',key:'phoneNum'");
	
	
	$("#edit_sys_role").validate({validateAjax: true , submitReset: true});
	
	wtTypeChange();
	
	$("#birthday").click(function(){
		WdatePicker({dateFmt:'yyyy-MM-dd'});
	});
	
	$("#entryDate").click(function(){
		WdatePicker({dateFmt:'yyyy-MM-dd'});
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


//获取工种信息
function wtTypeChange(){
	var wtType = $("#wtType option:selected").val();
	var residentSel = $("#wtId");
	residentSel.find("option").remove();
	$.ajax({
		type : "post",
		url : "/sys/params/role/wt",
		data : {
			"wtType" : wtType
		},
		success : function(data) {
			if (data && data['wts'] && data['wts'].length > 0) {
				$.each(data['wts'],function(index, value) {
					var wtId = value["id"];
					if ('${wk.wtId}' == wtId) {
						residentSel.append("<option value='"+wtId+"' selected='selected' >" +  value['name'] + "</option>");
					} else {
						residentSel.append("<option value='"+wtId+"' >" + value['name'] + "</option>");
					}
				});
			}
		}
	});
}
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">添加保安保修角色</h2>
		<div class="rightNav-sub">
			<a href="/sys/params/role/list" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top ">
			<form method="post" action="/sys/params/role/new" autocomplete="off" id="edit_sys_role" >
			
				<input type="hidden" name="id" id="id" value="${workId}">
				
				<input type="hidden" name="wtpId" id="wtpId" value="${wk.wtpId}">
				
				<input type="hidden" name="isChecked" id="isChecked" value="${wk.isChecked}">
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
					
						<tr height="50px">
							<th><span class="color-red">*</span>角色类型：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select name="wtType" id="wtType" class="guest-num" onChange="wtTypeChange();" >
										<option value="1" <c:if test="${wk.wtType == 1}">selected="selected"</c:if>>保安</option>
										<option value="2" <c:if test="${wk.wtType == 2}">selected="selected"</c:if>>保修</option>
									</select>
									
									<select name="wtId" id="wtId" class="guest-num">
									</select>
									
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span>姓名：</th>
							<td>
								<div vdfld="userName" class="user-box-body form-relative-input">
									<input type="text" name="userName" id="userName" value="${wk.userName}" validate="isnotEmpty" class="form-control" placeholder="请输入姓名" />
									<div class="tip-normal error" vderr="userName" style="display: none;"><span class="errorIcon"></span>姓名不能为空</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span>手机号码：</th>
							<td>
								<div vdfld="vphoneNum" class="user-box-body form-relative-input">
									<input type="text" name="phoneNum" id="phoneNum" value="${wk.phoneNum}" validate="ajaxMobile" class="form-control" placeholder="请输入手机号码" />
									<div vdErr="vphoneNum" class="tip-normal error error-tooltip" style="display: none;">
									<span class="isNull" style="display: none;"><span class="errorIcon"></span>请输入正确的手机号码</span>
									<span class="checkObj" style="display: none;"><span class="errorIcon"></span>手机号码已经存在，请重新输入！</span>
									</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span>所属期块：</th>
							<td>
								<div class="cate-link">
										<div vdfld="partitionIds" class="user-box-body form-relative-input">
												<c:forEach items="${upList}" var="up" varStatus="status">
												
													<input type="checkbox" validate="checkboxCheck" name="partitionIds" id="partitionIds" value="${up.id}" <c:if test="${up.isChecked == 1}">checked="checked"</c:if>>  ${up.aliasName}
													&nbsp;&nbsp;&nbsp;
												
												</c:forEach>
											
											<div class="tip-normal error" vderr="partitionIds" style="display: none;"><span class="errorIcon"></span>请至少选择一个期块</div>
										</div>
								</div>
								
							</td>
						</tr>
						
						<c:if test="${empty workId}">
								<tr height="80px">
									<th>密码：</th>
									<td>
										<input type="password" id="password-pop" class="form-control" name="password" placeholder="若不填写则默认密码为手机号码后六位"/>
									</td>
								</tr>
								<tr height="80px">
									<th>确认密码：</th>
									<td vdfld="confirm-pw">
										<input type="password" class="form-control" vdOpt="pw:'#password-pop'" validate="confirmPassword" placeholder="若不填写则默认密码为手机号码后六位"/>
										<div class="tip-normal error" vderr="confirm-pw" style="display: none;">两次输入密码不一致</div>
									</td>
								</tr>
						</c:if>
						<c:if test="${not empty workId}">
								<tr height="80px">
									<th>修改密码：</th>
									<td class="noticeType-choice">
										<label><input type="radio" name="changePassword" value="0" checked="checked" class="wuye-radio change-pwd" /><span>不修改</span></label>
										<label><input type="radio" name="changePassword" value="1" class="wuye-radio change-pwd" /><span>修改</span></label>
									</td>
								</tr>
								<tr height="80px" class="pwd1-hid" style="display: none;">
									<th><span class="color-red">*</span>密码：</th>
									<td vdfld="pw">
										<input type="password" id="password-pop" class="form-control" name="password"/>
										<div class="tip-normal error" vderr="pw" style="display: none;">请输入密码</div>
									</td>
								</tr>
								<tr height="80px" class="pwd2-hid" style="display: none;">
									<th><span class="color-red">*</span>确认密码：</th>
									<td vdfld="confirm-pw">
										<input type="password" class="form-control" vdOpt="pw:'#password-pop'"/>
										<div class="tip-normal error" vderr="confirm-pw" style="display: none;">两次输入密码不一致</div>
									</td>
								</tr>
						</c:if>
						
						<tr height="80px">
							<th>身份证：</th>
							<td>
								<div vdfld="idCard" class="user-box-body form-relative-input">
									<input type="text" name="idCard" id="idCard" value="${wk.idCard}" class="form-control" placeholder="请输入身份证号码" />
									<div class="tip-normal error" vderr="idCard" style="display: none;"><span class="errorIcon"></span>身份证号码不能为空</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th>出生年月：</th>
							<td>
								<div vdfld="birthday" class="user-box-body form-relative-input">
									<input type="text" name="birthday" id="birthday" value="${wk.birthday}" class="form-control clear-data" placeholder="请输入出生年月" />
									<div class="tip-normal error" vderr="birthday" style="display: none;"><span class="errorIcon"></span>出生年月不能为空</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th>入职时间：</th>
							<td>
								<div vdfld="entryDate" class="user-box-body form-relative-input">
									<input type="text" name="entryDate" id="entryDate" value="${wk.entryDate}" class="form-control clear-data" placeholder="请输入入职时间" />
									<div class="tip-normal error" vderr="entryDate" style="display: none;"><span class="errorIcon"></span>角色姓名不能为空</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="提交" class="btn btn-success btn-submit">提 交</a>
									<a href="/sys/params/role/list" title="取消" class="btn btn-primary">取 消</a>	
								</div>
							</td>
						</tr>
						
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>


<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>