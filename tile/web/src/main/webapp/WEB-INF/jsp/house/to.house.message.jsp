<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$('[js="unbind"]').on("click", function(){
		var hrId = $(this).closest(".fcInfoCon").find(".hidden-id").val();
		$("#houseResidentId").val(hrId);
		$('.dialog-unbind-alert, .black-opacity').fadeIn();
	});

	$('[js="submitUnbind"]').on("click", function(){
		var houseId = $("#houseId").val();
		var hrId = $("#houseResidentId").val();
		$.ajax({
			url: "/house/resident/unbind",
			type: "post",
			data: {"houseResidentId": hrId},
			dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = "/house/message?houseId=" + houseId;
                } else {
                	return false;
                }
		    }
		});
		return false;
	});

	$('[js="modifyBind"]').on("click", function(){
		var houseId = $("#houseId").val();
		
		var houseResidentId = $(this).closest(".fcInfoCon").find(".hidden-id").val();
		var type = $(this).closest(".fcInfoCon").find(".hidden-type").val();
		var userName = $(this).closest(".fcInfoCon").find(".hidden-user-name").val();
		var idCard = $(this).closest(".fcInfoCon").find(".hidden-idcard").val();
		var phoneNum = $(this).closest(".fcInfoCon").find(".hidden-phone").val();

		var t = $("#update_resident_form").find('[name=type]')[0];
		if(type == 0) {
			t.innerHTML = '<option selected="selected" value="0">业主</option><option value="1">家属</option><option value="2">租客</option>';
		} else if(type == 1) {
			t.innerHTML = '<option value="0">业主</option><option selected="selected" value="1">家属</option><option value="2">租客</option>';
		} else if(type == 2) {
			t.innerHTML = '<option value="0">业主</option><option value="1">家属</option><option selected="selected" value="2">租客</option>';
		}

		$("#update_resident_form").find('[name=residentName]').val(userName);
		$("#update_resident_form").find('[name=idCard]').val(idCard);
		$("#update_resident_form").find('[name=phoneNum]').val(phoneNum);
		
		$("#update_resident_form").attr("action", "/house/resident/bind/modify/" + houseResidentId);
		$("#phoneNum").attr("vdOpt", "url:'/house/" + houseId + "/phone/validate?hrId=" + houseResidentId + "',key:'phoneNum'");
		$("#update_resident_form").validate({validateAjax: true});
		$('.dialog-modify-bind-resident, .black-opacity').fadeIn();
	});

	$('[js="submitModify"]').on("click", function(){
		$("#update_resident_form").submit();
	});
});
</script>


<div class="rightCon">
                	
                	<div class="rightNav">
                        <h2 class="titIcon wyIcon">房屋管理</h2>
                        <div class="rightNav-sub">
                            <a href="/house/list" title="返回" class="cur">返回</a>
                        </div>                        
                    </div>
                    
                    <div class="cont_box_wrap">                    
                    	<div class="detail-box">
                            <div class="owner-tab">
                                <h3 class="h3tit">房屋信息</h3>
                               	<input type="hidden" id="houseId" value="${house.id}" />
                                <table width="100%" class="inv-table detail-table" style="width:100%;">
                                    <tbody>
                                        <tr>
                                            <th><label>房屋信息</label></th>
                                            <td>${house.roomNum}</td>
                                        </tr>
                                        <tr>
                                            <th><label>产证号码</label></th>
                                            <td>${house.proNo}</td>
                                        </tr>					
                                        <tr>
                                            <th><label>房屋面积</label></th>
                                            <td>${house.area}平方米</td>
                                        </tr>
                                        <tr>
                                            <th><label>房屋状态</label></th>
                                            <td class="status">
                                            	<c:if test="${house.status=='1'}">
									                自住
									                </c:if>
									                <c:if test="${house.status=='2'}">
									               空置
									                </c:if>
									                <c:if test="${house.status=='3'}">
									                待售
									                </c:if>
									                <c:if test="${house.status=='4'}">
									                出租
									                </c:if>
									                <c:if test="${house.status=='5'}">
									                待租
									                </c:if>
                                            </td>
                                        </tr>											
                                    </tbody>
                                </table>
                                <h3 class="h3tit mt20">业主信息</h3>
                                <div class="fcInfoBox">
                                	<c:if test="${not empty residentList}">
	                                	<c:forEach var="resident" items="${residentList}" varStatus="status">
	                                		<c:if test="${resident.TYPE == 0}">
	                                			<div class="fcInfoCon">
	                                				<input type="hidden" class="hidden-id" value="${resident.ID}" />
	                                				<input type="hidden" class="hidden-type" value="${resident.TYPE}" />
	                                				<input type="hidden" class="hidden-user-name" value="${resident.USER_NAME}" />
	                                				<input type="hidden" class="hidden-idcard" value="${resident.ID_CARD}" />
	                                				<input type="hidden" class="hidden-phone" value="${resident.PHONE_NUM}" />
			                                        <table width="100%" class="inv-table detail-table" style="width:100%;">
			                                            <tbody>					
			                                                <tr>
			                                                    <th><label>业主姓名</label></th>
			                                                    <td>${resident.USER_NAME}</td>
			                                                </tr>
			                                                <tr>
			                                                    <th><label>身份证号</label></th>
			                                                    <td>${resident.ID_CARD}</td>
			                                                </tr>					
			                                                <tr>
			                                                    <th><label>手机号码</label></th>						
			                                                    <td>${resident.PHONE_NUM}</td>					
			                                                </tr>								
			                                            </tbody>					
			                                        </table>
			                                        <div class="fcInfoBtn">
			                                        	<a href="/inout/passerby?residentId=${resident.residentId}&rname=${resident.USER_NAME}&timeFlag=2&timeType=4" title="查看租客进出入记录">查看${resident.USER_NAME}出入记录</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="unbind" title="解绑">解绑</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="modifyBind" title="修改">修改</a>
			                                        </div>
		                                    	</div>
	                                		</c:if>
	                                	</c:forEach>
                                	</c:if>
                                    
                                	<div class="clear"></div>
                                </div>
                                <h3 class="h3tit mt20">家属信息</h3>
                                <div class="fcInfoBox">
                                    <c:if test="${not empty residentList}">
	                                	<c:forEach var="resident" items="${residentList}" varStatus="status">
	                                		<c:if test="${resident.TYPE == 1}">
	                                			<div class="fcInfoCon">
	                                				<input type="hidden" class="hidden-id" value="${resident.ID}" />
	                                				<input type="hidden" class="hidden-type" value="${resident.TYPE}" />
	                                				<input type="hidden" class="hidden-user-name" value="${resident.USER_NAME}" />
	                                				<input type="hidden" class="hidden-idcard" value="${resident.ID_CARD}" />
	                                				<input type="hidden" class="hidden-phone" value="${resident.PHONE_NUM}" />
			                                        <table width="100%" class="inv-table detail-table" style="width:100%;">
			                                            <tbody>					
			                                                <tr>
			                                                    <th><label>家属姓名</label></th>
			                                                    <td>${resident.USER_NAME}</td>
			                                                </tr>
			                                                <tr>
			                                                    <th><label>身份证号</label></th>
			                                                    <td>${resident.ID_CARD}</td>
			                                                </tr>					
			                                                <tr>
			                                                    <th><label>手机号码</label></th>						
			                                                    <td>${resident.PHONE_NUM}</td>					
			                                                </tr>								
			                                            </tbody>					
			                                        </table>
			                                        <div class="fcInfoBtn">
			                                        	<a href="/inout/passerby?residentId=${resident.residentId}&rname=${resident.USER_NAME}&timeFlag=2&timeType=4" title="查看租客进出入记录">查看${resident.USER_NAME}出入记录</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="unbind"  title="解绑">解绑</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="modifyBind" title="修改">修改</a>
			                                        </div>
		                                    	</div>
	                                		</c:if>
	                                	</c:forEach>
                                	</c:if>
                                    <div class="clear"></div>
                                </div>
                                <h3 class="h3tit mt20">租客信息</h3>
                                <div class="fcInfoBox">
                                    <c:if test="${not empty residentList}">
	                                	<c:forEach var="resident" items="${residentList}" varStatus="status">
	                                		<c:if test="${resident.TYPE == 2}">
	                                			<div class="fcInfoCon">
	                                				<input type="hidden" class="hidden-id" value="${resident.ID}" />
	                                				<input type="hidden" class="hidden-type" value="${resident.TYPE}" />
	                                				<input type="hidden" class="hidden-user-name" value="${resident.USER_NAME}" />
	                                				<input type="hidden" class="hidden-idcard" value="${resident.ID_CARD}" />
	                                				<input type="hidden" class="hidden-phone" value="${resident.PHONE_NUM}" />
			                                        <table width="100%" class="inv-table detail-table" style="width:100%;">
			                                            <tbody>					
			                                                <tr>
			                                                    <th><label>租客姓名</label></th>
			                                                    <td>${resident.USER_NAME}</td>
			                                                </tr>
			                                                <tr>
			                                                    <th><label>身份证号</label></th>
			                                                    <td>${resident.ID_CARD}</td>
			                                                </tr>					
			                                                <tr>
			                                                    <th><label>手机号码</label></th>						
			                                                    <td>${resident.PHONE_NUM}</td>					
			                                                </tr>								
			                                            </tbody>					
			                                        </table>
			                                        <div class="fcInfoBtn">
			                                        	<a href="/inout/passerby?residentId=${resident.residentId}&rname=${resident.USER_NAME}&timeFlag=2&timeType=4" title="查看租客出入记录">查看${resident.USER_NAME}出入记录</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="unbind" title="解绑">解绑</a>
			                                        	&nbsp;&nbsp;&nbsp;&nbsp;
			                                        	<a href="javascript:void(0);" js="modifyBind" title="修改">修改</a>
			                                        </div>
		                                    	</div>
	                                		</c:if>
	                                	</c:forEach>
                                	</c:if>
                                    <div class="clear"></div>
                                </div>
                            </div>			
                        </div>
                    </div>
                    
                </div>
                
                
<div class="dialog dialog-unbind-alert">
    <div class="dialog-container">
    	<input type="hidden" id="houseResidentId" value="" />
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定解除此住户权限？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" js="submitUnbind" title="确定"  class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>



<!--修改房屋住户绑定-->
<div class="dialog dialog-modify-bind-resident">
	<div class="dialog-container inv-form">
		<form method="post" autocomplete="off" id="update_resident_form">
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
							<a href="javascript:void(0);" js="submitModify" title="确定" class="btn bntbgGreen">确 定</a>
							<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>


