$(document).ready(function(){
    //수정 20170906
    $("#msgAll").click(function(){
        var checked = $(this).prop("checked");
        if(checked){
            $(":checkbox[name=checkmsg]").prop("checked", true);
        } else {
            $(":checkbox[name=checkmsg]").prop("checked", false);
        }
    });
    $('.check-arrow').click(function(){
        $('.check-msg').slideUp();
        if(!$('.check-msg').is(':visible')){
            $('.check-msg').slideDown('fast');
            $('.check-arrow').find('img').attr('src', '../../img/common/bg_arrow_down02.png');
        } else {
            $('.check-msg').slideUp('fast');
            $('.check-arrow').find('img').attr('src', '../../img/common/bg_arrow_up02.png');
        }
    });

    $('.rate-arrow').click(function(e){
        e.preventDefault();
        var _rateCon = $(this).parent().next();
        if(!_rateCon.is(':visible')){
            _rateCon.slideDown('fast');
            $(this).find('img').attr('src', '../../img/common/btn_prod_arrow_up.jpg');
        }
        else {
            _rateCon.slideUp('fast');
            $(this).find('img').attr('src', '../../img/common/btn_prod_arrow_down.jpg');
        }
    });

    $('.sun-view').click(function(e){
        e.preventDefault();
        if(!$('.sun-view-con').is(':visible')){
            $('.sun-view-con').slideDown('fast');
        }
        else {
            $('.sun-view-con').slideUp('fast');
        }
    });

    //당일 대출, 전체 대출 상품 라디오 버튼
    $('#limit01').click(function(){
        var limit01 = $(this).prop('checked');
        if(limit01 == true) {
            $('.today-chk').show();
        }
    });
    $('#limit02').click(function(){
        var limit02 = $(this).prop('checked');
        if(limit02 == true) {
            $('.today-chk').hide();
        }
    });

    $('#radioLoan input[id="radio05"]').click(function(){
        $('.loan-money').addClass('active');
    });
    $('#radioLoan input[id="radio06"]').click(function(){
        $('.loan-money').removeClass('active');
    });

    //tab 선택 버튼
    $('.tab-btns.type01 .btn').click(function(){
        var _tabBtn01 = $(this).index();
        var _tabText = $(this).text();
        $('.tab-btns.type01 .btn').each(function(index){
            $(this).addClass('active');
            if(_tabBtn01 != index){
                $(this).removeClass('active');
            }
        });
        //통신사
        if(_tabText == '알뜰폰'){
            $('.save-tel-btn').addClass('active');
        } else {
            $('.save-tel-btn').removeClass('active');
        }
    });
    $('.tab-btns.type02 .btn').click(function(e){
        e.preventDefault();
        var _tabBtn02 = $(this).index();
        var _tabtext = $(this).text();
        console.log(_tabtext);
        $('.tab-btns.type02 .btn').each(function(index){
            $(this).addClass('active');
            if(_tabBtn02 != index){
                $(this).removeClass('active');
            }
        });
    });
    $('.right-btns .btn').click(function(e){
        e.preventDefault();
        var _rightBtn = $(this).index();
        var _rightText = $(this).text();
        $('.right-btns .btn').each(function(index){
            $(this).addClass('active');
            if(_rightBtn != index){
                $(this).removeClass('active');
            }
        });
        if(_rightText == '직장인'){
            $('.select-office').addClass('active');
        }
        else {
            $('.select-office').removeClass('active');
        }
    });

    //주소찾기 팝업
    $('.address .btn').click(function(){
        $('.address .btn').removeClass('active');
        $(this).addClass('active');
    });

    //faq
    $('.question').on('click', function(){
        var _question = $(this);
        var _answer = $(this).next();
        if($('.answer').hasClass('active')){
            _answer.closest('.question').addClass('active');
        }
        $('.answer').slideUp();
        $('.question').removeClass('active');
        if(!_answer.is(':visible')){
            _answer.slideDown();
            _question.addClass('active');
        }
    });

    // gnb
    // 수정
    var _winHeight = $(window).height();
    var logoHeight = $('.logo').height();
    $('#gnbWrap .gnb > ul').css({'height' : _winHeight-logoHeight  + 'px'});

    $('.menu').on('click', function(e){
        e.preventDefault();
        var _Gnb = false;
        if(!_Gnb){
            $('#gnbWrap').addClass('active');
            $('body').append('<div class="gnb-block">');
            $('body, html, #containerWrap').css({'overflow': 'hidden'});
            $('.gnb-block').on('click', function(){
                if($('.gnb-block'.length > 0)){
                    $('#gnbWrap').removeClass('active');
                    $('.gnb-block').fadeOut(300).empty().remove();
                }
                $('body, html, #containerWrap').css({'overflow' : ''});
            });
        } else {
            $('#gnbWrap').removeClass('active');
            $('body, html, #containerWrap').css({'overflow' : ''});
            $('.gnb-block').fadeOut(300).empty().remove();

        }
    });
    $(document).on('click', '.menu-close', function(e) {
        e.preventDefault();
        $('.gnb-block').trigger('click');
    });

    // 2017-09-03 수정 accordian
    $('.depth1 > a').click(function(){
        $('.depth1 > ul').slideUp();
        if($('.depth2 > ul').is(':visible')){
            $('.depth2 > ul').slideUp();
            $('.icon-small-ar img').attr('src', '../../img/common/bg_arrow_down.png');
        }
        $('.icon-ar img').attr('src', '../../img/common/bg_gnb_down.png');
        if(!$(this).next().is(":visible")){
            $(this).next().slideDown();
            $(this).find('.icon-ar img').attr('src','../../img/common/bg_gnb_up.png');
        }
    });
    $('.depth2 > a').click(function(){
        $('.depth2 > ul').slideUp();
        $('.icon-small-ar img').attr('src', '../../img/common/bg_arrow_down.png');
        if(!$(this).next().is(":visible")){
            $(this).next().slideDown();
            $(this).find('.icon-small-ar img').attr('src', '../../img/common/bg_arrow_up.png');
        }
    });

    //main
    $('.tab > a').click(function(){
        $('.tab a').removeClass('active');
        $(this).addClass('active');
    });

    //영업점안내
    var idex;
    var max = 8;
    var branch;
    var branch_con;
    $('.branch-select').change(function(){
        idex = $(this).children('option:selected').index();
        branch = $('.branch-select option').eq(idex).val();
        branch_con = $('.branch-con').eq(idex).attr('id');

        $('#branchSearch').click(function(){
            if(branch == branch_con){
                $('.branch-con').removeClass('active');
                $('#'+branch_con).addClass('active');
            }
        });
    });
});
function showtab(id) {
    $('.tab-con').removeClass('active');
    $('#'+id).addClass('active');
}
//약관 동의
function agree(_id){
    var slider = $('.slider li').width() * $('.slider li').length;
    $('.slider').css({'width' : slider+'px' });

    var idx = 0;
    var num_idx = 0;
    var slidemax = $('#'+_id+' .slider li.agree-con').length-1;
    var pos = $('#'+_id+' .slider li.agree-con').width();
    var number;

    function sliding(add, _id) {

        idx = idx + add;
        if(idx < 0) {
            idx = slidemax;
        }
        else if (idx > slidemax ) {
            idx = 0;
        }
        $('#'+_id+' .slider').stop().animate({'left' : -(idx*pos)+'px'}, 'fast');

        $('#'+_id+' .agree-num > li').eq(idx).addClass('active');

    }
    $('.agree-num > li').click(function() {
        idx = $(this).index();
        $(this).addClass('active');
        sliding(0, _id);
        // console.log("idx : "+idx+"///num_idx : "+num_idx);
        // $(this).eq(num).addClass('active');
    });
    $('#leftBtn, #rightBtn').click(function() {
        if($(this).attr('id') == "leftBtn") {

            sliding(-1, _id);
        }
        else sliding(1, _id);
    });

    $('li.agree-con').bind('swipeleft', function(){
        sliding(1, _id);
    });
    $('li.agree-con').bind('swiperight', function(){
        sliding(-1, _id);
    });
}
