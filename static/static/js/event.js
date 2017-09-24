//初始化百度地图
function initMap(tagId, city, address, building){
	var map = new BMap.Map(tagId);
	var myGeo = new BMap.Geocoder();
	/**
	 * 根据地址获得位置坐标，然后实例化百度地图
	 */
	myGeo.getPoint(address, function(point){
		if(point){
			map.enableScrollWheelZoom();          //启用滚轮放大缩小
			map.centerAndZoom(point, 15);          //初始化地图,设置中心点坐标和地图级别。
			map.addControl(new BMap.NavigationControl());  //添加平移缩放控件
			map.addControl(new BMap.OverviewMapControl());  //添加地图缩略图控件
			//创建标注(类似定位小红旗)
			var marker = new BMap.Marker(point);
			//标注提示文本
			var label = new BMap.Label(building, {"offset": new BMap.Size(20, -20)});
			marker.setLabel(label); //添加提示文本
			//创建消息框
			var infoWindow = new BMap.InfoWindow(address);
			//绑定标注单击事件，设置显示的消息框
			marker.addEventListener("click", function(){
				this.openInfoWindow(infoWindow);
			});
			map.addOverlay(marker);  //把标注添加到地图
		}
	}, city);
}

//初始化百度地图
function initMap2(tagId, latitude, longitude, msg){
	var map = new BMap.Map(tagId);
	var point = new BMap.Point(longitude, latitude);
	map.enableScrollWheelZoom();          //启用滚轮放大缩小
	map.centerAndZoom(point, 15);
	map.addControl(new BMap.NavigationControl());  //添加平移缩放控件
	map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
	map.addControl(new BMap.OverviewMapControl());  //添加地图缩略图控件
	//创建标注(类似定位小红旗)
	var marker = new BMap.Marker(point);
	//标注提示文本
	var label = new BMap.Label("我在这里", {"offset": new BMap.Size(20, -20)});
	marker.setLabel(label); //添加提示文本
	//创建消息框
	var infoWindow = new BMap.InfoWindow(msg);
	//绑定标注单击事件，设置显示的消息框
	marker.addEventListener("click", function(){
		this.openInfoWindow(infoWindow);
	});
	map.addOverlay(marker);  //把标注添加到地图
}