var COMPONENT_UI = (function (cp, $) {
  $(document).ready(function() {
    AOS.init({
      duration: '1000',
      once: 'true',
      mirror: 'true'
    });
  });
  
  cp.scroll = {
    header: function() {
      $(window).scroll(function() {
        var scrollTop = $(window).scrollTop();

        if(scrollTop > 100) {
          $('header').addClass('active')
        } else {
          $('header').removeClass('active')
        }
        
      });
    },
  }
  cp.init = function () {
    cp.scroll.header();
  };

  cp.init();
  return cp;
}(window.COMPONENT_UI || {}, jQuery));