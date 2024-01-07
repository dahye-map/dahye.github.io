$(function () {
  $(document).ready(function () {

    // 메인 스와이퍼
    var ww = $(window).width();
    var mySwiper = undefined;

    function initSwiper() {
      if (ww > 768 && mySwiper == undefined) {
        mySwiper = new Swiper(".about-swiper", {
          initialSlide: 1,
          slidesPerView: "auto",
          spaceBetween: 16,
          navigation: {
            nextEl: ".about-swiper .swiper-button-next",
            prevEl: ".about-swiper .swiper-button-prev",
          },
        });
      } else if (ww <= 768 && mySwiper != undefined) {
        mySwiper.destroy();
        mySwiper = undefined;
      }
    }

    initSwiper();

    $(window).on('resize', function () {
      ww = $(window).width();
      initSwiper();
    });

    // 모바일 메뉴
    $('.header-button .btn-menu').click(function(){
      $(this).toggleClass('active');
      $('.header-menu').toggleClass('active')
    })
  })
});
