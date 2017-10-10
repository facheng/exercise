<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$('[js="searchRole"]').on("click", function(){
		var roleName = $.trim($("#roleName").val());

		var url = "/admin/role/list";
		if(roleName != "") {
			url += "?rname=" + roleName;
		}

		location.href = url;
	});

	$('.delete-role-btn').on('click', function(){
		var roleId = $(this).closest("tr").attr("id");
		$("#roleId").val(roleId);
		$('.dialog-role-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteRole"]').on("click", function(){
		var roleId = $("#roleId").val();
		$('.dialog-role-alert').fadeOut();
		
		$.ajax({
			url: "/admin/role/" + roleId,
			type: "post",
			data: {"_method": "delete"},
			dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
            		$('.black-opacity').fadeOut();
                    alert('该角色不能删除！');
                	return false;
                }
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});


	var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		view: {
			fontCss: setFontCss
		},
		callback:{
			onCheck: onCheck
		}
	};

	$('[js="showAuthedMenuTree"]').on("click", function(){
		var roleId = $(this).closest("tr").attr("id");
		$("#authRoleId").val(roleId);
		$("#authMenuIds").val("");
		$('.black-opacity').fadeIn();
		
		var zNodes = [];
		$.ajax({
			url: "/admin/role/" + roleId + "/menus",
            type: "get",
            dataType: "json",
            success: function(data){
				$.fn.zTree.init($("#treeDemos"), setting, data);
        		$("#treeChoicebox").show();
		    },
		    error: function () {
                alert('接口调用失败！');
                $('.black-opacity').fadeOut();
            }
		});
		return false;
	});

	$('[js="selectTree"]').on("click", function(){
		var roleId = $("#authRoleId").val();
		var menuIds = $("#authMenuIds").val();

		if(roleId == "") {
			return false;
		}

		$.ajax({
			url: "/admin/role/" + roleId + "/menus",
			type: "post",
			data: {"menuIds": menuIds},
			dataType: "text",
			success: function(data){
				if(data == 1) {
					location.href = location.href;
				}
			},
		    error: function () {
                alert('接口调用失败！');
            }
		});
		
		$("#treeChoicebox").hide();
		//$('.dialog, .black-opacity').fadeOut();
	});

	$('[js="closeTree"]').on("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});
});

function setFontCss(treeId, treeNode) {
	
};

function onCheck(e, treeId, treeNode){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemos");
	var nodes = treeObj.getCheckedNodes(true);
	var ids  = "";
	for(var i = 0; i < nodes.length; i++){
		if(nodes[i].valid == 1) {
			ids += nodes[i].id + ",";
		}
	}
	if (ids.length > 0 ){
		ids = ids.substring(0, ids.length - 1);
	}
	$("#authMenuIds").val(ids);
};
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">角色管理</h2>
		<div class="addbtn">
			<a href="/admin/role" class="btn bntbgBrown" title="添加用户信息">添加角色</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		<div class="category more-cate mt10">
			<ul class="searchfm clear">
				<li>
					<span class="zw">角色名称：</span>
					<input type="text" id="roleName" class="textinput" value="${rname}" placeholder="请输入角色名称">
				</li>
				<li>
					<span>&nbsp;</span>
					<a href="javascript:void(0);" js="searchRole" title="查询" class="btn bntbgGreen">查询</a>
				</li>
			</ul>
		</div>
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="3%">
				<col width="10%">
				<col width="15%">
				<col width="72%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>序号</th>
					<th>角色名称</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty roleList}">
				<tbody>
					<c:forEach items="${roleList}" var="role" varStatus="sta">
						<tr id="${role.id}">
							<td><input type="checkbox" /></td>
							<td>${sta.count}</td>
							<td>${role.name}</td>
							<td class="action">
								<a class="btn_smalls btn-success" title="权限" href="javascript:void(0);" js="showAuthedMenuTree">权限</a>
								<a class="btn_smalls btn-primary" title="编辑" href="/admin/role?id=${role.id}">编辑</a>
								<c:if test="${role.canDelete == 1}">
									<a class="btn_smalls btn-warning delete-role-btn" title="删除" href="javascript:void(0);">删除</a>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty roleList}">
				<tr>
					<td colspan="4"><h3 class="clearfix mt10" style="text-align:center;"> 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>



<div class="dialog dialog-role-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除角色？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="roleId" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteRole" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>


<div class="dialog dialog-choose-obj" id="treeChoicebox" style="display: none; width: 450px;">
    <div class="dialog-container">
		<div class="importInfoTitle"><span>角色权限分配</span></div>
    	<div class="choose-obj-dialog-con">
        	<div class="zTreeDemoBackground left">
				<ul id="treeDemos" class="ztree"></ul>
			</div>
        </div>
        <div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="selectTree" class="btn bntbgGreen">确 定</a>
			<a href="javascript:void(0);" title="关闭" js="closeTree" class="btn bntbgGreen dialog-close">关 闭</a>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>


<input type="hidden" id="authRoleId" value=""/>
<input type="hidden" id="authMenuIds" value=""/>