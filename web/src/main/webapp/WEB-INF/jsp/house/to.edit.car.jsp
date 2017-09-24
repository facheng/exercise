<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$("#edit_car_form").validate({validateAjax: true, submitReset: true});
	$('.save-car-btn').on('click', function(){
		$('.dialog-save-car-alert, .black-opacity').fadeIn();
	});
	
	$('[js="submitCar"]').click(function(){
		
		//如果车牌号没有发生变化，则不进行重复校验
		var oldPlateN = $('#td_plateNo').attr('plateNo');
		var currPlateN = $('input[name="plateNo"]').val();
		var residentId = $('#sel_residentId').val();
		if( oldPlateN != ""){
			$('#sel_residentId').removeAttr('validate');
			if(residentId == '请选择住户'){
				$('#sel_residentId').removeAttr('name');
			}
		} 
		
		if(currPlateN != "" && oldPlateN == currPlateN ){
			$('input[name="plateNo"]').removeAttr('validate');
			$('.error-tooltip').attr('style','display: none;');
		} else {
			$('input[name="plateNo"]').attr('validate','ajaxValid');
		}
		
		$('.dialog, .black-opacity').fadeOut();
		$("#edit_car_form").submit();
		
	});
	
	//列出片区下所有楼栋
	$(".car-resident .partition").on("change", function(){
		
		var partitionId = $(this).val();
		
		var vprTag = $(this).closest(".car-resident");
		var storyTag = vprTag.find(".story");
		var houseTag = vprTag.find(".house");
		var residentTag = vprTag.find(".resident");
		
		storyTag.html('<option><f:message key="select.story.tip"/></option>');
		houseTag.html('<option><f:message key="select.house.tip"/></option>');
		residentTag.html('<option><f:message key="select.resident.tip"/></option>');
		
		if(partitionId == "") {
			return false;
		}
		
		$.ajax({
			url: "/ajax/partition/" + partitionId + "/stories",
			type: "get",
			dataType: "json",
			success: function(data){
				var html = '<option><f:message key="select.story.tip"/></option>';
				if (data != null && data['storyList'] != null && data['storyList'].length > 0) {
					$.each(data['storyList'], function(index, value) {
						html += "<option value='" + value["id"] + "'>" + value["storyNum"] + "</option>";
					});
				}
				storyTag.html(html);
			}
		});

		return false;
	});
	
	//列出楼栋下所有房屋
	$(".car-resident .story").on("change", function(){
		var storyId = $(this).val();
		
		var vprTag = $(this).closest(".car-resident");
		var houseTag = vprTag.find(".house");
		var residentTag = vprTag.find(".resident");
		
		houseTag.html('<option><f:message key="select.house.tip"/></option>');
		residentTag.html('<option><f:message key="select.resident.tip"/></option>');
		
		if(storyId == "") {
			return false;
		}

		$.ajax({
			url: "/ajax/story/" + storyId + "/houses",
			type: "get",
			dataType: "json",
			success: function(data){
				var html = '<option><f:message key="select.house.tip"/></option>';
				if(data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
			        }
				}
				houseTag.html(html);
			}
		});

		return false;
	});
	
	//列出房屋下所有住户
	$(".car-resident .house").on("change", function(){
		var houseId = $(this).val();
		
		var vprTag = $(this).closest(".car-resident");
		var residentTag = vprTag.find(".resident");
		
		residentTag.html('<option><f:message key="select.resident.tip"/></option>');
		
		if(houseId == "") {
			return false;
		}
		
		$.ajax({
			url: "/ajax/house/" + houseId + "/residents",
			type: "get",
			dataType: "json",
			success: function(data){
				var html = '<option><f:message key="select.resident.tip"/></option>';
				if (data != null && data['residentList'] != null && data['residentList'].length > 0) {
					$.each(data['residentList'], function(index, value) {
						html += "<option value='" + value["id"] + "'>" + value["name"] + "</option>";
					});
				}
				residentTag.html(html);
			}
		});

		return false;
	});

	
});
</script>

<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">编辑车辆信息</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
				<form method="post" action="/house/car" autocomplete="off" id="edit_car_form">
				<input type="hidden" name="id" value="${map.carId}"/>
					<table width="100%" cellspacing="0" class="table_form">
						<tbody class="bind-tbody">
							<tr height="70px">
								<th><span class="color-red">*</span>车牌号：</th>
								<td id="td_plateNo" plateNo="${map.plateNo }">
									<div vdfld="daddr" class="user-box-body form-relative-input">
										<input type="text"  name="plateNo" value="${map.plateNo }" validate="ajaxValid" vdOpt="url:'/house/car/plate',key:'plateNo'" class="form-control" style="width: 480px" placeholder="请输入车牌号" />
										<div  vdErr="un" class="tip-normal error error-tooltip" style="display: none;">
											<span class="isNull" style="display: none;"><span class="errorIcon"></span>车牌号不能为空</span>
											<span class="checkObj" style="display: none;"><span class="errorIcon"></span>车牌号已存在</span>
										</div>
									</div>
								</td>
							</tr>
						
							<tr height="70px">
								<th><label><span class="color-red">*</span>车主：</label></th>
								<td>
									<div vdfld="resd" class="car-resident">
										<select class="select-control partition">
											<option><f:message key="select.unit.partition.tip"/></option>
											<c:forEach items="${partitionList}" var="pt">
												<option value="${pt.id}">${pt.name}</option>
											</c:forEach>
										</select>
										<select class="select-control story">
											<option><f:message key="select.story.tip"/></option>
										</select>
										<select class="select-control house">
											<option><f:message key="select.house.tip"/></option>
										</select>
										<select class="select-control resident" id="sel_residentId" name="residentId" validate="isnotSelectFirst">
											<option><f:message key="select.resident.tip"/></option>
										</select>
										<div class="tip-normal error" vderr="resd" style="display: none;"><span class="errorIcon"></span>请选择住户</div>
									</div>
								</td>
							</tr>
							<tr height="70px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="确 定" class="btn btn-success save-car-btn">确 定</a>
									<a href="/house/car/list" title="取 消" class="btn btn-primary">取 消</a>	
								</td>
							</tr>
						</tbody>
					</table>
				</form>
		</div>
	</div>
</div>

<div class="dialog dialog-save-car-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定保存车辆信息？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submitCar" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>

<div class="dialog dialog-save-car-error-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">车牌号重复</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" class="btn bntbgBrown dialog-close">确 定</a>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>


