<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_delivery_form").validate();

	$('.save-delivery-msg-btn').on('click', function(){
		$('.dialog-save-delivery-msg-alert, .black-opacity').fadeIn();
	});

	$('[js="submitDelivery"]').click(function(){
		$('.dialog, .black-opacity').fadeOut();
		$("#edit_delivery_form").submit();
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

	$('[js="showHouseTree"]').on("click", function(){
		var zNodes = [];
		$.ajax({
			url: "/ajax/unit/${unitId}/houses",
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

	$('[js="selectHouseTree"]').on("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});

	$('[js="closeHouseTree"]').on("click", function(){
		$("#treeChoicebox").hide();
		$('.dialog, .black-opacity').fadeOut();
	});
	
	$('#select_commonWords').on('change' , function(){
		var commonWords = $('#select_commonWords').val();
		var option_common_select = $('#option_common_select').val();
		if(commonWords != option_common_select ){
			$('[name=title]').val(commonWords);
		}
	});
});

function setFontCss(treeId, treeNode) {
	
};

function onCheck(e, treeId, treeNode){
	var treeObj = $.fn.zTree.getZTreeObj("treeDemos");
	var nodes = treeObj.getCheckedNodes(true);
	var values = "";
	var ids  = "";
	for(var i = 0; i < nodes.length; i++){
		if(nodes[i].valid == 1) {
			values += nodes[i].name + ",";
			ids += nodes[i].id + ",";
		}
	}
	if (values.length > 0 ){
		values = values.substring(0, values.length - 1);
	}
	if (ids.length > 0 ){
		ids = ids.substring(0, ids.length - 1);
	}
	$("#houseIds").val(ids);
	$("#selectedHouses").val(values);
}
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">编辑快递信息</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<form method="post" action="/info/delivery" autocomplete="off" id="edit_delivery_form" >
				<c:if test="${not empty deliveryId}">
					<input type="hidden" name="id" value="${deliveryId}"/>
				</c:if>
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<c:if test="${empty deliveryId}">
							<tr height="80px" class="wuye-content-hide">
								<th width="100"><span class="color-red">*</span>选择接收对象：</th>
								<td>
									<div vdfld="ehouseId" class="user-box-body form-relative-input">
										<input type="text" id="selectedHouses" class="form-control" placeholder="选择接收对象" value="" disabled="disabled" />
										<span class="msgAddBtn" js="showHouseTree"></span>
										<input type="hidden" id="houseIds" name="houseIds" value="" validate="isnotEmpty"/>
										<div class="tip-normal error" vderr="ehouseId" style="display: none;"><span class="errorIcon"></span>接收对象不能为空</div>
									</div>
								</td>
							</tr>
						</c:if>
						
						<tr height="80px">
							<th width="100">常用语：</th>
							<td>
								<select class="form-control commonWords" id="select_commonWords">
									<option id="option_common_select"><f:message key="common.select"/></option>
									<c:forEach items="${commonWordsList }" var="commonWords">
										<option >${ commonWords.words}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						
						<tr height="80px">
							<th width="100"><span class="color-red">*</span>消息标题：</th>
							<td>
								<div vdfld="etitle" class="user-box-body form-relative-input">
									<input type="text" class="form-control" name="title" value="${map.title}" validate="isnotEmpty" placeholder="请输入消息标题" />
									<div class="tip-normal error" vderr="etitle" style="display: none;"><span class="errorIcon"></span>标题不能为空</div>
								</div>
							</td>
						</tr>
						<!-- 内容暂时不要
						<tr height="350px" class="wuye-content-hide">
							<th><span class="color-red">*</span>消息内容：</th>
							<td>
								<div vdfld="econtent" class="user-box-body form-relative-input">
									<textarea class="form-control form-control-textarea" name="content" validate="isnotEmpty" placeholder="请输入消息内容">${map.content}</textarea>
									<div class="tip-normal error" vderr="econtent" style="display: none;"><span class="errorIcon"></span>内容不能为空</div>
								</div>
							</td>
						</tr> -->
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="发送" class="btn btn-success save-delivery-msg-btn">发 送</a>
									<a href="/info/delivery/list" title="取 消" class="btn btn-primary">取 消</a>
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
		<div class="importInfoTitle"><span>选择接收对象</span></div>
    	<div class="choose-obj-dialog-con">
        	<div class="zTreeDemoBackground left">
				<ul id="treeDemos" class="ztree"></ul>
			</div>
        </div>
        <div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="selectHouseTree" class="btn bntbgGreen">确 定</a>
			<a href="javascript:void(0);" title="关闭" js="closeHouseTree" class="btn bntbgGreen dialog-close">关 闭</a>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>


<div class="dialog dialog-save-delivery-msg-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定发送快递消息？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submitDelivery" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>


