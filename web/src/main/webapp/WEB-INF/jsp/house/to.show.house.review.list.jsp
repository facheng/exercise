<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">

function submitForm(){
	var state = "";
	$(".s_state").each(function(){
		if($(this).hasClass("cur")) {
			state = $(this).attr("value");
			return;
		}
	});
	$("#state_hidden").val(state);
	
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
	
	$(".s_state").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.s_state').each(function(){
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

	$('.house-review-btn').on('click', function(){
		var hrId = $(this).closest("tr").attr("id");
		$(".dialog-house-review").attr("params", hrId);
		$('.dialog-house-review, .black-opacity').fadeIn();
	});

	$('.house-review-batch-btn').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var hrIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-house-review").attr("params", hrIds);
		$('.dialog-house-review, .black-opacity').fadeIn();
	});

	$('[js="approveHouseReview"]').click(function(){
		var hrIds = $(this).closest(".dialog-house-review").attr("params");

		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/review/approve",
            type: "post",
            data: {"houseResidentIds": hrIds},
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

	$('[js="rejectHouseReview"]').click(function(){
		var hrIds = $(this).closest(".dialog-house-review").attr("params");

		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/review/reject",
            type: "post",
            data: {"houseResidentIds": hrIds},
            dataType: "text",
            success: function(data){
                if(data == 1) {
	                alert("操作成功！");
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
		<h2 class="titIcon wyIcon">房屋审核</h2>
		<div class="addbtn"></div>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/house/review" method="get" id="search_form">
			<div class="category ctop mt10">
					<div class="cate-link">
						<span>片区：</span> 
						<a href="javascript:void(0);" title="全部" class="s_partitionId  <c:if test="${empty partitionId}">cur</c:if>">全部</a>
						<c:if test="${not empty unitPs}">
							<c:forEach var="up" items="${unitPs}" varStatus="status">
								<a href="javascript:void(0);" value ="${up.id}" title="${up.aliasName}" class="s_partitionId <c:if test="${up.id == partitionId}">cur</c:if>">${up.aliasName}</a>
							</c:forEach>
						</c:if>
						<input type="hidden" id="partitionId_hidden" name="partitionId" value="${partitionId}"/>
					</div>
			</div>
			<div class="category no-border-top">
				<div class="cate-link">
					<span>房屋状态：</span>
					<a href="javascript:void(0);" class="s_state <c:if test="${empty state}">cur</c:if>">全部</a>
					<a href="javascript:void(0);" value="0" class="s_state <c:if test="${state == 0}">cur</c:if>">未核准</a>
					<a href="javascript:void(0);" value="1" class="s_state <c:if test="${state == 1}">cur</c:if>">已核准</a>
					<a href="javascript:void(0);" value="2" class="s_state <c:if test="${state == 2}">cur</c:if>">已驳回</a>
					
					<input type="hidden" id="state_hidden" name="state" value="${state}"/>
				</div>
			</div>
	
			<div class="category no-border-top">
				<ul class="searchfm clear">
					<li><span class="zw">门牌号码：</span><input type="text" id="roomNo" name="roomNo" class="textinput w-120" placeholder="请输入门室号" value="${roomNo}"/>&nbsp;</li>
					<li><span class="zw">住户姓名：</span><input type="text" id="userName" name="userName" class="textinput w-120" placeholder="请输入住户姓名" value="${userName}"/>&nbsp;</li>
					<li><span class="zw">手机号码：</span><input type="text" id="phoneNum" name="phoneNum" class="textinput w-120" placeholder="请输入手机号码" value="${phoneNum}"/>&nbsp;</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a>
					</li>
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="批量审核" class="btn btnbgViolet house-review-batch-btn">批量审核</a></li>
				</ul>
			</div>
	</form>
		<table id="data-list-table" width="100%" class="list-table mt10">
			<colgroup>
				<col width="5%">
				<col width="9%">
				<col width="8%">
				<col width="15%">
				<col width="6%">
				<col width="6%">
				<col width="9%">
				<col width="12%">
				<col width="12%">
				<col width="9%">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>片区</th>
					<th>楼栋号</th>
					<th>单元</th>
					<th>门室号</th>
					<th>默认房屋</th>
					<th>住户类型</th>
					<th>住户姓名</th>
					<th>手机号</th>
					<th>房屋状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty houseResidenList}">
				<tbody>
				<c:forEach items="${houseResidenList}" var="houseResident">
					<tr id="${houseResident.id}">
						<td>
							<c:if test="${houseResident.isApproved == 0}">
								<input type="checkbox" />
							</c:if>
						</td>
						
						<td>${houseResident.aliasName}</td>
						<td>${houseResident.storyNum}</td>
						<td>${houseResident.dyCode}</td>
						<td>${houseResident.roomNum}</td>
						
						<td>
							<c:if test="${houseResident.isDefault == 0}">否</c:if>
							<c:if test="${houseResident.isDefault == 1}">是</c:if>
						</td>	
						
						<td>
							<c:if test="${houseResident.type == 0}">业主</c:if>
							<c:if test="${houseResident.type == 1}">家属</c:if>
							<c:if test="${houseResident.type == 2}">租客</c:if>
							<c:if test="${houseResident.type == 3}">访客</c:if>
						</td>
						<td>${houseResident.userName}</td>
						<td>${houseResident.phoneNum}</td>
						<td>
							<c:if test="${houseResident.isApproved == 0}">未核准</c:if>
							<c:if test="${houseResident.isApproved == 1}">已核准</c:if>
							<c:if test="${houseResident.isApproved == 2}">已驳回</c:if>
						</td>
						
						<td class="action">
							<c:if test="${houseResident.isApproved == 0}">
								<a class="btn_smalls btn-warning house-review-btn" href="javascript:void(0);">审核</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</c:if>
		</table>

		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<div class="dialog dialog-house-review" params="">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">审核房屋绑定</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="核准" js="approveHouseReview" class="btn bntbgBrown">核 准</a>
            <a href="javascript:void(0);" title="拒绝" js="rejectHouseReview" class="btn btn-warning">拒 绝</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>