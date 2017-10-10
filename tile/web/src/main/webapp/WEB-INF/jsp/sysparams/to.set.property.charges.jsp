<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$("#edit_property_charge_rule").validate({ignoreHidden:true,bindBlur:true});
	
	if("${map.ctype}" == "1"){
		$('.tr_feeArea').hide();
		$('.tr_feeAll').show();
	} else {
		$('.tr_feeArea').show();
		$('.tr_feeAll').hide();
	}
	
	$('.save-property-btn').on('click', function(){
		var errDiv = $('.error:visible').length;
		if(errDiv != 0)return;
		$('.dialog-save-property-alert, .black-opacity').fadeIn();
	});
	
	$('#ctype').live('change' , function(){
		var val = $(this).val();
		if(val == '0'){
			$('.tr_feeArea').show();
			$('.tr_feeAll').hide();
			
		} else {
			$('.tr_feeArea').hide();
			$('.tr_feeAll').show();
		}
	});
	
	$('#partitionId').on('change' , function(){
		var val = $(this).val();
		$.ajax({
			url:"/sys/params/property/charges/detail",
			type: "get",
			dataType: "json",
			data:"partitionId="+val,
			success:function(obj){
				var cycle = obj.entity.cycle;
				var ctype = obj.entity.ctype;
				var isEff = obj.entity.isEffect;
				if(ctype == '0'){
					$('.tr_feeArea').show();
					$('.tr_feeAll').hide();
					
				} else {
					$('.tr_feeArea').hide();
					$('.tr_feeAll').show();
				}
				$('#cycle option[value='+cycle+']').attr('selected','selected');
				$('#ctype option[value='+ctype+']').attr('selected','selected');
				$('input[name=feeArea]').val(obj.entity.feeArea);
				$('input[name=feeLift]').val(obj.entity.feeLift);
				$('input[name=basementFeeArea]').val(obj.entity.basementFeeArea);
				$('input[name=feeAll]').val(obj.entity.feeAll);
				$('input[name=isEffect][value='+isEff+']').attr('checked','checked');
				
			},
			error:function(){
				alert("接口调用失败");
			}
			
		});
	});
	
	$('[js="submitCar"]').click(function(){
		
		$('.dialog-save-property-alert').hide();
		
		if(!checkFun($('#ctype').val()))return;
		
		var errDiv = $('.error:visible').length;
		if(errDiv != 0)return;
		
		$.ajax({
			url:"/sys/params/property/charges",
			type: "POST",
			dataType: "json",
			data:$("#edit_property_charge_rule").serialize(),
			success:function(bool){
				if(bool){
					$('.dialog-save-property-alert').fadeOut();
					$('.dialog-save-ok-alert').fadeIn();
				} else {
					alert("保存物业费规则失败");
				}
			},
			error:function(){
				alert("接口调用失败");
			}
			
		});
		
	});
});

function checkFun(ctype){
	var checkClass = "";
	var b = true;
	if(ctype == '0'){
		checkClass = ".isNotEmpty_feeArea";
		
	} else {
		checkClass = ".isNotEmpty_feeAll";
	}
	
	$(checkClass).each(function(){
		var v = $.trim($(this).val());
		if($.isNumeric(v) && v >= 0) {
			$(this).next().next("div").hide();
		} else {
			$(this).next().next("div").show();
			b = false;
		}
	});
	
	return b;
}
</script>


<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">物业费单价设置</h2>
	</div>

	<div class="cont_box_wrap">
		<div class="category no-border-top ">
			<form method="post" action="/sys/params/property/charges" autocomplete="off" id="edit_property_charge_rule" >
				
				<table width="100%" cellspacing="0" class="table_form">
					<tbody>
						<tr height="50px">
							<th><span class="color-red">*</span>选择期块：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select name="partitionId" id="partitionId" class="form-control">
										<c:forEach items="${unitPartitions}" var="up">
											<option <c:if test="${map.partitionId == up.id}">selected="selected"</c:if> value="${up.id}">${up.partitionName}</option>
										</c:forEach>
									</select>
									<br>
								</div>
							</td>
						</tr>
						<tr height="50px">
							<th><span class="color-red">*</span>缴费周期：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select id="cycle" name="cycle" class="form-control">
										<c:forEach items="${cycles}" var="cy">
											<option  <c:if test="${map.cycle == cy.key}">selected="selected"</c:if> value="${cy.key}">${cy.value}</option>
										</c:forEach>
									</select>
									<br>
								</div>
							</td>
						</tr>
						
						<tr height="50px">
							<th><span class="color-red">*</span>收费类型：</th>
							<td>
								<div class="user-box-body form-relative-input">
									<select id="ctype" name="ctype" class="form-control">
										<c:forEach items="${ctypes}" var="ct">
											<option <c:if test="${map.ctype == ct.key}">selected="selected"</c:if> value="${ct.key}">${ct.value}</option>
										</c:forEach>
									</select>
								</div>
							</td>
						</tr>
						
						<tr height="80px" class="tr_feeArea">
							<th><span class="color-red">*</span>单位面积费用：</th>
							<td>
								<div vdfld="daddr" class="user-box-body form-relative-input" style="width:58%">
									<input type="text" name="feeArea"   value="${map.feeArea}" validate="isLargerThanZero2"   class="form-control isNotEmpty_feeArea" width="47%" style="width:80%;display: inline;"  placeholder="单位面积费用" /><span style="margin-left: 10px">元/月</span>
									<div class="tip-normal error" vderr="daddr" style="display: none;"><span class="errorIcon"></span>请输入正确的单位面积费用</div>
								</div>
							</td>
						</tr>
						<tr height="80px" class="tr_feeArea">
							<th><span class="color-red">*</span>单位面积电梯单价(2楼及以上)：</th>
							<td>
								<div vdfld="dpwd" class="user-box-body form-relative-input" style="width:58%;">
									<input type="text" id="feeLift"  name="feeLift" value="${map.feeLift}" validate="isLargerThanZero2" class="form-control isNotEmpty_feeArea" style="width:80%;display: inline;" placeholder="单位面积电梯单价" /><span style="margin-left: 10px">元/月</span>
									<div class="tip-normal error" vderr="dpwd" style="display: none;"><span class="errorIcon"></span>请输入正确单位面积电梯单价</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px" class="tr_feeArea">
							<th><span class="color-red">*</span>地下室单位面积费用：</th>
							<td>
								<div vdfld="daddr" class="user-box-body form-relative-input" style="width:58%;">
									<input type="text"  name="basementFeeArea" value="${map.basementFeeArea}" validate="isLargerThanZero2" class="form-control isNotEmpty_feeArea" style="width:80%;display: inline;" placeholder="地下室单位面积费用" /><span style="margin-left: 10px">元/月</span>
									<div class="tip-normal error" vderr="daddr" style="display: none;"><span class="errorIcon"></span>请输入地下室单位面积费用</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px" style="display:none" class="tr_feeAll">
							<th><span class="color-red">*</span>整套房屋费用：</th>
							<td >
								<div vdfld="daddr" class="user-box-body form-relative-input" style="width:58%;" >
									<input type="text" name="feeAll" value="${map.feeAll}" validate="isLargerThanZero2" class="form-control isNotEmpty_feeAll" style="width:80%;display: inline;"  placeholder="整套房屋费用"><span style="margin-left: 10px">元/月</span>
									<div class="tip-normal error" vderr="daddr" style="display: none;"><span class="errorIcon"></span>请输入正确的整套房屋费用</div>
								</div>
							</td>
						</tr>
						
						<tr height="80px">
								<th width="100px"><label><span class="color-red">*</span>是否生效：</label></th>
								<td vdfld="bterr">
									<div class="noticeType-choice">
									<c:forEach items="${isEffects}" var="ef">
										<label><input type="radio" validate="radioChecked" name="isEffect" <c:if test="${map.isEffect == ef.key}">checked="checked"</c:if> value="${ef.key }" class="bind-type not_select_radio" /><span>${ef.value }</span></label>
									</c:forEach>
									</div>
									<!-- <div style="clear: both;"></div> -->
									<div class="tip-normal error" id="err_tip_isEffect" vderr="bterr" style="display: none;"><span class="errorIcon"></span>请选择是否生效</div>
								</td>
							</tr>
						
						<tr height="80px">
							<th></th>
							<td>
								<div>
									<a href="javascript:void(0);" title="确定" class="btn btn-success save-property-btn">确定</a>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</div>

<div class="dialog dialog-save-property-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定保存物业费规则？</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="submitCar" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="dialog dialog-save-ok-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">保存成功</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" class="btn bntbgBrown dialog-close">确定</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>


<div class="black-opacity click-disappear"></div>

