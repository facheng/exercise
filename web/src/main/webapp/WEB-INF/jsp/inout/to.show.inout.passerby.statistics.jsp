<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">

$(document).ready(function() {
	tabs(".tab-hd","active",".tab-bd");	
	
	var timeType = ${timeType};
	
	if(timeType == 1){
		$("#monthView").hide();
		$("#weekView").hide();
		$("#yearView").hide(); 
	}
	if(timeType == 6){
		$("#monthView").hide();
		$("#dayView").hide();
		$("#yearView").hide(); 
	}
	if(timeType == 7){
		$("#dayView").hide();
		$("#weekView").hide();
		$("#yearView").hide(); 
	}
	if(timeType == 5){
		$("#monthView").hide();
		$("#weekView").hide();
		$("#dayView").hide();
	}

	
	function tabs(tabTit,on,tabCon){
		$(tabTit).children().click(function(){
			
			var id = $(this).attr("id");
			if(id == "day"){
				timeType = 1;
			}
			if(id == "week"){
				timeType = 6;
			}
			if(id == "month"){
				timeType = 7;
			}
			if(id == "year"){
				timeType = 5;
			}
			
			location.href = "/inout/passerby/statistics?timeType=" + timeType;
		});
	};
});


$(function(){
	setWidth();
}); 
//设置tab容器宽度
function setWidth(){
	var leftNav = $('.statisticalData_wrap').width() - 40;	
	$('.cont_box_wrap').width(leftNav);
} 
//设置tab容器宽度跟随窗口宽度检测调整
$(window).resize(function() { 
	var boxWidth = $('.tab-bd').width() - 40;
	$(".cont_box_wrap").width(boxWidth);
});

</script>

<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">行人出入统计</h2>
	</div>
	
	<div class="detail-box">
		<div class="statisticalData_wrap">
			<div class="tab">
				<ul class="tab-hd">
					<li <c:if test="${timeType == 1}"> class="active" </c:if> id="day">今日出入统计</li>
					<li <c:if test="${timeType == 6}"> class="active" </c:if> id="week">近一周出入统计</li>
					<li <c:if test="${timeType == 7}"> class="active" </c:if> id="month">近30日出入统计</li>			
					<li <c:if test="${timeType == 5}"> class="active" </c:if> id="year">年度出入统计</li>
				</ul>
			</div>
			<!-- 今日访客统计 -->
			<ul class="tab-bd" style="display: list-item;">
				<li class="thisclass" id="dayView">
				<script type="text/javascript">
				$(function () {
						$('#container_day').highcharts({
							chart: {type: 'areaspline'},
							title: {text: '今日出入统计'}, 
							xAxis: {
									categories: ['00:00','01:00','02:00','03:00','04:00','05:00','06:00','07:00','08:00','09:00','10:00','11:00','12:00','13:00','14:00','15:00','16:00','17:00','18:00','19:00','20:00','21:00','22:00','23:00',]
								   },
							yAxis: {title: {text: '访<br>问<br>人<br>数',rotation:0}},
							tooltip: {shared: true,valueSuffix: '次',followPointer:true },
							credits: {enabled: false},
							plotOptions: {areaspline: {fillOpacity: 0.5}},
							series: ${arr}
						});
					});
				</script>
				<div id="container_day" class="cont_box_wrap" style="width:98%; height: 400px; margin: 0 auto"></div>
				</li>
				
				<!-- 近周访客统计 -->
			<li id="weekView" style="display: list-item;">
				<script type="text/javascript">
					$(function () {
							$('#container_wek').highcharts({
								chart: {type: 'areaspline'},
								title: {text: '近一周出入统计'}, 
								xAxis: {categories: ['7天','6天','5天','4天','3天','2天','今天']},
								yAxis: {title: {text: '访<br>问<br>人<br>数',rotation:0}},
								tooltip: {
									shared: true,
									valueSuffix: '次'
								},
								credits: {
									enabled: false
								},
								plotOptions: {
									areaspline: {
										fillOpacity: 0.5
									}
								},
								series: ${arr}
						});
					});
				</script>
				<div id="container_wek" class="cont_box_wrap" style="width:98%; height: 400px; margin: 0 auto"></div>
			</li>
		<!-- 最近30日访客统计 -->
			<li id="monthView" style="display: list-item;">
				<script type="text/javascript">
			$(function () {
					$('#container_month').highcharts({
						chart: {
							type: 'areaspline'
						},
						title: {
							text: '近30日出入统计'
						},
						 
						xAxis: {
							categories: [
								'30天',
								'29天',
								'28天',
								'27天',
								'26天',
								'25天',
								'24天',
								'23天',
								'22天',
								'21天',
								'20天',
								'19天',
								'18天',
								'17天',
								'16天',
								'15天',
								'14天',
								'13天',
								'12天',
								'11天',
								'10天',
								'9天',
								'8天',
								'7天',
								'6天',
								'5天',
								'4天',
								'3天',
								'2天',
								'今天',
							]
						},
						yAxis: {title: {text: '访<br>问<br>人<br>数',rotation:0}},
						tooltip: {
							shared: true,
							valueSuffix: '次'
						},
						credits: {
							enabled: false
						},
						plotOptions: {
							areaspline: {
								fillOpacity: 0.5
							}
						},
						series: ${arr}
					});
				});
			</script>
			<div id="container_month" class="cont_box_wrap" style="width:98%; height: 400px; margin: 0 auto"></div>
			</li>

			<!-- 年度访客统计 -->
			<li id="yearView" style="display: list-item;">
				<script type="text/javascript">
			$(function () {
			$('#container_year').highcharts({
				chart: {
					type: 'areaspline'
				},
				title: {
					text: '年度出入统计'
				},
				 
				xAxis: {
					categories: [
						'一月',
						'二月',
						'三月',
						'四月',
						'五月',
						'六月',
						'七月',
						'八月',
						'九月',
						'十月',
						'十一月',
						'十二月'
					],
				},
				yAxis: {title: {text: '访<br>问<br>人<br>数',rotation:0}},
				tooltip: {shared: true,valueSuffix: '次',followPointer:true},
				credits: {
					enabled: false
				},
				plotOptions: {
					areaspline: {
						fillOpacity: 0.5
					}
				},
				series: ${arr}
			});
		});
		</script>
		<div id="container_year" class="cont_box_wrap" style="width:98%; height: 400px; margin: 0 auto"></div>
			</li>
			</ul>
		</div>
	</div>
</div>

<div class="black-opacity click-disappear"></div>

