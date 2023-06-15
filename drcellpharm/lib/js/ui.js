$('.btn-try').click(function(){
    $('.prd-share-box').toggleClass('active');
});

var clipboard = new ClipboardJS('.clip-link-all');
clipboard.on('success', function(e) {
    //alert("링크 복사가 완료되었습니다.")
    $('.link-success-wrap').addClass('active');
    setTimeout(function(){ $('.link-success-wrap').removeClass('active'); }, 2000);
});
clipboard.on('error', function(e) {
    alert("Ctrl + C 를 누르면 복사가 완료됩니다.")
});

var clipboard_anti = new ClipboardJS('.clip-link-anti');
clipboard_anti.on('success', function(e) {
    //alert("링크 복사가 완료되었습니다.")
    $('.link-success-anti-wrap').addClass('active');
    setTimeout(function(){ $('.link-success-anti-wrap').removeClass('active'); }, 2000);
});
clipboard_anti.on('error', function(e) {
    alert("Ctrl + C 를 누르면 복사가 완료됩니다.")
});

var clipboard_light = new ClipboardJS('.clip-link-light');
clipboard_light.on('success', function(e) {
    //alert("링크 복사가 완료되었습니다.")
    $('.link-success-light-wrap').addClass('active');
    setTimeout(function(){ $('.link-success-light-wrap').removeClass('active'); }, 2000);
});
clipboard_light.on('error', function(e) {
    alert("Ctrl + C 를 누르면 복사가 완료됩니다.")
});

var clipboard_relax = new ClipboardJS('.clip-link-relax');
clipboard_relax.on('success', function(e) {
    //alert("링크 복사가 완료되었습니다.")
    $('.link-success-relax-wrap').addClass('active');
    setTimeout(function(){ $('.link-success-relax-wrap').removeClass('active'); }, 2000);
});
clipboard_relax.on('error', function(e) {
    alert("Ctrl + C 를 누르면 복사가 완료됩니다.")
});


//<![CDATA[
// // 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('8ee330b83141ece3a62ca9db12b02f9c');
// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
Kakao.Link.createDefaultButton({
    container: '#kakao-link-btn',
    objectType: 'feed',
    content: {
        title: document.title,
        description: '내용, 주로 해시태그',
        imageUrl: document.images[0].src,
        link: {
            webUrl: 'http://drcellpharm.com/',
            mobileWebUrl: 'http://drcellpharm.com/'
        }
    },
    social: {
        likeCount: 286,
        commentCount: 45,
        sharedCount: 845
    },
    buttons: [
        {
            title: 'Open!',
            link: {
                mobileWebUrl: 'http://drcellpharm.com/',
                webUrl: 'http://drcellpharm.com/'
            }
        }
    ]
});
//]]>
Kakao.Link.createDefaultButton({
    container: '#kakao-link-btn-anti',
    objectType: 'feed',
    content: {
        title: document.title,
        description: '내용, 주로 해시태그',
        imageUrl: document.images[0].src,
        link: {
            webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EC%95%88%ED%8B%B0%EC%97%90%EC%9D%B4%EC%A7%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/16/category/1/display/2/',
            mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EC%95%88%ED%8B%B0%EC%97%90%EC%9D%B4%EC%A7%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/16/category/1/display/2/'
        }
    },
    social: {
        likeCount: 286,
        commentCount: 45,
        sharedCount: 845
    },
    buttons: [
        {
            title: 'Open!',
            link: {
                mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EC%95%88%ED%8B%B0%EC%97%90%EC%9D%B4%EC%A7%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/16/category/1/display/2/',
                webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EC%95%88%ED%8B%B0%EC%97%90%EC%9D%B4%EC%A7%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/16/category/1/display/2/'
            }
        }
    ]
});
//]]>
Kakao.Link.createDefaultButton({
    container: '#kakao-link-btn-light',
    objectType: 'feed',
    content: {
        title: document.title,
        description: '내용, 주로 해시태그',
        imageUrl: document.images[0].src,
        link: {
            webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%ED%99%94%EC%9D%B4%ED%8A%B8%EB%8B%9D-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/17/category/24/display/1/',
            mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%ED%99%94%EC%9D%B4%ED%8A%B8%EB%8B%9D-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/17/category/24/display/1/'
        }
    },
    social: {
        likeCount: 286,
        commentCount: 45,
        sharedCount: 845
    },
    buttons: [
        {
            title: 'Open!',
            link: {
                mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%ED%99%94%EC%9D%B4%ED%8A%B8%EB%8B%9D-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/17/category/24/display/1/',
                webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%ED%99%94%EC%9D%B4%ED%8A%B8%EB%8B%9D-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/17/category/24/display/1/'
            }
        }
    ]
});
//]]>
Kakao.Link.createDefaultButton({
    container: '#kakao-link-btn-relax',
    objectType: 'feed',
    content: {
        title: document.title,
        description: '내용, 주로 해시태그',
        imageUrl: document.images[0].src,
        link: {
            webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EB%AF%BC%EA%B0%90%EC%A7%84%EC%A0%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/18/category/24/display/1/',
            mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EB%AF%BC%EA%B0%90%EC%A7%84%EC%A0%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/18/category/24/display/1/'
        }
    },
    social: {
        likeCount: 286,
        commentCount: 45,
        sharedCount: 845
    },
    buttons: [
        {
            title: 'Open!',
            link: {
                mobileWebUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EB%AF%BC%EA%B0%90%EC%A7%84%EC%A0%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/18/category/24/display/1/',
                webUrl: 'http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EB%AF%BC%EA%B0%90%EC%A7%84%EC%A0%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/18/category/24/display/1/'
            }
        }
    ]
});
//]]>


function shareFacebook(){
    window.open('http://www.facebook.com/sharer.php?u=http://drcellpharm.com/');
}
function shareFacebook_anti(){
    window.open('http://www.facebook.com/sharer.php?u=http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EC%95%88%ED%8B%B0%EC%97%90%EC%9D%B4%EC%A7%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/16/category/1/display/2/');
}

function shareFacebook_light(){
    window.open('http://www.facebook.com/sharer.php?u=http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%ED%99%94%EC%9D%B4%ED%8A%B8%EB%8B%9D-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/17/category/24/display/1/');
}
function shareFacebook_relax(){
    window.open('http://www.facebook.com/sharer.php?u=http://www.drcellpharm.com/product/%EB%B7%B0%ED%8B%B0%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8-2%EC%A3%BC%EB%AF%B8%EB%9D%BC%ED%81%B4-%EC%86%94%EB%A3%A8%EC%85%98-%EB%AF%BC%EA%B0%90%EC%A7%84%EC%A0%95-%EB%8B%A4%EC%9D%B4%EC%96%B4%ED%8A%B8/18/category/24/display/1/');
}




setTimeout(function(){ $('.floating-banner-wrap .floating-banner').addClass('active'); }, 500);

$('.floating-banner-wrap .floating-banner').click(function(){
    $('#fitWrap').addClass('active');
    $('.black-cover').addClass('active');
});

$('.close a').click(function(){
    $('#fitWrap').removeClass('active');
    $('.black-cover').removeClass('active');
});

$('.back').click(function(){
    window.history.back();
});

$('.btn-start').click(function(){
    $('#fitstartWrap .fit-start').hide();
    $('#fittestWrap .fittest').addClass('active');

    setTimeout(function(){ $('.fit-question.first .fit-msg .fit-msg-item:first-child').addClass('up'); }, 100);
    setTimeout(function(){ $('.fit-question.first .fit-msg .fit-msg-item:last-child').addClass('up'); }, 400);
    setTimeout(function(){ $('.fit-choice.first').addClass('up'); }, 800);
});


$('.fit-choice-item').click(function(){
    var _this = $(this),
        _nextQ = $(this).parent().next(),
        _nextA = $(this).parent().next().next();

    _this.addClass('active');
    _this.siblings().css('display', 'none');

    _nextQ.addClass('active');
    _nextA.addClass('active');
    
    // 질문 답변 순차적으로 보여지기
    if( _nextQ.hasClass('active') ) {
        setTimeout(function(){ $('.fit-question.active .fit-msg .fit-msg-item:first-child').addClass('up'); }, 100);
        setTimeout(function(){ $('.fit-question.active .fit-msg .fit-msg-item:last-child').addClass('up'); }, 400);
        setTimeout(function(){ $('.fit-choice.active').addClass('up'); }, 800);
    }
    $('.fit-content-wrap .fit-content-inner').animate({ scrollTop: $('.fit-content').height() }, "slow");
});


$('.btn-replay').click(function(){

    $('.fit-question').removeClass('active');
    $('.fit-msg .fit-msg-item').removeClass('up');
    $('.fit-choice').removeClass('active');
    $('.fit-choice').removeClass('up');
    $('.fit-choice .fit-choice-item').css('display', '');
    $('.fit-choice br').css('display', '');
    $('.fit-choice .fit-choice-item').removeClass('active');

    $('.fit-result-choice').removeClass('active');
    $('.fit-result-choice').removeClass('up');
    $('.result-con-wrap .result-con').removeClass('active');

    $('.prd-share-box').removeClass('active');

    setTimeout(function(){ $('.fit-question.first .fit-msg .fit-msg-item:first-child').addClass('up'); }, 100);
    setTimeout(function(){ $('.fit-question.first .fit-msg .fit-msg-item:last-child').addClass('up'); }, 400);
    setTimeout(function(){ $('.fit-choice.first').addClass('up'); }, 800);
    
});


function go_result(result) {
    setTimeout(function(){ 
        $('.fit-loading').removeClass('active');
        
    }, 3000);
    setTimeout(function(){ $('.fit-result-wrap, .fit-result-wrap .fit-question, .fit-result-wrap .fit-choice').addClass('active') }, 4000);
    setTimeout(function(){ $('.fit-result-wrap .fit-msg .fit-msg-item:first-child').addClass('up'); }, 4100);
    setTimeout(function(){ $('.fit-result-wrap .fit-msg .fit-msg-item:last-child').addClass('up'); }, 4300);
    setTimeout(function(){ $('.fit-result-wrap .fit-choice.active').addClass('up'); }, 4700);

    $('#result_view').attr('onclick', "result_view('"+ result +"')");

    $('.fit-content-wrap .fit-content-inner').animate({ scrollTop: $('.fit-content').height() }, "slow");

    
}

function result_view(result) {
    if ( result == 'anti') {
        $('.result-con').hide();
        $('.result-con-wrap').addClass('active');
        $('.result-anti').addClass('active');
        setTimeout(function(){ $('.result-con .fit-msg .fit-msg-item').addClass('up'); }, 100);
        setTimeout(function(){ $('.result-anti .pop-con').addClass('active'); },500);
        setTimeout(function(){ $('.result-con .fit-result-choice').addClass('active'); $('.result-con .fit-result-choice').addClass('up'); },800);
    }
    if ( result == 'light') {
        $('.result-con').hide();
        $('.result-con-wrap').addClass('active');
        $('.result-light').addClass('active');
        setTimeout(function(){ $('.result-con .fit-msg .fit-msg-item').addClass('up'); }, 100);
        setTimeout(function(){ $('.result-light .pop-con').addClass('active'); },500);
        setTimeout(function(){ $('.result-con .fit-result-choice').addClass('active'); $('.result-con .fit-result-choice').addClass('up'); },800);
    }
    if ( result == 'relax') {
        $('.result-con').hide();
        $('.result-con-wrap').addClass('active');
        $('.result-relax').addClass('active');
        setTimeout(function(){ $('.result-con .fit-msg .fit-msg-item').addClass('up'); }, 100);
        setTimeout(function(){ $('.result-relax .pop-con').addClass('active'); },500);
        setTimeout(function(){ $('.result-con .fit-result-choice').addClass('active'); $('.result-con .fit-result-choice').addClass('up'); },800);
    }

    $('.fit-content-wrap .fit-content-inner').animate({ scrollTop: $('.fit-content').height() }, "slow");
}


$('.btn-pop-close').click(function(){
    $('.result-con .pop-con').removeClass('active');
});

$('.result-replay').click(function(){
    $('.result-con .pop-con').addClass('active');
});


$('.prev').click(function(){

});