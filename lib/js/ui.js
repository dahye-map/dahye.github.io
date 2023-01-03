//block
function addBlock() {
    $('body').append('<div class="block"></div>');
    //$('body, html, #wrap').css({'overflow': 'hidden','height': winH});
    $('.block').fadeIn(300);
    $('.block').on('click', function() {
        if ($('.block').length > 0) {
            $('.block').fadeOut(300).empty().remove();
            $('.layerpop-wrap').fadeOut(300);
        }
        //$('body, html, #wrap').css({'height': '', 'overflow': ''});
    });
}
$(document).on('click', '.pop-close, .layerpop-wrap .btn-white', function(e) {
    e.preventDefault();
    $('.block').trigger('click');
});
function deleteBlock(){
    $('.block').fadeOut(300);
    $('.block').detach();
    //$('body, html, #wrap').css({'height':'','overflow':''});
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

    // 메뉴 드롭다운
    $('.nav li').click(function(){
        $(this).children('ul').stop().slideToggle(300);
        $('a', this).addClass('active');
    });

    const allChk = $('input:checkbox').length;
    let chkBox = $('input:checked').length;

    // checkbox 모두 클릭/해제(bg-color 추가)
    $('input[name=all-chk]').click(function(){
        if($('input[name=all-chk]').is(':checked')){
            $('input[name=chk]').prop('checked', true);
            $("tr").addClass('bg-color');
        }else{
            $('input[name=chk]').prop('checked', false);
            $("tr").removeClass('bg-color');
        };
        
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

  
