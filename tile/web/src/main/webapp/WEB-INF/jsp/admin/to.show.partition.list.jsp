<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	
	$(document).ready(function() {
		$('[js="findPartitionByName"]').on("click", function(){
			var aliasName = $.trim($("#serachAliasName").val());
			var url = "/admin/partition/list?unitId=${unitId}";

			if(aliasName != "") {
				url += "&serachAliasName=" + aliasName;
			}
			location.href = url;
		});
		
		
		$(".delete-unitPartition-btn").on("click", function(){
			var partitionId = $(this).closest("tr").attr("id");
			$("#partitionId").val(partitionId);
			$('.dialog-confirm-alert, .black-opacity').fadeIn();
		});

		$('[js="delete"]').on("click", function(){
			var partitionId = $("#partitionId").val();
			$('.dialog-confirm-alert').fadeOut();
			
			$.ajax({
				url: "/admin/partition/del?id=" + partitionId +"&unitId= ${unitId}",
				type: "post",
	            success: function(data){
	                if(data['flag'] == "true" || data['flag'] == true){
						$('.black-opacity').fadeOut();
						window.location.href="/admin/partition/list?unitId=${unitId}";
					}else{
						$('.black-opacity').fadeOut();
	                    alert('接口调用失败！');
	                	return false;
					}
			    },
			    error: function () {
	        		$('.black-opacity').fadeOut();
	                alert('接口调用失败！');
	            }
			});
			return false;
		});
	});
</script>

<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">期数管理</h2>
		<div class="rightNav-sub">
			<a href="/admin/unit/list" title="返回" class="cur">返回</a>
		</div>
		<div class="addbtn">
		</div>
	</div>

	<div class="cont_box_wrap">
	
		<div class="category more-cate mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">期数别名：</span>
					<input type="text" class="textinput" id="serachAliasName" name="serachAliasName" placeholder="请输入别名" value="${serachAliasName}">
				</li>
				<li>
					<span>&nbsp;</span>
					<a href="javascript:void(0);" js="findPartitionByName" title="查询" class="btn bntbgGreen" id="serachPartition">查询</a>
				</li>
			</ul>
		</div>
	
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="3%">
				<col width="5%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="25%">
				<col width="22%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>小区名称</th>
					<th>期数</th>
					<th>别名</th>
					<th>备注</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty unitPartitions}">
				<tbody>
					<c:forEach var="unitPartition" items="${unitPartitions}" varStatus="p">
						 <tr id="${unitPartition.id}">
							<td><input type="checkbox" /></td>
						    <td>${p.count}</td>
						    <td>${unitPartition.unitName}</td>
						    <td>${unitPartition.partitionName}</td>
						    <td>${unitPartition.aliasName}</td>
						    <td>${unitPartition.remark}</td>
			                <td>
			                	<a class="btn_smalls bntbgGreen" title="详情" href="/admin/partition/info?id=${unitPartition.id}">详情</a>
		                		<a class="btn_smalls btn-primary" title="编辑" href="/admin/partition/init?id=${unitPartition.id}&unitId=${unitPartition.unitId}" >编辑</a>
								<a class="btn_smalls btn-warning delete-unitPartition-btn" onclick="javascript:void(0);" title="删除">删除</a>
			                </td>
						 </tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty unitPartitions}">
				<tr>
					<td colspan="7"><h3 class="clearfix mt10" style="text-align:center;" >该小区没有分期！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<div class="dialog dialog-confirm-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除该期数？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="partitionId" value=""/>
            <a href="javascript:void(0);" title="确定" js="delete" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
