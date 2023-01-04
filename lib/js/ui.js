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

    const allChk = $('input:checkbox').length;
    let chkBox = $('input:checked').length;

    // checkbox 모두 클릭/해제(bg-color 추가)
    $('input[name=all-chk]').click(function(){
        if($('input[name=all-chk]').is(':checked')){
            $('input[name=chk]').prop('checked', true);
            $("tr").addClass('bg-color');
        } else {
            $('input[name=chk]').prop('checked', false);
            $("tr").removeClass('bg-color');
        }
        
        // checkbox:disabled css 변경하지 않게
        if($('input:disabled')){
            $('input:disabled').prop('checked', false);
            $('input:disabled').parent().parent().parent().parent().addClass('chk-disabled');
        } 
    })

    // checkbox 개별 선택
    $('input:checkbox').on('click', function(){
        if($(this).prop('checked')){
            $(this).parent().parent().parent().parent().addClass('bg-color');
        }else{
            $(this).parent().parent().parent().parent().removeClass('bg-color');
            $('input[name=all-chk]').prop('checked', false);
        }

        if(allChk === chkBox){
            $('input[name=all-chk]').is(':checked');
        }else{

        }
    })
});

  
