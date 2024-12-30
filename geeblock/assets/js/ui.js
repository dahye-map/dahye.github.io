$(function(){
  registUI();

  AOS.init({
    duration: '1000',
    mirror: 'true'
  });

  $(".header__wrap .logo").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 300);
  });
});

var registUI = function(){
  if ( $('.header__wrap').length ) { header(); }
  if ( $('.nav__wrap').length ) { nav(); }
  if ( $('.intro__txt .title-sub').length ) { introAni(); }
  if ( $('.geellet__slide').length ) { geelletSlide(); }
  if ( $('.explorer__slide').length ) { explorerSlide(); }
  if ( $('.tab__wrap').length ) { tab(); }
  if ( $('.accordion__wrap').length ) { accordion(); }
};

/**
  * @name header()
  * @description header function
  */
var header = function(){
  $(window).on("scroll", function () {
    if ($(this).scrollTop() > 100) {
      $(".header__inner").addClass("fixed");
    } else {
      $(".header__inner").removeClass("fixed");
    }
  });
}

/**
  * @name nav()
  * @description nav function
  */
let isNavOpen = false;
var setupMenu = function() {
  const isMobile = window.matchMedia("(max-width: 768px)").matches;

  if (isMobile) {
    $(".nav__wrap > ul > li > a").off("mouseenter mouseleave").on("click", function (e) {
      const parentLi = $(this).parent();
      const depth2 = parentLi.find(".depth2");

      if (depth2.length) {
        e.preventDefault();
        $(".nav__wrap .depth2").not(depth2).slideUp();
        depth2.stop(true, true).slideToggle();
      }
    });

    $(".nav__wrap").off("mouseleave");
  } else {
    $(".nav__wrap > ul > li").off("click").on("mouseenter", function () {
      $(this).find(".depth2").stop(true, true).slideDown();
    }).on("mouseleave", function () {
      $(this).find(".depth2").stop(true, true).slideUp();
    });
  }
}
var toggleNav = function() {
  if (isNavOpen) {
    $(".nav__wrap").removeClass("active");
    $(".mobile__menu").removeClass("on");
    isNavOpen = false;
  } else {
    $(".nav__wrap").addClass("active");
    $(".mobile__menu").addClass("on");
    isNavOpen = true;
  }
}
var nav = function() {
  setupMenu();
  $(window).on("resize", function () {
    setupMenu();
  });
  $(".mobile__menu").click(function () {
    toggleNav();
  });
  $(".nav__wrap a").click(function () {
    const depth2 = $(this).next(".depth2");
    if (isNavOpen && depth2.length === 0) {
      toggleNav();
    }
  });
}

/**
  * @name introAni()
  * @description intro 애니메이션
  */
var introAni = function() {
  // intro animation
  const $textElement = $(".intro__txt .title-sub");
  if ($textElement.length === 0) return;
  const originalText = $textElement.text();
  $textElement.html(
    originalText.split(" ").map(word => 
      `<span style="opacity: 0; display: inline-block">${word}</span>`
    ).join(" ")
  );
  gsap.fromTo(
    $textElement.children(),
    {
      y: 30,
      opacity: 0
    },
    {
      y: 0,
      opacity: 1,
      duration: 0.5,
      stagger: 0.05,
      ease: "power2.out"
    }
  );
}

/**
  * @name geelletSlide()
  * @description geelletSlide 애니메이션
  */
var geelletSlide = function() {
  // Geellet 텍스트 데이터 설정
  const txtData = [
    {
      title: "Gee Block Wallet, <br> Geellet",
      desc: "The most secure asset management & <br> gateway to the Gee Block ecosystem with Web3 wallet",
      info: "",
      url: "https://geellet.io/",
      btn: "Go To Geellet"
    },
    {
      title: "Gee Block Explorer, <br>Geescan",
      desc: "Displays all blocks and transactions created on Gee Block. You can check our transparency through Geescan.",
      info: "",
      url: "https://geescan.io/",
      btn: "Go to Geescan"
    },
    {
      title: "Gee Block Multi-Chain <br>Launchpad, CRYTICAL.io",
      desc: "rytical launchpad, the first dapp to join the Gee Block ecosystem. <br>Crytical is an opportunity for Gee Block to activate its ecosystem and collaborate with other networks collaboration with other networks to create mutual synergies.",
      info: "* Provides scalability by linking Gee Block's network with other Mainnets and dapps."
    },
    {
      title: "AI Chat",
      desc: "Enable chatting and video calls through AI, facilitating various forms of communication for sharing information or daily life updates.",
      info: ""
    },
  ];

  // swiper_geellet
  var swiper_geellet = new Swiper(".geellet__slide", {
    slidesPerView: 1,
    spaceBetween: 0,
    loop: true,
    navigation: {
      nextEl: ".section__geellet .swiper-button-next",
      prevEl: ".section__geellet .swiper-button-prev",
    },
    breakpoints: {
      1200: {
        slidesPerView: 1.2,
        spaceBetween: 40,
      },
    },
  });
  swiper_geellet.on("slideChange", function () {
    const currentIndex = swiper_geellet.realIndex;
    const currentText = txtData[currentIndex];

    $(".geellet__txt .title").html(currentText.title);
    $(".geellet__txt .desc").html(currentText.desc);
    $(".geellet__txt .info").html(currentText.info);
    // 버튼 처리
    if (currentText.url && currentText.btn) {
      $(".customswiper-btn__wrap .btn-fill").attr("href", currentText.url).html(currentText.btn).show();
    } else {
      $(".customswiper-btn__wrap .btn-fill").hide();
    }
  });
}

/**
  * @name explorerSlide()
  * @description explorerSlide 애니메이션
  */
var explorerSlide = function() {
  var swiper_explorer = new Swiper(".explorer__slide", {
    slidesPerView: 1,
    spaceBetween: 16,
    loop: true,
    navigation: {
      nextEl: ".section__explorer .swiper-button-next",
      prevEl: ".section__explorer .swiper-button-prev",
    }
  });
}

/**
  * @name tab()
  * @description tab
  */
var tab = function() {
  $(".tab__btn ul li a").on("click", function (e) {
    e.preventDefault();
    const index = $(this).parent().index();

    $(".tab__btn ul li a").removeClass("active");
    $(this).addClass("active");

    const $targetContent = $(".tab__container .tab__content").eq(index);
    $(".tab__container .tab__content").removeClass('active');
    $targetContent.addClass('active');

    $targetContent.find(".desc__wrap").removeClass("aos-animate");
    setTimeout(() => {
      $targetContent.find(".desc__wrap").addClass("aos-animate");
    }, 100);
  });
}

/**
  * @name accordion()
  * @description accordion
  */
var accordion = function() {
  $('.accordion__tit').click(function(){
    const $content = $(this).next('.accordion__con');
    $('.accordion__tit').removeClass('active')
    if ($content.is(':visible')) {
      $content.slideUp();
      $(this).removeClass('active');
    } else {
      $('.accordion__con').slideUp();
      $content.slideDown();
      $(this).addClass('active');
    }
  });
}
