var COMPONENT_UI = (function (cp, $) {
  AOS.init({
    duration: '1000',
    once: 'true',
    mirror: 'true'
  });

  var swiper1 = new Swiper(".swiper-unpaid", {
    slidesPerView: 1,
    slidesPerGroup: 1,
    pagination: {
      el: ".swiper-pagination-unpaid",
      clickable: true,
    },
    navigation: {
      nextEl: ".swiper-button-next",
      prevEl: ".swiper-button-prev",
    },
    autoplay: {
      delay: 2000
    }
  });

  $('.btn-scroll').click(function() {
    $('html, body').animate({
      scrollTop:document.body.scrollHeight - 1800
    },500)
  })

  cp.form = {
    init: function () {
      this.formTab();
      this.paymember();
      this.paymember2();
      this.authkakao();
    },
    formTab: function () {
      const paytype = $('.pay_box .pay input[type=radio]');
      paytype.on('change', function () {
        const _thisid = $(this).attr('id');
        $('.write_form_table').removeClass('active');
        $('.write_form_table.' + _thisid).addClass('active');
      });
    },
    paymember: function () {
      togglePaymemberSection();
      $('input[name="paymember1"]').change(function () {
        togglePaymemberSection();
      });
      function togglePaymemberSection() {
        var selectedId = $('input[name="paymember1"]:checked').attr('id');
        $('.paymember1').hide();
        if (selectedId) {
          $('.' + selectedId).show();
        }
      }
    },
    paymember2: function () {
      togglePaymemberSection();
      $('input[name="paymember2"]').change(function () {
        togglePaymemberSection();
      });
      function togglePaymemberSection() {
        var selectedId = $('input[name="paymember2"]:checked').attr('id');
        $('.paymember2').hide();
        if (selectedId) {
          $('.' + selectedId).show();
        }
      }
    },
    authkakao: function () {
      togglePaymemberSection();
      $('input[name="ars2-1"]').change(function () {
        togglePaymemberSection();
      });
      function togglePaymemberSection() {
        var selectedId = $('input[name="ars2-1"]:checked').attr('id');
        $('.chk_kakao').hide();
        if (selectedId) {
          $('.' + selectedId).show();
        }
      }
    }
  }
  cp.accordion = {
    init: function () {
      //accodain
      var _isSlide = false;
      $('.accordion-container:nth-child(1) .accordion-con').slideDown(200).addClass('active');
      $('.accordion-container:nth-child(3) .accordion-con').slideDown(200).addClass('active');
      $('.accordion-container:nth-child(1) .accordion-tit').addClass('active');
      $('.accordion-container:nth-child(3) .accordion-tit').addClass('active');

      $('.accordion-wrap .accordion-container .accordion-tit').click(function (e) {
        e.preventDefault();
        $this = $(this);
        $target = $(this).next();
        if (!_isSlide) {
          _isSlide = true;
          if (!$target.hasClass('active')) {
            $this.addClass('active');
            $target.slideDown(200).addClass('active');
          } else {
            $this.removeClass('active');
            $target.slideUp(200).removeClass('active');
          }
          setTimeout(function () { _isSlide = false; }, 200);
        }
      });
    }
  }
  cp.modalpop = {
    init: function() {
      $('.btn-modal').on('click', function() {
        const modalName = $(this).attr('data-target');
        $('.modal-wrap[data-modal="' + modalName + '"]').fadeIn(200).addClass('active');
      });

      $('.btn-close').on('click', function() {
        $(this).parents('.modal-wrap').fadeOut(200).removeClass('active');
      })
    }
  }
  cp.init = function () {
    cp.form.init();
    cp.accordion.init();
    cp.modalpop.init();
  };

  cp.init();
  return cp;
}(window.COMPONENT_UI || {}, jQuery));