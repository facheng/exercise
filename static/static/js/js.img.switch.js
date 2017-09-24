(function(b){
	jQuery.fn.extend({imageSwitch:function(d){
		if(typeof Fai == "undefined") {
			alert("must import fai.js");
			return;
		}
		var c = b.extend({
			title: true,
			desc: false,
			btn: true,
			repeat: "no-repeat",
			position: "50% 50%",
			titleSize: 14,
			titleFont: "Verdana,宋体",
			titleColor: "#FFF",
			titleTop: 4,
			titleLeft: 4,
			descSize: 12,
			descFont: "Verdana,宋体",
			descColor: "#FFF",
			descTop: 2,
			descLeft: 4,
			btnWidth: 15,
			btnHeight: 15,
			btnMargin: 4,
			playTime: 4000,
			animateTime: 1500,
			animateStyle: "o",
			index: 0,
			from: "module"
		}, d);
		return b(this).each(function(){
			var s = b(this);
			var u = c.width || s.width();
			var g = c.height || s.height();
			var y = c.data.length;
			var e = c.index;
			s.css("overflow", "hidden");
			s.height(g);
			if(c.width && c.from == "module"){
				s.width(c.width);
			}
			var p = "none";
			if(c.data.length > 1){
				p = c.btn ? "block" : "none";
			}
			var t = b('<div class="imageSwitchBtnArea"/>').appendTo(s).css("position", "absolute").css("zIndex", 3).css("display", p);
			b("<div />").appendTo(s);
			var m = b('<div class="imageSwitchShowName" />').appendTo(s)
															.css("position", "absolute")
															.css("display", "none")
															.css("zIndex", 2)
															.css("width", b.browser.msie && b.browser.version == 6 ? b(s).parent().parent().width() + "px" : b(s).parent().width() + "px")
															.css("height", 30 + "px")
															.css("line-height", 30 + "px")
															.css("background-color", "#131414")
															.css("filter", "alpha(opacity=50)")
															.css("opacity", 0.5);
			if(c.showImageName){
				m.css("display", "block");
			}
			var h = b('<div class="switchGroup"  id="switchGroup"/>').appendTo(s)
																	 .css("width", (c.width <= s.width()) ? c.width : "100%")
																	 .css("position", "relative")
																	 .height("y,show-y".indexOf(c.animateStyle) != -1 ? g * y : g);
			var o = 0;
			b.each(c.data, function(B,D){
				var A = "";
				if(!D.href){
					A = "onclick='return false;'";
				}
				if(D.width && D.width > 0) {
					b('<a hidefocus="true" style="outline:none;" ' + A + "/>").appendTo(h)
																			  .css("width", "100%")
																			  .css("height", g + "px")
																			  .attr("href", D.href ? D.href : "javascript:;")
																			  .attr("target", D.target ? D.target : "")
																			  .attr("title", D.tip ? D.tip : "")
																			  .css("cursor", D.href ? "pointer" : "default")
																			  .css("background-position", c.position)
																			  .css("background-repeat", c.repeat)
																			  .css("overflow", "hidden")
																			  .css("display", "block")
																			  .css("float", "x,show-x".indexOf(c.animateStyle) != -1 ? "left" : "")
																			  .html("<img src='" + D.src + "' width='" + D.width + "' height='" + D.height + "'>");
				} else {
					b('<a hidefocus="true" style="outline:none;" ' + A + "/>").appendTo(h)
																			  .css("width", "100%")
																			  .css("height", g + "px")
																			  .attr("href", D.href ? D.href : "javascript:;")
																			  .attr("target", D.target ? D.target : "")
																			  .attr("title", D.tip ? D.tip : "")
																			  .css("cursor", D.href ? "pointer" : "default")
																			  .css("background-image", "url(" + D.src + ")")
																			  .css("background-position", c.position)
																			  .css("background-repeat", c.repeat)
																			  .css("overflow", "hidden")
																			  .css("display", "block")
																			  .css("float", "x,show-x".indexOf(c.animateStyle) != -1 ? "left" : "");
				}
				var C = b('<a class="imageSwitchBtn" />').appendTo(t).html("<span>" + (B + 1) + "</span>");
				o += Fai.getDivWidth(C);
				var z = b('<span class="spanHiddenName"/>').appendTo(m).css("margin-left", 10 + "px").text(D.tip);
				if(B == e){
					C.addClass("imageSwitchBtnSel");
					z.addClass("spanShowName");
				}
			});
			if(t.parents("#banner").length > 0){
				t.appendTo(h);
			}
			t.width(o);
			var k = s.parent();
			var n = k.width();
			if(b.browser.msie && b.browser.version == 6){
				n = k.parent().width();
			}
			var f = k.height();
			if(c.from == "module") {
				if(n > c.width){
					n = c.width;
				}
			} else {
				if(n > c.width){
					n = c.width + (n - c.width) / 2;
				}
				if(n > s.width()){
					n = s.width();
				}
			}
			if(f > g){
				f = g;
			}
			t.css("top", (f - t.height()) + "px");
			if(t.parents("#banner").length > 0) {
				t.css("right", "0px");
			} else {
				t.css("left", (n - o) + "px");
			}
			var l = t.children("a");
			var v = h.children("a");
			var q = m.children("span");
			var r = n - o;
			m.css("top", (f - t.height() - 4) + "px").css("left", 0 + "px");
			var i = b.browser.msie && b.browser.version == 6 ? parseInt(j() + 30) : parseInt(j() + 20);
			if(r > i) {
				t.css("top", (f - t.height()) + "px");
			} else {
				t.css("top", (f - t.height() - 30) + "px");
			}
			function j(){
				if(q.length > 0){
					var A = b(q[0]).width();
					for(var z = 1; z < q.length; z++){
						if(A < b(q[z]).width()){
							A = b(q[z]).width();
						}
					}
					return A;
				}
				return 0;
			}
			if("o,show,none".indexOf(c.animateStyle) != -1){
				v.each(function(z, A){
					if(e != z){
						b(this).hide();
					}
					b(this).css("position", "absolute");
					b(this).css("left", "0");
					b(this).css("top", "0");
				});
			}
			l.click(function(){
				var z = l.index(this);
				if(z == e){
					return;
				}
				l.eq(e).removeClass("imageSwitchBtnSel");
				l.eq(z).addClass("imageSwitchBtnSel");
				q.eq(e).removeClass("spanShowName");
				q.eq(z).addClass("spanShowName");
				switch(c.animateStyle){
					case "o":
						v.eq(e).fadeOut(c.animateTime, "failinear");
						v.eq(z).fadeIn(c.animateTime, "failinear");
						break;
					case "x":
						h.animate({marginLeft: -z * u}, c.animateTime);
						break;
					case "y":
						h.animate({marginTop: -z * g}, c.animateTime);
						break;
					case "show":
					case "show-x":
					case "show-y":
						v.eq(e).hide(c.animateTime);
						v.eq(z).show(c.animateTime);
						break;
					case"none":
						v.eq(e).hide();
						v.eq(z).show();
						break;
				}
				e = z;
			});
			var x = "imageSwitch" + Math.random();
			function w(){
				l.eq((e + 1) % y).click();
			}
			Fai.addInterval(x, w, c.playTime);
			Fai.startInterval(x);
			if(typeof c.mouseoverId != "undefined") {
				b("#" + c.mouseoverId).mouseover(function(){
					Fai.stopInterval(x);
				});
				b("#" + c.mouseoverId).mouseout(function(){
					Fai.startInterval(x);
				});
			} else {
				s.mouseover(function(){
					Fai.stopInterval(x);
				});
				s.mouseout(function(){
					Fai.startInterval(x);
				});
			}
		});
	}});
})(jQuery);



