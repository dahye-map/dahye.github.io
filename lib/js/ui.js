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
    $('.depth-menu').hide();
    $('.sub-menu').click(function(){
        // $(this).children('ul').slideToggle(300);
        $('ul', this).slideToggle(300);
    });

    // checkbox 모두 클릭/해제
    $('input[name=all-chk]').click(function(){
        if($('input[name=all-chk]').is(':checked')) $('input[name=chk]').prop('checked', true);
        else $('input[name=chk]').prop('checked', false);

        // checkbox:disabled css 변경하지 않게
        if($('input:disabled').is(':checked')) $('input:disabled').prop('checked', false);
    });


});

  
