<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#create_repair_form").validate({submitReset: true});
	
	$("#order_time").click(function(){
		//showCalendar($(this).attr("id"));
		WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
	});

	$("#partition_slt").on("change", function(){
		$("#resident_id").val(0);
		$("#resident_name").val("");
		$("#phone_num").val("");
		$("#address").val("");
		var partitionId = $(this).val();
		if(partitionId == -1) {
			$("#story_slt").html('<option value="-1"><f:message key="select.story.tip"/></option>');
			$("#house_slt").html('<option value="-1"><f:message key="select.house.tip"/></option>');
			return false;
		}

		$.ajax({
			url: "/ajax/partition/" + partitionId + "/stories",
			type: "get",
			dataType: "json",
			success: function(data){
				var html = '<option value="-1"><f:message key="select.story.tip"/></option>';
				if (data != null && data['storyList'] != null && data['storyList'].length > 0) {
					$.each(data['storyList'], function(index, value) {
						html += "<option value='" + value["id"] + "'>" + value["storyNum"] + "</option>";
					});
				}
				$("#story_slt").html(html);
			}
		});

		return false;
	});

	$("#story_slt").on("change", function(){
		$("#resident_id").val(0);
		$("#resident_name").val("");
		$("#phone_num").val("");
		$("#address").val("");
		var storyId = $(this).val();
		if(storyId == -1) {
			$("#house_slt").html('<option value="-1"><f:message key="select.house.tip"/></option>');
			return false;
		}

		$.ajax({
			url: "/ajax/story/" + storyId + "/houses",
			type: "get",
			dataType: "json",
			success: function(data){
				var html = '<option value="-1"><f:message key="select.house.tip"/></option>';
				if(data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
			        }
				}
				$("#house_slt").html(html);
			}
		});

		return false;
	});

	$("#house_slt").on("change", function(){
		$("#resident_id").val(0);
		$("#resident_name").val("");
		$("#phone_num").val("");
		$("#address").val("");
		var houseId = $(this).val();
		if(houseId == -1) {
			$(".dialog-select-resident .data-block").text("");
			return false;
		}
		
		$.ajax({
			url: "/ajax/house/" + houseId + "/residents",
			type: "get",
			dataType: "json",
			success: function(data){
				if (data != null && data['residentList'] != null && data['residentList'].length > 0) {
					var html = '';
					$.each(data['residentList'], function(index, value) {
						html += '<a rid="' + value["id"] + '" rname="' + value["name"] + '" rphone="' + value["phone"] + '" href="javascript:void(0);" class="editInfo mt10 editInfo-con">';
						if(index == 0) {
							html += '<p>' + value["name"] + '(' + value["phone"] + ')</p><label></label><br><span class="choiceBtn"></span>';
						} else {
							html += '<p>' + value["name"] + '(' + value["phone"] + ')</p><label></label><br><span class=""></span>';
						}
						html += '</a>';
					});
					$(".dialog-select-resident .dialog-container .data-block").html(html);
					$('.dialog-select-resident, .black-opacity').fadeIn();
				} else {
				}
			},
		    error: function () {
                alert('接口调用失败！');
            }
		});

		$.ajax({
			url: "/ajax/house/" + houseId + "/address",
			type: "get",
			dataType: "text",
			success: function(addr){
				$("#address").val(addr);
			}
		});
		
		return false;
	});

	$(".select-confirm-btn").live("click", function(){
		var rid = "0";
		var rname = "";
		var rphone = "";
		$(".dialog-select-resident .dialog-container .data-block .editInfo-con").each(function(){
			if($(this).find('span').hasClass("choiceBtn")) {
				rid = $(this).attr("rid");
				rname = $(this).attr("rname");
				rphone = $(this).attr("rphone");
				return;
			}
		});

		if(rid != "" && rid != "0") {
			$("#resident_id").val(rid);
			$("#resident_name").val(rname);
			$("#phone_num").val(rphone);
			$('.dialog-select-resident, .black-opacity').fadeOut();
		}

		return false;
	});

	$("#work_type_id").on("change", function(){
		var partitionId = $("#partition_slt").val();
		var workTypeId = $(this).val();
		if(partitionId == -1 || workTypeId == -1) {
			$("#assign_to").html('<div class="tips">请选择维修工种，将报修申请分配到相关的维修人员</div>');
			return false;
		}

		$.ajax({
			url: "/ajax/partition/" + partitionId + "/wtype/" + workTypeId + "/workers",
			type: "get",
			dataType: "json",
			success: function(data){
				if (data != null && data['workerList'] != null && data['workerList'].length > 0) {
					var html = '<div class="mai-list"><div class="areaBox">';
					$.each(data['workerList'], function(index, value) {
						if(index == 0) {
							html += '<span><input name="workerId" type="radio" value="' + value["id"] + '" checked="checked">' + value["name"] + '</span>';
						} else {
							html += '<span><input name="workerId" type="radio" value="' + value["id"] + '">' + value["name"] + '</span>';
						}
					});
					html += '</div></div>';
					$("#assign_to").html(html);
				} else {
					$("#assign_to").html('<div class="tips">请选择维修工种，将报修申请分配到相关的维修人员</div>');
				}
			},
		    error: function () {
                alert('接口调用失败！');
                $("#assign_to").html('<div class="tips">请选择维修工种，将报修申请分配到相关的维修人员</div>');
            }
		});
		return false;
	});
	
	$('#select_commonWords').on('change' , function(){
		var commonWords = $('#select_commonWords').val();
		var option_common_select = $('#option_common_select').val();
		if(commonWords != option_common_select ){
			$('[name=remark]').val(commonWords);
		}
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">新增报修</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<form method="post" action="/repair/new" autocomplete="off" id="create_repair_form" >
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="80px">
							<th></th>
							<td>
								<p class="tips">您可以在这里添加接收到的电话报修</p>
							</td>
						</tr>
						<tr height="40px">
							<th width="150"><span class="color-red">*</span>报修类型：</th>
							<td vdfld="rt">
								<select name="repairType" validate="isnotSelectFirst" class="form-control">
									<option value="-1"><f:message key="common.select"/></option>
									<c:if test="${not empty repairTypeList}">
										<c:forEach items="${repairTypeList}" var="rt">
											<option value="${rt.key}">${rt.value}</option>
										</c:forEach>
									</c:if>
								</select>
								<div class="tip-normal error" vderr="rt" style="display: none;"><span class="errorIcon"></span>请选择报修类型</div>
							</td>
						</tr>
						<tr height="80px">
							<th><span class="color-red">*</span>维修类型：</th>
							<td vdfld="st">
								<select name="serviceType" validate="isnotSelectFirst" class="form-control">
									<option value="-1"><f:message key="common.select"/></option>
									<c:if test="${not empty serviceTypeList}">
										<c:forEach items="${serviceTypeList}" var="st">
											<option value="${st.key}">${st.value}</option>
										</c:forEach>
									</c:if>
								</select>
								<div class="tip-normal error" vderr="st" style="display: none;"><span class="errorIcon"></span>请选择维修类型</div>
							</td>
						</tr>
						<tr height="40px">
							<th><span class="color-red">*</span>报修人房屋：</th>
							<td vdfld="rh" class="three-slt">
								<select class="form-control" id="partition_slt">
									<option value="-1"><f:message key="select.unit.partition.tip"/></option>
									<c:if test="${not empty partitionList}">
										<c:forEach items="${partitionList}" var="partition">
											<option value="${partition.id}">${partition.aliasName}</option>
										</c:forEach>
									</c:if>
								</select>
								<select class="form-control" id="story_slt">
									<option value="-1"><f:message key="select.story.tip"/></option>
								</select>
								<select class="form-control" id="house_slt" name="houseId" validate="isnotSelectFirst">
									<option value="-1"><f:message key="select.house.tip"/></option>
								</select>
								<div class="tip-normal error" vderr="rh" style="display: none;"><span class="errorIcon"></span>请选择报修房屋</div>
							</td>
						</tr>
						<tr height="80px">
							<th><span class="color-red">*</span>报修人姓名：</th>
							<td>
								<input type="hidden" id="resident_id" name="residentId" value="0"/>
								<div vdfld="rname" class="user-box-body form-relative-input">
									<input type="text" class="form-control" id="resident_name" name="residentName" value="" validate="isnotEmpty" placeholder="请输入报修人姓名" />
									<div class="tip-normal error" vderr="rname" style="display: none;"><span class="errorIcon"></span>报修人姓名不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="60px">
							<th><span class="color-red">*</span>报修人手机号：</th>
							<td>
								<div vdfld="phnum" class="user-box-body form-relative-input">
									<input type="text" class="form-control" id="phone_num" name="phoneNum" value="" validate="isPhone" placeholder="请输入报修人手机号" />
									<div class="tip-normal error" vderr="phnum" style="display: none;"><span class="errorIcon"></span>请填写正确的手机号码</div>
								</div>
							</td>
						</tr>
						<tr height="60px">
							<th><span class="color-red">*</span>预约时间：</th>
							<td>
								<div vdfld="rordertime" class="user-box-body form-relative-input">
									<input type="text" class="form-control clear-data" id="order_time" name="orderTime" value="" readonly="readonly" validate="isnotEmpty" placeholder="请选择预约时间" />
									<div class="tip-normal error" vderr="rordertime" style="display: none;"><span class="errorIcon"></span>预约时间不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="40px">
							<th>是否公开：</th>
							<td>
								<div class="noticeType-choice">
									<label><input type="radio" name="isPublic" value="0" checked="checked" /><span><f:message key="common.yes"/></span></label>
									<label><input type="radio" name="isPublic" value="1" /><span><f:message key="common.no"/></span></label>
								</div>
							</td>
						</tr>
						<tr height="60px">
							<th><span class="color-red">*</span>报修地址：</th>
							<td>
								<div vdfld="addr" class="user-box-body form-relative-input">
									<input type="text" class="form-control" id="address" name="address" value="" validate="isnotEmpty" placeholder="请输入报修地址" />
									<div class="tip-normal error" vderr="addr" style="display: none;"><span class="errorIcon"></span>报修地址不能为空</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
								<th width="100">常用语：</th>
								<td>
									<select class="form-control commonWords" id="select_commonWords">
										<option id="option_common_select"><f:message key="common.select"/></option>
										<c:forEach items="${commonWordsList }" var="commonWords">
											<option >${ commonWords.words}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
						
						<tr height="350px">
							<th>报修描述：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<textarea class="form-control form-control-textarea" name="remark" placeholder="请输入报修描述"></textarea>
								</div>
							</td>
						</tr>
						<tr height="40px">
							<th><span class="color-red">*</span>紧急程度：</th>
							<td vdfld="urs">
								<select class="form-control" name="urgentState" validate="isnotSelectFirst">
									<option value="-1"><f:message key="common.select"/></option>
									<c:if test="${not empty urgentStateList}">
										<c:forEach items="${urgentStateList}" var="urs">
											<option value="${urs.key}">${urs.value}</option>
										</c:forEach>
									</c:if>
								</select>
								<div class="tip-normal error" vderr="urs" style="display: none;"><span class="errorIcon"></span>请选择紧急程度</div>
							</td>
						</tr>
						<tr height="80px">
							<th><span class="color-red">*</span>维修工种：</th>
							<td vdfld="wt">
								<select class="form-control" id="work_type_id" name="workTypeId" validate="isnotSelectFirst">
									<option value="-1"><f:message key="common.select"/></option>
									<c:if test="${not empty workTypeList}">
										<c:forEach items="${workTypeList}" var="wt">
											<option value="${wt.id}">${wt.name}</option>
										</c:forEach>
									</c:if>
								</select>
								<div class="tip-normal error" vderr="wt" style="display: none;"><span class="errorIcon"></span>请选择维修工种</div>
							</td>
						</tr>
						<tr>
							<th>分派给：</th>
							<td id="assign_to">
								<div class="tips">请选择维修工种，将报修申请分配到相关的维修人员</div>
							</td>
						</tr>
						
						
						<tr height="80px">
							<th></th>
							<td>
								<div class="submit">
									<a href="javascript:void(0);" title="确定" class="btn btn-success btn-submit">确定</a>
									<a href="/repair/unassigned" title="取消" class="btn btn-primary">取 消</a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>




<div class="dialog dialog-select-resident">
	<div class="dialog-container ">
		<div class="data-block clear"></div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" class="btn bntbgBrown select-confirm-btn">确定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>



