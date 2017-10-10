<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {

	$('.delete-key-device-btn').on('click', function(){
		var keyDeviceId = $(this).closest("tr").attr("id");
		$("#keyDeviceId").val(keyDeviceId);
		$('.dialog-key-device-del-alert, .black-opacity').fadeIn();
	});

	$('[js="deleteKeyDevice"]').click(function(){
		var keyDeviceId = $("#keyDeviceId").val();

		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/sys/params/key/device/" + keyDeviceId,
            type: "post",
            data: {"_method": "delete"},
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
		<h2 class="titIcon wyIcon">小区设备钥匙管理</h2>
		<div class="addbtn">
			<a href="/sys/params/key/device/edit" class="btn bntbgBrown" title="添加设备">添加设备</a>
		</div>
	</div>
      
	<div class="cont_box_wrap full-width">
		<form action="/sys/params/key/device" method="get" id="search_form">
			<div class="category ctop mt10">
				<ul class="searchfm clear">
					<li>
						<span class="zw">钥匙名称：</span>
						<input type="text" name="keyName" class="textinput w-180" value="${searchVo.keyName}" placeholder="请输钥匙名称" />
					</li>
					<li>
						<span class="zw">地址：</span>
						<input type="text" name="addr" class="textinput w-180" value="${searchVo.addr}" placeholder="请输钥匙地址" />
					</li>
					<li>
						<span class="zw">设备类型：</span>
						<select name="deviceType" class="guest-num w-120" style="height:32px;">
							<option selected="selected" value="">全部</option>
							<option <c:if test="${searchVo.deviceType == 0}">selected="selected"</c:if> value="0">小区</option>
							<option <c:if test="${searchVo.deviceType == 1}">selected="selected"</c:if> value="1">楼栋</option>
						</select>
					</li>
					<li>
						<span>&nbsp;</span>
						<a href="javascript:void(0);" title="查询" class="btn bntbgGreen btn-submit">查询</a>
					</li>
				</ul>
			</div>
		</form>
		
		<table width="100%" class="list-table mt10">
			<colgroup>
				<col width="4%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="36%">
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" class="selectAll" /></th>
					<th>钥匙名称</th>
					<th>钥匙类型</th>
					<th>楼栋编号</th>
					<th>地址</th>
					<th>操作</th>
				</tr>
			</thead>
			<c:if test="${not empty mapList}">
				<tbody>
					<c:forEach items="${mapList}" var="map">
						<tr id="${map.id}">
							<td><input type="checkbox" /></td>
							<td>${map.keyName}</td>
							<td>${map.keyTypeName}</td>
							<td>${map.storyNo}</td>
							<td>${map.deviceAddr}</td>
							<td class="action">
								<a class="btn_smalls areaNumber-info" title="详情" href="/sys/params/key/device/${map.id}">详情</a>
								<a class="btn_smalls btn-primary" title="编辑" href="/sys/params/key/device/edit?id=${map.id}">编辑</a>
								<a class="btn_smalls bntbgBrown delete-key-device-btn" title="删除" href="javascript:void(0);">删除</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
	</div>
</div>


<div class="dialog dialog-key-device-del-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除钥匙设备？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="keyDeviceId" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteKeyDevice" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>


