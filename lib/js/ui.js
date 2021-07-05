$(document).ready(function(){


    var swiper_pro = new Swiper('.mo-cate-list', {
        slidesPerView: 'auto',
        spaceBetween: 10,
    });
    
    var swiper = new Swiper('.mainb-wrap', {
        pagination: {
            el: '.mainb-pagination',
        },
    });
    
    var swiper_pro = new Swiper('.prob-wrap', {
        loop:true,
        effect: 'fade',
        pagination: {
            el: ".swiper-pagination",
            type: "progressbar",
        },
    });
    
    var swiper_pro = new Swiper('.best-list-slide', {
        slidesPerView:'auto',
        spaceBetween: 22,
        observer: true,
        observeParents: true,
        resistance : true,
    
    });
    
    
    $('.lang-wrap').on('mouseenter focusin',function(){
        // $('#countryWrap').addClass('active');
        // $('#headerWrap').css('margin-top', '691px');
        // $('html').css('overflow', 'hidden');
        $('.lang-wrap .lang-drop').addClass('active');
    });
    $('.lang-wrap').on('mouseleave',function(){
        $('.lang-wrap .lang-drop').removeClass('active');
    });
    
    $('.btn-close').click(function(){
        $('#countryWrap').removeClass('active');
        $('#headerWrap').css('margin-top', '');
        $('html').css('overflow', '');
    });
    
    
    // gnb
    var prevEnterDepthIdx;
    var _isGnbOpen = false;
    if (!_isGnbOpen) {
        _isGnbOpen = true;
        $('.depth1 > a').on('mouseenter focusin',function(){
            var idx = $('.depth1 > a').index($(this));
            if (prevEnterDepthIdx != idx) {
                $('.depth2-wrap').removeClass('active');
                $('.depth1 > a').removeClass('active');
            }
            $(this).addClass('active').siblings('.depth2-wrap').addClass('active');
            prevEnterDepthIdx = idx;
        });
    }
    
    // bag
    var BagEnterDepthIdx;
    var _isBagOpen = false;
    if (!_isBagOpen) {
        _isBagOpen = true;
        $('.util-list > a').mouseenter(function(){
            var idx = $('.util-list > a').index($(this));
            if (BagEnterDepthIdx != idx) {
                $('.orderListArea').removeClass('active');
                $('.util-list > a').removeClass('active');
            }
            $(this).addClass('active').siblings('.orderListArea').addClass('active');
            BagEnterDepthIdx = idx;
        });
    }
    
    $('#headerWrap').on('mouseleave', function(){
        $('.depth2-wrap, .orderListArea').removeClass('active');
        $('.depth1 > a, .xans-layout-orderbasketcount > a').removeClass('active');
        $('.lang-wrap .lang-drop').removeClass('active');
    });
    
    
    //네비 2depth
    var _isSlide = false;
    $('.accordian-list > li > a').click(function() {
        $target = $(this).next('.content');
        var allPanels = $('.content');
        if(!_isSlide){
            _isSlide = true;
            if(!$target.hasClass('active')){
                allPanels.slideUp(500).removeClass('active');
                $target.slideDown(500).addClass('active');
                $('.accordian-list > li > a').removeClass('active');
                $(this).addClass('active');
    
            } else {
                $target.slideUp(500).removeClass('active');
                $(this).removeClass('active');
            }
            setTimeout(function(){_isSlide=false;},200);
        }
    });
    
    // 모바일 햄버거
    $('.menu').click(function(){
        $('#navWrap').addClass('active');
    });
    $('.btn-nav-close').click(function(){
        $('#navWrap').removeClass('active');
    });
    
    $('.language').click(function(){
        $('.box').toggleClass('show');
    });
    
    $('.depth.women a').click(function(){
        $('.nav-depth1').fadeOut().removeClass('active');
        setTimeout(function(){
            $('.nav-depth2.women').fadeIn().addClass('active');
        },300);
    });
    $('.depth.men a').click(function(){
        $('.nav-depth1').fadeOut().removeClass('active');
        setTimeout(function(){
            $('.nav-depth2.men').fadeIn().addClass('active');
        },300);
    });
    $('.btn-back-nav').click(function(){
        $('.nav-depth2').fadeOut().removeClass('active');
        setTimeout(function(){
            $('.nav-depth1').fadeIn().addClass('active');
        },300);
    });



    $(window).scroll(function(){
        var scroll = $(window).scrollTop();
        if(scroll >= 10) {
            $('#headerWrap .header.mo, .mo-cate-list').addClass('active');
        } else {
            $('#headerWrap .header.mo, .mo-cate-list').removeClass('active');
        }
        
    });

    $('.lang-selec').click(function(){
        $('.lang-flag, .lang-selec-wrap .lang-selec').toggleClass('active');
    });

});

//팝업
function addBlock() {
    $('body').append('<div class="block"></div>');
    $('.block').fadeIn(300);
}

function deleteBlock(){
    $('.block').fadeOut(300);
    $('.block').detach();
}
function openPopup(id) {
    if ($('.layerpopup').css('display') == 'none') {
        addBlock();
        $('#' + id).css('display', 'block');
    }
}
function closePopup(id) {
    deleteBlock();
    $('#' + id).css('display', 'none');
}



