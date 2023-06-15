var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('.navi-bottom').outerHeight();
$(window).scroll(function(event){
    didScroll = true;
});
setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 250);
function hasScrolled() {
    var st = $(this).scrollTop();
    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta) return;
    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > navbarHeight){
        // Scroll Down
        $('.navi-bottom').removeClass('nav-down').addClass('nav-up');
    } else {
        // Scroll Up
        if(st + $(window).height() < $(document).height()) {
            $('.navi-bottom').removeClass('nav-up').addClass('nav-down');
        }
    }
    lastScrollTop = st;
}





$('.main_banner').slick({
    autoplay: true,
    autoplaySpeed: 4000,
    fade: true,
    dots: true,
    arrows:false,
    pauseOnHover:false,
    adaptiveHeight: false
});

$('.cf_slide').slick({
    infinite: true,
    centerMode: true,
    cssEase: 'linear',
    slidesToShow: 1,
    infinite: true,
    variableWidth: true,
    arrows:false,
    dots: true,
    customPaging : function(slider, i) {
        var thumb = $(slider.$slides[i]).data();
        if (i=='0'){
            i = "공기청정기";
        }
        else if (i=='1'){
            i = "클린미스트";
        }
        else if (i=='2'){
            i = "칫솔살균기";
        }
        return '<a class="dot">'+i+'</a>';
    }
});

$('.new-item-slide').bxSlider({
    mode: 'horizontal',
    auto:true,
    autoDelay:10,
    minSlides:1,
    maxSlides: 5,
    slideWidth:650,
    moveSlides:1,
    pause:5000,
    controls:true,
    pager:false
});



$('.event-banner-wrap .event-banner ul').bxSlider({
    mode: 'fade',
    auto:true,
    autoDelay:10,
    autoControls:true,
    minSlides:1,
    moveSlides:1,
    pause:5000,
    controls:true,
    pager:true,
    pagerType:'short'
});

$(window).scroll(function(){

    var w_st = $(window).scrollTop();
    if(w_st >= 1000) {
        // $('#gnbWrap .gnb').addClass('active');
        $('.tab-wrap ul').addClass('active');
        $('.tab-wrap ul li').addClass('active');
    } else {
        // $('#gnbWrap .gnb').removeClass('active');
        $('.tab-wrap ul').removeClass('active');
        $('.tab-wrap ul li').removeClass('active');
    }
});

// 전체상품탭
$('.all-product .all-tab li').click(function(){
    var tab_id = $(this).attr('id');
    var tab_con_id = $("#"+tab_id+"_con");

    $(".all-product .all-tab li").removeClass('active');
    $(this).addClass('active');
    $(".all-product .ec-base-product").removeClass('active');
    tab_con_id.addClass('active');
});
// 인테리어탭
$(".interior-list .grid").addClass('active');
setTimeout(function(){
    $(".interior-list .grid").removeClass('active');
    $(".interior-list .grid.first").addClass('active');
}, 1000);
$('.interior-list .all-tab li').click(function(){
    var tab_id = $(this).attr('id');
    var tab_con_id = $("#"+tab_id+"_con");

    $(".interior-list .all-tab li").removeClass('active');
    $(this).addClass('active');
    $(".interior-list .grid").removeClass('active');
    tab_con_id.addClass('active');
});



var winH = $(window).height()||window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
function addBlock() {
    $('body').append('<div class="block"></div>');
    //$('body, html, #wrap').css({'overflow': 'hidden','height': winH});
    $('.block').fadeIn(300);

}
$(document).on('click', '.pop-close', function(e) {
    e.preventDefault();
    $('.block').trigger('click');
});
function deleteBlock(){
	$('.block').fadeOut(300);
	$('.block').detach();
	//$('body, html, #wrap').css({'height':'','overflow':''});
}
//popup
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
