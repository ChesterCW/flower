$(function(){	

$.getJSON("/Passport/Login/LoginState?rmd="+Math.random(), function(json){    //登陆信息显示
		var loginUrl="/Passport/Login/?backUrl="+location.href;
		var loginInfo='<a href="'+loginUrl+'" rel="nofollow">你好，请登录</a><a href="https://img02.hua.com/Passport/Register/" rel="nofollow">注册</a>';
		var loginedHtml='<p class="avatar_imgbox"><img src="avatar_none.jpg"/*tpa=https://img02.hua.com/pc/assets/img/mbar/avatar_none.jpg*/></p>你好！请 <a href="'+loginUrl+'">登录</a> | <a href="https://img02.hua.com/Passport/Register/">注册</a>';
		if(json.Logined==true)
		{
			loginedHtml='<p class="avatar_imgbox"><img src="avatar.jpg"/*tpa=https://img02.hua.com/pc/assets/img/mbar/avatar.jpg*/></p><a href="https://img02.hua.com/Member/MemberCenter/">'+json.ShowName+'</a>，你好！'
			if(json.IsVip==true)
			{
				loginedHtml=loginedHtml+'<i class="ico_vip"></i>'
			}
			loginInfo = '<a href="https://img02.hua.com/Member/MemberCenter/" rel="nofollow">你好，' + json.ShowName + '</a><a href="https://img02.hua.com/Passport/Login/Loginout" title="退出">退出</a>';

			if (json.Grade == "4") {
			    $("#liGrad4").show();
			    $("#liGrad").hide();
			}
			else {
			    $("#liGrad4").hide();
			    $("#liGrad").show();
			}
		}
		if($("#loginStats").length>0){$("#loginStats").html(loginedHtml);}
		if ($("#LoginInfo").length > 0) { $("#LoginInfo").html(loginInfo); }
		
});

$.getJSON("/shopping/getcartjson?rmd="+Math.random(), function(json){    //购物车信息显示
		if($("#gwcCount").length>0){
			$("#gwcCount").html("("+json.productsNum+")");
		}
		if($("#cart_num").length>0){
			$("#cart_num").html(json.productsNum);
		}	

		var cartInfo='';
		if(json.productsNum==0)
		{
			cartInfo='<div class="empty">您的购物车中没有商品，<a href="https://img02.hua.com/">先去选购吧</a>！</div>'
		}
		else
		{
			cartInfo='<div class="cargo">'
			$.each(json.datas,function(index,data){
				cartInfo=cartInfo+'<div class="com-list"><div class="img-box"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html" target="_blank"><img src="//img01.hua.com/uploadpic/newpic/'+data.productCode+'.jpg_80x87.jpg" width="50" height="53"></a></div><div class="title"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html" target="_blank">'+data.productName+'</a></div><div class="num">'+data.productNum+'</div><div class="price"><span class="price-sign text-primary">&yen; </span><span class="price-num text-primary strong"> '+data.productPrice+'</span></div></div>';
			});
			cartInfo=cartInfo+'<div class="settlement"><div class="total-price"><span><strong class="text-primary">'+json.productsNum+'</strong> 件总计:</span><span class="price-sign text-primary strong">&yen; </span><span class="price-num text-primary strong"> '+json.productsMoney+'</span></div><a href="https://img02.hua.com/shopping/showcart" class="btn btn-primary btn-sm" target="_blank">去购物车结算</a></div></div>';
		}
		if($("#CartInfo").length>0){$("#CartInfo").html(cartInfo);}
	});
});

	//ds.base
	(function(global, document, undefined){
		var 
		rblock = /\{([^\}]*)\}/g,
		ds = global.ds = {
			noop: function(){},
			//Object
			mix: function(target, source, cover){
				if(typeof source !== 'object'){
					cover = source;
					source = target;
					target = this;
				}
				for(var k in source){
					if(cover || target[k] === undefined){
						target[k] = source[k];
					}
				}
				return target;
			},
			//BOM
			scrollTo: (function(){
				var 
				duration = 480,
				view = $(global),
				setTop = function(top){ global.scrollTo(0, top);},
				fxEase = function(t){return (t*=2)<1?.5*t*t:.5*(1-(--t)*(t-2));};
				return function(top, callback){
					top = Math.max(0, ~~top);
					var 
					tMark = new Date(),
					currTop = view.scrollTop(),
					height = top - currTop,
					fx = function(){
						var tMap = new Date() - tMark;
						if(tMap >= duration){
							setTop(top);
							return (callback || ds.noop).call(ds, top);
						}
						setTop(currTop + height * fxEase(tMap/duration));
						setTimeout(fx, 16);
					};
					fx();
				};
			})(),
			requestAnimationFrame: (function(){
				var handler = global.requestAnimationFrame || global.webkitRequestAnimationFrame || 
					global.mozRequestAnimationFrame || global.msRequestAnimationFrame || 
					global.oRequestAnimationFrame || function(callback){
						return global.setTimeout(callback, 1000 / 60);
					};
				return function(callback){
					return handler(callback);
				};
			})(),
			animate: (function(){
				var 
				easeOut = function(pos){ return (Math.pow((pos - 1), 3) + 1);};
				getCurrCSS = global.getComputedStyle ? function(elem, name){
					return global.getComputedStyle(elem, null)[name];
				} : function(elem, name){
					return elem.currentStyle[name];
				};
				return function(elem, name, to, duration, callback, easing){
					var 
					from = parseFloat(getCurrCSS(elem, name)) || 0,
					style = elem.style,
					tMark = new Date(),
					size = 0;
					function fx(){
						var elapsed = +new Date() - tMark;
						if(elapsed >= duration){
							style[name] = to + 'px';
							return (callback || ds.noop).call(elem);
						}
						style[name] = (from + size * easing(elapsed/duration)) + 'px';
						ds.requestAnimationFrame(fx);
					};
					to = parseFloat(to) || 0;
					duration = ~~duration || 200;
					easing = easing || easeOut;
					size = to - from;
					fx();
					return this;
				};
			})(),
			isIE6: !-[1,] && !global.XMLHttpRequest
		};
	
	})(this, document);
	
	
	;(function(global){var ds=global.ds||(global.ds={});var rarg1=/\$1/g,rgquote=/\\"/g,rbr=/([\r\n])/g,rchars=/(["\\])/g,rdbgstrich=/\\\\/g,rfuns=/<@\s*(\w+|.)([\s\S]*?)\s*@>/g,rbrhash={'10':'n','13':'r'},helpers={'=':{render:'__.push($1);'}};ds.tmpl=function(tmpl,data){var render=new Function('_data','var __=[];__.data=_data;'+'with(_data){__.push("'+tmpl.replace(rchars,'\\$1').replace(rfuns,function(a,key,body){body=body.replace(rbr,';').replace(rgquote,'"').replace(rdbgstrich,'\\');var helper=helpers[key],tmp=!helper?key+body:typeof helper.render==='function'?helper.render.call(ds,body,data):helper.render.replace(rarg1,body);return'");'+tmp+'__.push("';}).replace(rbr,function(a,b){return'\\'+(rbrhash[b.charCodeAt(0)]||b);})+'");}return __.join("");');return data?render.call(data,data):render;};ds.tmpl.helper=helpers;})(this);
	
	
	jQuery(function($){
		//创建DOM
		var 
		quickHTML = document.querySelector("div.quick_link_mian"),
		quickShell = $(document.createElement('div')).html(quickHTML).addClass('quick_links_wrap'),
		quickLinks = quickShell.find('.quick_links');
		quickPanel = quickLinks.next();
		quickShell.appendTo('.mui-mbar-tabs');
		
		//具体数据操作 
		var 
		quickPopXHR,
		loadingTmpl = '<div class="loading" style="padding:30px 80px"><i></i><span>Loading...</span></div>',
		popTmpl = '<a href="javascript:;" class="ibar_closebtn" title="关闭"></a><div class="ibar_plugin_title"><h3><@=title@></h3></div><div class="pop_panel"><@=content@></div><div class="arrow"><i></i></div><div class="fix_bg"></div>',
		quickPop = quickShell.find('#quick_links_pop'),
		quickDataFns = {
			//购物车
			message_list: {
				title: '',
				content: '',
				init:$.noop
			},
			//我的关注
			history_list: {
				title: '',
				content: '',
				init: $.noop
			},
			//最近查看
			mpbtn_histroy:{
				title: '',
				content: '',
				init: $.noop
			}
		};
		
		//showQuickPop
		var 
		prevPopType,
		prevTrigger,
		doc = $(document),
		popDisplayed = false,
		hideQuickPop = function(){
			$(".quick_links_wrap,.mui-mbar-tabs").width(0);
			if(prevTrigger){
				prevTrigger.removeClass('current');
			}
			popDisplayed = false;
			prevPopType = '';
			quickPop.hide();
			quickPop.animate({left:280,queue:true});
		},
		showQuickPop = function(type){
			$(".quick_links_wrap,.mui-mbar-tabs").width(320);
			if(type == "mpbtn_recharge")$(".quick_links_wrap,.mui-mbar-tabs").width(0);
			if(quickPopXHR && quickPopXHR.abort){
				quickPopXHR.abort();
			}
			if(type !== prevPopType){
				var fn = quickDataFns[type];
				$.ajaxSettings.async = false; //设置getJson同步
				if(type=="message_list")
				{
					$.getJSON("/shopping/getCartJson?rmd="+Math.random(), function(json){
						fn.title="购物车";
						var cartHtml='';
						if(json.productsNum==0)
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">你的购物车还是空的，赶紧行动吧！</div></div>'
						}
						else
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">共 '+json.productsNum+' 件商品</div>'
							$.each(json.datas,function(index,data){
								cartHtml=cartHtml+'<div class="com-list"><div class="img-box"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html"><img src="//img01.hua.com/uploadpic/newpic/'+data.productCode+'.jpg_80x87.jpg"></a></div><div class="title"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html">'+data.productName+'</a></div><div class="price"><span class="price-sign text-primary">&yen;</span><span class="price-num text-primary strong">'+data.productPrice+'</span><span class="com-num">&times; '+data.productNum+'</span></div></div>';
							});
							cartHtml=cartHtml+'<div class="com-total"><div class="info">'+json.productsNum+' 件商品<div class="price"><span class="price-sign text-primary">&yen; </span><span class="price-num text-primary strong"> '+json.productsMoney+'</span></div></div><a href="https://img02.hua.com/shopping/showcart" class="btn btn-primary">去购物车结算</a></div>';
						}
						fn.content=cartHtml;
					});
				}
				else if(type=="history_list")
				{
					$.getJSON("/Home/getAttentionJson?rmd="+Math.random(), function(json){
						fn.title="我的收藏";
						var cartHtml='';
						if(json.productsNum==0)
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">你还没有收藏的商品！</div></div>'
						}
						else
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">共收藏了 '+json.productsNum+' 件商品</div>'
							$.each(json.datas,function(index,data){
								cartHtml=cartHtml+'<div class="com-list"><div class="img-box"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html"><img src="//img01.hua.com/uploadpic/newpic/'+data.productCode+'.jpg_80x87.jpg"></a></div><div class="title"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html">'+data.productName+'</a></div><div class="price"><span class="price-sign text-primary">&yen;</span><span class="price-num text-primary strong">'+data.productPrice+'</span><a href="/shopping/AddtoCart?product_code='+data.productCode+'" class="btn btn-primary btn-sm">加入购物车</a></div></div>';
							});
							if(json.productsNum>4)
							{
								cartHtml=cartHtml+'<div class="com-list" style="text-align:right;"><a href="https://img02.hua.com/member/order/myattention">查看更多&gt;&gt;</a></div>';
							}
						}
						fn.content=cartHtml;
					});
				}
				else if(type=="mpbtn_histroy")
				{
					$.getJSON("/Home/getLatestJson?rmd="+Math.random(), function(json){
						fn.title="最近查看";
						var cartHtml='';
						if(json.productsNum==0)
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">还没有最近查看的商品！</div></div>'
						}
						else
						{
							cartHtml='<div class="ibar_plugin_content"><div class="sub_title">共 '+json.productsNum+' 件商品</div>'
							$.each(json.datas,function(index,data){
								cartHtml=cartHtml+'<div class="com-list"><div class="img-box"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html"><img src="//img01.hua.com/uploadpic/newpic/'+data.productCode+'.jpg_80x87.jpg"></a></div><div class="title"><a href="https://img02.hua.com/product/%27+data.productCode+%27.html">'+data.productName+'</a></div><div class="price"><span class="price-sign text-primary">&yen;</span><span class="price-num text-primary strong">'+data.productPrice+'</span><a href="/shopping/AddtoCart?product_code='+data.productCode+'" class="btn btn-primary btn-sm">加入购物车</a></div></div>';
							});
						}
						fn.content=cartHtml;
					});
				}
				quickPop.html(ds.tmpl(popTmpl, fn));
				fn.init.call(this, fn);
			}
			doc.unbind('click.quick_links').one('click.quick_links', hideQuickPop);
	
			quickPop[0].className = 'quick_links_pop quick_' + type;
			popDisplayed = true;
			prevPopType = type;
			quickPop.show();
			quickPop.animate({left:0,queue:true});
		};
		quickShell.bind('click.quick_links', function(e){
			e.stopPropagation();
		});
		quickPop.delegate('a.ibar_closebtn','click',function(){
			$(".quick_links_wrap,.mui-mbar-tabs").width(0);												 
			quickPop.hide();
			quickPop.animate({left:280,queue:true});
			if(prevTrigger){
				prevTrigger.removeClass('current');
			}
		});
	
		//通用事件处理
		var 
		view = $(window),
		getHandlerType = function(className){
			return className.replace(/current/g, '').replace(/\s+/, '');
		},
		showPopFn = function(){
			var type = getHandlerType(this.className);
			if(popDisplayed && type === prevPopType){
				return hideQuickPop();
			}
			showQuickPop(this.className);
			if(prevTrigger){
				prevTrigger.removeClass('current');
			}
			prevTrigger = $(this).addClass('current');
		},
		quickHandlers = {
			//购物车，最近浏览，商品咨询
			my_qlinks: showPopFn,
			message_list: showPopFn,
			history_list: showPopFn,
			// leave_message: showPopFn,
			mpbtn_histroy:showPopFn,
			mpbtn_recharge:showPopFn,
			//返回顶部
			return_top: function(){
				ds.scrollTo(0, 0);
				hideReturnTop();
			}
		};
		quickShell.delegate('a', 'click', function(e){
			var type = getHandlerType(this.className);
			if(type && quickHandlers[type]){
				quickHandlers[type].call(this);
				e.preventDefault();
			}
		});
		
		//Return top
		var scrollTimer, resizeTimer, minWidth = 1350;
	
		function resizeHandler(){
			clearTimeout(scrollTimer);
			scrollTimer = setTimeout(checkScroll, 160);
		}
		
		function checkResize(){
			quickShell[view.width() > 1340 ? 'removeClass' : 'addClass']('quick_links_dockright');
		}
		function scrollHandler(){
			clearTimeout(resizeTimer);
			resizeTimer = setTimeout(checkResize, 160);
		}
		function checkScroll(){
			view.scrollTop()>100 ? showReturnTop() : hideReturnTop();
		}
		function showReturnTop(){
			quickPanel.addClass('quick_links_allow_gotop');
		}
		function hideReturnTop(){
			quickPanel.removeClass('quick_links_allow_gotop');
		}
		view.bind('scroll.go_top', resizeHandler).bind('resize.quick_links', scrollHandler);
		resizeHandler();
		scrollHandler();
	});

	$(".quick_links_panel li").mouseenter(function(){
		$(this).children(".mp_tooltip").animate({left:-120,queue:true});
		$(this).children(".mp_tooltip").css("visibility","visible");
		$(this).children(".ibar_login_box").css("display","block");
	});
	$(".quick_links_panel li").mouseleave(function(){
		$(this).children(".mp_tooltip").css("visibility","hidden");
		$(this).children(".mp_tooltip").animate({left:-150,queue:true});
		$(this).children(".ibar_login_box").css("display","none");
	});
	$(".quick_toggle li").mouseover(function(){
		$(this).children(".mp_qrcode").show();
	});
	$(".quick_toggle li").mouseleave(function(){
		$(this).children(".mp_qrcode").hide();
	});