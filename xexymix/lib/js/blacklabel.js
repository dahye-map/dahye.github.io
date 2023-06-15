
$(window).scroll(function(){
    $('.flexy-list-wrap .swiper-slide').each(function(){
        var offsetTopPosition = $(this).offset().top - $(window).scrollTop();
        if (offsetTopPosition < 980) {
            $(this).find('.bar-fill').addClass('active');
        }
    });
});

var swiper = new Swiper('.slide-img-wrap', {
    slidesPerView: 'auto',
    loop:true,
    speed: 5000,
    spaceBetween: 20,
    autoplay: {
        delay: 0,
        disableOnInteraction: false,
      },
});


var flexyThumbs = new Swiper('.flexy-list-thumbs', {
      spaceBetween: 15,
      slidesPerView: 5,
      freeMode: true,
      watchSlidesVisibility: true,
      watchSlidesProgress: true,
    });

var flexyTop = new Swiper('.flexy-list-wrap', {
  thumbs: {
    swiper: flexyThumbs
  }
});

$('.highflexy .length-tab a').click(function(){
    var length_id = $(this).attr('id');
    var color_id = $("#"+length_id+"_color");
    var img_id = $("#"+length_id+"_color_img");

    $(".highflexy .length-tab a").removeClass('active');
    $(this).addClass('active');
    $(".highflexy .color-tab").removeClass('active');
    color_id.addClass('active');
    $(".highflexy .color-img-tab").removeClass('active');
    img_id.addClass('active');
});
$('.joggings .length-tab a').click(function(){
    var length_id = $(this).attr('id');
    var color_id = $("#"+length_id+"_color");
    var img_id = $("#"+length_id+"_color_img");

    $(".joggings .length-tab a").removeClass('active');
    $(this).addClass('active');
    $(".joggings .color-tab").removeClass('active');
    color_id.addClass('active');
    $(".joggings .color-img-tab").removeClass('active');
    img_id.addClass('active');
});



//하이플렉시
$('#9bu_color span').click(function(){
    var nine_class = $(this).attr("class");
    var nine_img_class = $("#9bu_color_img ."+nine_class+"-img");

    $('#9bu_color span').removeClass('active');
    $(this).addClass('active');
    $('#9bu_color_img span').removeClass('active');
    nine_img_class.addClass('active');
});
$('#85bu_color span').click(function(){
    var eight_class = $(this).attr("class");
    var eight_img_class = $("#85bu_color_img ."+eight_class+"-img");

    $('#85bu_color span').removeClass('active');
    $(this).addClass('active');
    $('#85bu_color_img span').removeClass('active');
    eight_img_class.addClass('active');
});
$('#5bu_color span').click(function(){
    var five_class = $(this).attr("class");
    var five_img_class = $("#5bu_color_img ."+five_class+"-img");

    $('#5bu_color span').removeClass('active');
    $(this).addClass('active');
    $('#5bu_color_img span').removeClass('active');
    five_img_class.addClass('active');
});

//하이플렉시 조깅스
$('#9bujo_color span').click(function(){
    var jo_class = $(this).attr("class");
    var jo_img_class = $("#9bujo_color_img ."+jo_class+"-img");

    $('#9bujo_color span').removeClass('active');
    $(this).addClass('active');
    $('#9bujo_color_img span').removeClass('active');
    jo_img_class.addClass('active');
});

// 하이플렉시 릴렉스
$('#9bure_color span').click(function(){
    var re_class = $(this).attr("class");
    var re_img_class = $("#9bure_color_img ."+re_class+"-img");

    $('#9bure_color span').removeClass('active');
    $(this).addClass('active');
    $('#9bure_color_img span').removeClass('active');
    re_img_class.addClass('active');
});

// 하이플렉시 vup
$('#9buv_color span').click(function(){
    var v_class = $(this).attr("class");
    var v_img_class = $("#9buv_color_img ."+v_class+"-img");

    $('#9buv_color span').removeClass('active');
    $(this).addClass('active');
    $('#9buv_color_img span').removeClass('active');
    v_img_class.addClass('active');
});

// 하이플렉시 워터레깅스
$('#9buw_color span').click(function(){
    var w_class = $(this).attr("class");
    var w_img_class = $("#9buw_color_img ."+w_class+"-img");

    $('#9buw_color span').removeClass('active');
    $(this).addClass('active');
    $('#9buw_color_img span').removeClass('active');
    w_img_class.addClass('active');
});
