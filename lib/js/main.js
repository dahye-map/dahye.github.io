var winW  = $(window).width();
$(document).ready(function(e) {
    var _isClick = false;
    var slide = $('.visual-slide-wrap ul').bxSlider({
        control: true,
        auto: true,
        speed: 600,
        mode: 'fade',
        nextText : '',
        prevText : '',
        onSliderLoad: function(currentIndex){
            $('.visual-slide-wrap ul li').eq(0).addClass('active');
        },
        onSlideAfter: function($slideElement, oldIndex, newIndex){
            if(!_isClick){
                Motion(newIndex);
            }else{
                setTimeout(function(){
                    _isClick = false;
                    slide.goToSlide(slide.getCurrentSlide()+1);
                },4600);
            }
        }
    });
    $('.bx-controls-direction > a').on('click',function(e){
        Motion(slide.getCurrentSlide());
        e.preventDefault();
    });
    function Motion(_newIndex){
        var bgSrc = $('.visual-slide-wrap ul li').eq(_newIndex).data('slide-bg');
        $('.visual-slide-wrap ul li').removeClass('active');
        $('.visual-slide-wrap ul li').eq(_newIndex).addClass('active');
        $('#mainWrap').css('background-image','url('+bgSrc+')');
    }

    if ($(window).width() >= 768) {
		$('.news-list').slimScroll({
			width : 'auto',
			height : '268px',
            position : 'right',
			size : '7px',
            railVisible: true,
            railColor: '#dadada',
            railOpacity: 1,
			alwaysVisible : true,
			touchScrollStep: 50,
			color: '#f00024'
		});
	}else{
		$('.news-list').slimScroll({
			width : 'auto',
			height : '268px',
			size : '7px',
			alwaysVisible : true,
			touchScrollStep: 50,
			color: '#f00024'
		});
	}
});

/**
 * PC 인지 모바일인지 판단하기
 * return true : pc
 * return false : mobile
 *
 */
var isPc = (function() {
	var filter = "win16|win32|win64|mac";
	var isPc = true;

	if( navigator.platform  ){
		if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
		//("모바일 기기에서 접속");
			return false;
		}else{
		//("PC에서 접속");
			return true;
		}
	}
});
