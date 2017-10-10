<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_commonWords_form").validate();

	$('.save-commonWords-btn').on('click', function(){
		$('.dialog-save-commonWords-alert, .black-opacity').fadeIn();
	});

	$('[js="submitCommonWords"]').click(function(){
		$('.dialog, .black-opacity').fadeOut();
		
		if($('#input_common_words_val').val().length > 200){
			$('#err_tip_valid').show();
			return;
		} else {
			$('#err_tip_valid').hide();
		}
		
		$("#edit_commonWords_form").submit();
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">编辑常用语</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<form method="post" action="/sys/params/common/words" autocomplete="off" id="edit_commonWords_form" >
				<c:if test="${not empty commonWordsId}">
					<input type="hidden" name="id" value="${commonWordsId}"/>
				</c:if>
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="70px">
							<th width="150"><span class="color-red">*</span>选择常用语类别：</th>
							<td class="noticeType-choice">
								<label><input type="radio" name="type" value="1" checked="checked" /><span>通知</span></label>
								<label><input type="radio" name="type" value="2" <c:if test="${map.type == 2}">checked="checked"</c:if> /><span>快递</span></label>
								<label><input type="radio" name="type" value="3" <c:if test="${map.type == 3}">checked="checked"</c:if> /><span>报修</span></label>
							</td>
						</tr>
					
						<tr height="70px" class="wuye-content-hide">
							<th><span class="color-red">*</span>常用语内容：</th>
							<td>
								<div vdfld="bcontent" class="user-box-body form-relative-input">
									<!-- <textarea class="form-control form-control-textarea" name="content" validate="isnotEmpty" placeholder="请输入常用语内容">${map.content}</textarea> -->
									<input type="text" id="input_common_words_val" class="form-control" name="words" validate="isnotEmpty" placeholder="请输入常用语内容" value="${map.words}">
									<div class="tip-normal error" vderr="bcontent" style="display: none;"><span class="errorIcon"></span>常用语内容不能为空</div>
									<div class="tip-normal error" id="err_tip_valid" style="display: none;"><span class="errorIcon"></span>常用语内容过长</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="确定" class="btn btn-success save-commonWords-btn">确定</a>
									<a href="/sys/params/common/words" title="取 消" class="btn btn-primary">取 消</a>	
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>



<div class="dialog dialog-save-commonWords-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定保存常用语？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submitCommonWords" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>