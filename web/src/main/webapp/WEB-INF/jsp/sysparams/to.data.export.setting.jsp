<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
});
function exportFunc(){
	$('.black-opacity ,.click-disappear').fadeIn();
	$('#btn_ExportHouse').attr("href" , "/sys/params/house/export");
	$('.black-opacity ,.click-disappear').fadeOut();
	/*$.ajax({
		url: "/sys/params/house/export",
		type: "get",
		dataType: "json",
		success: function(data){
		}
	});*/
}
</script>

<div class="rightCon">
	<div class="rightNav">
			<h2 class="titIcon wyIcon">数据导出</h2>
		</div>
		<div class="detail-box dataExportShll">
		<div class="dataExportBox">
				<div class="dataExportLeft fangwuData">
					<div class="dataExportTitle">房屋数据导出</div>
					<div class="dataExportbtn">
						<a class="btn_big btnbgViolet" title="导出报表" id="btn_ExportHouse" href="javascript:void(0);" onclick="exportFunc();">导出报表</a>
					</div>
				</div>
		</div>
	<div class="clear"></div>
	</div>
</div>
<div class="black-opacity click-disappear"></div>