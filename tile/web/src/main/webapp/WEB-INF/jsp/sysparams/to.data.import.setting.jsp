<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp"%>


<script type="text/javascript">

$(document).ready(function() {
	//close popup
	$('.dialog-close', '.dialog').click(function(){
		$('.dialog, .black-opacity').fadeOut();
	});
	$("#complete").show();
});

//显示弹窗
function showBox(ida,idb){
	if(ida == "importStory"){
		$('#impForm').attr('action','/sys/params/story/import'); 
		$('#templeDownload').attr('href','/static/template/storyImport.xls'); 
	}
	
	if(ida == "importHouse"){
		$('#impForm').attr('action','/sys/params/house/import'); 
		$('#templeDownload').attr('href','/static/template/houseImport.xls'); 
	}
	
	if(ida == "importResident"){
		$('#impForm').attr('action','/sys/params/resident/import'); 
		$('#templeDownload').attr('href','/static/template/residentImport.xls'); 
	}
	
	if(ida == "importKeyDevice"){
		$('#impForm').attr('action','/sys/params/key/import'); 
		$('#templeDownload').attr('href','/static/template/keyDeviceImport.xls'); 
	}
	
	if(ida == "importCarGarage"){
		$('#impForm').attr('action','/sys/params/garage/import'); 
		$('#templeDownload').attr('href','/static/template/carGarageImport.xls'); 
	}
	
	if(ida == "importCarPort"){
		$('#impForm').attr('action','/sys/params/port/import'); 
		$('#templeDownload').attr('href','/static/template/carPortImport.xls'); 
	}
	
	$('.data-import,.black-opacity').fadeIn();
};

function importSubmit(upload){
	var isfile = $("#"+upload+"").val();
	if(isfile == ''){
		alert("请选择需要导入的文件");
		return ;
	}else{
		$("#impForm").submit();
		$("#importView").hide();
		$("#waiting").show();
	}	
}
</script>


<div class="rightCon">
		<div class="rightNav">
			<h2 class="titIcon wyIcon">数据导入</h2>
		</div>
		<div class="detail-box dataImportShll">
			<div class="dataImportBox">
				<div class="dataImportLeft fangwuData">
					<div class="dataImportTitle">楼栋数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importStoryData"><a class="btn_big btnbgViolet" title="楼栋数据导入" href="javascript:void(0)" onclick="showBox('importStory','importStoryBox');">楼栋数据导入</a></div>
					</div>
				</div>
				<div class="dataImportLeft fangwuData">
					<div class="dataImportTitle">房屋数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importHouseData"><a class="btn_big btnbgViolet" title="房屋数据导入" href="javascript:void(0)" onclick="showBox('importHouse','importHousebox');">房屋数据导入</a></div>
					</div>
				</div>
				<div class="dataImportLeft fangwuData">
					<div class="dataImportTitle">住户数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importResidentData"><a class="btn_big btnbgViolet" title="住户数据导入" href="javascript:void(0)" onclick="showBox('importResident','importResidentbox');">住户数据导入</a></div>
					</div>
				</div>
				<div class="dataImportLeft fangwuData">
					<div class="dataImportTitle">钥匙数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importKeyDeviceData"><a class="btn_big btnbgViolet" title="钥匙数据导入" href="javascript:void(0)" onclick="showBox('importKeyDevice','importKeyDevicebox');">钥匙数据导入</a></div>
					</div>
				</div>
				
				<div class="dataImportLeft chekuData">
					<div class="dataImportTitle">车库数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importCarGarageData"><a class="btn_big btnbgViolet" title="车库数据导入" href="javascript:void(0)" onclick="showBox('importCarGarage','importCarGaragebox');">车库数据导入</a></div>
					</div>
				</div>
				
				<div class="dataImportLeft cheweiData">
					<div class="dataImportTitle">车位数据导入</div>
					<div class="dataImportInfo">						
						<div class="dataImportBtn importCarPortData"><a class="btn_big btnbgViolet" title="车位数据导入" href="javascript:void(0)" onclick="showBox('importCarPort','importCarPortbox');">车位数据导入</a></div>
					</div>
				</div>
				
			</div>
			<div class="clear"></div>
		</div>
	</div>

	
<!--导入弹层-->
<form action="" name="impForm" id="impForm" method="post" enctype="multipart/form-data">
<div class="dialog data-import" id="importView">
    <div class="dialog-container ">
    	<div class="text-con-dialog importInfoBox">
        	<p>
				<span>温馨提示：</span><br>
				请先下载批量导入文件并录入数据 
            	<a href="" id="templeDownload">点击下载“批量更新数据”</a>。您导入的文件需为当前系统里最新模版，且字段名称和顺序须与模版相符合。<br>若需人工协助，请致电：+86（21）6160-0112。
			</p>
            <p>请选择要导入的Excel文件：</p>
            <div class="filediv">
                <div class="line">
                    <span class="span">
						<input name="avatar" type="text" id="viewfile" onmouseout="document.getElementById('upload').style.display='none';" class="inputstyle"   disabled />
                    </span>
                    <label for="unload" onmouseover="document.getElementById('upload').style.display='block';" class="file1">浏览...</label>
					<input type="file" accept=".xls" onchange="document.getElementById('viewfile').value=this.value;this.style.display='none';" class="file" id="upload"  name="file"/>
                </div>
			</div>
        </div>
        <div class="winBtnBox mt20">
            <a href="javascript:void(0)" onclick="importSubmit('upload');" title="导入" class="btn bntbgBrown import-confirm-btn">导 入</a>
            <a href="#" title="取消" class="btn bntbgGreen dialog-close">取 消</a>	
        </div>
    </div>
    <a class="icon icon-close dialog-close"></a>
</div>
</form>

<!-- 导入等待  -->
<div class="dialog dialog-importing" style="display:none;" id="waiting">
	<p class="inputInfoStyleP">正在导入数据，请稍等......</p>
	<div class="clear"></div>
</div>

<!-- 完成后 -->
<c:if test="${not empty msg}">
	<div class="dialog dialog-importing" id="complete">
	    <div class="dialog-container ">
	    	<div class="importing-con-dialog">
		    		<c:forEach var="tipMsg" items="${msg}" varStatus="status">
		        	<p>${tipMsg}</p>
		            </c:forEach>
	        </div>
	        <div class="winBtnBox mt20">
	            <a href="/sys/params/data/import" title="确定" class="btn bntbgGreen">确 定</a>	
	        </div>
	    </div>
	    <a class="icon icon-close dialog-close" href="/sys/params/data/import"></a>
	</div>
 </c:if>
<div class="black-opacity"></div>
