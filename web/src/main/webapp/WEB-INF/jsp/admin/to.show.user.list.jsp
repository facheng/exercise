<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$('[js="search"]').on("click", function(){
		var userName = $.trim($("#searchUserName").val());
		if(userName != null && userName != "") {
			location.href = "/admin/user/list?userName=" + userName;
		} else {
			location.href = "/admin/user/list";
		}
	});

	$(".delete-customer-btn").on("click", function(){
		var customerId = $(this).closest("tr").attr("id");
		$("#customerId").val(customerId);
		$('.dialog-confirm-alert, .black-opacity').fadeIn();
	});

	$('[js="delete"]').on("click", function(){
		var customerId = $("#customerId").val();
		$('.dialog-confirm-alert').fadeOut();
		
		$.ajax({
			url: "/admin/user/" + customerId,
			type: "post",
			data: {"_method": "delete"},
			dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
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

	$(".select-role-unit-dialog").on("click", function(){
		var customerId = $(this).closest("tr").attr("id");
		var branchId = $(this).closest("tr").attr("branchId");
		$("#customer_id").val(customerId);

		$('.black-opacity').fadeIn();
		$.ajax({
			url: "/ajax/admin/company/${companyId}/roles",
			type: "get",
			dataType: "json",
			async: false,
			success: function(data){
				var html = "<option value='0'>请选择角色</option>";
				if(data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
			        }
				}
				$("#role_slt").html(html);
			}
		});
		$.ajax({
			url: "/ajax/admin/branch/" + branchId + "/units",
			type: "get",
			dataType: "json",
			async: false,
			success: function(data){
				var html = "<option value='0'>请选择小区</option>";
				if(data != null && data.length > 0) {
					for (var i = 0; i < data.length; i++) {
						html += "<option value='" + data[i].id + "'>" + data[i].name + "</option>";
			        }
				}
				$("#unit_slt").html(html);
			}
		});
		
		$('.dialog-select-role-unit').fadeIn();
	});

	$('[js="select"]').on("click", function(){
		var customerId = $("#customer_id").val();
		var roleId = $("#role_slt").val();
		var unitId = $("#unit_slt").val();

		if(customerId == "" || customerId <= 0) {
			return false;
		}
		if(roleId == "" || roleId <= 0) {
			$(".dialog-role-alert").fadeIn();
			return false;
		}

		$('.dialog-select-role-unit').fadeOut();
		$.ajax({
			url: "/admin/user/" + customerId + "/role/" + roleId + "/unit/" + unitId,
			type: "post",
			dataType: "text",
			success: function(){
				location.href = location.href;
			}
		});
		return false;
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">用户管理</h2>
		<div class="addbtn"></div>
		<div class="addbtn">
			<a href="/admin/user" class="btn bntbgBrown" title="添加用户">添加用户</a>
	    </div>
	</div>

	<div class="cont_box_wrap">
		<div class="category more-cate mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">用户名：</span>
					<input type="text" class="textinput" id="searchUserName" placeholder="请输用户名" value="${userName}" />
				</li>
				<li>
					<span>&nbsp;</span>
					<a href="javascript:void(0);" js="search" title="查询" class="btn bntbgGreen">查询</a>
				</li>
			</ul>
		</div>
	
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="3%">
				<col width="5%">
				<col width="10%">
				<col width="17%">
				<col width="15%">
				<col width="9%">
				<col width="14%">
				<col width="27%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>用户名</th>
					<th>身份证</th>
					<th>组织名称</th>
					<th>创建人</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty customerList}">
				<tbody>
					<c:forEach var="customer" items="${customerList}" varStatus="p">
						 <tr id="${customer.id}" branchId="${customer.branchId}">
							<td><input type="checkbox" /></td>
						    <td>${p.count}</td>
						    <td>${customer.userName}</td>
						    <td>${customer.idCard}</td>
						    <td>${customer.branchName}</td>
			                <td>${customer.creator}</td>
						    <td>${customer.createTime}</td>
			                <td>
			                	<a class="btn_smalls btn-success select-role-unit-dialog" title="详情" href="javascript:void(0);">分配角色+小区</a>
		                		<a class="btn_smalls bntbgBrown" title="详情" href="/admin/user/${customer.id}" >详情</a>
		                		<a class="btn_smalls btn-primary" title="编辑" href="/admin/user?id=${customer.id}" >编辑</a>
								<a class="btn_smalls btn-warning delete-customer-btn" onclick="javascript:void(0);" title="删除">删除</a>
			                </td>
						 </tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty customerList}">
				<tr>
					<td colspan="8"><h3 class="clearfix mt10" style="text-align:center;"> 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>




<div class="dialog dialog-confirm-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除用户？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="customerId" value=""/>
            <a href="javascript:void(0);" title="确定" js="delete" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>


<div class="dialog dialog-select-role-unit">
	<input type="hidden" id="customer_id" value=""/>
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">请选择角色和小区：</p>
        	<br/>
        	<p class="dialog-text-center">
	        	<select id="role_slt"></select>
	        	&nbsp;&nbsp;&nbsp;&nbsp;
	        	<select id="unit_slt"></select>
        	</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="customerId" value=""/>
            <a href="javascript:void(0);" title="确定" js="select" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>


<div class="dialog dialog-role-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">请选择角色</p>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
