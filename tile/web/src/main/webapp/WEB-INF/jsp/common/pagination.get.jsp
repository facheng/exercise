<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<c:if test="${page.pageCount > 1}">
<div class="clear mt10">
	<ul class="pagination">
		<c:if test="${page.hasPrev == true}">
			<li><a href="javascript:void(0);" class="to_url" pn="1">&lt;&lt;首页</a></li>
		</c:if>

		<c:if test="${page.hasPrev == true}">
			<li><a href="javascript:void(0);" class="to_url" pn="${page.currentPage - 1}">上一页</a></li>
		</c:if>

		<c:forEach items="${page.pageNos}" var="pageNo">
			<c:if test="${pageNo == page.currentPage}">
				<li><a href="javascript:void(0);" class="cur">${pageNo}</a></li>
			 </c:if>
			 <c:if test="${pageNo != page.currentPage}">
				<li><a href="javascript:void(0);" class="to_url" pn="${pageNo}">${pageNo}</a></li>
			 </c:if>
		</c:forEach>

		<c:if test="${page.hasNext == true}">
			<li><a href="javascript:void(0);" class="to_url" pn="${page.currentPage + 1}">下一页</a></li>
		</c:if>
		
		<c:if test="${page.hasNext == true}">
			<li><a href="javascript:void(0);" class="to_url" pn="${page.pageCount}">尾页&gt;&gt;</a></li>
		</c:if>
	</ul>
</div>
</c:if>


<script type="text/javascript">
$(document).ready(function(){
	$(".to_url").on("click ", function(){
		var url = "${page.url}";
		var pageNo = $(this).attr("pn");

		/*检查url是否以问号结尾*/
		if(/\?$/.test(url)) {
			location.href = url + "pageNo=" + pageNo + "&pageSize=${page.pageSize}";
		} else {
			location.href = url + "&pageNo=" + pageNo + "&pageSize=${page.pageSize}";
		}
	});
});
</script>