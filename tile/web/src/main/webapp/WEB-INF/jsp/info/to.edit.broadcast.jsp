<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_broadcast_form").validate();

	$('.save-broadcast-btn').on('click', function(){
		$('.dialog-save-broadcast-alert, .black-opacity').fadeIn();
	});

	$('[js="submitBroadcast"]').click(function(){
		$('.dialog, .black-opacity').fadeOut();
		$("#edit_broadcast_form").submit();
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">编辑公告</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<form method="post" action="/info/broadcast" autocomplete="off" id="edit_broadcast_form" >
				<c:if test="${not empty broadcastId}">
					<input type="hidden" name="id" value="${broadcastId}"/>
				</c:if>
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="40px">
							<th width="150"><span class="color-red">*</span>选择公告类别：</th>
							<td class="noticeType-choice">
								<label><input type="radio" name="fromType" value="0" checked="checked" class="wuye-radio" /><span>物业</span></label>
								<label><input type="radio" name="fromType" value="1" <c:if test="${map.type == 1}">checked="checked"</c:if> class="juweihu-radio" /><span>居委会</span></label>
							</td>
						</tr>
					
						<tr height="80px">
							<th><span class="color-red">*</span>公告标题：</th>
							<td>
								<div vdfld="btitle" class="user-box-body form-relative-input">
									<input type="text" class="form-control" name="title" value="${map.title}" validate="isnotEmpty" placeholder="请输入公告标题" />
									<div class="tip-normal error" vderr="btitle" style="display: none;"><span class="errorIcon"></span>公告标题不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="350px" class="wuye-content-hide">
							<th><span class="color-red">*</span>公告内容：</th>
							<td>
								<div vdfld="bcontent" class="user-box-body form-relative-input">
									<textarea class="form-control form-control-textarea" name="content" validate="isnotEmpty" placeholder="请输入公告内容">${map.content}</textarea>
									<div class="tip-normal error" vderr="bcontent" style="display: none;"><span class="errorIcon"></span>公告内容不能为空</div>
								</div>
							</td>
						</tr>
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="发布" class="btn btn-success save-broadcast-btn">发 送</a>
									<a href="/info/broadcast/list" title="取 消" class="btn btn-primary">取 消</a>	
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>



<div class="dialog dialog-save-broadcast-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定发送公告？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submitBroadcast" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>