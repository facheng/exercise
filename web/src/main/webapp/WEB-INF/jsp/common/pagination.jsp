<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<c:if test="${page.pageCount > 1}">
<div class="page_navi">
	<div class="bg-white">
		<ul>
			<c:if test="${page.hasPrev == true}">
			<li class="pre1">
				<a href="javascript:void(0);" class="to_url" pn="1">&nbsp;</a>
			</li>
			</c:if>
			<c:if test="${page.hasPrev == false}">
				<li class="pre1 disabled-pre">
					<a href="javascript:void(0);">&nbsp;</a>
				</li>
			</c:if>

			<c:if test="${page.hasPrev == true}">
			<li class="pre">
				<a href="javascript:void(0);" class="to_url" pn="${page.currentPage - 1}">&nbsp;</a>
			</li>
			</c:if>
			<c:if test="${page.hasPrev == false}">
				<li class="pre disabled-pre">
					<a href="javascript:void(0);">&nbsp;</a>
				</li>
			</c:if>

			<c:forEach items="${page.pageNos}" var="pageNo">
			<c:if test="${pageNo == page.currentPage}">
			 	<li class="current">
			 		<a href="javascript:void(0);">${pageNo}</a>
			 	</li>
			 </c:if>
			 <c:if test="${pageNo != page.currentPage}">
			 	<li>
			 		<a href="javascript:void(0);" class="to_url" pn="${pageNo}">${pageNo}</a>
			 	</li>
			 </c:if>
			</c:forEach>

			<c:if test="${page.hasNext == true}">
			<li class="next">
				<a href="javascript:void(0);" class="to_url" pn="${page.currentPage + 1}">&nbsp;</a>
			</li>
			</c:if>
			<c:if test="${page.hasNext == false}">
			<li class="next disabled-next">
				<a href="javascript:void(0);">&nbsp;</a>
			</li>
			</c:if>
			
			<c:if test="${page.hasNext == true}">
			<li class="next1">
				<a href="javascript:void(0);" class="to_url" pn="${page.pageCount}">&nbsp;</a>
			</li>
			</c:if>
			<c:if test="${page.hasNext == false}">
			<li class="next1 disabled-next">
				<a href="javascript:void(0);">&nbsp;</a>
			</li>
			</c:if>
		</ul>
	</div>
</div>
</c:if>


<script type="text/javascript">
$(document).ready(function(){
	$('.to_url').on("click ", function(){
		var pageNo = $(this).attr("pn");
		var form = $(".page_search_form");
		var url = form.attr("action");

		form.attr("action", url + "?pageNo=" + pageNo + "&pageSize=${pageSize}");
		form.submit();
	});
});
</script>