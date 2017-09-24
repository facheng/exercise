<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>
<script type="text/javascript">
$(document).ready(function() {
	$('[js="searchCompanyBranch"]').on("click", function(){
		var branchName = $.trim($("#branchName").val());
		if(branchName == "") {
			location.href = "/admin/company/branch/list";
		} else {
			location.href = "/admin/company/branch/list?branchName=" + branchName;
		}
	});
	
	$('[js="deleteBranch"]').click(function(){
		$('.dialog-branch-del-alert, .black-opacity').fadeOut();
		var branchId = $("#branchId").val();
		$.ajax({
			url: "/admin/company/branch/" + branchId,
            type: "post",
            data: {"_method": "delete"},
            dataType: "text",
            success: function(data){
                if(data == 1) {
					location.href = location.href;
                } else {
                	$('.dialog-branch-del-boolean, .black-opacity').fadeIn();
                	return false;
                }
		    },
		    error: function () {
		    	$('.dialog-branch-del-boolean, .black-opacity').fadeIn();
            }
		});
		return false;
	});
});
function deleteBranch(branchId){
	$("#branchId").val(branchId);
	$('.dialog-branch-del-alert, .black-opacity').fadeIn();
}
</script>

<div class="rightCon">
                	
 	<div class="rightNav">
         <h2 class="titIcon wyIcon">组织架构管理</h2>
         <div class="addbtn">
         </div>
     </div>
     
     
     <div class="cont_box_wrap">
     
     	<div class="category more-cate mt10">
             <ul class="searchfm clear">
                  <li>
                  	<span class="zw">组织名称：</span>
                     <input type="text" class="textinput" id="branchName" value="${branchName}" placeholder="请输入组织名称">
                  </li>
                  <li>
                  	<span>&nbsp;</span>
                     <a href="javascript:void(0);" js="searchCompanyBranch" title="查询" class="btn bntbgGreen">查询</a>
                  </li>
             </ul>
         </div>
         
         <table width="100%" class="list-table mt10">
             <colgroup>
				<col width="3%">
				<col width="10%">
				<col width="15%">
				<col width="15%">
				<col width="15%">
				<col width="42%">
             </colgroup>
             <thead>
                 <tr>
					<th><input type="checkbox" class="selectAll" /></th>
                    <th>序号</th>
                    <th>组织名称</th>
                    <th>组织编码</th>	
                    <th>上级组织</th>
                    <th>操作</th>
                 </tr>
             </thead>
             <c:if test="${not empty branchList}">
				<tbody>
					<c:forEach var="branch" items="${branchList}" varStatus="status">
						<tr id="${branch.id}">
							<td><input type="checkbox" /></td>
							<td>${status.count}</td>
							<td>${branch.branchName}</td>
							<td>${branch.code}</td>
							<td>${branch.parentName}</td>
							<td class="action">
								<a class="btn_smalls btn-success" title="新增" href="/admin/company/branch?parentId=${branch.id}">新增</a>
                         		<a class="btn_smalls btn-primary" title="编辑" href="/admin/company/branch?branchId=${branch.id}&parentId=${branch.parentId}">编辑</a>
                         		<c:if test="${branch.parentId != 0}">
                         			<a class="btn_smalls btn-warning delete-customer-btn" title="删除" onclick="deleteBranch(${branch.id});" href="javascript:void(0);">删除</a>
                         		</c:if>
                         		
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
			<c:if test="${empty branchList}">
				<tr>
					<td colspan="6"><h3 class="clearfix mt10" style="text-align:center;" > 没有结果！</h3></td>
				</tr>
			</c:if>
		</table>
		<c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
         
     </div>
     
 </div>
 
 <div class="dialog dialog-branch-del-alert">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确定删除该组织？</p>
        </div>
        <div class="winBtnBox mt20">
        	<input type="hidden" id="branchId" value=""/>
            <a href="javascript:void(0);" title="确定" js="deleteBranch" class="btn bntbgBrown">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
 <div class="dialog dialog-branch-del-boolean">
    <div class="dialog-container">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">删除失败，确定此组织下没有子组织和绑定小区！</p>
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<div class="black-opacity"></div>