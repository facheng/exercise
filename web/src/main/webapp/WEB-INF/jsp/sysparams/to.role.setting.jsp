<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">

function submitForm(){
	var wtType = "";
	$(".s_wtType").each(function(){
		if($(this).hasClass("cur")) {
			wtType = $(this).attr("value");
			return;
		}
	});
	$("#wtType_hidden").val(wtType);
	
	var partitionId = "";
	$(".s_partitionId").each(function(){
		if($(this).hasClass("cur")) {
			partitionId = $(this).attr("value");
			return;
		}
	});
	$("#partitionId_hidden").val(partitionId);
	
	$("#search_form").submit();
}
$(document).ready(function() {
	
	$(".btn-submit").on("click", submitForm);
	
	$(".s_wtType").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.s_wtType').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});
	
	$(".s_partitionId").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.s_partitionId').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});
	
	$('.delete-worker').on('click', function(){
		var hrId = $(this).closest("tr").attr("id");
		$(".dialog-delete-worker").attr("params", hrId);
		$('.dialog-delete-worker, .black-opacity').fadeIn();
	});
	
	$('.delete-worker-batch').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var frIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-delete-worker").attr("params", frIds);
		$('.dialog-delete-worker, .black-opacity').fadeIn();
	});
	
	$('[js="removeRoleWorker"]').click(function(){
		var workerIds = $(this).closest(".dialog-delete-worker").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/sys/params/role/re",
            type: "post",
            data: {"workerIds": workerIds},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                    alert('接口调用失败！');
                	return false;
                }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});
});

</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">角色分配</h2>
		<div class="addbtn">
			<a class="btn bntbgBrown modify-focus-btn" title="添加角色" href="/sys/params/role/init">添加角色</a>
		</div>
	</div>
	<div class="cont_box_wrap full-width">
		<form action="/sys/params/role/list" method="get" id="search_form">
			<div class="category ctop mt10">
				<div class="cate-link">
					<span>角色类型：</span>
					 <a href="javascript:void(0);" title="全部" class="s_wtType <c:if test="${empty worker.wtType}">cur</c:if>">全部</a>
					 <a href="javascript:void(0);" value="1" title="保安" class="s_wtType <c:if test="${worker.wtType == 1}">cur</c:if>">保安</a>
					 <a href="javascript:void(0);" value="2" title="保修" class="s_wtType <c:if test="${worker.wtType == 2}">cur</c:if>">保修</a>
					 <input type="hidden" id="wtType_hidden" name="wtType" value="${worker.wtType}"/>
				</div>
			</div>

			<div class="category no-border-top">
				<div class="cate-link">
					<span>区块分类：</span> 
					<a href="javascript:void(0);" title="全部" class="s_partitionId  <c:if test="${empty worker.partitionId}">cur</c:if>">全部</a>
					<c:if test="${not empty upList}">
						<c:forEach var="up" items="${upList}" varStatus="status">
							<a href="javascript:void(0);" value ="${up.id}" title="${up.aliasName}" class="s_partitionId <c:if test="${worker.partitionId == up.id}">cur</c:if>">${up.aliasName}</a>
						</c:forEach>
					</c:if>
					<input type="hidden" id="partitionId_hidden" name="partitionId" value="${worker.partitionId}"/>
				</div>
			</div>

			<div class="category no-border-top">
				<ul class="searchfm clear">
					<li>
						<span class="zw">工作人员：</span>
						<input type="text" id="userName" name="userName" class="textinput" placeholder="请输入工作人员" value="${worker.userName}">
					</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a>
					</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-worker-batch">批量删除</a>
					</li>
				</ul>
			</div>
		</form>
	</div>
		
	<table id="data-list-table" width="100%" class="list-table mt10 focus-host-tbl">
		<colgroup>
			<col width="5%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<col width="">
		</colgroup>
		<thead>
			<tr>
				<th><input type="checkbox" class="selectAll" /></th>
				<th>姓名</th>
				<th>工种</th>
				<th>手机号</th>
				<th>身份证</th>
				<th>角色</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty workerList}">
				<c:forEach var="wl" items="${workerList}" varStatus="status">
					<tr id="${wl.ID}">
						<td><input type="checkbox" /></td>
						<td>${wl.USER_NAME}</td>
						<td>${wl.wtName}</td>
						<td>${wl.PHONE_NUM}</td>
						<td>${wl.ID_CARD}</td>
						<td>
							<c:if test="${wl.wtType == 1}"> 保安  </c:if>
							<c:if test="${wl.wtType == 2}"> 保修  </c:if>
						</td>
						<td class="action">
							<a class="btn_smalls btn-primary modify-focus-btn" href="/sys/params/role/init?workId=${wl.ID}">修改</a>
							<a class="btn_smalls bntbgBrown delete-worker" href="javascript:void(0);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty workerList}">
				<tr>
					<td colspan="7">
						<h3 class="clearfix mt10" style="text-align: center;">没有结果！</h3>
					</td>
				</tr>
		</c:if>
					</tbody>
				</table>
				<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<!--删除-->
<div class="dialog dialog-delete-worker" params="">
	<div class="dialog-container ">
		<div class="text-con-dialog">
			<p class="dialog-text-center">确认删除</p>
		</div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="removeRoleWorker" class="btn bntbgBrown delete-confirm-btn">确 定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<!--删除-->

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>