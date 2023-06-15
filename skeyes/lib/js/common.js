
//roll
jQuery(function(){
	var rollover = {
		newimage: function(src) {
			return src.substring(0, src.search(/(\.[a-z]+)$/)) + '_on' + src.match(/(\.[a-z]+)$/)[0];
		},
		oldimage: function(src) {
			return src.replace(/_on\./, '.');
		},
		init: function() {
			$('.roll').hover(

			function() {
				$(this).attr('src', rollover.newimage($(this).attr('src')));
			}, function() {
				$(this).attr('src', rollover.oldimage($(this).attr('src')));
			});
		}
	};
	rollover.init();
});

$(document).ready(function(){
	//scroll top
    $('.btn-top').click(function(){
        $('html, body').animate({ scrollTop: 0 }, 800);
        return false;
    });

	//menu
	var handler = function(e){e.preventDefault();}
	$('.menu a').on('click',function(){
		$('html').css({'overflow':'hidden'});
		$('.layer-popup-bg').css({'height': $(window).height()}).fadeIn(300);
		$('#gnb-list').css({'left':'50%','margin-left':-($('#gnb-list').width()/2)}).fadeIn(300);
		$(window).bind('touchmove', handler);
	});
	$('.gnb-close a').on('click',function(){
		$('html').css({'overflow':''});
		$('.layer-popup-bg').fadeOut(300);
		$('#gnb-list').fadeOut(300);
		$(window).unbind('touchmove', handler);
	});

	if ($(window).width() >= 768) {
		$('#scroll').slimScroll({
			width : 'auto',
			height : '90%',
			size : '7px',
			alwaysVisible : false,
			touchScrollStep: 50,
			color: '#fff'
		});

		$('#gnb-list > div ul li ul li').hover(function(){
			$(this).css({'background':'#222'});
		}, function() {
			$(this).css({'background':'none'});
		});
	}else{
		$('#scroll').slimScroll({
			width : 'auto',
			height : '85%',
			size : '7px',
			alwaysVisible : false,
			touchScrollStep: 50,
			color: '#fff'
		});
	}

	//기사 페이지 이동
	var totalNum = $('.skarticle').length-1;
	$('.article-navi div').click(function(e){
		e.preventDefault();
		console.log(totalNum);
		if ($(this).index()==0){
			location.href=$('.skarticle').eq(currentMenu-1).find('a').attr('href');
			if (currentMenu==0){
				location.href=$('.skarticle').eq(totalNum).find('a').attr('href');
			}
		} else if ($(this).index()==1){
			location.href=$('.skarticle').eq(currentMenu+1).find('a').attr('href');
			if (currentMenu==totalNum){
				location.href=$('.skarticle').eq(0).find('a').attr('href');
			}
		}
	});

	//selectbox
	var selectTarget = $('.select-box select');

	selectTarget.change(function(){
		var select_name = $(this).children('option:selected').text();
		$(this).siblings('label').text(select_name);
	});

});
