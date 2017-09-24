<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_key_device").validate({submitReset: true});

	$('#deviceType').live("change", function(){
		var dtype = $(this).val();

		if(dtype == 1) {
			$("#story_id").attr("validate", "isIntLargerThanZero");
			$("#story_tr").show();
		} else {
			$("#story_id").removeAttr("validate");
			$("#story_tr").hide();
		}
	});


	var setting = {
		check: {
			enable: false
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
			onClick: onClick
		}
	};

	$('[js="showStoryTree"]').live("click", function(){
		var zNodes = [];
		$.ajax({
			url: "/ajax/unit/${unitId}/stories",
            type: "get",
            dataType: "json",
            success: function(data){
				$.fn.zTree.init($("#treeDemos"), setting, data);
        		$("#treeChoicebox").show();
        		$('.black-opacity').fadeIn();
		    },
		    error: function () {
                alert('接口调用失败！');
            }
		});
		return false;
	});

	$('[js="selectStoryTree"]').live("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});

	$('[js="closeStoryTree"]').live("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});
});

function setFontCss(treeId, treeNode) {
	
};

function onClick(e, treeId, treeNode){
	if(treeNode.valid == 1) {
		$("#story_id").val(treeNode.id);
		$("#story_name").val(treeNode.name);
	}
}
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">添加小区设备钥匙</h2>
		<div class="rightNav-sub">
			<a href="/sys/params/key/device" title="返回" class="cur">返回</a>
		</div>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top ">
			<form method="post" action="/sys/params/key/device/edit" autocomplete="off" id="edit_key_device" >
				<c:if test="${not empty keyDeviceId}">
					<input type="hidden" name="id" value="${keyDeviceId}"/>
				</c:if>
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="80px">
							<th width="150"><span class="color-red">*</span>钥匙名称：</th>
							<td>
								<div vdfld="keyn" class="user-box-body form-relative-input">
									<input type="text" name="keyName" value="${map.keyName}" validate="isnotEmpty" class="form-control" placeholder="" />
									<div class="tip-normal error" vderr="keyn" style="display: none;"><span class="errorIcon"></span>钥匙名称不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="50px">
							<th><span class="color-red">*</span>钥匙类型：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select name="keyType" class="form-control">
										<option value="0" <c:if test="${map.keyType == 0}">selected="selected"</c:if>>人行</option>
										<option value="1" <c:if test="${map.keyType == 1}">selected="selected"</c:if>>车行</option>
									</select>
								</div>
							</td>
						</tr>
						<!--
						<tr height="80px">
							<th>设备名称：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<input type="text" name="deviceName" value="${map.deviceName}" class="form-control" placeholder="" />
								</div>
							</td>
						</tr>
						-->
						<tr height="50px">
							<th><span class="color-red">*</span>设备类型：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select id="deviceType" name="deviceType" class="form-control">
										<option value="0" <c:if test="${map.deviceType == 0}">selected="selected"</c:if>>小区</option>
										<option value="1" <c:if test="${map.deviceType == 1}">selected="selected"</c:if>>楼栋</option>
									</select>
								</div>
							</td>
						</tr>
						<tr height="80px" id="story_tr" <c:if test="${empty map.deviceType or map.deviceType == 0}">style="display: none;"</c:if>>
							<th><span class="color-red">*</span>楼栋：</th>
							<td>
								<div vdfld="dstory" class="user-box-body form-relative-input">
									<input type="text" id="story_name" value="${map.storyName}" class="form-control" placeholder="选择楼栋" disabled="disabled" />
									<span class="msgAddBtn" js="showStoryTree"></span>
									<c:if test="${empty map.storyId}">
										<input type="hidden" id="story_id" name="storyId" value="0" <c:if test="${map.deviceType == 1}">validate="isIntLargerThanZero"</c:if>/>
									</c:if>
									<c:if test="${not empty map.storyId}">
										<input type="hidden" id="story_id" name="storyId" value="${map.storyId}" <c:if test="${map.deviceType == 1}">validate="isIntLargerThanZero"</c:if>/>
									</c:if>
									<div class="tip-normal error" vderr="dstory" style="display: none;"><span class="errorIcon"></span>楼栋不能为空</div>
								</div>
							</td>
						</tr>
						<!--
						<tr height="80px">
							<th><span class="color-red">*</span>设备UUID：</th>
							<td>
								<div vdfld="duuid" class="user-box-body form-relative-input">
									<input type="text" name="deviceUuid" value="${map.deviceUuid}" validate="isnotEmpty" class="form-control" placeholder="" />
									<div class="tip-normal error" vderr="duuid" style="display: none;"><span class="errorIcon"></span>UUID不能为空</div>
								</div>
							</td>
						</tr>
						-->
						<tr height="80px">
							<th><span class="color-red">*</span>设备地址：</th>
							<td>
								<div vdfld="daddr" class="user-box-body form-relative-input">
									<input type="text" name="deviceAddress" value="${map.deviceAddress}" validate="isnotEmpty" class="form-control" placeholder="" />
									<div class="tip-normal error" vderr="daddr" style="display: none;"><span class="errorIcon"></span>设备地址不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="80px">
							<th><span class="color-red">*</span>设备密码：</th>
							<td>
								<div vdfld="dpwd" class="user-box-body form-relative-input">
									<input type="password" id="password-pop" name="password" value="${map.password}" validate="isPassword" class="form-control" placeholder="" />
									<div class="tip-normal error" vderr="dpwd" style="display: none;"><span class="errorIcon"></span>请输入设备密码</div>
								</div>
							</td>
						</tr>
						<tr height="80px">
							<th>确认设备密码：</th>
							<td>
								<div vdfld="confirm-pw" class="user-box-body form-relative-input">
									<input type="password" class="form-control" vdOpt="pw:'#password-pop'" value="${map.password}" validate="confirmPassword"/>
									<div class="tip-normal error" vderr="confirm-pw" style="display: none;"><span class="errorIcon"></span>两次输入密码不一致</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>备注：</th>
							<td>
								<div>
									<textarea rows="6" cols="95" name="remark" class="form-textarea">${map.remark}</textarea>
								</div>
							</td>
						</tr>
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="提交" class="btn btn-success btn-submit">提 交</a>
									<a href="/sys/params/key/device" title="取消" class="btn btn-primary">取 消</a>	
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>



<div class="dialog dialog-choose-obj" id="treeChoicebox" style="display: none; width: 450px;">
    <div class="dialog-container">
		<div class="importInfoTitle"><span>选择楼栋</span></div>
    	<div class="choose-obj-dialog-con">
        	<div class="zTreeDemoBackground left">
				<ul id="treeDemos" class="ztree"></ul>
			</div>
        </div>
        <div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="selectStoryTree" class="btn bntbgGreen">确 定</a>
			<a href="javascript:void(0);" title="关闭" js="closeStoryTree" class="btn bntbgGreen dialog-close">关 闭</a>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity click-disappear"></div>

