var winH = $(window).height()||window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
$(document).ready(function(){
    var gridMb = parseInt($('.grid').css('margin-bottom'));

    // 첫행 높이 계산
    if (winH > 720) { winH = 720; }
    var rowFirstH = winH - 94;
    var gridH = (rowFirstH - gridMb) / 2 ;
    $('.row.first, .visual-banner ul li').height(rowFirstH);
    $('.row.first .grid').each(function(){
        if ($(this).hasClass('news-banner')) {
            $(this).height(gridH - 26);
        }else{
            $(this).height(gridH);
        }
        if($(this).hasClass('slider')){
            $(this).find('ul li').height(gridH);
        }
    });
    // 두번째행 높이 계산
    if (winH > 680) { winH = 680; }
    var gridH2 = (winH - gridMb) / 2 ;
    $('.row.second').height(winH);
    $('.row.second .grid-h').each(function(){
        $(this).height(gridH2);
        if($(this).hasClass('slider')){
            $(this).find('ul li').height(gridH2);
        }
    });
    //over-wrap hover function
    $('.over-wrap').hover(function(){
        $(this).addClass('active');
        setTimeout(function(){$(this).find('.over:after').addClass('active');},200);
    },function(){
        $(this).removeClass('active');
        setTimeout(function(){$(this).find('.over:after').removeClass('active');},200);
    });
    // slider
    $('.visual-banner .txt02').addClass('active');
    var pmBanner = $('.visual-banner ul').bxSlider({
        mode: 'fade',
        auto: true,
        controls: false,
        pager: false,
        pause: 4000,
        speed: 1000,
        easing: 'ease-out',
        onSlideNext: function($slideElement, oldIndex, newIndex){
            // 170926 동서문학상 이벤트 때문에 넣음
            if (newIndex > 0) {
                $('.visual-banner .txt02').removeClass('active');
                $('.visual-banner .txt01').addClass('active');
            }else{
                $('.visual-banner .txt01').removeClass('active');
                $('.visual-banner .txt02').addClass('active');
            }
        },
        onSlidePrev: function($slideElement, oldIndex, newIndex){
            // 170926 동서문학상 이벤트 때문에 넣음
            if (newIndex > 0) {
                $('.visual-banner .txt02').removeClass('active');
                $('.visual-banner .txt01').addClass('active');
            }else{
                $('.visual-banner .txt01').removeClass('active');
                $('.visual-banner .txt02').addClass('active');
            }
        }
    })
    var newsBanner = $('.news-banner ul').bxSlider({
        controls:false,
        auto : true,
        mode : 'fade'
    });
    var newPrdBanner = $('.newprd-banner ul').bxSlider({
        controls:false,
        auto : true
    });
    var csrBanner = $('.csr-banner ul').bxSlider({
        controls:false,
        auto : true,
        mode : 'fade'
    });
    var tvcfBanner = $('.tvcf-banner ul').bxSlider({
        controls:false,
        auto : true,
        mode : 'fade'
    });
    var wzBanner = $('.webzine-banner ul').bxSlider({
        controls:false,
        auto : true,
        mode : 'fade'
    });
    // 하단 배경 이미지 선로드
    $.preloadImages('../images/page/02_products/bg_prd_maxim.jpg','../images/page/02_products/bg_prd_maxwell.jpg','../images/page/02_products/bg_prd_frima.jpg','../images/page/02_products/bg_prd_tarra.jpg','../images/page/02_products/bg_prd_post.jpg','../images/page/02_products/bg_prd_mitte.jpg','../images/page/02_products/bg_prd_top.jpg','../images/page/02_products/bg_prd_philadelphia.jpg','../images/page/02_products/bg_prd_honey.jpg','../images/page/02_products/bg_prd_starbucks.jpg','../images/page/02_products/bg_prd_oreo.jpg');

    var menuBar = $('.brand-menu-wrap .bar');
    var brandBgArr = ['bg_prd_maxim.jpg','bg_prd_maxwell.jpg','bg_prd_frima.jpg','bg_prd_tarra.jpg','bg_prd_post.jpg','bg_prd_mitte.jpg','bg_prd_top.jpg','bg_prd_philadelphia.jpg','bg_prd_honey.jpg','bg_prd_starbucks.jpg','bg_prd_oreo.jpg'];

    $('.brand-menu li button').on('click',function(){
        var idx = $('.brand-menu li').index($(this).parent());
        var firstLipos = $('.brand-menu li:first-child').offset().left;
        var barLeft = $(this).offset().left - firstLipos + 12;
        menuBar.css({'left':barLeft,'width':$(this).width()});
        $('.brand-img').css('background-image',"url('../images/page/02_products/"+brandBgArr[idx]+"')");
        $('.brand').removeClass('active').eq(idx).addClass('active');
    });
    // // 가오픈때만.
    // $('.brand-prd li a').on('click',function(e){
    //     e.preventDefault();
    // });
});
