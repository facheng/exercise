<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	//提示是否删车辆
	$('.btn-del-car-alert').on('click', function(){
		var hrId = $(this).closest("tr").attr("carId");
		$(".dialog-car-del-alert").attr("params", hrId);
		$('.dialog-car-del-alert, .black-opacity').fadeIn();
	});
	
	$('.delete-car-batch').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("carId") + ',';
			return(checkedNum);
		});
		var frIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-car-del-alert").attr("params", frIds);
		$('.dialog-car-del-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteCar"]').click(function(){
		var carIds = $(this).closest(".dialog-car-del-alert").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/cars",
            type: "post",
            data: {"carIds": carIds , "_method": "delete"},
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
		<h2 class="titIcon wyIcon">车辆管理</h2>
		 <div class="addbtn">
               <a class="btn bntbgBrown modify-focus-btn" title="添加车辆" href="/house/car">添加车辆</a>
           </div>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/house/car/list" method="get" id="search_form">
			<div class="category ctop mt10">
			<!-- 	<a href="/house/car" title="添加车辆信息" class="btn bntbgGreen">添加车辆信息</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-car-batch">批量删除</a>-->
			</div> 
			<div class="category no-border-top searchTipsBtnBox">
				<ul class="searchfm clearfix">
					 <li><span class="zw">车牌号码：</span><input type="text" name="plateNo" value="${searchVo.plateNo}" class="textinput" placeholder="请输入车牌号码"/></li>
					<li><span class="zw">车主姓名：</span><input type="text" name="residentName" value="${searchVo.residentName}" class="textinput" placeholder="请输入车主姓名"/></li>
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li> 
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-car-batch">批量删除</a></li> 
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10" id="data-list-table">
			<colgroup>
				<col width="5%">
				<col width="30%">
				<col width="30%">
				<col width="35%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>车牌号码</th>
					<th>车主姓名</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr  rname="${result.residentName}" carId="${result.carId}" plateno="${result.plateNo}">
						<td><input type="checkbox" /></td>
						<td>${result.plateNo}</td>
						<td>${result.residentName}</td>
						<td class="action">
							<a class="btn_smalls areaNumber-info " title="详情" href="/house/car/${result.carId}/detail">详情</a>
							<a class="btn_smalls btn-primary btn_edit_car" id="btn_edit_car" title="编辑" href="/house/car?id=${result.carId}">编辑</a>
							<a class="btn_smalls bntbgBrown btn-del-car-alert" title="删除" href="javascript:void(0);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>
<!-- 删除车辆的弹层提醒 -->
<div class="dialog dialog-car-del-alert" params="">
	<div class="dialog-container">
		<div class="text-con-dialog">
			<p class="dialog-text-center">确定删除车辆信息？</p>
		</div>
		<div class="winBtnBox mt20">
			<input type="hidden" id="car_id" value=""/>
			<a href="javascript:void(0);" title="确定" js="deleteCar" class="btn bntbgBrown btn-del-car-confirm">确 定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>

<div class="black-opacity click-disappear"></div>


