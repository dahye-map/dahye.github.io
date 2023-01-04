//block
function addBlock() {
    $('body').append('<div class="block"></div>');
    $('.block').fadeIn(300);
    $('.block').on('click', function() {
        if ($('.block').length > 0) {
            $('.block').fadeOut(300).empty().remove();
            $('.layerpop-wrap').fadeOut(300);
        }
    });
}
$(document).on('click', '.pop-close, .layerpop-wrap .btn-white', function(e) {
    e.preventDefault();
    $('.block').trigger('click');
});
function deleteBlock(){
    $('.block').fadeOut(300);
    $('.block').detach();
}
//popup
function openPopup(id) {
    if ($('.layerpop-wrap').css('display') == 'none') {
        addBlock();
        $('#' + id).fadeIn(300);
    }
}
function closePopup(id) {
    deleteBlock();
    $('#' + id).fadeOut(300);
}


$(document).ready(function(){
    // 하단 상세보기
    var more_view = $('.more-view-wrap');
    $('.btn-more').click(function(){
        var more_name = $(this).parents('tr').children('.name').children('a').text();
        var more_date = $(this).parents('tr').children('.date').text();
        var more_view_name = more_view.find('.name');
        var more_view_date = more_view.find('.date');
        more_view.addClass('active');
        more_view_name.attr('value',more_name);
        more_view_date.text(more_date);
    });
    $('.btn.close').click(function(){
        more_view.removeClass('active');
    });

    // nav
    var nav = {
        init:function(){
            this.isOver = false;
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
            this.addEvent();
            if(_self.isActive){
                this.activeFunc(this.currentOneDepthNum, this.currentTwoDepthNum);
            }
        },
        addEvent:function(){
            var _self = this;
            $('#navWrap .nav > ul > li > ul').stop().slideUp();

            $('#navWrap .nav > ul > li > a').on('click',function(e){
                var _sibblings = $(this).siblings('ul');
                if(_sibblings.length){
                    e.preventDefault();
                    $('#navWrap .nav > ul > li').removeClass('active');
                    $(this).parent().addClass('active');
                    $('#navWrap .nav > ul > li > ul').stop().slideUp();
                    _sibblings.stop().slideToggle();
                }
            })
        },
        activeFunc:function(_oneNum, _twoNum){
            var _sibblings;
            if(_oneNum != -1){
                _sibblings = $('#navWrap .nav > ul > li').eq(_oneNum).find('ul');
                $('#navWrap .nav > ul > li').eq(_oneNum).addClass('active');
                if(_sibblings.length > 0 ){
                    $('#navWrap .nav > ul > li').eq(_oneNum).find('> ul').addClass('active')
                    $('#navWrap .nav > ul > li').eq(_oneNum).find('> ul > li').eq(_twoNum).addClass('active');
                }
            }else if(_oneNum == -1){
                $('#navWrap .nav > ul > li > ul').hide();
            }
        }
    }
    nav.init();

    // 체크박스
    var _Check = $(".common-check.each-chk input").length;
    var _disableCheck = $('input:disabled').length;
    var _realCheck = _Check - _disableCheck;
    //전체 체크 해제
    $('.common-check.all-chk input').click(function(){
        var _thisName = $(this).attr('name');

        if($(this).is(":checked")){
            $("[name='" + _thisName + "']").prop("checked", true);
        }else{
            $("[name='" + _thisName + "']").prop("checked", false);
        }
        //disabled 시 체크 안됨
        if($('input:disabled')){
            $('input:disabled').prop('checked', false);
        }
    })

    // checkbox 개별 선택
    $('.common-check.each-chk input').on('click', function(){
        var _eachChecked = $(".common-check.each-chk input:checked").length;

        //행 bg control
        if($(this).prop('checked')){
            $(this).parents('tr').addClass('bg-color');
        }else{
            $(this).parents('tr').removeClass('bg-color');
        }

        //개별 선택으로 전체 선택 control
        if( _realCheck == _eachChecked ) {
            $('.common-check.all-chk input').prop("checked", true);
        } else {
            $('.common-check.all-chk input').prop("checked", false);
        }
        
    })
});

  
