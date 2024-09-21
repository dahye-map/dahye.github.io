var COMPONENT_UI = (function (cp, $) {
  AOS.init({
    duration: '1000',
    once: 'true',
    mirror: 'true'
  });
  cp.light = {
    init: function() {
      $('.light-img .before').click(function() {
        $(this).fadeOut(100);
        setTimeout(() => {
          $(this).parent('.light-img').addClass('on')
          $(this).next().fadeIn();
        }, 200);

        console.log($('.light-img.on').length)

        if($('.light-img.on').length >= 2) {
          setTimeout(() => {
            $('[data-modal="puzzle_popup"]').addClass('active');
          }, 1000);
        }
      })
    },
    lightView :function(){
      $('.light-bottom > div').hide();
      $('.light-img').click(function(){
        const lightIdx = $(this).index();
        $('.light-default').fadeOut();
        $('.light-bottom > div').fadeOut();
        $('.light-bottom > div').eq(lightIdx).fadeIn();
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
    cp.modalpop.init();
    cp.light.init();
    cp.light.lightView();
  };

  cp.init();
  return cp;
}(window.COMPONENT_UI || {}, jQuery));