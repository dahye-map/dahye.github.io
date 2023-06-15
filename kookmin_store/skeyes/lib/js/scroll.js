// JavaScript Document
//Scroll
	$.fn.ssuScroll= function(options){
		var $this = this;
		var bar = $('.scroll_bar',this);

		var cont, contT, barH, currTop, currWheel, Before_pageY, After_pageY ;
		this.contH = 1004;



		/*
		this.ssuScrollinit = function(){
			console.log('ssuScrollinit');
		}
		this.ssuScrollinit();
		*/



		function Default(){
			//contH = $('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight));
			barH = (((window.innerHeight || document.documentElement.clientHeight)  - 102) * ((window.innerHeight || document.documentElement.clientHeight)  - 102)) / $('#gnb_list').height();
			contT = $('#gnb_list').css('top');
			currTop = $('.scroll_bar').css('top');
		}

		function Scroll(){
			Default();

			// 유동적 bar
			if($('#gnb_contents').height() > (window.innerHeight || document.documentElement.clientHeight) ){ //컨텐츠 내용이 많을 때
				bar.css('height',barH);
				currTop = parseInt(bar.css('top'));
			}else{ //컨텐츠 내용이 적을 때
				$('#gnb_scroll_rail').css('display','none');
				var cont_margin = ((window.innerHeight || document.documentElement.clientHeight)  - 102) - $('#gnb_list').height();
				$('#gnb-sub .gnb-sub-box').css('margin-bottom',cont_margin);
				RemoveEventHandler();
			}

			// touch
			$('#gnb_contents').bind('touchstart',function(e){
				Before_pageY = e.originalEvent.touches[0].pageY || e.originalEvent.changedTouches[0].pageY;

				$('#gnb_contents').bind('touchmove',function(e){
					t = parseInt(bar.css('top'));
					After_pageY = e.originalEvent.touches[0].pageY || e.originalEvent.changedTouches[0].pageY;

					if(Before_pageY - After_pageY < 0){
						currTop = t - After_pageY/100;
					}else{
						currTop = t + Before_pageY/100;
					}
					//contH = $('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight) );
					barH = (((window.innerHeight || document.documentElement.clientHeight)  - 102) * ((window.innerHeight || document.documentElement.clientHeight)  - 102)) / $('#gnb_list').height();

					if (currTop <= 0){
						$('.scroll_bar').css('top',0);
					}else if(currTop >= (contH - barH)){
						var contV = $('#gnb_list').height() + parseInt($('#gnb_list').css('top'));
						if(contV < ((window.innerHeight || document.documentElement.clientHeight) - 102)){
							contT = ((window.innerHeight || document.documentElement.clientHeight) - 102) - $('#gnb_list').height();
							$('#gnb_list').css('top',contT);
						}
					}else{
						$('.scroll_bar').css('top',currTop);
					}
					contMove();
					e.preventDefault();
				});
			});
			/*$('#gnb_contents').bind('touchend',function(e){
				e.preventDefault();
				$('#gnb_contents').unbind('touchmove');
			});*/

			$('#gnb_container').bind('contextmenu',function(event){return false;});
			$('#gnb_container').bind('mousedown',function(event){return false;});

			//Mouse

			mouse()	;
			reSize();
			AddEventHandler();
		}

		function AddEventHandler(){
			var elem = document.getElementById ('gnb_contents');
            if (elem.addEventListener) {    // all browsers except IE before version 9
                elem.addEventListener ('mousewheel', MouseScroll, false); // Internet Explorer, Opera, Google Chrome and Safari
                elem.addEventListener ('DOMMouseScroll', MouseScroll, false); // Firefox
            }
            else {
                if (elem.attachEvent) { // IE before version 9
                    elem.attachEvent ('onmousewheel', MouseScroll);
				}
            }
		}

		function RemoveEventHandler(){
			var elem = document.getElementById ('gnb_contents');
            if (elem.removeEventListener) {    // all browsers except IE before version 9
                elem.removeEventListener ('mousewheel', MouseScroll, false); // Internet Explorer, Opera, Google Chrome and Safari
                elem.removeEventListener ('DOMMouseScroll', MouseScroll, false); // Firefox
            }
            else {
                if (elem.detachEvent) { // IE before version 9
                    elem.detachEvent ('onmousewheel', MouseScroll);
                }
            }
		}

		function mouse(){
			bar.bind('mousedown.ssuScroll',function(e){
				//contH = $('#gnb_list').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight));
				//$('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight));
				barH =  $('.scroll_bar').height();

				$(this).css('opacity',1.0);
				t = parseInt($('.scroll_bar').css('top'));
				pageY = e.pageY;
				console.log('t:'+t)	;
				$(document).bind('mousemove.ssuScroll',function(e){
					currTop = t + e.pageY - pageY ;
					//console.log('currTop : '+currTop);
					console.log('드래그 contH : '+contH);
					//console.log('barH : '+barH);
					if (currTop <= 0){
						bar.css('top',0);
					}else if(currTop >= (contH - barH)){
						currTop = contH - $('.scroll_bar').height();
						bar.css('top',currTop);

					}else{
						bar.css('top',currTop);
					}
					contMove();
				});

				$(document).bind('mouseup.ssuScroll', function(e) {
					$(this).css('opacity',0.2);
					$(document).unbind('mousemove.ssuScroll');
					});
				});
				bar.bind('mouseout',function(e){
					$(this).css('opacity',0.4);
				});
			}
		}

		function reSize() {
			$(window).bind('resize.ssuScroll',function(e){

				//contH = $('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight));
				console.log('리사이즈 contH : '+contH);
				barH = (((window.innerHeight || document.documentElement.clientHeight)  - 102) * ((window.innerHeight || document.documentElement.clientHeight)  - 102)) / $('#gnb_list').height();
				$('.scroll_bar').css('height',barH);
				if($('#gnb_list').height() < ((window.innerHeight || document.documentElement.clientHeight) - 102)){
					contT = 0;
					currTop = 0;
					$('#gnb_list').css('top',contT);
				}else {
					var contV = $('#gnb_list').height() + parseInt($('#gnb_list').css('top'));
					if(contV < ((window.innerHeight || document.documentElement.clientHeight) - 102)){
						contT = ((window.innerHeight || document.documentElement.clientHeight) - 102) - $('#gnb_list').height();
						$('#gnb_list').css('top',contT);
					}else{
						contT = $('#gnb_list').height() - ((window.innerHeight || document.documentElement.clientHeight) - 102);
						currTop = ( barH * contT ) / ((window.innerHeight || document.documentElement.clientHeight) - 102);
						$('#gnb_list').css('top',-contT);
					}
				}
				currTop = contH - $('.scroll_bar').height();
				$('.scroll_bar').css('top',currTop);
				contMove();
			});
		}


		function MouseScroll (e) {
            currTop = parseInt($('.scroll_bar').css('top'));
			//contH = $('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight));
            if ('wheelDelta' in event) {
				rolled = (event.wheelDelta) * 0.5;
				currTop = currTop - rolled;
				if(currTop < 0){
					currTop = 0
				}else if(currTop >= (contH - $('.scroll_bar').height())){
					currTop = contH - $('.scroll_bar').height();
				}
				$('.scroll_bar').css('top',currTop);
            }
            else {  // Firefox
                    // The measurement units of the detail and wheelDelta properties are different.
                rolled = -40 * event.detail;
				currTop = currTop - rolled;
				if(currTop < 0){
					currTop = 0;
				}else if(currTop >= (contH - $('.scroll_bar').height())){
					currTop = contH - $('.scroll_bar').height();
				}
				$('.scroll_bar').css('top',currTop);
            }
			contMove();
        }

		//content move
		function contMove(){
			currTop = parseInt($('.scroll_bar').css('top'));
			contT = - ((currTop * ($('#gnb_list').height() - (window.innerHeight || document.documentElement.clientHeight)  + 72 )) / ((window.innerHeight || document.documentElement.clientHeight)  - 72 - $('.scroll_bar').height())) ;
			$('#gnb_list').css('top',contT);
		}

		this.init = function(){
		//function init(){
			var currWheel, Before_pageY, After_pageY = 0;
			contT = $('#gnb_list').css('top',0);
			currTop = $('.scroll_bar').css('top',0);
			console.log('init contH :' +contH);
			//contH = $('#gnb_contents').height() - ($('#gnb_container').height() - (window.innerHeight || document.documentElement.clientHeight) );
			barH = (((window.innerHeight || document.documentElement.clientHeight)  - 102) * ((window.innerHeight || document.documentElement.clientHeight)  - 102)) / $('#gnb_list').height();
		}

		function removeEvent(e){
			$(document).unbind('.ssuScroll');
			$(window).unbind('resize.ssuScroll');
			$('#gnb_container').unbind('contextmenu');
			$('#gnb_container').unbind('mousedown');
			$('#gnb_contents').unbind('touchstart');
			$('#gnb_contents').unbind('touchmove');
			$('#gnb_contents').unbind('touchend');
		}

		//gnb click
		$('.gnb-menu a').bind('click',function(){ // 레이어 클릭시
			$('#gnb-sub').fadeIn(300);   // 레이어 보임
			$('html').css('overflow','hidden');
	    	//$(window).bind('touchmove', handler);
			//console.log('contH1 :' +contH);
			$this.init();
			Scroll();
		});
	 
		$('.gnb-menu-close a').click(function(){ // 레이어 close버튼
	    	$('#gnb-sub').fadeOut(300);       // 레이어 사라짐
			$('html').css('overflow','auto');
	    	//$(window).unbind('touchmove', handler);4
			removeEvent();
		});
