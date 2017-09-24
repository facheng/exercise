<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	
	$(function(){
		$("#pageForm").validate({validateAjax: true});
		
		setValue();
	});
	
	
	function setValue(){
		var partitionName = $("#partitionName option:selected").val();
		var partitionId =  $("#id").val();
		if(partitionId == 0){
			$("#aliasName").attr("value",partitionName);
		}
	}
	
</script>

    <div class="rightCon">
			<div class="rightNav">
			     <c:if test="${unitPartition.id == '0'}">
					<h2 class="titIcon wyIcon">添加小区期数</h2>
					<div class="rightNav-sub">
						 <a href="/admin/unit/list" title="返回" class="cur">返回</a>
					</div>
				 </c:if>
				 <c:if test="${unitPartition.id != '0'}">
				 <h2 class="titIcon wyIcon">编辑小区期数</h2>
					<div class="rightNav-sub">
						 <a href="/admin/partition/list?unitId=${unit.id}"  title="返回" class="cur">返回</a>
					</div>
			  	 </c:if>					
			</div>
	<div class="cont_box_wrap">
		<div class="msgBox category mt20">
			 <form action="/admin/partition/edit?unitId=${unit.id}" method="post" id="pageForm" autocomplete="off">
				<div class="category no-border-top">
					<table style="width:100%" class="inv-table">
						<tbody>
						
						<tr height="50px" class="wuye-content-hide">
						  <th width="150"><label>小区名称：</label></th>
						  <td>
						  	 <input type="hidden" name="unitId" id= "unitId"  class="form-control"  value="${unit.id}">
						  	<input type="text" readonly="readonly" name="unitName" id= "unitName"  class="form-control"  value="${unit.unitName}">
						  </td>
						</tr>
											 
						<tr height="50px" class="wuye-content-hide">
						  <th width="150"><label>期数：</label></th>
						  <td vdfld="un">
						  	 <c:if test="${empty unitPartition.id}">
						  	 	<c:set var="id" value="0"></c:set>
						  	 </c:if>
						  	 <c:if test="${not empty unitPartition.id}">
						  	 	<c:set var="id" value="${unitPartition.id}"></c:set>
						  	 </c:if>
						 	 <input type="hidden" name="id" id= "id"  class="form-control"  value="${id}">
						 	 <div>
						 	 	<select name="partitionName" id="partitionName" class="guest-num" validate="ajaxValid" vdOpt="url:'/ajax/admin/partition?unitId=${unit.id}&id=${id}',key:'partitionName'" onchange="setValue();">
						 	 		<option <c:if test="${unitPartition.partitionName == '一期'}">selected="selected"</c:if> value="一期">一期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '二期'}">selected="selected"</c:if> value="二期">二期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '三期'}">selected="selected"</c:if> value="三期">三期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '四期'}">selected="selected"</c:if> value="四期">四期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '五期'}">selected="selected"</c:if> value="五期">五期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '六期'}">selected="selected"</c:if> value="六期">六期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '七期'}">selected="selected"</c:if> value="七期">七期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '八期'}">selected="selected"</c:if> value="八期">八期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '九期'}">selected="selected"</c:if> value="九期">九期</option>
						 	 		<option <c:if test="${unitPartition.partitionName == '十期'}">selected="selected"</c:if> value="十期">十期</option>
						 	 	</select>
						 	 	<div vdErr="un" class="tip-normal error error-tooltip" style="display: none;">
										<span class="checkObj" style="display: none;">该期数已经存在</span>
								</div>
						  	 </div>
						  </td>
						</tr>
						
						<tr height="50px" class="wuye-content-hide">
						  <th width="150"><span class="color-red">*</span><label>别名：</label></th>
						  <td>
						  	<div vdfld="aliasName" class="user-box-body form-relative-input">
							  	<input type="text" name="aliasName" id= "aliasName"  class="form-control"  value="${unitPartition.aliasName}" validate="isnotEmpty">
							  	<div class="tip-normal error" vderr="aliasName" style="display: none;"><span class="error"></span>别名不能为空</div>
							</div>
						  </td>
						</tr>
						
						
						<tr height="50px" class="wuye-content-hide">
						  <th width="150"><label>备注：</label></th>
						  <td>
						  	<textarea name="remark" id="remark"  class="form-control" rows=" " style="height:100px;">${unitPartition.remark}</textarea>
						  </td>
						</tr>
						<tr class="wuye-content-hide">
							<th></th>
							<td>
								<a href="javascript:void(0);" title="保存" class="btn bntbgGreen btn-submit">保 存</a>
		           	            <c:if test="${unitPartition.id == '0'}">
		           	                <a href="/admin/unit/list" title="取消" class="btn bntbgGreen">取 消</a>		
								</c:if>
								<c:if test="${unitPartition.id != '0'}">
								 	<a href="/admin/partition/list?unitId=${unit.id}" title="取消" class="btn bntbgGreen">取 消</a>		
								</c:if>
							</td>
						</tr>
					 </tbody>
				</table>
			</div>
		</form>
			</div>
			</div>
	</div>


<!-- 弹出层开始 -->
<div class="overlay" id="addOwner" style="display:none"></div>
<div class="inv-form" id="addOwnerbox"style="display:none; width: 300px;height: 300px">
	    
	    <div >
	    	<ul id="treeDemos" class="ztree" style="height: 250px; overflow: auto;"></ul>
	    </div>
	    
		<div style="padding-top: 20px; text-align: center;">
			<a href="javascript:selectCompanyBranch();" title="确定" class="btn bntbgGreen">确 定</a>
		</div>
		<div class="close-btn">
			<a title="关闭" href="javascript:closeWindow();">关闭</a>
		</div>
	
</div>
<!-- 弹出层结束 -->

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
