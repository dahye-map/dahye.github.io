$('.btn-start').click(function () {
    $('#fitstartWrap .fit-start').hide();
    $('#fittestWrap .fittest').addClass('active');

    setTimeout(function () { $('.fit-question.first .fit-msg .fit-msg-item:first-child').addClass('up'); }, 100);
    setTimeout(function () { $('.fit-question.first .fit-msg .fit-msg-item:nth-child(2)').addClass('up'); }, 200);
    setTimeout(function () { $('.fit-question.first .fit-msg .fit-msg-item:last-child').addClass('up'); }, 400);
    setTimeout(function () { $('.fit-choice.first').addClass('up'); }, 800);
});

// 질문 답변 순차적으로 보여지기
// $('#fittestWrap .fittest').addClass('active');
// setTimeout(function () { $('.fit-question.first .fit-msg .fit-msg-item:first-child').addClass('up'); }, 100);
// setTimeout(function () { $('.fit-question.first .fit-msg .fit-msg-item:last-child').addClass('up'); }, 400);
// setTimeout(function () { $('.fit-choice.first').addClass('up'); }, 800);

function qa_up() {
    setTimeout(function () { $('.fit-question.active .fit-msg-item:first-child').addClass('up'); }, 100);
    setTimeout(function () { $('.fit-question.active .fit-msg-item:last-child').addClass('up'); }, 400);
    setTimeout(function () { $('.fit-choice.active').addClass('up'); }, 800);
}
function pick_up() {
    setTimeout(function () { $('.pick .fit-question.active .fit-msg-item:first-child').addClass('up'); }, 100);
    setTimeout(function () { $('.pick .fit-question.active .fit-msg-item:last-child').addClass('up'); }, 400);
    setTimeout(function () { $('.pick .fit-choice.active').addClass('up'); }, 800);
}

var interest01 = '<div class="step-answer type2 pick" step="8"><div class="fit-question sub-first"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>예전보다 활력(에너지)이 많이 떨어지셨나요?</p></div></div></div><div class="fit-choice sub-first"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>무기력해 보인다는 말을 자주 들으시나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>혈압이 높아지는 일이 잦으신가요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>평소 몸이 차거나 저리시는 적이 많나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>평소 노화가 걱정되시나요?</p></div></div></div><div class="fit-choice last"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div></div>'

var interest02 = '<div class="step-answer type3 pick" step="8"><div class="fit-question sub-first"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>체중 감량 계획이 있으신가요?</p></div></div></div><div class="fit-choice sub-first"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>체중조절을 위해 최소 30분 이상 신체활동(운동)을 하고 계시나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>평소에 군것질(과자, 음료 등)을 좋아하나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>식사시, 고기(소고기, 돼지고기 등) 위주의 메뉴를 선택하시나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>키와 몸무게를 입력해주세요.</p></div></div></div><div class="fit-choice last"><div class="input-wrap"><input type="number" name="height" min="0" id="height">cm <br> <input type="number" name="weight" min="0" id="weight">kg </div><div class="fit-choice-item bmi-chk"><a href="javascript:void(0)">NEXT</a></div></div></div>'

var interest03 = '<div class="step-answer type4 pick" step="8"><div class="fit-question sub-first"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>음주를 좋아하시나요?</p></div></div></div><div class="fit-choice sub-first"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>술자리를 갖을때, 보통 얼마나 섭취 하시나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">1~2잔</a></div><div class="fit-choice-item"><a href="javascript:void(0)">3잔 이상</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>음주 후, 다음 날 숙취때문에 고생 한 적이 많은가요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>과증된 학업이나 잦은 야근으로 인해 피곤하신가요?</p></div></div></div><div class="fit-choice last"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div></div>'

var interest04 = '<div class="step-answer type5 pick" step="8"><div class="fit-question sub-first"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>피부가 건조하거나 푸석거려서 고민이신가요?</p></div></div></div><div class="fit-choice sub-first"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>피부가 칙칙해서 고민이신가요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>피부의 탄력이나 생기가 고민이신가요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>기미, 주름깨 등 잡티가 고민이신가요?</p></div></div></div><div class="fit-choice last"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div></div>'

var interest05 = '<div class="step-answer type6 pick" step="8"><div class="fit-question sub-first"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>평소, 스트레스를 많이 받으시나요?</p></div></div></div><div class="fit-choice sub-first"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>기분이 처지거나, 우울해지는 일이 많아지셨나요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>자주깨고, 자고나서도 개운하지 않으신가요?</p></div></div></div><div class="fit-choice"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div><div class="fit-question"><div class="fit-profile"><p class="thumb"><img src="../img/img_profile_thumb.png" alt=""></p><p class="name">곰히얼</p></div><div class="fit-msg"><div class="fit-msg-item"><p>식사는 잘 하시나요?</p></div></div></div><div class="fit-choice last"><div class="fit-choice-item"><a href="javascript:void(0)">YES</a></div><div class="fit-choice-item"><a href="javascript:void(0)">NO</a></div></div></div>'







//순위매기기
var index = 0;
$('.result-fit .fit-choice-item').click(function () {
    index = index + 1;
    $(this).append('<div class="count">' + (index) + '</div>');
    if (index == 1) {
        index = 1;
        return;
    }
    if (index == 2) {
        index = 2;
    }
    if (index == 3) {
        index = 3;
    }
});

$('.fit-content').on('click', '.fit-choice-item', function () {
    var _this = $(this),
        _thisA = $(this).parent(),
        _nextQ = $(this).parent().next(),
        _nextA = $(this).parent().next().next(),
        _nextSubQ = $(this).parent().next().children('.fit-question.sub-first'),
        _nextSubQ02 = $(this).parent().parent().next().children('.fit-question.sub-first'),
        _nextSubA = $(this).parent().next().children('.fit-choice.sub-first'),
        _nextSubA02 = $(this).parent().parent().next().children('.fit-choice.sub-first'),
        answerPick = _this.attr('answer'),
        resultPick = $('.fit-result').attr('result');

    if (_thisA.attr('step') == 4) {
        _this.addClass('active');

        // 세개선택가능
        var stepCnt = $('.fit-choice-item.active').length - 3;

        var _isCnt = false;
        if (!_isCnt) {
            _isCnt = true;

            if (stepCnt >= 3) {
                _nextQ.addClass('active');
                _nextA.addClass('active');

                //세개 이상 클릭 시 클릭 액티브 막기
                $('.result-fit .fit-choice-item').css('pointer-events', 'none')
            } else {
                _nextQ.removeClass('active');
                _nextA.removeClass('active');

            }
            //세개 이상 클릭 시 클릭 액티브 막기
            if (stepCnt > 3) {
                _this.removeClass('active');
            }
            setTimeout(function () { _isCnt = false; }, 200);
        }

        if (answerPick == 2) {
            $('.step-answer.type2').remove();
            $('.fit-content').append(interest01);
            $('.fit-result-wrap .fit-result.type1').removeClass('active');
        }
        if (answerPick == 3) {
            $('.step-answer.type3').remove();
            $('.fit-content').append(interest02);
            $('.fit-result-wrap .fit-result.type1').removeClass('active');
        }
        if (answerPick == 4) {
            $('.step-answer.type4').remove();
            $('.fit-content').append(interest03);
            $('.fit-result-wrap .fit-result.type1').removeClass('active');
        }
        if (answerPick == 5) {
            $('.step-answer.type5').remove();
            $('.fit-content').append(interest04);
            $('.fit-result-wrap .fit-result.type1').removeClass('active');
        }
        if (answerPick == 6) {
            $('.step-answer.type6').remove();
            $('.fit-content').append(interest05);
            $('.fit-result-wrap .fit-result.type1').removeClass('active');
        }
        //다시 선택
        $('.reset').click(function () {
            $('.result-fit .fit-choice-item').removeClass('active')
            $('.step-answer').remove();
            $('.result-fit~.fit-question').removeClass('active');
            $('.result-fit~.fit-choice').removeClass('active');
            $('.fit-result').removeClass('active');

            $('.result-fit .fit-choice-item').css('pointer-events', '')
            $('.count').remove();
            index = 0;
        });
    } else {
        _this.addClass('active');
        _this.siblings('.fit-choice-item').css('display', 'none');

        _nextQ.addClass('active');
        _nextA.addClass('active');

    }

    //개별질문
    if (_thisA.attr('step') >= 7) {
        _nextQ.removeClass('active');
        _nextA.removeClass('active');

        _nextSubQ.addClass('active');
        _nextSubA.addClass('active');

        //끝나따 이놈아
        if (!_nextSubQ.hasClass('active')) {
            $('.fit-content-wrap').hide();
            //$('.fit-result-wrap').show();
            var cnt0 = 0;
            counterFn();

            function counterFn() {
                id0 = setInterval(count0Fn, 300);
                function count0Fn() {
                    cnt0 = cnt0 + 7;
                    if (cnt0 > 100) {
                        clearInterval(id0);
                        $('.fit-loading').hide();
                    } else {
                        $(".percent").html(cnt0 + "%");
                    }
                }
            }
        }


        pick_up();
    }

    if (_thisA.hasClass('last')) {
        _nextSubQ02.addClass('active');
        _nextSubA02.addClass('active');

        //끝나따 이놈아
        if (!_nextSubQ02.hasClass('active')) {
            $('.fit-content-wrap').hide();
            //$('.fit-result-wrap').show();
            var cnt0 = 0;
            counterFn();

            function counterFn() {
                id0 = setInterval(count0Fn, 300);
                function count0Fn() {
                    cnt0 = cnt0 + 7;
                    if (cnt0 > 100) {
                        clearInterval(id0);
                        $('.fit-loading').hide();
                    } else {
                        $(".percent").html(cnt0 + "%");
                    }
                }
            }
        }

        pick_up();
    }

    if (_nextQ.hasClass('active')) {
        qa_up();
    }
    $('.fit-content-wrap .fit-content-inner').animate({ scrollTop: $('.fit-content').outerHeight() }, "slow");


    //결과 도출
    $('.fit-result-list-wrap .fit-result.type' + answerPick).addClass('active');


    //나이 결과 도출
    $('.age-choice .fit-choice-item').click(function () {
        $('.fit-result-summary .age').html($(this).attr('value'))
    });

    //성별 결과 도출
    $('.gender-choice .fit-choice-item').click(function () {
        $('.fit-result-summary .gender').html($(this).attr('value') + "  ·  ")
    });

    $('.fit-result-summary .height').html($('#height').val() + "cm  ·  ")
    $('.fit-result-summary .weight').html($('#weight').val() + "kg  ｜  ")



    $('.btn-result-show').click(function () {
        $('#fitWrap').removeClass('active');
        $('#fittestWrap .fittest').removeClass('active');
        $('.fit-result-summary').hide();
        $('#fitresultWrap').addClass('active');
    });




});

// bmi체크
$('.fit-content').on('click', '.bmi-chk', function () {
    var _height = $('input[name=height]').val(),
        _weight = $('input[name=weight]').val(),
        height_p = _height / 100,
        bmi = _weight / (height_p * height_p);


    $('.fit-result-summary .bear.type01').hide();
    $('.fit-result-summary .bear.type02').show();

    if (bmi >= 0 && bmi <= 18.5) {
        $('.fit-result-summary .bmi').html("저체중")
        $('.gauge-wrap .bar').addClass('w10');
    } else if (bmi >= 18.6 && bmi <= 22.9) {
        $('.fit-result-summary .bmi').html("정상")
        $('.gauge-wrap .bar').addClass('w50');
    } else if (bmi >= 23 & bmi <= 24.9) {
        $('.fit-result-summary .bmi').html("과체중")
        $('.gauge-wrap .bar').addClass('w60');
    } else if (bmi >= 25 & bmi <= 29.9) {
        $('.fit-result-summary .bmi').html("1단계비만")
        $('.gauge-wrap .bar').addClass('w80');
    } else if (bmi >= 30 & bmi <= 34.9) {
        $('.fit-result-summary .bmi').html("2단계비만")
        $('.gauge-wrap .bar').addClass('w90');
    } else if (bmi >= 35) {
        $('.fit-result-summary .bmi').html("고도비만")
        $('.gauge-wrap .bar').addClass('w100');
    }

});






var ww = $(window).width();
var swiper_result = undefined;

function initSwiper() {

    if (ww > 991 && swiper_result == undefined) {
        swiper_result = new Swiper('.fit-result-list-wrap', {
            slidesPerView: 'auto',
            spaceBetween: 135,
        });
    } else if (ww <= 991 && swiper_result != undefined) {
        swiper_result.destroy();
        swiper_result = undefined;
    }
}

initSwiper();

$(window).on('resize', function () {
    ww = $(window).width();
    initSwiper();
});