<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function(){
	
});
</script>

	<div class="leftNav">
		<c:if test="${not empty sessionAuthorizedMenus}">
			<c:forEach items="${sessionAuthorizedMenus}" var="fMenu">
				<c:if test="${sessionFirstLevelMenuCode == fMenu.code}">
					<h1><a href="${fMenu.url}">${fMenu.title}</a></h1>
					<div class="leftNav-sub">
						<c:forEach items="${fMenu.childMenuList}" var="sMenu">
							<c:if test="${sessionSecondLevelMenuCode == sMenu.code}">
								<a title="${sMenu.title}" href="${sMenu.url}"  class="cur">${sMenu.title}</a>
							</c:if>
							<c:if test="${sessionSecondLevelMenuCode != sMenu.code}">
								<a title="${sMenu.title}" href="${sMenu.url}">${sMenu.title}</a>
							</c:if>
						</c:forEach>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
   </div>



