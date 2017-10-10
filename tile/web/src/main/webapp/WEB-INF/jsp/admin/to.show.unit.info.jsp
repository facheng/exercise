<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">
	
	
</script>

	<div class="rightCon">
		<div class="rightNav">
			<h2 class="titIcon wyIcon">小区信息</h2>
			<div class="rightNav-sub">
				<a href="/admin/unit/list" title="返回" class="cur">返回</a>
			</div>
		</div>		
		<div class="detail-box">			
			<div class="owner-tab">
				<h3 class="h3tit">小区信息</h3>
				<table style="widht:100%" class="inv-table">
					<tbody>
						<tr>
							<th><label>小区名称</label></th>
							<td>${mapUnit.unitName}</td>
						</tr>
						<tr>
							<th><label>小区纬度</label></th>
							<td>
								${mapUnit.lantitude}
							</td>
						</tr>
						<tr>
							<th><label>小区经度</label></th>
							<td>${mapUnit.longitude}</td>
						</tr>
						<tr>
							<th><label>所属组织架构</label></th>
							<td>${mapUnit.branchName}</td>
						</tr>
							<tr>
							<th><label>所属物业公司</label></th>
							<td>${mapUnit.companyName}</td>
						</tr>
						<tr>
							<th><label>区/县</label></th>
							<td>${mapUnit.provinceName},${mapUnit.cityName},${mapUnit.districtName}</td>
						</tr>
						<tr>
							<th><label>地址</label></th>
							<td>${mapUnit.address}</td>
						</tr>
						
						<tr>
							<th><label>备注</label></th>
							<td>${mapUnit.remark}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
