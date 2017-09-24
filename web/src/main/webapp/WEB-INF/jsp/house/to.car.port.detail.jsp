<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#update_car_port_form").validate({submitReset: true});

	$('.update-car-port-btn').on('click', function(){
		$("#pno").val("${map.portNo}");
		$('.dialog-update-car-port-alert, .black-opacity').fadeIn();
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">车位详情</h2>
		<div class="rightNav-sub">
			<a href="/house/carport/list" title="返回" class="cur">返回</a>
			<c:if test="${not empty map and map.bindType == 2}">
				<!-- 出租状态下可以修改车位信息 -->
				<!--
				<a href="javascript:void(0);" class="update-car-port-btn" title="修改车位信息">修改车位信息</a>
				-->
			</c:if>
		</div>
	</div>

	<div class="cont_box_wrap">                    
		<div class="detail-box">
			<div class="owner-tab">
				<c:if test="${empty map}">
					车位不存在
				</c:if>
				<c:if test="${not empty map}">
					<h3 class="h3tit">车位信息</h3>
					<table width="100%" class="inv-table detail-table" style="width:100%;">
						<tbody>
							<tr>
								<th><label>车位号</label></th>
								<td>${map.portNo}</td>
							</tr>
							<tr>
								<th><label>车位状态</label></th>
								<td class="status">${map.bindTypeName}</td>
							</tr>
						</tbody>
					</table>
					<c:if test="${map.bindType == 1}">
						<h3 class="h3tit mt20">业主信息</h3>
						<div class="fcInfoBox">
							<div class="fcInfoCon">
								<table width="100%" class="inv-table detail-table" style="width:100%;">
									<tbody>
										<tr>
											<th><label>业主姓名</label></th>
											<td>${map.residentName}</td>
										</tr>
										<tr>
											<th><label>身份证号</label></th>
											<td>${map.idCard}</td>
										</tr>
										<tr>
											<th><label>手机号码</label></th>
											<td>${map.phoneNum}</td>
										</tr>
										<tr>
											<th><label>出售日期</label></th>
											<td>${map.bindTime}</td>
										</tr>
									</tbody>
								</table>
		                        <div class="fcInfoBtn"></div>
							</div>
							<div class="clear"></div>
						</div>
					</c:if>
					<c:if test="${map.bindType == 2}">
						<h3 class="h3tit mt20">租客信息</h3>
						<div class="fcInfoBox">
							<div class="fcInfoCon">
								<table width="100%" class="inv-table detail-table" style="width:100%;">
									<tbody>
										<tr>
											<th><label>租客姓名</label></th>
											<td>${map.residentName}</td>
										</tr>
										<tr>
											<th><label>身份证号</label></th>
											<td>${map.idCard}</td>
										</tr>
										<tr>
											<th><label>手机号码</label></th>
											<td>${map.phoneNum}</td>
										</tr>
										<tr>
											<th><label>出租日期</label></th>
											<td>${map.bindTime}</td>
										</tr>
									</tbody>
								</table>
		                        <div class="fcInfoBtn"></div>
							</div>
							<div class="clear"></div>
						</div>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
</div>


<div class="black-opacity click-disappear"></div>
<div class="dialog dialog-update-car-port-alert">
	<form action="/house/carport/${id}" method="post" id="update_car_port_form">
		<table width="100%" class="inv-table detail-table">
			<tbody>
				<tr>
					<th><label><span class="color-red">*</span>车位号</label></th>
					<td vdfld="pn">
						<input type="text" class="guest-num" id="pno" name="pno" value="" validate="isnotEmpty">
						<div class="tip-normal error" vderr="pn" style="display: none;"><span class="errorIcon"></span>请输入车位号</div>
					</td>
				</tr>
				<tr>
					<th><label>车位状态</label></th>
					<td>
						<select class="chargeCompany" id="bind_type" name="btype">
							<c:forEach items="${btypesMap}" var="btp">
								<option value="${btp.key}" <c:if test="${btp.key == 2}">selected="selected"</c:if>>${btp.value}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th></th>
					<td>
						<a href="javascript:void(0);" title="确定" class="btn bntbgBrown btn-submit">确 定</a>
						<a href="javascript:void(0);" title="关闭" class="btn bntbgGreen dialog-close">关闭</a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>



