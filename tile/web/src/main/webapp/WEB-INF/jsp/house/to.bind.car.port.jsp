<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#bind_car_port_form").validate({submitReset: true});
	
	//列出片区下所有楼栋
	$(".car-port-resident .partition").on("change", function(){
		var partitionId = $(this).val();
		
		var vprTag = $(this).closest(".car-port-resident");
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
	$(".car-port-resident .story").on("change", function(){
		var storyId = $(this).val();
		
		var vprTag = $(this).closest(".car-port-resident");
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
	$(".car-port-resident .house").on("change", function(){
		var houseId = $(this).val();
		
		var vprTag = $(this).closest(".car-port-resident");
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

	$(".bind-type").live("click", function(){
		var btype = $(this).val();

		var tbody = $(this).closest(".bind-tbody");
		var rptr = tbody.find(".rent-period-tr");
		var rpslt = rptr.find(".rent-period");
		

		if(btype == 1) {
			//出售
			rptr.hide();
			rpslt.removeAttr("validate");
		} else if(btype == 2) {
			//出租
			rptr.show();
			rpslt.attr("validate", "isnotSelectFirst");
		}
		
	});

	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">车位绑定</h2>
		<div class="rightNav-sub">
			<a href="javascript:history.go(-1);" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<c:if test="${empty map}">
				车位不存在
			</c:if>
			<c:if test="${not empty map}">
				<form method="post" action="/house/carport/${id}/bind" id="bind_car_port_form">
					<table width="100%" cellspacing="0" class="table_form">
						<tbody class="bind-tbody">
							<tr height="70px">
								<th width="100px"><label><span class="color-red">*</span>绑定类型：</label></th>
								<td vdfld="bterr">
									<div class="noticeType-choice">
										<label><input type="radio" validate="radioChecked" name="btype" <c:if test="${map.bindType == 1}">checked="checked"</c:if> value="1" class="wuye-radio bind-type" /><span>出售</span></label>
										<label><input type="radio" validate="radioChecked" name="btype" <c:if test="${map.bindType == 2}">checked="checked"</c:if> value="2" class="wuye-radio bind-type" /><span>出租</span></label>
									</div>
									<div style="clear: both;"></div>
									<div class="tip-normal error" vderr="bterr" style="display: none;"><span class="errorIcon"></span>请选择绑定类型</div>
								</td>
							</tr>
							<c:if test='${map.bindType == 2}'>
								<tr height="70px" class="rent-period-tr">
									<th><label><span class="color-red">*</span>租赁周期：</label></th>
									<td>
										<div vdfld="rpr" class="user-box-body form-relative-input">
											<select class="chargeCompany rent-period" name="rperiod" validate="isnotSelectFirst">
												<option value="-1"><f:message key="common.select"/></option>
												<c:forEach items="${rentPeriodsMap}" var="rp">
													<option <c:if test="${map.bindRentPeriod == rp.key}">selected="selected"</c:if> value="${rp.key}">${rp.value}</option>
												</c:forEach>
											</select>
											<div class="tip-normal error" vderr="rpr" style="display: none;"><span class="errorIcon"></span>请选择租赁周期</div>
										</div>
									</td>
								</tr>
							</c:if>
							<c:if test='${map.bindType != 2}'>
								<tr height="70px" class="rent-period-tr" style="display: none;">
									<th><label><span class="color-red">*</span>租赁周期：</label></th>
									<td>
										<div vdfld="rpr" class="user-box-body form-relative-input">
											<select class="chargeCompany rent-period" name="rperiod">
												<option value="-1"><f:message key="common.select"/></option>
												<c:forEach items="${rentPeriodsMap}" var="rp">
													<option <c:if test="${map.bindRentPeriod == rp.key}">selected="selected"</c:if> value="${rp.key}">${rp.value}</option>
												</c:forEach>
											</select>
											<div class="tip-normal error" vderr="rpr" style="display: none;"><span class="errorIcon"></span>请选择租赁周期</div>
										</div>
									</td>
								</tr>
							</c:if>
							<tr height="70px">
								<th><label><span class="color-red">*</span>住户：</label></th>
								<td>
									<div vdfld="resd" class="car-port-resident">
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
										<select class="select-control resident" name="residentId" validate="isnotSelectFirst">
											<option><f:message key="select.resident.tip"/></option>
										</select>
										<div class="tip-normal error" vderr="resd" style="display: none;"><span class="errorIcon"></span>请选择住户</div>
									</div>
								</td>
							</tr>
							<tr height="70px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="确定" class="btn btn-success btn-submit">确 定</a>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</c:if>
		</div>
	</div>
</div>

<div class="black-opacity click-disappear"></div>


