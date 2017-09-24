<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});
	
	$('.delete-notice-btn').on('click', function(){
		var hrId = $(this).closest("tr").attr("id");
		$(".dialog-notice-del-alert").attr("params", hrId);
		$('.dialog-notice-del-alert, .black-opacity').fadeIn();
	});
	
	$('.delete-notice-batch').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var frIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-notice-del-alert").attr("params", frIds);
		$('.dialog-notice-del-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteNotice"]').click(function(){
		var noticeIds = $(this).closest(".dialog-notice-del-alert").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/info/notices",
            type: "post",
            data: {"noticeIds" : noticeIds , "_method": "delete"},
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
		<h2 class="titIcon wyIcon">通知管理</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category ctop mt10">
			<a href="/info/notice" title="发布新通知" class="btn bntbgGreen">发布新通知</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0);" title="批量删除" class="btn btnbgViolet delete-notice-batch">批量删除</a>
		</div>
		<div class="category no-border-top">
			<div class="cate-link">
				<span>通知类别：</span>
				<a href="/info/notice/list" title="全部" <c:if test="${empty type}">class='cur'</c:if>>全部</a>
				<a href="/info/notice/list?type=0" title="物业" <c:if test="${type == 0}">class='cur'</c:if>>物业</a>
				<a href="/info/notice/list?type=1" title="居委会" <c:if test="${type == 1}">class='cur'</c:if>>居委会</a>
			</div>
		</div>
	
		<table width="100%" class="list-table mt10" id="data-list-table">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="10%">
				<col width="">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>类别</th>
					<th>发布时间</th>
					<th>标题</th>	
					<th>发送人</th>
					<th>接收人</th>
					<th>已阅人数</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty noticeList}">
				<tbody>
					<c:forEach items="${noticeList}" var="notice">
						<tr id="${notice.id}">
							<td><input type="checkbox" /></td>
							<td>${notice.fromTypeName}</td>
							<td>${notice.createTime}</td>
							<td>${notice.title}</td>
							<td>${notice.createUserName}</td>
							<td>${notice.toTypeName}</td>	
							<td>${notice.readCount}</td>
							<td class="action">
								<a class="btn_smalls areaNumber-info " title="通知详情" href="/info/notice/${notice.id}">通知详情</a>
								<a class="btn_smalls btn-primary" title="已阅记录" href="/info/notice/${notice.id}/read/list">已阅记录</a>
								<a class="btn_smalls bntbgBrown delete-notice-btn" title="删除" href="javascript:void(0);">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<div class="dialog dialog-notice-del-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除通知？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="noticeId" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteNotice" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>