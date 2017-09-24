<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	//提示是否删除常用语
	$('.btn-del-commonWords-alert').on('click', function(){
		var hrId = $(this).closest("tr").attr("cwId");
		$(".dialog-commonWords-del-alert").attr("params", hrId);
		$('.dialog-commonWords-del-alert, .black-opacity').fadeIn();
	});
	
	$('.delete-commonWords-batch').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("cwId") + ',';
			return(checkedNum);
		});
		var frIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-commonWords-del-alert").attr("params", frIds);
		$('.dialog-commonWords-del-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteCommonWords"]').click(function(){
		var carIds = $(this).closest(".dialog-commonWords-del-alert").attr("params");
		console.info(carIds);
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/sys/params/common/words",
            type: "post",
            data: {"ids": carIds , "_method": "delete"},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                    alert('接口调用失败！');
                	return false;
                }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});
	
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">常用语设置</h2>
		 <div class="addbtn">
               <a class="btn bntbgBrown modify-focus-btn" title="添加常用语" href="/sys/params/common/words/new">添加常用语</a>
           </div>
	</div>

	<div class="cont_box_wrap full-width">
		<form action="/sys/params/common/words" method="get" id="search_form">
			<div class="category ctop mt10">
			</div> 
			<div class="category no-border-top searchTipsBtnBox">
				<ul class="searchfm clearfix">
					<li>
					<span class="zw">常用语类型：</span>
					<select id="type" class="guest-num" name="type" style="height:32px;">
						<option selected="selected" value="0">全部</option>
						<option <c:if test="${searchVo.type == 1}">selected="selected"</c:if> value="1">通知</option>
						<option <c:if test="${searchVo.type == 2}">selected="selected"</c:if> value="2">快递</option>
						<option <c:if test="${searchVo.type == 3}">selected="selected"</c:if> value="3">报修</option>
					</select>
					</li>
					<li>
						<span class="zw">创建人：</span>
						<input type="text" id="createrName" style="width:186px"  name="createrName" class="textinput" value="${searchVo.createrName}" placeholder="请输入创建人姓名" />
					</li>
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a></li> 
					<li><span>&nbsp;</span><a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-commonWords-batch">批量删除</a></li> 
				</ul>
			</div>
		</form>

		<table width="100%" class="list-table mt10" id="data-list-table">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="35%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>类型</th>
					<th>内容</th>
					<th>创建人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="stat">
					<tr  cwId="${result.commonWordsId}">
						<td><input type="checkbox" /></td>
						<td>
							<c:if test="${result.type == 1}">通知</c:if>
							<c:if test="${result.type == 2}">快递</c:if>
							<c:if test="${result.type == 3}">报修</c:if>
						</td>
						<td>${result.words}</td>
						<td>${result.createrName}</td>
						<td class="action">
							<a class="btn_smalls areaNumber-info " title="详情" href="/sys/params/common/words/${result.commonWordsId}/detail">详情</a>
							<a class="btn_smalls btn-primary btn_commonWords_edit" id="btn_commonWords_edit" title="编辑" href="/sys/params/common/words/new?id=${result.commonWordsId}">编辑</a>
							<a class="btn_smalls bntbgBrown btn-del-commonWords-alert" title="删除" href="javascript:void(0);">删除</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>
<!-- 删除常用语弹层提醒 -->
<div class="dialog dialog-commonWords-del-alert" params="">
	<div class="dialog-container">
		<div class="text-con-dialog">
			<p class="dialog-text-center">确定删除常用语？</p>
		</div>
		<div class="winBtnBox mt20">
			<input type="hidden" id="car_id" value=""/>
			<a href="javascript:void(0);" title="确定" js="deleteCommonWords" class="btn bntbgBrown btn-del-commonWords-confirm">确 定</a>
			<a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>

<div class="black-opacity click-disappear"></div>


