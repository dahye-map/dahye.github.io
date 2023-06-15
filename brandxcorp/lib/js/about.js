

var agent = navigator.userAgent.toLowerCase();
var isVisible = false;
var isVisible2 = false;
function checkVisible( elm, eval ) {
    eval = eval || "object visible";
    var viewportHeight = $(window).height(),
        scrolltop = $(window).scrollTop(),
        y = $(elm).offset().top,
        elementHeight = $(elm).height();

    if (eval == "object visible") return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
    if (eval == "above") return ((y < (viewportHeight + scrolltop)));
}




function checkVisible2( elm, eval ) {
    eval = eval || "object visible";
    var viewportHeight = $(window).height(),
        scrolltop = $(window).scrollTop(),
        y = $(elm).offset().top,
        elementHeight = $(elm).height();

    if (eval == "object visible") return ((y < (viewportHeight + scrolltop)) && (y > (scrolltop - elementHeight)));
    if (eval == "above") return ((y < (viewportHeight + scrolltop)));
}

$(window).scroll(function() {
	if (checkVisible($('.eruda'))&&!isVisible) {
		function txtAni() {
            setTimeout(function() {
                $('.brandx .plusBtn').stop().animate({'opacity': 0}, 300, function() {
                    setTimeout(function() {
                                $('div.xexyLogo').stop().animate({'left': '31%'}, 'easeOutQuad');
                                $('.whiaLogo').stop().animate({'left': '43.5%'}, 'easeOutQuad');
                                $('.mix2Logo').stop().animate({'left': '52%'}, 'easeOutQuad');
						        $('.madiLogo').stop().animate({'right': '31%'}, function(){

									  setTimeout(function() {
									      $('.brandx .hideLogo').stop().animate({'opacity': 0}, 700);
										  $('.brandx .bxgLogo').stop().animate({'opacity': 1}, 700);
										  	});
								});
                    }, 500);
                });
            }, 500);
        };
        txtAni();

		isVisible=true;
	}



});


$(window).scroll(function() {
if (checkVisible($('.drtsell'))&&!isVisible2) {
			function txtAni3() {
				setTimeout(function() {
					$('.thcare .plusBtn').stop().animate({'opacity': 0}, 300, function() {
						setTimeout(function() {
									$('.thcareLogo ').stop().animate({'left': '34%'}, 'easeOutQuad');
									$('.pocketLogo ').stop().animate({'left': '42%'}, 'easeOutQuad');
									$('.guLogo ').stop().animate({'left': '51%'}, 'easeOutQuad');
									$('.glamLogo ').stop().animate({'right': '28%'}, function(){

										  setTimeout(function() {
											  $('.thcare .hideLogo').stop().animate({'opacity': 0}, 700);
											  $('.thcare .thcareLogoLast').stop().animate({'opacity': 1}, 700);
												});
									});
						}, 500);
					});
				}, 500);
			};
			txtAni3();

			isVisible2=true;
		}
});


























//				function txtAni3() {
//						setTimeout(function() {
//							$('.plusBtn').stop().animate({'opacity': 0}, 500, function() {
//								setTimeout(function() {
//											$('.thcareLogo ').stop().animate({'left': '31%'}, 'easeOutQuad');
//											$('.pocketLogo ').stop().animate({'left': '43.5%'}, 'easeOutQuad');
//											$('.guLogo ').stop().animate({'left': '52%'}, 'easeOutQuad');
//											$('.glamLogo ').stop().animate({'right': '31%'}, function(){
//
//												  setTimeout(function() {
//													  $('.hideLogo').stop().animate({'opacity': 0}, 1500);
//													  $('.thcareLogo.last').stop().animate({'opacity': 1}, 1500);
//														});
//											});
//								}, 600, );
//							});
//						}, 1000);
//					};
//					txtAni3();



      $(document).ready(function(){





                $(window).scroll(function(){
                    $('.lazy').each(function(){
                        var offsetTopPosition = $(this).offset().top - $(window).scrollTop();
                        if (offsetTopPosition < 980) {
                            $(this).addClass('on');
                            $('.tit h1').addClass('on');
                        }

                    });

               });

               $(window).scroll(function(){
                    $('.lazy2').each(function(){
                        var offsetTopPosition = $(this).offset().top - $(window).scrollTop();
                        if (offsetTopPosition < 300) {
                            $(this).addClass('on');
                        }

                    });

               });



		  var secOffset = $('.section06').offset();
			$(window).scroll(function(){
				var win_W = $(window).width();
				if(win_W <= 768) {
					if ( $( document ).scrollTop() >= secOffset.top &&  $('.section06').height() + secOffset.top - 100 > $( document ).scrollTop()) {
						$( '.section06' ).addClass( 'mo-fixed' );
					} else {
						$( '.section06' ).removeClass( 'mo-fixed' );
					}
				} else {
					if ( $( document ).scrollTop() >= secOffset.top &&  $('.section06').height() + secOffset.top - 100 > $( document ).scrollTop()) {
						$( '.section06' ).addClass( 'fixed' );
					} else {
						$( '.section06' ).removeClass( 'fixed' );
					}
				}

			});
         });
