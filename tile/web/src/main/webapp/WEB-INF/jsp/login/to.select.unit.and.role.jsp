<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function(){
	//$("#unit_role_form").validate();

	$("#jinru").click(function(){
		var unitId = $("#unitId").val();
		var roleId = $("#roleId").val();
		if(unitId != "" && roleId != ""){
			$('.black-opacity').fadeIn();
			$("#unit_role_form").submit();
		}else{
			$('.dialog-select-unit-role, .black-opacity').fadeIn();
		}
	});
});
//选择小区
function selectUnit(unitId){
	$("#unitId").val(unitId);
	
	$.ajax({
        url: "/ajax/role/list",
        data: {"customerId": "${customerId}", "unitId": unitId},
        type: "get",
        async: true,
        dataType: "json",
        success: function(data) {
        	var html = "";
			for (var i = 0; i < data.length; i++) {
				html += '<li onclick="selectRole('+data[i].roleId+');">' + data[i].roleName + '</li>';
	        }
			$("#roleHtml").html(html);
	    },
	    error: function () {
            alert('接口调用失败！');
        }
	});
	return false;
}
function selectRole(roleId){
	$("#roleId").val(roleId);
}
</script>


	<div class="">
        <div class="role_top_con"></div>
        <div class="main">
                <div class="login-form">
                	<form action="/select/unit/role" method="post" autocomplete="off" id="unit_role_form">
	                	<c:if test="${not empty url}">
							<input type="hidden" name="url" value="${url}" />
						</c:if>
	                    <h1>您好,欢迎进入物业管理平台！</h1>
	                	<div class="rol-sel-con">
	                		<div class="rol-sel-list">
	                			<input type="hidden" id="unitId" name="unitId" />
	                        	<span class="role-result role-no-sel">请选择小区</span>
	                            <div class="role-sel-code">
	                            	<ul>
		                            	<c:if test="${not empty unitList}">
											<c:forEach items="${unitList}" var="unit">
												<li onclick="selectUnit(${unit.unitId});">${unit.unitName}</li>
											</c:forEach>
										</c:if>
	                                </ul>
	                            </div>
	                        </div>
							<div class="rol-sel-list">
								<input type="hidden" id="roleId" name="roleId" />
	                        	<span class="role-result role-no-sel">请选择角色</span>
	                            <div class="role-sel-code">
	                            	<ul id="roleHtml">
	                                </ul>
	                            </div>
	                        </div>
	                        <div class="submit">
	                            <a href="javascript:void(0);"  title="进入" id="jinru" class="loginSubmit">进入</a>
	                        </div>
	                        
	                    </div>
                    </form>
                </div>
        </div>
    </div>
    
<div class="dialog dialog-select-unit-role">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">请选择小区和角色！</p>
        </div>
        <div class="winBtnBox mt20">
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>