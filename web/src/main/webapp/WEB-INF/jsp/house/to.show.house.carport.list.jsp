<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
function submitForm(){
	var btype = "";
	$(".car-port-btype").each(function(){
		if($(this).hasClass("cur")) {
			btype = $(this).attr("value");
			return;
		}
	});
	$("#btype_hidden").val(btype);

	$("#search_form").submit();
}
$(document).ready(function() {
	
	$(".car-port-btype").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.car-port-btype').each(function(){
			$(this).removeClass('cur');
		});
		atag.addClass('cur');

		submitForm();
	});

	//提示是否删车位
	$(".btn-delete-cp-alert").on("click", function(){
		var portId = $(this).closest("tr").attr("id");
		$("#car_port_id").val(portId);
		$('.dialog-car-port-del-alert, .black-opacity').fadeIn();
	});

	//确定删除车位
	$(".btn-delete-cp-confirm").on("click", function(){
		var portId = $("#car_port_id").val();
		$(".black-opacity").fadeIn();

		$.ajax({
			url: "/house/carport/" + portId,
			type: "post",
			dataType: "text",
			data: {"_method": "delete"},
			success: function(data){
                if(data == 1) {
					location.href = location.href;
                }
		    }
		});
		return false;
	});

	//提示是否解绑
	$(".btn-unbind-cp-alert").on("click", function(){
		var portId = $(this).closest("tr").attr("id");
		var rname = $(this).closest("tr").attr("rname");
		var idcard = $(this).closest("tr").attr("idcard");
		var phone = $(this).closest("tr").attr("phone");
		
		var html = '';
		html += '<a portId="' + portId + '" rname="' + rname + '" idcard="' + idcard + '" phone="' + phone + '" href="javascript:void(0);" class="editInfo mt10 editInfo-con">';
		html += '<p>' + rname + '</p><p>' + idcard + '</p><p>' + phone + '</p><label></label><br><span class="choiceBtn"></span>';
		html += '</a>';

		$(".dialog-unbind-cp .dialog-container .data-block").html(html);
		$('.dialog-unbind-cp, .black-opacity').fadeIn();
	});

	//确定解绑
	$(".btn-unbind-cp-confirm").live("click", function(){
		var portId = "0";
		$(".dialog-unbind-cp .dialog-container .data-block .editInfo-con").each(function(){
			if($(this).find('span').hasClass("choiceBtn")) {
				portId = $(this).attr("portId");
				return;
			}
		});

		if(portId != "" && portId != "0") {
			$('.dialog-unbind-cp').fadeOut();
			$.ajax({
				url: "/house/carport/" + portId + "/unbind",
				type: "post",
				dataType: "text",
				success: function(data){
					if(data == 1) {
						location.href = location.href;
	                }
			    }
			});
			return false;
		}

		return false;
	});

	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">车位管理</h2>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/house/carport/list" method="get" id="search_form">
			<div class="category ctop mt10">
				<div class="cate-link">
					<span>车位状态：</span>
					<a href="javascript:void(0);" title="全部" class='car-port-btype <c:if test="${empty searchVo.btype}">cur</c:if>'>全部</a>
					<c:forEach items="${btypesMap}" var="btype">
						<a href="javascript:void(0);" value="${btype.key}" title="${btype.value}" class="car-port-btype <c:if test="${searchVo.btype == btype.key}">cur</c:if>">${btype.value}</a>
					</c:forEach>
					<input type="hidden" id="btype_hidden" name="btype" value="${searchVo.btype}"/>
				</div>
			</div>
			<div class="category no-border-top searchTipsBtnBox">
				<ul class="searchfm clearfix">
					<li><span class="zw">车位号码：</span><input type="text" name="pno" value="${searchVo.pno}" placeholder="请输入车位号码" class="textinput" /></li>
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li>
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="5%">
				<col width="30%">
				<col width="30%">
				<col width="35%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>车位号</th>
					<th>车位状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr id="${result.portId}" rname="${result.residentName}" idcard="${result.idCard}" phone="${result.phoneNum}">
						<td><input type="checkbox" /></td>
						<td>${result.portNo}</td>
						<td>${result.bindTypeName}</td>
						<td class="action">
							<a class="btn_smalls areaNumber-info " title="详情" href="/house/carport/${result.portId}/detail">详情</a>
							<c:if test="${result.bindType == 0}">
								<a class="btn_smalls btn-warning" title="绑定" href="/house/carport/${result.portId}/bind">绑定</a>
								<!--
								<a class="btn_smalls btn-warning btn-delete-cp-alert" title="删除" href="javascript:void(0);">删除</a>
								-->
							</c:if>
							<c:if test="${result.bindType != 0}">
								<a class="btn_smalls btn-warning btn-unbind-cp-alert" title="解绑" href="javascript:void(0);">解绑</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<!-- 删除车位的弹层提醒 -->
<div class="dialog dialog-car-port-del-alert">
	<div class="dialog-container">
		<div class="text-con-dialog">
			<p class="dialog-text-center">确定删除该车位？</p>
		</div>
		<div class="winBtnBox mt20">
			<input type="hidden" id="car_port_id" value=""/>
			<a href="javascript:void(0);" title="确定" class="btn bntbgBrown btn-delete-cp-confirm">确 定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>

<!-- 解绑车位的弹层提醒 -->
<div class="dialog dialog-unbind-cp">
	<div class="dialog-container">
		<div class="data-block clear"></div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="解绑" class="btn bntbgBrown btn-unbind-cp-confirm">解 绑</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>

<div class="black-opacity click-disappear"></div>


