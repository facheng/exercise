<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {

});
</script>
<div class="leftNav">
	<div <c:if test='${firstMenu != 1}'>style="display: none;"</c:if>>
		<div class="leftNav-sub">
			<h1><a href="">公司架构</a></h1>
			<a href="/admin/company/branch/list" class="<c:if test='${secondMenu == 1}'>cur</c:if>">组织列表</a>
		</div>
	</div>
	<div <c:if test='${firstMenu != 2}'>style="display: none;"</c:if>>
		<div class="leftNav-sub">
			<h1><a href="">小区信息</a></h1>
			<a href="/admin/unit/list" class="<c:if test='${secondMenu == 1}'>cur</c:if>">小区列表</a>
		</div>
	</div>
	<div <c:if test='${firstMenu != 3}'>style="display: none;"</c:if>>
		<div class="leftNav-sub">
			<h1><a href="">角色维护</a></h1>
			<a href="/admin/role/list" class="<c:if test='${secondMenu == 1}'>cur</c:if>">角色列表</a><br />
		</div>
	</div>
	<div <c:if test='${firstMenu != 4}'>style="display: none;"</c:if>>
		<div class="leftNav-sub">
			<h1><a href="">用户维护</a></h1>
			<a href="/admin/user/list" class="<c:if test='${secondMenu == 1}'>cur</c:if>">用户列表</a>
		</div>
	</div>
	<div <c:if test='${firstMenu != 5}'>style="display: none;"</c:if>>
		<div class="leftNav-sub">
			<h1><a href="">清结算</a></h1>
			<a href="/admin/profit/list" class="<c:if test='${secondMenu == 1}'>cur</c:if>">物业结算</a>
		</div>
	</div>
</div>




