<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$('[js="findUnitByName"]').on("click", function(){
			var unitName = $.trim($("#serachUnitName").val());
			var url = "/admin/unit/list";
			if(unitName != null && unitName != "") {
				url += "?serachUnitName=" + unitName;
			}
			location.href = url;
		});
		
		$(".delete-unit-btn").on("click", function(){
			var unitId = $(this).closest("tr").attr("id");
			$("#unitId").val(unitId);
			$('.dialog-confirm-alert, .black-opacity').fadeIn();
		});

		$('[js="delete"]').on("click", function(){
			var unitId = $("#unitId").val();
			$('.dialog-confirm-alert').fadeOut();
			
			$.ajax({
				type: "post", 
				url: "/admin/unit/del", 
				data: {"id":unitId},
	            success: function(data){
	                if(data['flag'] == "true" || data['flag'] == true){
						$('.black-opacity').fadeOut();
						window.location.href="/admin/unit/list";
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
		<h2 class="titIcon wyIcon">小区管理</h2>
		<div class="addbtn">
			<a href="/admin/unit/edit/init" class="btn bntbgBrown" title="添加小区信息">添加小区</a>
		</div>
	</div>

	<div class="cont_box_wrap">
	
		<div class="category more-cate mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">小区名称：</span>
					<input type="text" class="textinput" id="serachUnitName" name="serachUnitName" placeholder="请输入小区名称" value="${serachUnitchName}">
				</li>
				<li>
				<span>&nbsp;</span>
				<a href="javascript:void(0);" js="findUnitByName" title="查询" class="btn bntbgGreen" id="unitSerach">查询</a>
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
				<col width="15%">
				<col width="32%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>小区名称</th>
					<th>组织架构</th>
					<th>物业公司</th>
					<th>区/县</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty units}">
				<tbody>
					<c:forEach var="unit" items="${units}" varStatus="p">
						 <tr id="${unit.id}">
							<td><input type="checkbox" /></td>
						    <td>${p.count}</td>
						    <td>${unit.unitName}</td>
						    <td>${unit.branchName}</td>
			                <td>${unit.companyName}</td>
						    <td>${unit.districtName}</td>
			                <td>
			                	<a class="btn_smalls btn-success" title="添加期数" href="/admin/partition/init?unitId=${unit.id}">添加期数</a>
			                	<a class="btn_smalls bntbgGreen" title="查看期数" href="/admin/partition/list?unitId=${unit.id}">查看期数</a>
		                		<a class="btn_smalls btn-primary" title="编辑小区" href="/admin/unit/edit/init?id=${unit.id}" >编辑小区</a>
								<a class="btn_smalls btn-warning delete-unit-btn" onclick="javascript:void(0);" title="删除">删除</a>
			                </td>
						 </tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty units}">
				<tr>
					<td colspan="7"><h3 class="clearfix mt10" style="text-align:center;" > 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>

<div class="dialog dialog-confirm-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除该小区？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="unitId" value=""/>
            <a href="javascript:void(0);" title="确定" js="delete" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
