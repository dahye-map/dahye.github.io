var depth1, depth2, depth3;
var winW = $(window).width();
var prdListEq;

$(document).ready(function(){
    var burger = $('.menu-trigger');
    burger.on('click',function(e){
        e.preventDefault();
        $(this).toggleClass('active-7');
    });
    var gnb = {
        init:function(){
            this.isOver = false;
            this.isMobile = false;
            this.isActive = false;
            if(typeof depth1!="undefined" && depth1<100 && depth1!=-1){
                this.isActive = true;
            }
            if(this.isActive){
                this.currentOneDepthNum = depth1-1;
                this.currentTwoDepthNum = depth2-1;
            }
            this.setLayout();
        },
        setLayout:function(){
            var _self = this;
            $(window).on('resize',function(e){
                if($(window).width() < 768){
                    _self.isMobile  = true;
                }else{
                    _self.isMobile  = false;
                }
            }).resize();
            _self.mobileReset();
            this.addEvent();
            if(!_self.isMobile && _self.isActive){
                this.activeFunc(this.currentOneDepthNum, this.currentTwoDepthNum);
            }
        },
        addEvent:function(){
            var _self = this;
            //pc
            $('#gnbWrap .gnb > ul').on('mouseenter',function(e){
                if(!_self.isMobile){
                    _self.isOver = true;
                    $(this).parents('#gnbWrap').addClass('white');
                    $(this).parents('#gnbWrap').children('.gnb-bg').show();
                }

            }).on('mouseleave',function(e){
                if(!_self.isMobile){
                    _self.isOver = false;
                    _self.activeFunc(_self.currentOneDepthNum, _self.currentTwoDepthNum);
                    _self.oneOverNum = -1;
                    $(this).parents('#mainWrap #gnbWrap').removeClass('white');
                    $(this).parents('#gnbWrap').children('.gnb-bg').hide();
                }
            });
            $('#gnbWrap .gnb > ul > li > a').on('mouseenter focusin',function(e){
                var _sibblings = $('#gnbWrap .gnb > ul > li > ul');
                var _index = $(this).parent().index();
                $(this).parent().addClass('active');
                _self.isOver = true;
                if(_sibblings.length > 0 && _self.isOver ){
                    if(!_self.isMobile && _self.oneOverNum != _index){
                        if (_self.isOver) {
                            _self.isOver = false;
                            $('#gnbWrap .gnb > ul > li > ul').hide();
                        }
                        _self.isOver = true;
                        $('#gnbWrap .gnb').addClass('active');
                        _sibblings.stop().show();
                    }
                }else{
                    if(!_self.isMobile && _self.oneOverNum != _index){
                        // $(this).addClass('active');
                        $('#gnbWrap .gnb > ul > li > ul').hide();
                        $('#gnbWrap .gnb').removeClass('active');
                    }
                }
                _self.oneOverNum = _index;
            }).on('click',function(e){
                var _sibblings = $(this).siblings('ul');
                if(_sibblings.length){
                    if(_self.isMobile){
                        e.preventDefault();
                        $('#gnbWrap .gnb > ul > li').removeClass('active');
                        $(this).parent().addClass('active');
                        $('#gnbWrap .gnb > ul > li > ul').stop().slideUp();
                        _sibblings.stop().slideToggle();
                    }
                }
            });
            $('#gnbWrap .gnb > ul > li').on('mouseenter',function(e){
                $(this).addClass('active');
            }).on('mouseleave',function(e){
                $('#gnbWrap .gnb > ul > li').removeClass('active');
            });
            $('.mo-menu a').on('click',function(e){
                e.preventDefault();
                $('#gnbWrap .gnb > ul > li > a').removeClass('active');
                $('#gnbWrap .gnb').toggleClass('active');
                $('#gnbWrap .gnb > ul > li > ul').stop().slideUp();
            });
        },
        activeFunc:function(_oneNum, _twoNum){
            //console.log(_oneNum);
            var _sibblings;
            if(_oneNum != -1){
                _sibblings = $('#gnbWrap .gnb > ul > li').eq(_oneNum).find('ul');
                $('#gnbWrap .gnb > ul > li').eq(_oneNum).addClass('active');
                // $('#gnbWrap .gnb > ul > li').eq(_oneNum).find(' > a').trigger('mouseenter');
                $('#gnbWrap .gnb').removeClass('active');
                $('#gnbWrap .gnb > ul > li > ul').hide();
                if(_sibblings.length > 0 ){
                    $('#gnbWrap .gnb > ul > li').eq(_oneNum).find('> ul > li').eq(_twoNum).addClass('active');
                }
            }else if(_oneNum == -1){
                $('#gnbWrap .gnb > ul > li > ul').hide();
                $('#gnbWrap .gnb').removeClass('active');
            }
        },
        mobileReset:function(){
            $('#gnbWrap .gnb').removeClass('active');
            $('#gnbWrap .gnb > ul > li > ul').stop().slideUp();
        }
    }
    gnb.init();

    var fix_gnb = $('#gnbWrap .gnb > ul')
    $(window).scroll(function(){
       if( $(document).height() - fix_gnb.height()  > $(document).scrollTop()) {
           fix_gnb.parent().addClass('fix');
           $('#gnbWrap .fix-gnb-bg').css('display', 'block');
           $('#gnbWrap .gnb > ul > li > ul').css('display', 'none');
           // $('#gnbWrap .gnb .box-login .box.active').css('display', 'none');
       }
       if($(document).scrollTop() < fix_gnb.height() ) {
           fix_gnb.parent().removeClass('fix');
           $('#gnbWrap .fix-gnb-bg').css('display', 'none');
       }
    });

    //accordian
    var _isSlide = false;
    if ($('.accordian-wrap').length > 0) {
        $('.accordian-wrap').each(function(){
            $(this).find('.con').eq(0).slideDown(100).addClass('active');
        });
    }
    $('.accordian-wrap .title').click(function(e){
        e.preventDefault();
        $this = $(this);
        $target = $(this).next();
        var allPanels = $this.closest('.accordian-wrap').find('.con');
        if(!_isSlide){
            _isSlide = true;
            if(!$target.hasClass('active')){
                allPanels.slideUp(200).removeClass('active');
                $target.slideDown(200).addClass('active');
            }else{
                $target.slideUp().removeClass('active');
            }
            setTimeout(function(){_isSlide=false;},200);
        }
    });

    //top btn
    // var btnTop = $('.btn-top');
    // var docH = $(document).height();
    // var endEdge = docH - winH;
    //  $(window).scroll(function(){
    //      var st = $(window).scrollTop();
    //      if (endEdge < winH) { //페이지에 내용이 없어서 창이 작을 경우
    //          btnTop.addClass('active');
    //      }else{
    //          if (st < winH - 200 ) {
    //              btnTop.hide().removeClass('active');
    //          }else if(st >= endEdge - 300) { //끝에 왔을 경우
    //              btnTop.addClass('active');
    //          }else{
    //              btnTop.show().removeClass('active');
    //          }
    //      }
    //
    //      var isFooter = $('#contentsWrap').next().attr('id');
    //      btnTop.css('position', 'fixed');
    //      if( isFooter =='footerWrap'){
    //          if( btnTop.offset().top >= ( $("#footerWrap").offset().top - btnTop.height()) ){
    //              btnTop.css('position', 'absolute');
    //          }
    //      }
    //  });

     $('.select-wrap').mouseenter(function(){
         $('.select-wrap .lang').show();
         $('.select-wrap .box a').addClass('active');
     });
     $('.select-wrap').mouseleave(function(){
         $('.select-wrap .lang').hide();
         $('.select-wrap .box a').removeClass('active');
     });


     //hover 효과
     $('.black').mouseenter(function(){
         $(this).find('.hover-layer').stop().animate({
             opacity: 0.5
         }, 500);
         $(this).find('.description .des-detail').stop().animate({
             opacity: 1
         }, 500);
     }).mouseleave(function(){
         $(this).find('.hover-layer').stop().animate({
             opacity: 0
         }, 500);
         $(this).find('.description .des-detail.ani').stop().animate({
             opacity: 0
         }, 500);
     });


     $('.btn-main-login').on('click', function(){
        $(this).siblings('.box').toggleClass('active');
     });




});
