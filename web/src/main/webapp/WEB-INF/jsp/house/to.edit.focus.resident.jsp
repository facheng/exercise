<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
$(function() {
	$("#edit_fr_form").validate({validateAjax: true, submitReset: true});
	parChange();
});


//根据期数下拉框获取楼栋
function parChange() {
	var partitionId = $("#partition option:selected").val();
	var storySel = $("#story");
	storySel.find("option").remove();
	$.ajax({
		type : "post",
		url : "/story/findStory",
		data : {
			"partitionId" : partitionId
		},
		success : function(data) {
			if (data && data['storys'] && data['storys'].length > 0) {
				$.each(data['storys'],function(index, value) {
					var storyId = value["id"];
					if ('${fr.storyId}' == storyId) {
						storySel.append("<option value='"+storyId+"' selected='selected'>" + value['storyNum'] + "</option>");
					} else {
						storySel.append("<option value='"+storyId+"'>"+ value['storyNum']+ "</option>");
					}
				});
				storyChange();
			}else{
				var roomNumSel = $("#roomNum");
				roomNumSel.find("option").remove();
				var residentSel = $("#hrId");
				residentSel.find("option").remove();
			}
			
		}
	});
}

//根据楼栋获取房屋下拉框
function storyChange() {
	var storyId = $("#story option:selected").val();
	var roomNumSel = $("#roomNum");
	roomNumSel.find("option").remove();
	$.ajax({
		type : "post",
		url : "/house/findHouse",
		data : {
			"storyId" : storyId
		},
		success : function(data) {
			if (data && data['houses'] && data['houses'] && data['houses'].length > 0) {
				$.each(data['houses'],function(index, value) {
					var houseId = value["id"];
					if ('${fr.houseId}' == houseId) {
						roomNumSel.append("<option value='"+houseId+"' selected='selected' >" + value['roomNum'] + "</option>");
					} else {
						roomNumSel.append("<option value='"+houseId+"' >" + value['roomNum'] + "</option>");
					}
				});
				houseChange();
			}else{
				var residentSel = $("#hrId");
				residentSel.find("option").remove();
			}
			
		}
	});
}

//根据房屋获取住户
function houseChange(){
	var houseId = $("#roomNum option:selected").val();
	var residentSel = $("#hrId");
	residentSel.find("option").remove();
	$.ajax({
		type : "post",
		url : "/resident/findResident",
		data : {
			"houseId" : houseId
		},
		success : function(data) {
			if (data && data['residents'] && data['residents'].length > 0) {
				$.each(data['residents'],function(index, value) {
					var hrId = value["houseResidentId"];
					if ('${fr.hrId}' == hrId) {
						residentSel.append("<option value='"+hrId+"' selected='selected' >" + "&nbsp;" + value['residentName'] +"&nbsp;&nbsp;&nbsp;"+ value['phoneNum'] + "&nbsp;&nbsp;&nbsp;" + value['residentType'] + "</option>");
					} else {
						residentSel.append("<option value='"+hrId+"' >" + "&nbsp;" + value['residentName'] +"&nbsp;&nbsp;&nbsp;"+ value['phoneNum'] + "&nbsp;&nbsp;&nbsp;" + value['residentType'] + "</option>");
					}
				});
			}
		}
	});
	
}
</script>

<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">修改需要关注的业主信息</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<form method="post" action="/house/resident/focus/edit" id="edit_fr_form">
			<input type="hidden" name="id" id="id" value="${frId}">
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="80px">
							<th><span class="color-red">*</span><label>选择期数：</label></th>
							<td>
								 <div vdfld="partition" class="user-box-body form-relative-input">
									 <select id="partition" name=partition validate="isnotEmpty" class="guest-num" style="width: 370px;" onChange="parChange()" style="width: 50%;"  <c:if test="${frId != 0}">disabled="disabled"</c:if>>
										
										<c:forEach items="${ups}" var="up">
										
											<option value="${up.id}" <c:if test="${up.id==fr.partitionId}"> selected="selected" </c:if>> ${up.aliasName}</option>
										
										</c:forEach>
									  </select> 
									  <div class="tip-normal error" vderr="partition" style="display: none;"><span class="errorIcon"></span>期数不能为空</div>
								  </div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span><label>选择楼栋：</label></th>
							<td>
								 <div vdfld="story" class="user-box-body form-relative-input">
								  	  <select id="story" name="story" validate="isnotEmpty" class="guest-num" style="width: 370px;" onChange="storyChange()" style="width: 50%;" <c:if test="${frId != 0}">disabled="disabled"</c:if>>
											
								      </select>
								      <div class="tip-normal error" vderr="story" style="display: none;"><span class="errorIcon"></span>该期数下没有楼栋</div>
							     </div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span><label>选择房屋：</label></th>
							<td>
								<div vdfld="roomNum" class="user-box-body form-relative-input">
								    <select id="roomNum" name="roomNum" validate="isnotEmpty" class="guest-num" style="width: 370px;" onChange="houseChange();" style="width: 50%;" <c:if test="${frId != 0}">disabled="disabled"</c:if>>
								    </select>
								    <div class="tip-normal error" vderr="roomNum" style="display: none;"><span class="errorIcon"></span>该楼栋下没有房屋</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span><label>选择业主：</label></th>
							<td  vdfld="un">
									<select id="hrId" name="hrId" class="guest-num" style="width: 370px;" validate="ajaxValid" vdOpt="url:'/ajax/user/fr?id=${frId}',key:'hrId'">
									</select>
									<div vdErr="un" class="tip-normal error error-tooltip" style="display: none;">
										<span class="isNull" style="display: none;">该房屋未绑定业主</span>
										<span class="checkObj" style="display: none;">该业主已存在</span>
									</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th><span class="color-red">*</span><label>选择状态：</label></th>
							<td class="hmdList">
								<div class="clear">
								
									<div class="hmdBox">
										 <span class="blacklist angry"></span>
										 <span class="hmdBox-text">易&nbsp;怒</span>
										 <input type="radio" id="residentStatus" name="residentStatus" value="1" checked="checked">
									</div> 

									<div class="hmdBox">
										<span class="blacklist overdue"></span>
										<span class="hmdBox-text">体&nbsp;弱</span>
										<input type="radio" id="residentStatus" name="residentStatus" value="2" <c:if test="${fr.residentStatus == 2}">checked="checked"</c:if>>
									</div>
									
									<div class="hmdBox">
										<span class="blacklist weak"></span>
										<span class="hmdBox-text">迟缴费</span>
										<input type="radio" id="residentStatus" name="residentStatus" value="3" <c:if test="${fr.residentStatus == 3}">checked="checked"</c:if>>
									</div>

								</div>
							</td>
						</tr>

						<tr height="80px">
							<th><span class="color-red">*</span><label>备注内容：</label></th>
							<td><textarea name="remark" id="remark" class="form-control" placeholder="请输入备注内容" style="height: 100px;">${fr.remark}</textarea>
							</td>
						</tr>
						
						<tr height="80px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="保存" class="btn btn-success btn-submit">保 存</a>
	           						<a href="/house/resident/focus" title="取消" class="btn btn-primary">取 消</a>	
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

