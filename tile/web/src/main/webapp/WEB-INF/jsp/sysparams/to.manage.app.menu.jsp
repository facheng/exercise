<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#form_edit_menu").validate();
	
	$('.edit-menu-btn').on('click', function(){
		var mId = $(this).closest("tr").attr("id");
		var mName = $(this).closest("tr").attr("mname");
		var murl = $(this).closest("tr").attr("murl");
		var mtype = $(this).closest("tr").attr("mtype");
		$("#menuId").val(mId);
		$("#menuName").val(mName);
		$("#linkURL").val(murl);

		if(mtype == 1) {
			$("#spanrelUrl").show();
		} else {
			$("#linkURL").val("temp");
			$("#spanrelUrl").hide();
		}
		
		$('.dialog-edit-menu, .black-opacity').fadeIn();
	});

	$('[js="submitAppMenu"]').click(function(){
		if($('.menu-checkbox:checked').length == 0) {
			alert("您没有选择菜单");
			return false;
		}

		var checkedNum = "";
		$('.menu-checkbox:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var menuIds = checkedNum.substring(0, checkedNum.length - 1);

		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/sys/params/app/menu",
            type: "post",
            data: {"menuIds": menuIds},
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
		<h2 class="titIcon wyIcon">APP菜单管理</h2>
		<div class="addbtn">
			<a href="javaScript:void(0);" js="submitAppMenu" class="btn bntbgBrown" title="菜单修改">菜单修改</a>
		</div>
	</div>
	<div class="" id="caidan">
		<table id="tg1" class="TreeGrid" width="100%" cellspacing="0" cellpadding="0">
		<tbody>
			<tr class="firstTr" height="30">
				<th class="firstTd" align="left" width="20"></th>
				<th class="firstTd" align="left" width="200">名称</th>
				<th class="firstTd" align="left" width="500">URL</th>
				<th class="firstTd" align="left" width="50">操作</th>
			</tr>
			
			<c:if test="${not empty menuList}">
			<c:forEach items="${menuList}" var="fMenu">
				<tr id="${fMenu.menuId}" mname="${fMenu.menuName}" mtype="${fMenu.menuType}" murl="${fMenu.linkURL}">
					<td align="left"><input type="checkbox" class="menu-checkbox" <c:if test="${fMenu.checked == 1}">checked="checked"</c:if>/></td>
					<td align="left" style="text-indent: 0px;">${fMenu.menuName}</td>
					<td>${fMenu.linkURL}</td>
					<td align="left">
						<a class="btn_smalls btn-primary edit-menu-btn" href="javascript:void(0);">编辑</a>
					</td>
				</tr>
				<c:if test="${not empty fMenu.childMenuList}">
				<c:forEach items="${fMenu.childMenuList}" var="sMenu">
					<tr id="${sMenu.menuId}" mname="${sMenu.menuName}" mtype="${sMenu.menuType}" murl="${sMenu.linkURL}">
						<td align="left"><input type="checkbox" class="menu-checkbox" <c:if test="${sMenu.checked == 1}">checked="checked"</c:if>/></td>
						<td align="left" style="text-indent: 20px;">${sMenu.menuName}</td>
						<td>${sMenu.linkURL}</td>
						<td align="left">
							<a class="btn_smalls btn-primary edit-menu-btn" href="javaScript:void(0);">编辑</a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
			</c:forEach>
			</c:if>
		</tbody>
		</table>
	</div>
</div>


<div class="dialog dialog-edit-menu">
    <div class="dialog-container">
		<form action="/sys/params/app/menu/edit" method="post" id="form_edit_menu">
			<input type="hidden" id="menuId" name="menuId" value="" />
			<div align="center">
				<div vdfld="mname" class="user-box-body">
					<span>名称：</span>
					<input class="guest-num" type="text" id="menuName" name="menuName" value="" validate="isnotEmpty" />
					<div class="tip-normal error" vderr="mname" style="display: none;"><span class="errorIcon"></span>名称不能为空</div>
				</div>
				
				<div id="spanrelUrl" vdfld="murl" class="user-box-body">
					<span>URL：</span>
					<input class="guest-num" type="text" id="linkURL" name="linkURL" value="" validate="isnotEmpty" />
					<div class="tip-normal error" vderr="murl" style="display: none;"><span class="errorIcon"></span>URL不能为空</div>
				</div>
			</div>
		</form>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submit_edit_menu" class="btn bntbgBrown">确 定</a>
			<script type="text/javascript">
			$(function(){
				$('[js="submit_edit_menu"]').click(function(){
					$("#form_edit_menu").submit();
				});
			});
			</script>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>