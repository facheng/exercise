<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$('.qianshou').live('click',function(){
		var deliveryId = $(this).closest("tr").attr("id");
		$("#signDeliveryId").val(deliveryId);
		
		var houseMembers = $(this).closest(".action").find(".house-member")[0].innerHTML;
		$(".dialog-qianshou .dialog-container .data-block").html(houseMembers);
		
		$('.dialog-qianshou, .black-opacity').fadeIn();
	});
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});
	
	$('.delete-delivery-btn').on('click', function(){
		var hrId = $(this).closest("tr").attr("id");
		$(".dialog-delivery-del-alert").attr("params", hrId);
		$('.dialog-delivery-del-alert, .black-opacity').fadeIn();
	});
	
	$('.delete-delivery-batch').on('click', function(){
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
		
		$(".dialog-delivery-del-alert").attr("params", frIds);
		$('.dialog-delivery-del-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteDelivery"]').click(function(){
		var deliveryIds = $(this).closest(".dialog-delivery-del-alert").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/info/deliverys",
            type: "post",
            data: {"deliveryIds": deliveryIds , "_method": "delete"},
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

	$('.modify-confirm-btn').live("click", function(){
		var rid = "";
		$(".dialog-qianshou .dialog-container .data-block .editInfo-con").each(function(){
			if($(this).find('span').hasClass("choiceBtn")) {
				rid = $(this).attr("rid");
				return rid;
			}
		});

		var atag = $(this);
		if(rid != "") {
			var deliveryId = $("#signDeliveryId").val();
			$.ajax({
				url: "/info/delivery/" + deliveryId + "/sign",
				type: "post",
				data: {"residentId": rid},
				dataType: "text",
				success: function(data){
					if(data == 1) {
						location.href = location.href;
					} else {
						alert('接口调用失败！');
					}
				},
				error: function(){
					alert('接口调用失败！');
				}
			});
		}
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">快递管理</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category ctop mt10">
			<a href="/info/delivery" title="通知收快递" class="btn bntbgGreen">通知收快递</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-delivery-batch">批量删除</a>
		</div>
	
		<table width="100%" class="list-table mt10" id="data-list-table">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="20%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>时间</th>
					<th>标题</th>
					<th>发送人</th>
					<th>发送房屋</th>
					<th>签收人</th>
					<th>已阅人数</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty deliveryList}">
				<tbody>
					<c:forEach items="${deliveryList}" var="delivery">
						<tr id="${delivery.id}">
							<td><input type="checkbox" /></td>
							<td>${delivery.createTime}</td>
							<td>${delivery.title}</td>
							<td>${delivery.createUserName}</td>
							<td>${delivery.houseNo}</td>
							<td>${delivery.receiverName}</td>
							<td>${delivery.readCount}</td>
							<td class="action">
								<div class="house-member" style="display: none;">
									<c:if test="${not empty delivery.residentList}">
										<c:forEach items="${delivery.residentList}" var="resident">
											<a rid="${resident.residentId}" href="javascript:void(0);" class="editInfo mt10 editInfo-con">
												<p>${resident.residentName}(${resident.residentType})</p><label>${resident.idCard}</label><br>${resident.phoneNum}<span class=""></span>
											</a>
										</c:forEach>
									</c:if>
									<c:if test="${empty delivery.residentList}">
										无人可选
									</c:if>
								</div>
								<a class="btn_smalls areaNumber-info" title="详情" href="/info/delivery/${delivery.id}">详情</a>
								<a class="btn_smalls btn-primary" title="已阅记录" href="/info/delivery/${delivery.id}/read/list">已阅记录</a>
								<c:if test="${delivery.isReceived == 0}">
									<a class="btn_smalls btn-warning qianshou" title="签收" href="javascript:void(0);">签收</a>
								</c:if>
								<a class="btn_smalls bntbgBrown delete-delivery-btn" title="删除" href="javascript:void(0);">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>




<div class="dialog dialog-delivery-del-alert" params="">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除快递消息？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="deliveryId" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteDelivery" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>


 <!--签收-->
<div class="dialog dialog-qianshou">
	<div class="dialog-container ">
		<input type="hidden" id="signDeliveryId" value=""/>
		<div class="data-block clear"></div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="签收" class="btn bntbgBrown modify-confirm-btn">签收</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<!--签收-->
<div class="black-opacity"></div>



