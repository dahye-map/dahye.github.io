var COMPONENT_UI = (function (cp, $) {
  AOS.init({
    duration: '1000',
    once: 'true',
    mirror: 'true'
  });
  cp.gift = {
    init: function() {
      let energy_num = 0;
      $('.gift').on('click', function() {
        if(!$(this).hasClass('on')) {
          $(this).addClass('on');
          energy_num += 1;

          if(energy_num == 5) {
            setTimeout(() => {
              $('.modal-wrap').addClass('active')
            }, 800);
          }
        }
        $('.energy-wrap').addClass('lv0'+energy_num);

        $('.gift-click').hide();
      })
    },
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
    cp.gift.init();
  };

  cp.init();
  return cp;
}(window.COMPONENT_UI || {}, jQuery));