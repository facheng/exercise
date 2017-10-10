<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$(".delete-cru-btn").on("click", function(){
		var cruid = $(this).closest("div").attr("cruid");
		$("#cru_id").val(cruid);
		$('.dialog-delete-cru-alert, .black-opacity').fadeIn();
	});
	
	$('[js="deleteCru"]').on("click", function(){
		var cruid = $("#cru_id").val();
		$('.dialog-delete-cru-alert').fadeOut();
		
		$.ajax({
			url: "/admin/user/role/unit/" + cruid,
			type: "post",
			data: {"_method": "delete"},
			dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
            		$('.black-opacity').fadeOut();
                    alert('接口调用失败！');
                	return false;
                }
		    },
		    error: function () {
        		$('.black-opacity').fadeOut();
                alert('接口调用失败！');
            }
		});
		return false;
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">用户详情</h2>
		<div class="rightNav-sub">
			<a href="/admin/user/list" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		<div class="detail-box">
			<div class="owner-tab">
				<c:if test="${empty map}">
					查无此人
				</c:if>
				<c:if test="${not empty map}">
					<h3 class="h3tit">用户信息</h3>
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>用户名</label></th>
								<td>${map.userName}</td>
							</tr>
							<tr>
								<th><label>真实姓名</label></th>
								<td>${map.realName}</td>
							</tr>
							<tr>
								<th><label>身份证</label></th>
								<td>${map.idCard}</td>
							</tr>
							<tr>
								<th><label>组织名称</label></th>
								<td>${map.branchName}</td>
							</tr>
						</tbody>
					</table>
					<h3 class="h3tit mt20">关系信息</h3>
					<div class="fcInfoBox">
						<c:if test="${not empty map.cruList}">
							<c:forEach items="${map.cruList}" var="cru">
								<div class="fcInfoCon">
									<table width="100%" class="inv-table detail-table" style="width:100%;">
										<tbody>
											<tr>
												<th><label>角色名称</label></th>
												<td>${cru.roleName}</td>
											</tr>
											<tr>
												<th><label>小区名称</label></th>
												<td>${cru.unitName}</td>
											</tr>
										</tbody>
									</table>
									<div class="fcInfoBtn" cruid="${cru.id}">
										<a href="javascript:void(0);" class="delete-cru-btn" title="删除">删除</a>
									</div>
								</div>
							</c:forEach>
						</c:if>
						<div class="clear"></div>
					</div>
				</c:if>
			</div>
		</div>
	</div>
</div>


<div class="dialog dialog-delete-cru-alert">
	<div class="dialog-container">
		<input type="hidden" id="cru_id" value="" />
		<div class="text-con-dialog">
			<p class="dialog-text-center">确定删除此关系吗？</p>
		</div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" js="deleteCru" title="确定"  class="btn bntbgBrown">确 定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>


