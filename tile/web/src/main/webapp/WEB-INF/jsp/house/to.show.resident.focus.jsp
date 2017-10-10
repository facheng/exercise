<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">
$(document).ready(function() {
	$('[js="searchResident"]').on("click", function(){
		
		var roomNum = $.trim($("#roomNum").val());
		if(roomNum == "") {
			if("${residentStatus}" == null || "${residentStatus}" == "") {
				location.href = "/house/resident/focus";
			} else {
				location.href = "/house/resident/focus?status=${residentStatus}";
			}
		} else {
			if("${residentStatus}" == null || "${residentStatus}" == "") {
				location.href = "/house/resident/focus?roomNum=" + roomNum;
			} else {
				location.href = "/house/resident/focus?residentStatus=${residentStatus}&roomNum=" + roomNum;
			}
		}
	});
	
	$('.selectAll').click(function(){
		if ($(this).is(':checked') == true) {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", true);
		} else {
			$(this).closest("table").find('td input[type="checkbox"]').attr("checked", false);
		}
	});
	
	$('.delete-focus-hoster').on('click', function(){
		var hrId = $(this).closest("tr").attr("id");
		$(".dialog-delete-focus-hoster").attr("params", hrId);
		$('.dialog-delete-focus-hoster, .black-opacity').fadeIn();
	});
	
	$('.delete-focus-hoster-batch').on('click', function(){
		if($('#data-list-table td input[type="checkbox"]:checked').length == 0) {
			alert("请至少选择一条记录");
			return false;
		}

		var checkedNum = "";
		$('#data-list-table td input[type="checkbox"]:checked').each(function(i){
			checkedNum += $(this).closest('tr').attr("id") + ',';
			return(checkedNum);
		});
		var frIds = checkedNum.substring(0, checkedNum.length - 1);
		
		$(".dialog-delete-focus-hoster").attr("params", frIds);
		$('.dialog-delete-focus-hoster, .black-opacity').fadeIn();
	});
	
	$('[js="removeFocusResident"]').click(function(){
		var frIds = $(this).closest(".dialog-delete-focus-hoster").attr("params");
		var tag = $(this);
		tag.attr("disabled", "disabled");
		$.ajax({
			url: "/house/resident/focus/remove",
            type: "post",
            data: {"frIds": frIds},
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
           <h2 class="titIcon wyIcon">需要关注业主</h2>
           <div class="addbtn">
               <a class="btn bntbgBrown modify-focus-btn" title="添加业主" href="/house/resident/focus/info/0">添加关注</a>
           </div>
       </div>
       
       <div class="cont_box_wrap">
       	
           <div class="category ctop mt10">
               <div class="cate-link cateLinkIconBox">
                   <span>业主状态类型：</span>
                   <a title="全部" href="/house/resident/focus" id="allHoldType" <c:if test="${empty residentStatus}">class='cur'</c:if>>全部</a>
                   <a title="易怒" href="/house/resident/focus?residentStatus=1" class="cateLinkIcon angry <c:if test="${residentStatus == 1}">cur</c:if>">易怒</a>
                   <a title="体弱" href="/house/resident/focus?residentStatus=2" class="cateLinkIcon weak <c:if test="${residentStatus == 2}">cur</c:if>">体弱</a>				
                   <a title="迟缴费" href="/house/resident/focus?residentStatus=3" class="cateLinkIcon overdue <c:if test="${residentStatus == 3}">cur</c:if>">迟缴费</a>				
               </div>
           </div>
           
           <div class="category no-border-top">
               <ul class="searchfm clear">
                    <li><span class="zw">门牌号码：</span><input type="text" id="roomNum" name="roomNum" class="textinput" placeholder="请输入门牌号码" value="${roomNum}"> </li>
                    <li><span>&nbsp;</span><a href="javascript:void(0);"  js="searchResident" title="查询" class="btn bntbgGreen">查询</a></li>
                    <li><span>&nbsp;</span><a href="javascript:void(0);" title="批量移出" class="btn btnbgViolet delete-focus-hoster-batch">批量移出</a></li>
               </ul>
           </div>
           
           <table id="data-list-table" width="100%" class="list-table mt10 focus-host-tbl">
               <colgroup> 
               	   <col width="5%">
                   <col width="5%">
                   <col width="15%">
                   <col width="15%">
                   <col width="15%">
                   <col width="10%">
                   <col width="10%">
                   <col width="">
               </colgroup>
               <thead>
                   <tr>
                   	   <th><input type="checkbox" class="selectAll" /></th>
                       <th>序号</th>
                       <th>门牌号</th>
                       <th>业主姓名</th>
                       <th>手机号码</th>
                       <th>备注</th>
                       <th>状态</th>
                       <th>操作</th>
                   </tr>
               </thead>
               <tbody>
               		<c:if test="${not empty focusResidenList}">
               		<c:forEach var="fr" items="${focusResidenList}" varStatus="status">
                   <tr id="${fr.ID}">
                   	   <td><input type="checkbox" /></td>
                       <td>${status.count}</td>
                       <td>${fr.ROOM_NUM}</td>
                       <td>${fr.USER_NAME}</td>
                       <td>${fr.PHONE_NUM}</td>	
                       <td>${fr.REMARK}</td>
                       <td class="ownerBox">
                       <c:if test="${fr.RESIDENT_STATUS == 1}">
	                       <span class="blacklist angry">
	                           <div class="tooltip">
	                       	   <div class="tooltip-arrow"></div>
	                      	   <div class="tooltip-inner">
	                       	        <span class="angryBig"></span>易怒
	                       		<div>
	                       </span>
	                   </c:if>
                               
                       <c:if test="${fr.RESIDENT_STATUS == 2}">
                               <span class="blacklist overdue">
                               <div class="tooltip">
                                 <div class="tooltip-arrow"></div>
                                 <div class="tooltip-inner">
                                       <span class="overdueBig"></span>体弱
                                 </div>
                               </div>
                           </span>
                            </c:if>
                       <c:if test="${fr.RESIDENT_STATUS == 3}">       
                            <span class="blacklist weak">
                               <div class="tooltip">
                                 <div class="tooltip-arrow"></div>
                                 <div class="tooltip-inner">
                                       <span class="weakBig"></span>迟缴费
                                 </div>
                               </div>
                           </span>
                       </c:if>
                       </td>
                       <td class="action">
                           <a class="btn_smalls btn-primary modify-focus-btn" href="/house/resident/focus/info/${fr.ID}">修改</a>
                           <a class="btn_smalls btn-warning delete-focus-hoster" href="javascript:void(0);">移出</a>
                       </td>
                   </tr>
                   </c:forEach>
                   </c:if>
                   <c:if test="${empty focusResidenList}">
						<tr>
							<td colspan="8"><h3 class="clearfix mt10" style="text-align:center;" > 没有结果！</h3></td>
						</tr>
					</c:if>
               </tbody>
           </table>
           <c:import url="/WEB-INF/jsp/common/pagination.get.jsp" />
   	</div>
   </div>

<!--删除-->
<div class="dialog dialog-delete-focus-hoster" params="">
    <div class="dialog-container ">
    	<div class="text-con-dialog">
        	<p class="dialog-text-center">确认移出</p>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0);" title="确定" js="removeFocusResident" class="btn bntbgBrown delete-confirm-btn">确 定</a>
            <a href="javascript:void(0);" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
<!--删除-->
<div class="black-opacity"></div>