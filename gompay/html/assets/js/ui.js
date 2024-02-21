$(function () {
  AOS.init({
    duration: '1000',
    once: 'true',
    mirror: 'true'
  });

  
  $(document).ready(function () {
    //탭 많을 때 스크롤
    $('.tab-container.full-right').scrollLeft(200);
  
    // 메인 스와이퍼
    var ww = $(window).width();
    var mySwiper = undefined;
    function initSwiper() {
      if (ww > 768 && mySwiper == undefined) {
        mySwiper = new Swiper(".about-swiper", {
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

    if ($('[id *= "svg"').length) { gsapAni() }
    // GSAP 애니메이션
    function gsapAni() {
      const tl = gsap.timeline({ paused: true });
      const t2 = gsap.timeline({ paused: true });
      const t3 = gsap.timeline({ paused: true });
      const t4 = gsap.timeline({ paused: true });

      tl.to("#svg1 path", { duration: .5, attr: { d: "M786.5 667C561.7 895.4 168.5 785.833 0 702.5V-59H2099L2162.5 174.5C2017 145.333 1675 159.8 1471 451C1216 815 1067.5 381.5 786.5 667Z" } })
      t2.to('#svg2 path', { duration: .5, attr: { d: "M890.125 262.124C1150.83 124.32 1158.94 -42.6177 1130.41 -108.861C970.376 -515.281 219.513 -181.64 -175.347 53.9155C-570.206 289.471 -51.6496 931.668 257.964 595.445C567.578 259.222 564.246 434.379 890.125 262.124Z" } })

      t3.to('#svg3', {
        x: 0
      })
      t4.to('#svg4', {
        y: 0,
        opacity: 1
      })

      tl.play();
      t2.play();
      t3.play();
      setTimeout(() => {
        t4.play();
      }, 1000);
    }

    //서브 콘텐츠 탭
    contentsTab()
    function contentsTab() {
      var tabCon = $('.sub-tab__content');
      $('.sub-tab__item').click(function() {
        var tabIdx = $(this).index();
        var targetId = $(this).attr('data-target');

        $('.sub-tab__item').removeClass('active');
        $(this).addClass('active');

        tabCon.removeClass('active');
        tabCon.eq(tabIdx).addClass('active');

        if (targetId == 'wechat') {
          console.log('ddd')
          $('.header-menu__link').removeClass('active');
          $('.header-menu__link.menu-wechat').addClass('active');
        } else if (targetId == 'alipay') {
          $('.header-menu__link').removeClass('active');
          $('.header-menu__link.menu-alipay').addClass('active');
        } else if (targetId == 'union') {
          $('.header-menu__link').removeClass('active');
          $('.header-menu__link.menu-union').addClass('active');
        }
      });
    }
  })

  
});