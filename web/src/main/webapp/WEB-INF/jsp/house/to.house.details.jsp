<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	function updateHouse() {
		
		$("#houseMag").show();
		$("#houseMagBox").show();
	}

	function updateHouseClose() {
		$("#houseMag").hide();
		$("#houseMagBox").hide();
	}
	
	//修改房屋保存
	function saveHouseMag()
	{
		$("#houseMagForm").submit();
	}
	
	//房屋修改状态显示
	$(document).ready(function(){
		$("a[title='房屋管理']").attr("class","nav-item-link c");
		$("a[title='房屋详情']").attr("class","c");
	    //房屋状态回显
		$('#houseStatus option').each(function(){
		   $this = $(this).val();
	       if($this =="${house.STATUS}"){
	           $(this).attr('selected',true);
	       }
	    });	     
	});
	
</script>
<div class="rightCon">
	<div class="rightNav">
		<h2 class="titIcon wyIcon">房屋管理</h2>
		<div class="rightNav-sub">
			<a href="/house/list" title="返回" class="cur">返回</a> 
            <a href="javascript:updateHouse();" title="修改房屋信息">修改房屋信息</a>
		</div>
	</div>
	<div class="detail-box">
		<div class="owner-tab">
			<h3 class="h3tit">房屋信息</h3>
			<table width="100%" class="inv-table">
				<tbody>
					<tr>
						<th><label>房屋信息</label></th>
						<td>${house.DY_CODE}</td>
					</tr>
					<tr>
						<th><label>产证号码</label></th>
						<td>${house.PRO_NO}</td>
					</tr>
					<tr>
						<th><label>房屋面积</label></th>
						<td>${house.AREA}平方米</td>
					</tr>
					<tr>
						<th><label>房屋X坐标</label></th>
						<td>${house.LONGITUDE}</td>
					</tr>
					<tr>
						<th><label>房屋Y坐标</label></th>
						<td>${house.LANTITUDE}</td>
					</tr>
					<tr>
						<th><label>房屋状态</label></th>
                        
						<td class="status">
						    <c:if test="${house.STATUS=='1'}">
								自住
							</c:if> 
							<c:if test="${house.STATUS=='2'}">
								空置
							</c:if>
							<c:if test="${house.STATUS=='3'}">
								待售
							</c:if>
							<c:if test="${house.STATUS=='4'}">
								出租
							</c:if>
							<c:if test="${house.STATUS=='5'}">
								待租
							</c:if>
                        </td>
					</tr>
				</tbody>
			</table>
			<c:if test="${not empty yzList}">
				<h3 class="h3tit mt20">业主信息</h3>
				<div class="fcInfoBox">
					<c:forEach var="yz" items="${yzList}" varStatus="status">
						<div class="fcInfoCon">
							<table width="100%" class="inv-table">
								<tbody>
									<tr>
										<th><label>业主姓名</label></th>
										<td>${yz.USER_NAME}</td>
									</tr>
									<tr>
										<th><label>身份证号</label></th>
										<td>${yz.ID_CARD}</td>
									</tr>
									<tr>
										<th><label>手机号码</label></th>
										<td>${yz.PHONE_NUM}</td>
									</tr>
								</tbody>
							</table>
							<div class="fcInfoBtn">
								<a href="#" title="查看租客进出入记录">查看${yz.USER_NAME}进出入记录</a>
							</div>
						</div>
						<div class="clear"></div>
				</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty yzList}">
				<h3 class="h3tit mt20">业主信息</h3>
				<div class="fcInfoBox">
					<div class="fcInfoCon">
						<table width="100%" class="inv-table">
							<tbody>
								<tr>没有业主信息
								</tr>
							</tbody>
						</table>
					</div>
					<div class="clear"></div>
				</div>
			</c:if>
			<c:if test="${not empty zkList}">
				<h3 class="h3tit mt20">租客信息</h3>
				<div class="fcInfoBox">
					<c:forEach var="zk" items="${zkList}" varStatus="status">
						<div class="fcInfoCon">
							<table width="100%" class="inv-table">
								<tbody>
									<tr>
										<th><label>租客姓名</label></th>
										<td>${zk.USER_NAME}</td>
									</tr>
									<tr>
										<th><label>身份证号</label></th>
										<td>${zk.ID_CARD}</td>
									</tr>
									<tr>
										<th><label>手机号码</label></th>
										<td>${zk.PHONE_NUM}</td>
									</tr>
								</tbody>
							</table>
							<div class="fcInfoBtn">
								<a href="#" title="查看租客进出入记录">查看${zk.USER_NAME}进出入记录</a>
							</div>
						</div>
					</c:forEach>
			</c:if>
			<div class="clear"></div>
		</div>
		<c:if test="${empty zkList}">
			<h3 class="h3tit mt20">租客信息</h3>
			<div class="fcInfoBox">
				<div class="fcInfoCon">
					<table width="100%" class="inv-table">
						<tbody>
							<tr>没有租客信息
							</tr>
						</tbody>
					</table>
				</div>
				<div class="clear"></div>
			</div>
		</c:if>
	</div>
</div>
</div>
</div>
<!-- 房屋信息修改-->
<div id="houseMag" class="overlay" style="display: none"></div>
<div id="houseMagBox" class="inv-form" style="display: none">
	<form action="/house/update" method="post" id="houseMagForm">
		<table width="100%" class="inv-table">
			<input type="hidden" name="Id" value="${house.ID}">
			<tbody>
				<tr>
					<th><label>房屋信息</label></th>
					<td><input type="text" class="guest-num" name="dyCode"
						value="${house.DY_CODE}">
						<div class="tip-normal error" style="display: none">
							<span class="errorIcon"></span>请输入户主姓名
						</div></td>
				</tr>
				<tr>
					<th><label>产证号码</label></th>
					<td><input type="text" class="guest-num" name="proNo"
						value="${house.PRO_NO}"></td>
				</tr>
				<tr>
					<th><label>房屋面积</label></th>
					<td><input type="text" class="guest-num" name="area"
						value="${house.AREA}"><span>平方米</span></td>
				</tr>
				<tr>
					<th><label>房屋状态</label></th>
					<td>
					<select class="chargeCompany" id="houseStatus" name="status">
							<option value="1">自住</option>
							<option value="2">空置</option>
							<option value="3">待售</option>
							<option value="4">出租</option>
							<option value="5">待租</option>
					</select>
				   </td>
				</tr>
				<tr>
					<th></th>
					<td><a href="javascript:saveHouseMag();" title="确定"
						class="btn bntbgDarkG">确 定</a></td>
				</tr>
			</tbody>
		</table>
		<div class="close-btn">
			<a title="关闭" href="javascript:updateHouseClose();">关闭</a>
		</div>
	</form>
</div>