var depth1, depth2, depth3, depthExp;
var _isGnbOpen = false;
var winH = $(window).height()||window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
$(document).ready(function(){
    cardListEvent();
    // header / based on allMenuWrap
    var globalNav = {
        init: function() {
            if (typeof depth1 != "undefined" && depth1 < 100) this.currentOneDepthNum = depth1;
            if (typeof depth1 != "undefined" && depth1 < 100) this.currentTwoDepthNum = depth2;
            if (typeof depthExp != "undefined") this.currentExpDepthNum = depthExp;
            this.setLayout();
        },
        setLayout: function() {
            var _self = this;
            if (depth1 != 99 && typeof depth1 != "undefined" && depth1 < 100) {
                if (typeof depth2 != "undefined" && depth2 < 100) {
                    this.setText(this.currentOneDepthNum, this.currentTwoDepthNum, this.currentExpDepthNum);
                    this.activePage(this.currentOneDepthNum, this.currentTwoDepthNum);
                    this.activeLNB(this.currentOneDepthNum, this.currentTwoDepthNum);
                }
            }
            this.addEvent();
        },
        setText:function(_oneDepth,_twoDepth,_expDepth) {
            var depth1Txt ;
            var depthExpTxt;
            switch (_expDepth) {
                case 0:
                    depthExpTxt = '애독자 참여코너';
                    break;
                case 1:
                    depthExpTxt = '신규 구독 신청';
                    break;
                case 2:
                    depthExpTxt = '독자 정보 변경/중지';
                    break;
                case 3:
                    depthExpTxt = '독자 번호 찾기';
                    break;
                default:
                    depthExpTxt = '';
            }
            // gnb에 없는 depth 설정. 숫자는 98부터 아래로
            switch (_oneDepth) {
                case 98:
                    depth1Txt = '회원가입';
                    break;
                case 97:
                    depth1Txt = '회원서비스';
                    break;
                case 96:
                    depth1Txt = '검색결과';
                    break;
                case 95:
                    depth1Txt = '로그인';
                    break;
                default:
                    depth1Txt = $('.depth1:eq('+_oneDepth+') > a').text();
            }
            var depth2Txt;
            if ($('.step-wrap .step-list').length > 0) {
                depth2Txt = $('.step-wrap .step-list .step.active span').text();
            }else if($('.tab-wrap').length > 0){
                depth2Txt = $('.tab-wrap ul li.active a').text();
            }else{
                depth2Txt = $('.depth1:eq('+_oneDepth+') .depth2-list li:eq("'+_twoDepth+'") > a').text();
            }
            globalNav.setTitle(depth1Txt, depth2Txt, depthExpTxt);
        },
        setTitle:function(_depth1Txt,_depth2Txt,_depthExpTxt) {
            var _titleData = '';
            if($('.company-nav').length > 0){
                var depth3Txt = $('.company-nav a.active').text();
                _titleData += depth3Txt + ' &lt; ';
            }
            if ( _depthExpTxt != '') { _titleData += _depthExpTxt + ' &lt; '; } //예외depth(depthExp)가 있는 경우
            if ( _depth2Txt != '' ) {
                _titleData += _depth2Txt + ' &lt; '+_depth1Txt + ' &lt; ';
            }else{
                _titleData += _depth1Txt + ' &lt; ';
            }
            try {
			   //new browsers
			   $('title').html(_titleData+'동서식품');
			} catch (e) {
			   //IE8
			  document.title = _titleData+'동서식품';
			}
        },
        activePage:function(_oneDepth,_twoDepth) {
            $('.depth1:eq('+_oneDepth+') > a').addClass('active');
            //$('.depth1:eq('+_oneDepth+') .depth2-list li:eq("'+_twoDepth+'")').addClass('active');
        },
        activeLNB:function(_oneDepth,_twoDepth){
            var data =  $('.depth1:eq('+_oneDepth+') .depth2-list').html();
            $('#lnbWrap').append(data);
            $('#lnbWrap li:eq('+_twoDepth+')').addClass('active');
        },
        addEvent:function(){
            var prevEnterDepthIdx;
            if (!_isGnbOpen) {
                _isGnbOpen = true;
                $('.depth1 > a').on('mouseenter focusin',function(){
                    var idx = $('.depth1 > a').index($(this));
                    if (prevEnterDepthIdx != idx) {
                        $('.depth2-wrap').removeClass('active');
                        $('.depth1 > a').removeClass('active');
                    }
                    $(this).addClass('active').siblings('.depth2-wrap').addClass('active');
                    prevEnterDepthIdx = idx;
                    if ($('.block').length <= 0) {
                        $('#headerWrap').animate({'height':'412'},180).addClass('active');
                        addBlock();
                        $('.block').addClass('under');
                    }
                });
            }

        }
    };
    $('#headerWrap').on('mouseleave', function(){ gnbReset(); });
    $('.utility, h1').on('mouseenter focusin', function(){ gnbReset(); });
    function gnbReset(){
        if ($('#headerWrap').hasClass('active')) {
            $('#headerWrap').animate({'height':'72'},180).removeClass('active');
            $('.depth1 > a').removeClass('active');
            $('.depth1:eq('+depth1+') a').addClass('active');
            deleteBlock();
            $('.block').removeClass('under');
            _isGnbOpen = false;
        }
    }
    globalNav.init();
    // select
    var select = $("select");
    if(select.length > 0){
        select.each(function(){
            changeSelect();
        });
    }
	select.change(function(){
        changeSelect();
	});
    function changeSelect(){
        var select_name = $(this).children("option:selected").text();
	    $(this).siblings("p").text(select_name);
    }
    scrollTopFunc('.company-nav',0,'fixed');
    scrollTopFunc('.company-nav',0,'fixed','.company');

    //history
    var history = {
        init: function() {
            this.currentNum = -1;
            this.totalNum = $('.history-group').length;
            this.scorllTopArr = [];
            var _self = this;
            $('.history-group').each(function(index){
                var _top = $(this).offset().top - 406;
                _self.scorllTopArr.push(_top);
            });
            this.setLayout();
        },
        setLayout: function() {
            var _self = this;
            this.setScroll(this.currentNum);
            this.addEvent();
        },
        addEvent:function(){
            var _self = this;
            $('.circle-year').on('click',function(e){
                var _index = $(this).index();
                _self.setScroll(_index,"naviClick");
            });
        },
        setScroll: function(_num,_type) {
            var _self = this;
            if(typeof _type == 'undefined'){
                $( 'html, body' ).stop().animate({scrollTop : _self.scorllTopArr[_num] });
            }else{
                $( 'html, body' ).stop().animate({scrollTop : _self.scorllTopArr[_num-1]+30 });
            }
            this.scrollFunc();
        },
        scrollFunc: function(){
            var _self = this;
            if(_self.currentNum == -1)_self.currentNum=0;
            _self.visualFunc(_self.currentNum);
            $('.circle-year').removeClass('active');
            $('.circle-year').eq(_self.currentNum).addClass('active');
            $(window).scroll(function () {
                if ($(this).scrollTop() > _self.scorllTopArr[_self.currentNum + 1]) {
                    if(_self.currentNum < _self.totalNum-1)_self.currentNum = _self.currentNum+1;
                }else if($(this).scrollTop() < _self.scorllTopArr[_self.currentNum]){
                    if(_self.currentNum > 0)_self.currentNum = _self.currentNum-1;
                }
                _self.visualFunc(_self.currentNum);
                $('.circle-year').removeClass('active');
                $('.circle-year').eq(_self.currentNum).addClass('active');
            });

        },
        visualFunc: function(_num){
            if(_num == -1)_num=0;
            var _txt = $('.circle-year .year-num').eq(_num).text();
            $('.year-wrap .year-visual').text(_txt);
            $('.year-wrap .year-visual').css({'background':"url(/2017/images/page/01_company/bg_history"+(_num+1)+".png) no-repeat"});
        }
    };
    $(window).load(function(){
        history.init();
    });

    //accodain
    var answer = $('.accodian-wrap li .accodian-con.answer');
    var _isSlide = false;
    if ($('.accodian-wrap').length > 0) {
        $('.accodian-wrap').each(function(){
            $(this).find('.accodian-con.answer').eq(0).slideDown(100).addClass('active');
        });
    }
    $('.accodian-wrap > li .accodian-con.question').click(function(e) {
        e.preventDefault();
        $this = $(this);
        $target = $(this).parent().next();
        var allPanels = $this.closest('.accodian-wrap').find('li .accodian-con.answer');
        if(!_isSlide){
            _isSlide = true;
            if(!$target.hasClass('active')){
                allPanels.slideUp(200).removeClass('active');
                $target.slideDown(200).addClass('active');
                if($this.hasClass('arrow')){
                    $('.accodian-wrap > li .accodian-con.arrow').css({"background" : "#fff url(../../images/page/04_csr/accodian_arrow_down.png) no-repeat right", "background-position" : "98%"});
                    $this.css({"background" : "#fff url(../../images/page/04_csr/accodian_arrow_up.png) no-repeat right", "background-position" : "98%"});
                }
            }else{
                $target.slideUp().removeClass('active');
                if($this.hasClass('arrow')){
                    $this.css({"background" : "#fff url(../../images/page/04_csr/accodian_arrow_down.png) no-repeat right", "background-position" : "98%"});
                }
            }
            setTimeout(function(){_isSlide=false;},200);
        }
    });

    $('.family-site-wrap .select-wrap').on('change',function(){
        var url = $(this).find('option:selected').attr('value');
        window.open(url);
    });

    // CSR load bxSlider when first time
    if ($('.open-box.active').length > 0) {
        csrSliderLoad($('.open-box.active').attr('id'));
    }

    // top btn
    var btnTop = $('.btn.top');
    var docH = $(document).height();
    var endEdge = docH - winH;
    $(window).scroll(function(){
        var st = $('body').scrollTop();
        if (endEdge < winH) { //페이지에 내용이 없어서 창이 작을 경우
            btnTop.addClass('active');
        }else{
            if (st < winH - 200 ) {
                btnTop.hide().removeClass('active');
            }else if(st >= endEdge - 100) { //끝에 왔을 경우
                btnTop.addClass('active');
            }else{
                btnTop.show().removeClass('active');
            }
        }
    });

});
var csrSlider;
// CSR load bxSlider
function csrSliderLoad(_id) {
    csrSlider = $('#'+_id+' .csr-slider > ul').bxSlider({
        moveSlides: 1,
        controls : false,
        auto : true
    });
}
// CSR change Select function
function boxBlock(_id) {
    csrSlider.destroySlider();
    $('.open-box').removeClass('active');
    $('#' + _id).addClass("active");
    var liLen = $('#' + _id).find('.csr-slider li').length;
    if (liLen > 1) { csrSliderLoad(_id); }
}
// card list
function cardListEvent(){
    // card-list margin
    if ($('.card-list').length > 0) {
        $('.card-list').each(function(){
            if ($(this).hasClass('event') || $(this).hasClass('brand') ) {
                $(this).find('li:nth-child(3n-2)').css('margin-left',0);
            }else{
                $(this).find('li:nth-child(4n-3)').css('margin-left',0);
            }
        });
    }
    var hoverLiData = '<span class="drowborder top"></span><span class="drowborder right"></span><span class="drowborder bottom"></span><span class="drowborder left"></span>';
    $('.card-list > li > a').hover(function(){
        if (!$(this).parent().hasClass('utube')) {
            $(this).append(hoverLiData);
            $(this).find('.drowborder.top').animate({'width':'100%'},150);
            $(this).find('.drowborder.right').delay(170).animate({'height':'100%'},150);
            $(this).find('.drowborder.bottom').delay(340).animate({'width':'100%'},150);
            $(this).find('.drowborder.left').delay(510).animate({'height':'100%'},150);
        }
    },function(){
        if (!$(this).parent().hasClass('utube')) {
            $(this).find('.drowborder').empty().remove();
        }
    });
}
