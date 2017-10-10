<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	var jsonArrResult = ${jsonArrResult};
	var jsonArray = [];
	if (jsonArrResult != null && jsonArrResult != '' && jsonArrResult.length > 0) {
		$.each(jsonArrResult, function(index, value) {
			var x = parseInt(value["count"]);
			var y = parseFloat(value["percent"]);
			var arr = {
				"name": value["statusName"],
				"x": x,
				"y": y,
				"url": "/house/list?status=" + value["status"],
				"clickurl": true
			}
			jsonArray.push(arr);
		});
	};

	$('#statistic-chart').highcharts({
		chart: {
			type: 'pie',
			options3d: {
				enabled: true,
				alpha: 45,
				beta: 0
			},
			height:500
		},
		title: {
			text: '房屋状态信息统计'
		},
		subtitle: {
			text: '(点击扇面查看详情)'
		},
		tooltip: {
			pointFormat: '{point.name}: <b>{point.x}</b> 套<br>{series.name}: <b>{point.y:.2f}%</b>'
        },
		credits: {enabled: false},
		exporting: {enabled: false},
		plotOptions: {
			pie: {
				allowPointSelect: true,
				cursor: 'pointer',
				depth: 35,
				dataLabels: {
					enabled: true,
					format: '<b>{point.name}</b>: {point.x} 套<br><b>{series.name}</b>: {point.y:.2f}%'
				},
				showInLegend: true
			}
		},
		series: [
			{
				type: "pie",
			    name: "占比",
			    data: jsonArray
			}
		]
	});

});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">房屋统计</h2>
		<div class="addbtn"></div>
	</div>
	
	<div id="statistic-chart" class="cont_box_wrap" style="min-width:1000px; height: 500px; margin: 0 auto"></div>
	<div class="chartRemarks">总计：${count} 套房屋</div>
</div>