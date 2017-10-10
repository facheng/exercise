<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>

<script type="text/javascript">

	//根据省获取市下拉框
	function proChange() {
		var provinceId = $("#province option:selected").val();
		$.ajax({
			type : "post",
			url : "/admin/findCitys",
			data : {
				"provinceId" : provinceId
			},
				success : function(data) {
				var citySel = $("#city");
				citySel.find("option").remove();
			if (data && data['citys']) {
				$.each(data['citys'],function(index, value) {
					var cityId = value["cityId"];
					if ('${cityId}' == cityId) {
						citySel.append("<option value='"+cityId+"' selected='selected'>" + value['cityName'] + "</option>");
					} else {
						citySel.append("<option value='"+cityId+"'>"+ value['cityName']+ "</option>");
												
					}
						});
				}
				cityChange();
			}
		});
	}

	//根据省获取市下拉框
	function cityChange() {
		var cityId = $("#city option:selected").val();
		$.ajax({
			type : "post",
			url : "/admin/findDistricts",
			data : {
				"cityId" : cityId
			},
			success : function(data) {
				var districtSel = $("#district");
				districtSel.find("option").remove();
				if (data && data['districts']) {
					$.each(data['districts'],function(index, value) {
						var districtId = value["districtId"];
						if ('${districtId}' == districtId) {
							districtSel.append("<option value='"+districtId+"' selected='selected' >" + value['districtName'] + "</option>");
						} else {
							districtSel.append("<option value='"+districtId+"' >" + value['districtName'] + "</option>");
						}
					});
				}
			}
		});
	}

	$(document).ready(function() {
		proChange();
		$("#pageForm").validate();
		
		var setting = {
			check : {
				enable : false
			},
			data : {
				simpleData : {
					enable : true
				}
			},
			view : {
				fontCss : setFontCss
			},
			callback : {
				onClick : onClick
			}
		};

		//弹出组织架构层
		$('[js="showCompanyBranchTree"]').on("click", function() {
			$.ajax({
				type : 'get',
				url : "/ajax/company/${companyId}/branches",
				dataType : "json",
				success : function(data) {
					$.fn.zTree.init($("#treeDemos"), setting, data);
					$("#treeChoicebox").show();
					$('.black-opacity').fadeIn();
				},
				error : function() {
					alert('接口调用失败！');
				}
			});
			return false;
		});

		$('[js="selectCompanyBranchTree"]').on("click", function() {
			$("#treeChoicebox").hide();
			$('.dialog, .black-opacity').fadeOut();
		});

		$('[js="closeCompanyBranchTree"]').on("click", function() {
			$("#treeChoicebox").hide();
			$('.dialog, .black-opacity').fadeOut();
		});

	});

	function setFontCss(treeId, treeNode) {

	};

	//获取树状图选种的值
	function onClick(e, treeId, treeNode) {
		if (treeNode.valid == 1) {
			$("#branchId").val(treeNode.id);
			$("#branchName").val(treeNode.name);
		}
	}
</script>

<div class="rightCon">
	<div class="rightNav">

		<c:if test="${empty mapUnit.id}">
			<h2 class="titIcon wyIcon">添加小区信息</h2>
		</c:if>

		<c:if test="${not empty mapUnit.id}">
			<h2 class="titIcon wyIcon">编辑小区信息</h2>
		</c:if>

		<div class="rightNav-sub">
			<a href="/admin/unit/list" title="返回" class="cur">返回</a>
		</div>
	</div>


	<div class="cont_box_wrap">
		<div class="msgBox category mt20">
			<form action="/admin/unit/edit" method="post" id="pageForm"
				enctype="multipart/form-data">
				<div class="category no-border-top">
					<table style="width: 100%" class="inv-table">
						<tbody>
							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label><span class="color-red">*</span>小区名称：</label></th>
								<td>
									<c:if test="${empty mapUnit.id}">
										<input type="hidden" name='id' value="0">
										<div vdfld="um">
											<input type="text" name="unitName" id="unitName" validate="isnotEmpty" class="form-control" value="${mapUnit.unitName}">
											<div class="tip-normal error" vderr="um" style="display: none;">
												<span class="errorIcon"></span>请输入小区名称
											</div>
										</div>
									</c:if>
									<c:if test="${not empty mapUnit.id}">
									<input type="hidden" name='id' value="${mapUnit.id}">
									<input type="text" name="unitName" id="unitName" class="form-control" value="${mapUnit.unitName}" readonly="readonly">
									</c:if>
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label><span class="color-red">*</span>公司架构：</label></th>
								<td>
									<div vdfld="branchName" class="user-box-body form-relative-input">
										<input type="text" name="branchName" id="branchName" validate="isnotEmpty" class="form-control" value="${mapUnit.branchName}" placeholder="选择公司架构" disabled="disabled"> 
										<span class="msgAddBtn" js="showCompanyBranchTree"></span>
										<div class="tip-normal error" vderr="branchName" style="display: none;">
											<span class="errorIcon"></span>选择公司架构
										</div>
									</div> <input type="hidden" name="branchId" id="branchId" value="${mapUnit.branchId}" validate="isnotEmpty">
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150">
								<label><span class="color-red">*</span>区/县：</label></th>
								<td>
								省： <select id="province" name="province" class="guest-num" onChange="proChange()" style="width: 25%;">
										<c:forEach items="${provinces}" var="province">
											<option value="${province.provinceId}"
												<c:if test="${provinceId==province.provinceId}">
													selected="selected"
												</c:if>>
												${province.provinceName}
											</option>
										</c:forEach>
								    </select> 
								    市： <select id="city" name="city" class="guest-num"
									onChange="cityChange()" style="width: 25%;">
								</select> 
								区/县： <select id="district" name="districtId" class="guest-num" style="width: 25%;">
								</select>
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label><span class="color-red">*</span>地址：</label></th>
								<td>
									<div vdfld="address">
										<input type="text" name="address" id="address" validate="isnotEmpty" class="form-control" value="${mapUnit.address}">
										<div class="tip-normal error" vderr="address" style="display: none;">
											<span class="errorIcon"></span>请输入地址
										</div>
									</div>
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label>小区背景：</label></th>
								<td>
									<div class="importInfoBox">
										<span class="span"> <input name="avatar" type="text"
											id="viewfile"
											onmouseout="document.getElementById('upload').style.display='none';"
											class="inputstyle" disabled />
										</span> 
										<label for="upload" onmouseover="document.getElementById('upload').style.display='block';" class="file1">浏览...</label> 
										<input type="file" accept=".jpg" onchange="document.getElementById('viewfile').value=this.value;this.style.display='none';" class="file" id="upload" name="unitImg" />
									</div>
								</td>
							</tr>
							
							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label>小区纬度：</label></th>
								<td>
									<div vdfld="longitude">
										<input type="text" name="lantitude" id="lantitude" validate="isLargerThanZero1" class="form-control" value="${mapUnit.lantitude}">
										<div class="tip-normal error" vderr="lantitude" style="display: none;">
											<span class="errorIcon"></span>请输入数字
										</div>
									</div>
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label>小区经度：</label></th>
								<td>
									<div vdfld="lantitude">
										<input type="text" name="longitude" id="longitude" validate="isLargerThanZero1" class="form-control" value="${mapUnit.longitude}">
										<div class="tip-normal error" vderr="longitude" style="display: none;">
											<span class="errorIcon"></span>请输入数字
										</div>
									</div>
								</td>
							</tr>

							<tr height="50px" class="wuye-content-hide">
								<th width="150"><label>备注：</label></th>
								<td><textarea name="remark" id="remark" class="form-control" rows=" " style="height: 100px;">${mapUnit.remark}</textarea>
								</td>
							</tr>
							<tr class="wuye-content-hide" height="80px">
								<th></th>
								<td>
									<a href="javascript:void(0);" title="保存" class="btn bntbgGreen btn-submit">保 存</a>
									<a href="/admin/unit/list" title="取消" class="btn bntbgGreen">取消</a>
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
<div class="dialog dialog-choose-obj" id="treeChoicebox"
	style="display: none; width: 450px;">
	<div class="dialog-container">
		<div class="importInfoTitle">
			<span>选择公司架构</span>
		</div>
		<div class="choose-obj-dialog-con">
			<div class="zTreeDemoBackground left">
				<ul id="treeDemos" class="ztree"></ul>
			</div>
		</div>
		<div class="winBtnBox mt20">
			<a href="javascript:void(0);" title="确定" js="selectCompanyBranchTree"
				class="btn bntbgGreen">确 定</a> <a href="javascript:void(0);"
				title="关闭" js="closeCompanyBranchTree"
				class="btn bntbgGreen dialog-close">关 闭</a>
		</div>
	</div>
	<a class="icon icon-close dialog-close"></a>
</div>
<!-- 弹出层结束 -->

<!-- 表单页面遮罩 -->
<div class="black-opacity click-disappear"></div>
