//弹出操作窗口
	function showWindow(){
		$(".overlay").show();
		$(".inv-form").show();
	};
	function closeWindow(){
		$(".overlay").hide();
		$(".inv-form").hide();
	};
	function showWin(a,b){		
		$("."+a+"").show();
		$("."+b+"").show();
	};
	function closeWin(a,b){
		$("."+a+"").hide();
		$("."+b+"").hide();
	};
	$(".moreShow").click(function(){
		$(this).hide().siblings(".moreHide").show();
		$(".searchTips").stop().slideDown(500);
		localStorage.removeItem("searchTips");
		//$(".moreDCon .mid ul li").stop().slideDown(500)
	});
	$(".moreHide").click(function(){
		$(this).hide().siblings(".moreShow").show();
		$(".searchTips").stop().slideUp(500);
		localStorage.setItem("searchTips","searchTips");//设置缓存		
		//$(".moreDCon .mid ul li").stop().slideUp(500)	
	});
