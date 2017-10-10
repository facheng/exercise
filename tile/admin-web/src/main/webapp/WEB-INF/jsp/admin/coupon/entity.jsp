<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>优惠类型</title>
	<%@include file="/common/css.jsp" %>
	<%@ include file="/common/taglib.jsp" %>
</head>
<body>
	<div class="widget-box">
		<div class="widget-title">
			<span class="icon"> <i class="icon-align-justify"></i>
			</span>
			<h5>优惠类型</h5>
		</div>
		<div class="widget-content nopadding">
			<form action="save" method="post" class="form-horizontal" id="couponForm">
				<div class="control-group">
					<label class="control-label">优惠券名称 :</label>
					<div class="controls">
						<input type="hidden" name="id" value="${entity.id}"/>
						<input type="text" id="name" name="name" value="${entity.name}" style="width: 205px" class="{required:true,messages:{required:'优惠券名称不能为空!'}}" placeholder="优惠券名称" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">类型编码 :</label>
					<div class="controls">
						<select id="code" name="code">
							<option value="1" 
							 <c:if test="${entity.code == 1}">
								selected="selected"
							</c:if> >优惠码</option>
							<option value="2" 
							<c:if test="${entity.code == 2}">
									selected="selected"
							</c:if>>电商广告</option>
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">是否上架 :</label>
					<div class="controls">
						<input type="radio" id="onShelf" name="onShelf" value="0" <c:if test="${empty entity.onShelf}">checked="checked"</c:if><c:if test="${entity.onShelf == 0}">checked="checked"</c:if>> 未上架
						&nbsp;&nbsp;&nbsp;
						<input type="radio" id="onShelf" name="onShelf" value="1" <c:if test="${entity.onShelf == 1}">checked="checked"</c:if>> 已上架
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">类型 :</label>
					<div class="controls">
						<select id="ctype" name="ctype">
							<option value="1" 
							 <c:if test="${entity.ctype == 1}">
								selected="selected"
							</c:if> >家政宝</option>
							<option value="2" 
							<c:if test="${entity.ctype == 2}">
									selected="selected"
							</c:if>>生活宝</option>
							<option value="3" 
							<c:if test="${entity.ctype == 3}">
									selected="selected"
							</c:if>>商旅宝</option>
							<option value="4" 
							<c:if test="${entity.ctype == 4}">
									selected="selected"
							</c:if>>爱车宝</option>
							<option value="5" 
							<c:if test="${entity.ctype == 5}">
									selected="selected"
							</c:if>>生活缴费</option>
							<option value="6" 
							<c:if test="${entity.ctype == 6}">
									selected="selected"
							</c:if>>生活秘籍</option>
							
						</select>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">优惠金额 :</label>
					<div class="controls">
						<input type="text" id="price" name="price" value="${entity.price}" style="width: 205px" placeholder="优惠劵金额" class="{number:true}"/>元
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">优惠区域 :</label>
					<div class="controls">
						<textarea id="region" name="region" rows="2" placeholder="优惠区域" style="width: 50%">${entity.region}</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">发券商家 :</label>
					<div class="controls">
						<input type="text" id="sponsor" name="sponsor" value="${entity.sponsor}" style="width: 50%" placeholder="发券商家" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">有效期 :</label>
					<div class="controls">
						<input type="text" id="deadline" name="deadline" value="${entity.deadline}" style="width: 50%" placeholder="有效期" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">使用规则 :</label>
					<div class="controls">
						<textarea id="rule" name="rule" rows="2" placeholder="使用规则" style="width: 50%" >${entity.rule}</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">查询方式 :</label>
					<div class="controls">
						<textarea id="queryMethod" name="queryMethod" rows="1" placeholder="查询方式" style="width: 50%" >${entity.queryMethod}</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">客服电话 :</label>
					<div class="controls">
						<textarea id="servicePhone" name="servicePhone" rows="1" placeholder="客服电话" style="width: 50%" >${entity.servicePhone}</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">URL :</label>
					<div class="controls">
						<input type="text" id="url" name="url" value="${entity.url}" style="width: 50%" placeholder="优惠劵链接" />
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">优惠劵编码 :</label>
					<div class="controls">
						<textarea id="cpCode" name="cpCode" rows="4" placeholder="优惠劵编码" style="width: 50%" ></textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label">备注 :</label>
					<div class="controls">
						<textarea id="remark" name="remark" rows="2" placeholder="备注" style="width: 50%" >${entity.remark}</textarea>
					</div>
				</div>
				
				<div class="form-actions">
					<button type="submit" id="saveBtn" class="btn btn-success">保存</button>
					<button type="button" id="backBtn" backUrl="index" class="btn btn-danger">返回</button>
				</div>
				
			</form>
		</div>
	</div>
</body>
<%@include file="/common/js.jsp" %>
<script type="text/javascript" src="${basePath}defaultEdit.js"></script>
<script type="text/javascript" src="${basePath}wisdom.js"></script>
</html>