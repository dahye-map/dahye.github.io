
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700,800" rel="stylesheet">

<link rel="stylesheet" href="https://cdn1-aka.makeshop.co.kr/design/xexymix/renewal/mobile/css/import.css">
<script src="https://cdn1-aka.makeshop.co.kr/design/xexymix/renewal/mobile/js/jquery-1.9.1.min.js"></script>

<!-- swiper -->
<link rel="stylesheet" href="https://cdn1-aka.makeshop.co.kr/design/xexymix/renewal/mobile/js/swiper/swiper.css" />
<script type="text/javascript" src="https://cdn1-aka.makeshop.co.kr/design/xexymix/renewal/mobile/js/swiper/swiper.min.js"></script>

<!-- Global site tag (gtag.js) - Google Ads: 668738992 200211-->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-668738992"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-668738992');
</script>

<!-- Global site tag (gtag.js) - Google Ads: 827336921 190508-->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-827336921"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'AW-827336921');
</script>

<!-- Global site tag (gtag.js) - Google Analytics 2020.01.17 -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-9BXE3VXR5V"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-9BXE3VXR5V');
</script>

<!-- RE:LOAD -->
<script type="text/javascript" charset="utf-8" src="https://cdn1-aka.makeshop.co.kr/design/xexymix/js/rld.js"></script>
<script type="text/javascript">PX2.Reload.create({id:"190523A1", sno:"0004"});</script>
<!-- RE:LOAD. COPYRIGHT Pangpang, Inc. ALL RIGHTS RESERVED. -->



<!-- 스마트스킨 공통 CSS -->
<link rel="stylesheet" type="text/css" href="http://smartskin.co.kr/data/makeshop/standard/common_default/makeshopBodykiller.css">

<!-- 스마트스킨 공통 JS -->
<script id="smartskinCustomJs" src="/design/xexymix/smartskin/custom/makeshopCommonJs_SMS_xexymix.js"></script>
<!-- 스마트스킨 공통 JS -->

<!-- Playback Tracking Code for www.xexymix.com 19.10.25 -->
<script type="text/javascript" src="https://playback-assets.s3.ap-northeast-2.amazonaws.com/playback/js/index.js"></script>
<script type="text/javascript">var playback = new Playback( "WV9r3sWkoHrvLLvwQTCkxmyFxLzEjSZQLo0bVuQGzmbxbGMhtDBQ8gA9Zhjg" );playback.playbackInit();</script>


<script>
window.onload = function() {
  // Month Day, Year Hour:Minute:Second, id-of-element-container
//  countDownToTime("mar 10, 2020 18:24:00", 'countdown1'); // ****** Change this line!
  countDownToTime2("mar 10, 2020 18:24:00", 'countdown2');
}
//function countDownToTime(countTo, id) {
//  countTo = new Date(countTo).getTime();
//  var now = new Date(),
//	  countTo = new Date(countTo),
//	  timeDifference = (countTo - now);
//
//  var secondsInADay = 60 * 60 * 1000 * 24,
//	  secondsInAHour = 60 * 60 * 1000;
//
//
//  hours = Math.floor((timeDifference % (secondsInADay)) / (secondsInAHour) * 1);
//  mins = Math.floor(((timeDifference % (secondsInADay)) % (secondsInAHour)) / (60 * 1000) * 1);
//  secs = Math.floor((((timeDifference % (secondsInADay)) % (secondsInAHour)) % (60 * 1000)) / 1000 * 1);
//
//  hours = hours < 10 ? "0" + hours : hours;
//  mins = mins < 10 ? "0" + mins : mins;
//  secs = secs < 10 ? "0" + secs : secs;
//
//  var idEl = document.getElementById(id);
//
//  idEl.getElementsByClassName('hours')[0].innerHTML = hours;
//  idEl.getElementsByClassName('minutes')[0].innerHTML = mins;
//  idEl.getElementsByClassName('seconds')[0].innerHTML = secs;
//
//  clearTimeout(countDownToTime.interval);
//  countDownToTime.interval = setTimeout(function(){ countDownToTime(countTo, id); },1000);
//}
//
//
function countDownToTime2(countTo, id) {
  countTo = new Date(countTo).getTime();
  var now = new Date(),
	  countTo = new Date(countTo),
	  timeDifference = (countTo - now);

  var secondsInADay = 60 * 60 * 1000 * 24,
	  secondsInAHour = 60 * 60 * 1000;

  /*days = Math.floor(timeDifference / (secondsInADay) * 1);*/
  hours = Math.floor((timeDifference % (secondsInADay)) / (secondsInAHour) * 1);
  mins = Math.floor(((timeDifference % (secondsInADay)) % (secondsInAHour)) / (60 * 1000) * 1);
  secs = Math.floor((((timeDifference % (secondsInADay)) % (secondsInAHour)) % (60 * 1000)) / 1000 * 1);

  hours = hours < 10 ? "0" + hours : hours;
  mins = mins < 10 ? "0" + mins : mins;
  secs = secs < 10 ? "0" + secs : secs;

  var idEl = document.getElementById(id);
  /*idEl.getElementsByClassName('days')[0].innerHTML = days;*/
  idEl.getElementsByClassName('hours')[0].innerHTML = hours;
  idEl.getElementsByClassName('minutes')[0].innerHTML = mins;
  idEl.getElementsByClassName('seconds')[0].innerHTML = secs;

  clearTimeout(countDownToTime2.interval);
  countDownToTime2.interval = setTimeout(function(){ countDownToTime2(countTo, id); },1000);
}
</script>
  <!-- 타임세일 배너 끝-->

/**
* MAIN SHINSEGAE MAGAZINE
* */
var MainMagazine = (function(){
    var g_$window = $(window),
        g_$poster = $(".item-wrap .montly"),
        g_$listBox = $(".item-wrap .item-cont-wrap"),
        g_$posterInner = g_$poster.find("p");

    function init(){
        addEvents();
    }

    function addEvents(){
        g_$window.on("scroll", scroll);
        g_$window.on("resize", resize);

        scroll();
        resize();
        setTimeout(function(){
            scroll();
            resize();
        }, 500);
    }

    function scroll(){
        var m_st = g_$window.scrollTop(),
            //m_posterOffset = g_$poster.offset().top-35,
            m_posterMin = $("header").height(),
            m_posterMaxGap = g_$listBox.height()-g_$posterInner.height(),
            m_posterMax = m_posterMin+m_posterMaxGap;

        if(m_st >= m_posterMin){
            if(m_st >= m_posterMax){
                g_$posterInner.removeClass("fix");
                g_$posterInner.css("top", m_posterMaxGap);
            }else{
                g_$posterInner.addClass("fix");
            }
        }else{
            g_$posterInner.removeClass("fix");
            g_$posterInner.css("top", 0);
        }
    }
    function resize(){
        g_$posterInner.width(g_$poster.width()-40);
    }

    init();
})();


jQuery1_11_0(function(jQuery) {


	//탭상품슬라이드
	if(jQuery('#fixoSlide').length > 0){
		jQuery('#fixoSlide').flexslider({
			animation: "fade", //슬라이드효과(slide, fade)
			slideshowSpeed: 4000, //자동변환속도
			animationSpeed: 600, //슬라이드속도
			easing: "easeInOutCubic", //슬라이드모션
			animationLoop: true, //반복설정
			slideshow: true, //자동변환
			pauseOnHover: false, //슬라이드에마우스오버시멈춤
			controlNav: true, //현재슬라이드위치
			directionNav: false, //좌우버튼
			touch: false, //모바일터치사용여부
			keyboard: false, //키보드반응
			smoothHeight : false, //콘텐츠에맞게자동높이
			manualControls : "#main .section2 .tab_menu a", //현재위치커스텀
			init: function(slider){
				var setHeight = jQuery('#fixoSlide li.fixo-active-slide').height();
				if(jQuery('#fixoSlide').children().hasClass('fixo-viewport') == true){
					jQuery('#fixoSlide .fixo-viewport').css('height', setHeight);
				} else {
					jQuery('#fixoSlide').css('height', setHeight);
				}

				jQuery('#fixoSlide').delay(400).animate({opacity: 1});
			},
			//pauseOnHover false 적용시 활성화(자동변환 사용안할경우 비활성화)
			after: function(slider){ //슬라이드끝나면실행
				if (!slider.playing){
					slider.play();
				}
			}
		});
		//smoothHeight true 적용시 활성화
		jQuery(window).resize(function(){
			var setHeightRe = jQuery('#fixoSlide li.fixo-active-slide').height();
			if(jQuery('#fixoSlide').children().hasClass('fixo-viewport') == true){
				jQuery('#fixoSlide .fixo-viewport').css('height', setHeightRe);
			} else {
				jQuery('#fixoSlide').css('height', setHeightRe);
			}
		});

		jQuery('#main .prd_list_tab .box.small .box_prd .info .info_inner').mouseenter(function(){
			jQuery('.info_box', this).stop().animate({'opacity':'1'}, 300);
		}).mouseleave(function(){
			jQuery('.info_box', this).stop().animate({'opacity':'0'}, 300);
		});
	};
});


//메인 따라다니는 이미지
$(window).load(function(){
    var bestOffset = $('.best-tab-wrap').offset().top;
    var best_monthly = $('.best-tab-wrap .monthly');
    var newOffset = $('.item-wrap.new').offset().top;
    var new_monthly = $('.item-wrap.new .monthly');
    var athOffset = $('.item-wrap.ath').offset().top;
    var ath_monthly = $('.item-wrap.ath .monthly');
    var accOffset = $('.item-wrap.acc').offset().top;
    var acc_monthly = $('.item-wrap.acc .monthly');
    var h_height = $('header').height() + $('.tab-fixed-wrap').height();

    $(window).scroll(function(){

        var w_scroll = $(window).scrollTop();

        //베스트부분
        if ( w_scroll >= bestOffset - 50  &&  $('.best-tab-wrap').height() + bestOffset - 945 > w_scroll) {
            best_monthly.removeClass( 'absolute' );
            best_monthly.addClass( 'fix' );
        } else if( w_scroll >= $('.best-tab-wrap').height() + h_height ) {
            best_monthly.addClass( 'absolute' );
            best_monthly.removeClass( 'fix' );
        } else {
            best_monthly.removeClass( 'fix' );
            best_monthly.removeClass( 'absolute' );
        }

        //신상 부분
        // if ( w_scroll >= newOffset - 50 &&  $('.item-wrap.new').height() + newOffset - 945 > w_scroll) {
        //     new_monthly.removeClass( 'absolute' );
        //     new_monthly.addClass( 'fix' );
        // } else if ( w_scroll <= newOffset ) {
        //     new_monthly.removeClass( 'fix' );
        //     new_monthly.removeClass( 'absolute' );
        // } else if( w_scroll >= $('.item-wrap.new').height() + h_height ) {
        //     new_monthly.addClass( 'absolute' );
        //     new_monthly.removeClass( 'fix' );
        // }

        //애슬레져 부분
        if ( w_scroll >= athOffset - 50 &&  $('.item-wrap.ath').height() + athOffset - 945 > w_scroll) {
            ath_monthly.removeClass( 'absolute' );
            ath_monthly.addClass( 'fix' );
        } else if ( w_scroll <= athOffset ) {
            ath_monthly.removeClass( 'fix' );
            ath_monthly.removeClass( 'absolute' );
        } else if( w_scroll >= $('.item-wrap.ath').height() + h_height ) {
            ath_monthly.addClass( 'absolute' );
            ath_monthly.removeClass( 'fix' );
        }

        //악세사리 부분
        if ( w_scroll >= accOffset - 50 &&  $('.item-wrap.acc').height() + accOffset - 945 > w_scroll) {
            acc_monthly.removeClass( 'absolute' );
            acc_monthly.addClass( 'fix' );
        } else if ( w_scroll <= accOffset ) {
            acc_monthly.removeClass( 'fix' );
            acc_monthly.removeClass( 'absolute' );
        } else if( w_scroll >= $('.item-wrap.acc').height() + h_height ) {
            acc_monthly.addClass( 'absolute' );
            acc_monthly.removeClass( 'fix' );
        }
    });
});
