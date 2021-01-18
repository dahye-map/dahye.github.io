var controller = new ScrollMagic.Controller();
$(document).ready(function(){
    AOS.init({
      disableMutationObserver: false,
      offset: 250,
      easing: 'ease'
    });


var mi = $('strong.txtWarn').text().replace(/[^\d]+/g, '');
var total = $('#total_order_sale_price_view').text().replace(/[^\d]+/g, '');
if(mi >= total) {
    $('#input_mile').val(total.replace(/[^\d]+/g, ''));
} else {
    $('#input_mile').val(mi.replace(/[^\d]+/g, ''));
}
return;

var getParameters = function (paramName) {
    var returnValue;

    var url = location.href;

    var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');

    for (var i = 0; i < parameters.length; i++) {
        var varName = parameters[i].split('=')[0];
        if (varName.toUpperCase() == paramName.toUpperCase()) {
            returnValue = parameters[i].split('=')[1];
            return decodeURIComponent(returnValue);
        }
    }
};
var flag = false;
var paramFlag = getParameters('flag');
if(getParameters('product_no') == 10 && !flag && paramFlag !== 'Y' ) {
    flag = true;
    window.location.replace('https://100labs.co.kr/product/detail_salon.html?product_no=' + getParameters('product_no')+'&flag=Y');
}
if(getParameters('product_no') == 14 && !flag && paramFlag !== 'Y' ) {
    flag = true;
    window.location.replace('https://100labs.co.kr/product/detail_salon.html?product_no=' + getParameters('product_no')+'&flag=Y');
}
if(getParameters('product_no') == 17 && !flag && paramFlag !== 'Y' ) {
    flag = true;
    window.location.replace('https://100labs.co.kr/product/detail_salon.html?product_no=' + getParameters('product_no')+'&flag=Y');
}
if(getParameters('product_no') == 18 && !flag && paramFlag !== 'Y' ) {
    flag = true;
    window.location.replace('https://100labs.co.kr/product/detail_salon.html?product_no=' + getParameters('product_no')+'&flag=Y');
}
if(getParameters('product_no') == 23 && !flag && paramFlag !== 'Y' ) {
    flag = true;
    window.location.replace('https://100labs.co.kr/product/detail_salon.html?product_no=' + getParameters('product_no')+'&flag=Y');
}

    //gnb
    $('.btn-menu').click(function(e){
        e.preventDefault();
        var _Gnb = false;
        if(!_Gnb){
            _Gnb = true;
            if(!$('#gnbWrap .gnb').hasClass('active')){
                $('#gnbWrap .gnb').addClass('active');
                $('body').append('<div class="gnb-block">');
            } else {
                $('#gnbWrap .gnb').removeClass('active');
                $('.gnb-block').fadeOut(300).empty().remove();
            }
        }
    });

    $('.btn-close').click(function(){
        $('#gnbWrap .gnb').removeClass('active');
        $('.gnb-block').fadeOut(300).empty().remove();
    });

    //quick-menu
    $(window).scroll(function(){
        var st = $(window).scrollTop();
        if(st >= 50) {
            $('.quick-menu').addClass('active');
        } else {
            $('.quick-menu').removeClass('active');
        }
    });

    var swiper = new Swiper('.brand-slide-wrap', {
        slidesPerView: 1,
        slidesPerView: 'auto',
        loop:true,
        spaceBetween: 25,
        pagination: {
            el: '.swiper-pagination',
            type: 'progressbar',
        },
        on:{
            slideChangeTransitionEnd: function(){
                if(this.activeIndex == 0 || this.activeIndex==1){
                    $('.section01 .tit-big').html('우리집에서 즐기는 <br>엄마의 목욕탕 스킨케어 비법');
                } else {
                    $('.section01 .tit-big').html('유기농 쌀 본연의 힘으로 환한 피부를 ‘짓다‘')
                }
            }
        }
    });

    if($('.brand-slide .recipe')){
        $('.section01 .tit-big').html('우리집에서 즐기는 <br>엄마의 목욕탕 스킨케어 비법')
    }
    if($('.brand-slide .salon')){
        $('.section01 .tit-big').html('유기농 쌀 본연의 힘으로 환한 피부를 ‘짓다‘')
    }
});
