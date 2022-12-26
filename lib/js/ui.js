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
$(document).on('click', '.pop-close, .layerpop-wrap .btn-gray', function(e) {
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
