<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function(){
	$('#unitSelect').on("change", function(){
		var uId = $(this).val();
		var roleTag = $('#roleSelect');

		$.ajax({
            url: "/ajax/role/list",
            data: {"customerId": "${sessionUserId}", "unitId": uId},
            type: "get",
            async: true,
            dataType: "json",
            success: function(data) {
            	roleTag.text("");
    			roleTag.append('<option value="0"><f:message key="common.select"/></option>');
				for (var i = 0; i < data.length; i++) {
					var html = '<option value="' + data[i].roleId + '">' + data[i].roleName + '</option>';
					roleTag.append(html);
		        }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});

	$('#roleSelect').on("change", function(){
		var rId = $(this).val();

		if(rId == 0) {
			alert("请选择角色！");
			return false;
		}

		$(this).closest("form").submit();
		return false;
	});
});
</script>
		<div style="width:100%; height:102px;"></div>
		<div class="loginHeader">
            <!-- 顶部欢迎开始 -->
            <div class="login-statu">
            	<span>您好，${sessionUser.userName}</span>
            	<form method="post" action="/select/unit/role" autocomplete="off" style="float: left;">
					<select name="unitId" id="unitSelect">
						<c:if test="${not empty sessionUserUnitList}">
							<c:forEach items="${sessionUserUnitList}" var="unit">
								<c:if test="${unit.unitId == sessionUserUnit}">
									<option value="${unit.unitId}" selected="selected">${unit.unitName}</option>
								</c:if>
								<c:if test="${unit.unitId != sessionUserUnit}">
									<option value="${unit.unitId}">${unit.unitName}</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
					<select name="roleId" id="roleSelect">
						<c:if test="${not empty sessionUserRoleList}">
							<c:forEach items="${sessionUserRoleList}" var="role">
								<c:if test="${role.roleId == sessionUserRole}">
									<option value="${role.roleId}" selected="selected">${role.roleName}</option>
								</c:if>
								<c:if test="${role.roleId != sessionUserRole}">
									<option value="${role.roleId}">${role.roleName}</option>
								</c:if>
							</c:forEach>
						</c:if>
					</select>
				</form>
                <a href="/logout" title="安全退出">安全退出 &gt;</a>
            </div>
            
            <!-- 顶部欢迎结束 -->
            <div class="top-nav clear">
             	<div class="logo">
                    <a href="/" title="物业管理平台">物业管理平台</a>
                </div>
                <ul class="nav">
                	<c:if test="${not empty sessionAuthorizedMenus}">
                		<li class="nav-item">
                			<c:forEach items="${sessionAuthorizedMenus}" var="fMenu">
								<c:if test="${sessionFirstLevelMenuCode == fMenu.code}">
									<a class="nav-item-link cur" title="${fMenu.title}" href="${fMenu.url}">${fMenu.title}</a>
								</c:if>
								<c:if test="${sessionFirstLevelMenuCode != fMenu.code}">
									<a class="nav-item-link" title="${fMenu.title}" href="${fMenu.url}">${fMenu.title}</a>
								</c:if>
							</c:forEach>
                		</li>
					</c:if>
				</ul>
             </div>
             
        </div>






