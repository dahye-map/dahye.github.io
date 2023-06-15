
$(document).ready(function(){
    AOS.init({
      disableMutationObserver: false,
      offset: 250,
      easing: 'ease'
    });

    var win_W = $(window).width();
    //gnb
    $('.all-menu').click(function(e){
        e.preventDefault();
        var _Gnb = false;
        if(!_Gnb){
            _Gnb = true;
            if(!$('.all-menu').hasClass('active')){
                $('.all-menu, .gnb-wrap, .header .logo').addClass('active');
                $('#headerWrap.light .header').css('box-shadow', 'none');
                $('body').append('<div class="gnb-block">');
                // if(win_W <= 1280){
                //     $('body, html, #containerWrap').css({'overflow': 'hidden'}).bind('touchmove');
                // }
                //$('body, html, #containerWrap').css({'overflow': 'hidden'});
            } else {
                $('.all-menu, .gnb-wrap, .header .logo').removeClass('active');
                $('#headerWrap.light .header').css('box-shadow', '');
                $('.gnb-block').fadeOut(300).empty().remove();
                // if(win_W <= 1280){
                //     $('body, html, #containerWrap').css({'overflow' : 'visible'}).unbind('touchmove');
                // }
                //$('body, html, #containerWrap').css({'overflow' : ''});
            }
        }
    });
    $(window).scroll(function(){
        var header = $('#headerWrap .header'),
            scroll = $(window).scrollTop();

        if (scroll >= 100) {
            header.addClass('fixed');
            $('#headerWrap .header.fixed .logo.visible-xs img').attr('src', '/web/upload/images/img_logo02.png');
        } else {
            header.removeClass('fixed');
            $('#headerWrap .header .logo.visible-xs img').attr('src', '/web/upload/images/img_logo01.png');
        }
    });


    $('.input-wrap input, .input-wrap textarea').click(function(){
        $(this).parent('li').addClass('focus');
    });


    //footer
    var footer = $('#footerWrap').offset();
    var footer_H = $('#footerWrap').outerHeight();
    var footerBottom = $('#footerBottom');
    $(window).scroll(function(){
        var top            = $('#footerBottom').offset().top,
            documentHeight = $(document).height(),
            viewportHeight = $('#footerWrap').outerHeight(),

            moveTop = Math.round(Math.floor(top-documentHeight+viewportHeight)/5),
            percent = moveTop / $('#footerBottom').height() + 1,

            opacity = 1,
            scale   = 1;
        if ($( document ).scrollTop() >= Math.ceil(footer.top)-footer_H) {
            $('#footerBottom').css('opacity',1);
            opacity = 4.5 - (percent*5),
            scale   = 1 + (percent/5);

            $('#footerBottom .txt').css({marginTop: -moveTop});
            $('.jump-mask').css({opacity: opacity});

            $('#footerBottom figure').css({
                'transform': 'scale('+scale+')',
                '-ms-transform': 'scale(\''+scale+'\')',
            })
        }
    });



    // 다크모드 라이트모드
    $('.mode-change').click(function(){
        if(!$('#containerWrap').hasClass('light')){
            $('#containerWrap, #headerWrap, #footerWrap, #wrap').addClass('light');
            $('#containerWrap, #headerWrap, #footerWrap, #wrap').removeClass('dark');
            $('.theme-icon').css('background', 'url("/web/upload/images/ico_moon.png") center no-repeat');

            //career복지부분
            var i;
            for(i=1; i<=21; i++){
                $('.welfare-img.type'+i+' img').attr('src', '/web/upload/images/ico_welfare'+i+'.png');
            }
        } else {
            $('#containerWrap, #headerWrap, #footerWrap, #wrap').addClass('dark');
            $('#containerWrap, #headerWrap, #footerWrap, #wrap').removeClass('light');
            $('.theme-icon').css('background', 'url("/web/upload/images/ico_sun.png") center no-repeat');

            //career복지부분
            var i;
            for(i=1; i<=21; i++){
                $('.welfare-img.type'+i+' img').attr('src', '/web/upload/images/ico_welfare'+i+'_dark.png');
            }
        }
    });


    //아코디언
    var _isSlide = false;
    $('.accordian-list').click(function(e) {
        e.preventDefault();
        $target = $(this).next('.accordian-con');
        var allPanels = $('.accordian-con');
        if(!_isSlide){
            _isSlide = true;
            if(!$target.hasClass('active')){
                allPanels.slideUp(500).removeClass('active');
                $target.slideDown(500).addClass('active');

            } else {
                $target.slideUp(500).removeClass('active');
            }
            setTimeout(function(){_isSlide=false;},500);
        }
    });

    //브랜드상세 top
    var swiper = new Swiper('.brand-top', {
        slidesPerView: '1',
        pagination: {
            el: '.progressbar',
            type: 'progressbar',
          }
    });
    var counter = $('.fraction');
    var total = $('.swiper-slide').length;
    var currentCount = $('<span class="count">1' + ' / '+ total +'<span/>');
    counter.append(currentCount);

    swiper.on('transitionStart', function () {
        var index = this.activeIndex + 1;
        currentCount = $('<span class="count next">' + index +' / '+total + '<span/>');
        counter.html(currentCount);
    });


    //타이틀 따라다니기
    var secOffset = $('.section01').offset();
    $(window).scroll(function(){
        if ( $(document).scrollTop() >= secOffset.top + 250  &&  $('.section01').height() + secOffset.top > $(document).scrollTop()) {
            $( '.section01' ).addClass( 'fixed' );
        } else {
            $( '.section01' ).removeClass( 'fixed' );
        }


        //그래프
        $('.lazy').each(function(){
            var offsetTopPosition = $(this).offset().top - $(window).scrollTop();
            if (offsetTopPosition < 980) {
                $(this).addClass('on');
            }
        });
    });

});
