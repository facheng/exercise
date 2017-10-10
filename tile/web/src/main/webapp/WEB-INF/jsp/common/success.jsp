<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<div class="sub-success">
	<div class="success-msg">${msg}</div>
	<button class="btn-u" js="gotoUrl"><span><f:message key="common.ok"/></span></button>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$('[js="gotoUrl"]').click(function(){
		location.href = "${toUrl}";
	});
});
</script>

