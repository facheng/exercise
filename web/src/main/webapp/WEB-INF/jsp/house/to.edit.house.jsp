<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_house_form").validate();

	$('[js="submit"]').click(function(){
		var area = $.trim($("#area").val());
		if(area == "") {
			$("#area").val("0");
		}
		$("#edit_house_form").submit();
	});
});
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">修改房屋信息</h2>
	</div>
        
	<div class="cont_box_wrap">
		<div class="category no-border-top">
			<c:if test="${empty map}">
				房屋不存在
			</c:if>
			<c:if test="${not empty map}">
				<form method="post" action="/house/${id}" autocomplete="off" id="edit_house_form" >
					<table width="100%" cellspacing="0" class="table_form">
						<tbody>
							<tr height="50px">
								<th><label><span class="color-red">*</span>门室号</label></th>
								<td>
									<div vdfld="rnum" class="user-box-body form-relative-input">
										<input type="text" class="guest-num" placeholder="" name="roomNum" value="${map.roomNum}" validate="isnotEmpty" />
										<div class="tip-normal error" vderr="rnum" style="display: none;"><span class="error"></span>门室号不能为空</div>
									</div>
								</td>
							</tr>
							<tr height="50px">
								<th><label><span class="color-red">*</span>房屋楼层</label></th>
								<td>
									<div vdfld="fnum" class="user-box-body form-relative-input">
										<input type="text" class="guest-num" placeholder="" name="floorNum" value="${map.floorNum}" validate="isIntLargerThanZero" />
										<div class="tip-normal error" vderr="fnum" style="display: none;"><span class="errorIcon"></span>请输入正确的楼层(必须是大于0的整数)</div>
									</div>
								</td>
							</tr>
							<tr height="50px">
								<th><label>产证号码</label></th>
								<td class="noticeType-choice">
									<input type="text" class="guest-num" placeholder="" name="proNo" value="${map.proNo}" />
								</td>
							</tr>
							<tr height="50px">
								<th><label>房屋面积</label></th>
								<td>
									<div vdfld="ar">
										<input type="text" class="guest-num" placeholder="" id="area" name="area" value="${map.area}" validate="isLargerThanZero1" />平方米
										<div class="tip-normal error" vderr="ar" style="display: none;"><span class="errorIcon"></span>必须是大于0的数字</div>
									</div>
								</td>
							</tr>
							<tr height="50px">
								<th><label>房屋状态</label></th>
								<td class="noticeType-choice">
									<label><input type="radio" name="status" value="1" checked="checked" class="wuye-radio" /><span>自住</span></label>
									<label><input type="radio" name="status" value="2" <c:if test="${map.status == 2}">checked="checked"</c:if> class="wuye-radio" /><span>空置</span></label>
									<label><input type="radio" name="status" value="3" <c:if test="${map.status == 3}">checked="checked"</c:if> class="wuye-radio" /><span>待售</span></label>
									<label><input type="radio" name="status" value="4" <c:if test="${map.status == 4}">checked="checked"</c:if> class="wuye-radio" /><span>出租</span></label>
									<label><input type="radio" name="status" value="5" <c:if test="${map.status == 5}">checked="checked"</c:if> class="wuye-radio" /><span>待租</span></label>
								</td>
							</tr>
							<tr height="50px">
								<th><label>代收快递</label></th>
								<td class="noticeType-choice">
									<label><input type="radio" name="delegateDelivery" value="1" checked="checked" class="wuye-radio" /><span>接受代收</span></label>
									<label><input type="radio" name="delegateDelivery" value="2" <c:if test="${map.delegate == 2}">checked="checked"</c:if> class="wuye-radio" /><span>拒绝代收</span></label>
								</td>
							</tr>
							<tr>
								<th></th>
								<td>
									<a href="javascript:void(0);" js="submit" title="保存" class="btn btn-success">保 存</a>
            						<a href="/house/list" title="取消" class="btn btn-primary">取 消</a>	
								</td>
							</tr>
						</tbody>
					</table>
				</form>
			</c:if>
		</div>
	</div>
</div>

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>


