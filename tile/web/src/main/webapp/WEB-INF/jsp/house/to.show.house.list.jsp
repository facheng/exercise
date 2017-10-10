<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(function(){
	$('.show_key_info').live('click',function(){
		
		var houseMembers = $(this).closest(".action").find(".house-member")[0].innerHTML;
		$(".dialog-show-key-info .dialog-container .data-block").html(houseMembers);
		
		$('.dialog-show-key-info, .black-opacity').fadeIn();
	});
});

function submitForm(){
	var status = "";
	$(".s_status").each(function(){
		if($(this).hasClass("cur")) {
			status = $(this).attr("value");
			return;
		}
	});
	$("#status_hidden").val(status);
	
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
	
	$(".s_status").on("click", function(){
		var atag = $(this);
		atag.closest("div").find('.s_status').each(function(){
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
	
	
	$('[js="binding"]').on("click", function(){
		var houseId = $(this).closest("tr").attr("id");
		$("#save_resident_form").attr("action", "/house/" + houseId + "/resident/bind");
		$("#phoneNum").attr("vdOpt", "url:'/house/" + houseId + "/phone/validate',key:'phoneNum'");
		$("#save_resident_form").validate({validateAjax: true});
		$('.dialog-bind-resident, .black-opacity').fadeIn();
	});
	
	//绑定住户保存
	$("#bangdingBnt").click(function(){
		$("#save_resident_form").submit();
	});


	$('[js="searchHouse"]').on("click", function(){
		var rno = $.trim($("#rno").val());
		if(rno == "") {
			if("${status}" == null || "${status}" == "") {
				location.href = "/house/list";
			} else {
				location.href = "/house/list?status=${status}";
			}
		} else {
			if("${status}" == null || "${status}" == "") {
				location.href = "/house/list?rno=" + rno;
			} else {
				location.href = "/house/list?status=${status}&rno=" + rno;
			}
		}
	});
});
</script>



<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">房屋管理</h2>
		<div class="addbtn"></div>
	</div>
  
	<div class="import_tmpl">
		<div class="tips">系统没有任何房屋信息，请先
			<a href="javascript:void(0);">下载“房屋资料批量导入模版”</a>并录入数据 。您导入的文件需为当前最新模版，且字段名称和顺序须与模版相符合。然后 
			<a href="javascript:void(0);" title="批量导入房屋信息" class="btn btn-import-info">批量导入房屋信息</a> 再进行房屋操作。
		</div>
	</div>
	<div class="cont_box_wrap full-width">
		<form action="/house/list" method="get" id="search_form">
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
					<a href="javascript:void(0);" title="全部" class="s_status <c:if test="${empty status}">cur</c:if>">全部</a>
					<a href="javascript:void(0);" value="1" title="自住" class="s_status <c:if test="${status == 1}">cur</c:if>">自住</a>
					<a href="javascript:void(0);" value="2" title="空置" class="s_status <c:if test="${status == 2}">cur</c:if>">空置</a>
					<a href="javascript:void(0);" value="3" title="待售" class="s_status <c:if test="${status == 3}">cur</c:if>">待售</a>
					<a href="javascript:void(0);" value="4" title="出租" class="s_status <c:if test="${status == 4}">cur</c:if>">出租</a>
					<a href="javascript:void(0);" value="5" title="待售" class="s_status <c:if test="${status == 5}">cur</c:if>">待租</a>
					<input type="hidden" id="status_hidden" name="status" value="${status}"/>
				</div>
			</div>
			<div class="category no-border-top">
				<ul class="searchfm clear">
					<li><span class="zw">房屋编号(室)：</span><input type="text" class="textinput" id="rno" name="rno" value="${rno}" placeholder="房屋编号"></li>
					<li><span>&nbsp;</span>
					<a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a>
					</li>
				</ul>
			</div>
		</form>
	
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="5%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="35%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>片区</th>
					<th>楼栋号</th>
					<th>门室号</th>
					<th>房屋状态</th>
					<th>快递状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty houseList}">
				<tbody>
					<c:forEach var="house" items="${houseList}" varStatus="status">
						<tr id="${house.id}">
							<td><input type="checkbox" /></td>
							<td>${status.count}</td>
							<td>${house.aliasName}</td>
							<td>${house.storyNum}</td>
							<td>${house.roomNum}</td>
							
							<td>
								<c:if test="${house.status == '1'}">自住</c:if>
								<c:if test="${house.status == '2'}">空置</c:if>
								<c:if test="${house.status == '3'}">待售</c:if>
								<c:if test="${house.status == '4'}">出租</c:if>
								<c:if test="${house.status == '5'}">待租</c:if>
							
							</td>
							<td>
								<c:if test="${house.delegateDelivery == '0'}">未设置</c:if>
								<c:if test="${house.delegateDelivery == '1'}">可代收</c:if>
								<c:if test="${house.delegateDelivery == '2'}"><font color="red">不可代收</font></c:if>
							</td>
							
							<td class="action">
							
								<div class="house-member" style="display: none;">
									<c:if test="${not empty house.keyMap}">
										<c:forEach items="${house.keyMap}" var="keyDevice">
											<a  href="javascript:void(0);" class="editInfo mt10">
												<p>${keyDevice.keyName}</p><label>${keyDevice.deviceAddress}</label><br>
												
												<c:if test="${keyDevice.deviceType == '1'}">楼栋钥匙</c:if>
												<c:if test="${keyDevice.deviceType == '0'}">小区钥匙</c:if>
												
												<span class=""></span>
											</a>
										</c:forEach>
									</c:if>
									<c:if test="${empty house.keyMap}">
										钥匙信息为空
									</c:if>
								</div>
								
								<a title="详情" href="/house/message?houseId=${house.id}" class="btn_smalls areaNumber-info">详情</a>
								<a class="btn_smalls btn-warning" js="binding" title="绑定住户">绑定住户</a>
								<a class="btn_smalls btn-primary" href="/house/${house.id}" title="修改">修改</a>
								<a class="btn_smalls btnbgViolet show_key_info" href="javascript:void(0);" title="钥匙">钥匙</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty houseList}">
				<tr>
					<td colspan="8"><h3 class="clearfix mt10" style="text-align:center;" > 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<!--绑定住户-->
<div class="dialog dialog-bind-resident">
	<div class="dialog-container inv-form">
		<form method="post" autocomplete="off" id="save_resident_form">
			<table class="inv-table">
				<tbody>
					<tr>
						<td><label>住户类型</label></td>
						<td>
							<select class="chargeCompany" name="type">
								<option value="0">业主</option>
								<option value="1">家属</option>
								<option value="2">租客</option>
							</select>
						</td>
					</tr>
					<tr>
						<td><label>住户姓名</label></td>
						<td vdfld="rname">
							<input type="text" name="residentName" class="guest-num" placeholder="请输入姓名" validate="isnotEmpty" />
							<div class="tip-normal error" vderr="rname" style="display: none;"><span class="errorIcon"></span>请输入姓名</div>
						</td>
					</tr>
					<tr>
						<td><label>身份证号</label></td>
						<td>
							<input type="text" name="idCard" class="guest-num" placeholder="请输入身份证号" />	
							<div class="tip-normal error">请输入18位身份证号码</div>							
						</td>
					</tr>
					<tr>
						<td><label>手机号码</label></td>						
						<td vdfld="vphoneNum">
							<input type="text" id="phoneNum" name="phoneNum" class="guest-num" placeholder="请输入手机号" validate="ajaxMobile" />
							<div vdErr="vphoneNum" class="tip-normal error error-tooltip" style="display: none;">
								<span class="isNull" style="display: none;"><span class="errorIcon"></span>请输入正确的手机号码</span>
								<span class="checkObj" style="display: none;"><span class="errorIcon"></span>此住户已经存在，请重新绑定！</span>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<a href="javascript:void(0);" id="bangdingBnt" title="确定" class="btn bntbgGreen">确 定</a>
							<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>


<!--绑定住户-->
<c:if test="${not empty message}">
	<!-- 提示消息 -->
	<div class="dialog dialog-message" style="display: block;">
		<div class="dialog-container">
			<input type="hidden" id="jiebangId" value="" />
			<div class="text-con-dialog">
				<p class="dialog-text-center" id="message"></p>
			</div>
		</div>
		<a class="icon icon-close dialog-close"></a>
	</div>
	<!-- 提示消息  -->
</c:if>

<!--房屋钥匙信息-->
<div class="dialog dialog-show-key-info" style="overflow:auto;width: 520px;height: 350px">
	<div class="dialog-container " >
		<div class="data-block clear" ></div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" class="btn bntbgBrown dialog-close">确定</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>



