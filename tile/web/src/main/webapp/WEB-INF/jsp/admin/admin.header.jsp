<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {

});
</script>
<div style="width:100%; height:102px;"></div>
<div class="loginHeader">
	<div class="login-statu">
		<span>您好：${sessionUser.userName}</span>&nbsp;&nbsp;<a href="/logout" title="安全退出">安全退出</a>
	</div>
	<div class="top-nav clear">
		<div class="logo">
			<a title="物业管理平台" href="/">物业管理平台</a>
		</div>
		<ul class="nav">
			<li class="nav-item">
				<a bs="head" href="/admin/company/branch/list" title="公司架构" style="text-decoration:none" class="nav-item-link<c:if test='${firstMenu == 1}'> cur</c:if>">公司架构</a>
				<a bs="head" href="/admin/unit/list" title="小区信息" style="text-decoration:none" class="nav-item-link<c:if test='${firstMenu == 2}'> cur</c:if>">小区信息</a>
				<a bs="head" href="/admin/role/list" title="角色维护" style="text-decoration:none" class="nav-item-link<c:if test='${firstMenu == 3}'> cur</c:if>">角色维护</a>
				<a bs="head" href="/admin/user/list" title="用户维护" style="text-decoration:none" class="nav-item-link<c:if test='${firstMenu == 4}'> cur</c:if>">用户维护</a>
				<a bs="head" href="/admin/profit/list" title="清结算" style="text-decoration:none" class="nav-item-link<c:if test='${firstMenu == 5}'> cur</c:if>">清结算</a>
			</li>
		</ul>
	</div>
</div>