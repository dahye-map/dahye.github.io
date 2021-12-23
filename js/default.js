var winH = $(window).height()||window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight;
$(document).on('click', '.btn-top', function(e) {
    e.preventDefault();
    $('body, html').animate({
        scrollTop: 0
    }, 300);
});


//문자열자르기
function cutByLen(str, maxByte) {
    for (b = i = 0; c = str.charCodeAt(i);) {
        b += c >> 7 ? 2 : 1;
        if (b > maxByte)
            break;
        i++;
    }
    return str.substring(0, i);
}
// 접근성 관련 포커스 강제 이동
function accessibilityFocus() {
    $(document).on('keydown', '[data-focus-prev], [data-focus-next]', function(e) {
        var next = $(e.target).attr('data-focus-next'),
            prev = $(e.target).attr('data-focus-prev'),
            target = next || prev || false;
        if (!target || e.keyCode != 9) {
            return;
        }
		//console.log('next : '+next+'\nprev : '+prev);
        if ((!e.shiftKey && !!next) || (e.shiftKey && !!prev)) {
            setTimeout(function() {
				//console.log('target : '+target);
                $('[data-focus="' + target + '"]').focus();
            }, 1);
        }
    });
}
function tooltip() {
    var openBtn = '[data-tooltip]',
        closeBtn = '.tooltip-close';

    function getTarget(t) {
        return $(t).attr('data-tooltip');
    }

    function open(t) {
        var showTarget = $('[data-tooltip-con="' + t + '"]');
        showTarget.show().focus();
        showTarget.find('.tooltip-close').data('activeTarget', t);
    }

    function close(t) {
        var activeTarget = $('[data-tooltip-con="' + t + '"]');
        activeTarget.hide();
        $('[data-tooltip="' + t + '"]').focus();
    }
    $(document).on('click', openBtn, function(e) {
        e.preventDefault();
        open(getTarget(e.target));
    }).on('click', closeBtn, function(e) {
        e.preventDefault();
        close($(this).data('activeTarget'));
    });
}
//block
function addBlock() {
    $('body').append('<div class="block"></div>');
    //$('body, html, #wrap').css({'overflow': 'hidden','height': winH});
    $('.block').fadeIn(300);
    $('.block').on('click', function() {
        if ($('.block').length > 0) {
            $('.block').fadeOut(300).empty().remove();
            $('.layerpopup').fadeOut(300);
        }
        //$('body, html, #wrap').css({'height': '', 'overflow': ''});
    });
}
$(document).on('click', '.pop-close', function(e) {
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
    if ($('.layerpopup').css('display') == 'none') {
        addBlock();
        $('#' + id).fadeIn(300);
    }

}
function closePopup(id) {
    deleteBlock();
    $('#' + id).fadeOut(300);
}

//radio, checkbox custom style
function setupLabel() {
	if ($('.check input').length) {
		$('.check').each(function(){
			$(this).removeClass('c-on');
		});
		$('.check input:checked').each(function(){
			$(this).parent('label').addClass('c-on');
		});
	};
	if ($('.radio input').length) {
		$('.radio').each(function(){
			$(this).next('.radio-txt').removeClass('radio-txt-on');
			$(this).removeClass('r-on');
		});
		$('.radio input:checked').each(function(){
			$(this).parent('label').addClass('r-on');
			$(this).parent('label').next('.radio-txt').addClass('radio-txt-on');
		});
	};
};
//selectbox
function customSelect() {
    if ($('.select').length) {
        $('.select').each(function(){
            $(this).find('p').text($(this).find('li.select').text());
        });
        $('.select').find('p').on('click',function(){
            var $select = $(this);
            $('.select ul').slideUp('fast');
            $('.select .select-wrap').removeClass('active');
            $(this).parent().addClass('active');
            if ($(this).siblings('ul').css('display') == 'none') {
                $(this).siblings('ul').slideDown('fast');
            }else{
                $('.select .select-wrap').removeClass('active');
            }
        });
        $('.select li a').on('click',function(e){
            e.preventDefault();
            var selectUl = $(this).parent().parent();
            var selectLi = $(this).parent();
            selectUl.find('li').removeClass('select');
            selectLi.addClass('select');
            selectUl.slideUp('fast').siblings('p').text($(this).text());
            selectUl.parent().removeClass('active');
        });
    }
}
$(document).click(function(e){
    if (!$(e.target).parent().hasClass('select-wrap')) {
         $('.select ul').slideUp('fast');
         $('.select .select-wrap').removeClass('active');
    }
});
$(document).ready(function(){
	$("body").on("click",".check, .radio",function(e){
		setupLabel();
	});
	setupLabel();
    customSelect();
	$('.btn-close-pop').on('click',function(){
		closePopup($(this).parent().parent().parent().attr('id'));
		$('body, html, #wrap').css({'height':'','overflow':''}); //161111 add : booking-detail-popup
	});
});

//radio, checkbox custom style

// 이미지로드
$.preloadImages = function() {
    for (var i = 0; i < arguments.length; i++) {
        $("<img />").attr("src", arguments[i]);
    }
};
/* selectbox */
jQuery.fn.extend({
    selectbox: function(options) {
        return this.each(function() {
            new jQuery.SelectBox(this, options);
        });
    }
});

/* pawel maziarz: work around for ie logging */
if (!window.console) {
    var console = {
        log: function(msg) {}
    }
}

$(document).ready(function() {
	//$('select').selectbox();
});
jQuery.SelectBox = function(selectobj, options) {

	var opt = options || {};
	opt.inputType = opt.inputType || "input";
	opt.inputClass = opt.inputClass || "selectbox";
	opt.containerClass = opt.containerClass || "selectbox-wrapper";
	opt.hoverClass = opt.hoverClass || "current";
	opt.currentClass = opt.currentClass || "selected";
	opt.groupClass = opt.groupClass || "groupname"; //css class for group
	//opt.maxHeight = opt.maxHeight || 200; // max height of dropdown list
	opt.loopnoStep = opt.loopnoStep || false; // to remove the step in list moves loop
	opt.onChangeCallback = opt.onChangeCallback || false;
	opt.onChangeParams = opt.onChangeParams || false;
	opt.debug = opt.debug || false;
	opt.selectColor = opt.selectColor || "#000"; //css class for group

	var elm_id = selectobj.id;
	var active = 0;
	var inFocus = false;
	var hasfocus = 0;
	var hasfocusContainer = -1;
	//jquery object for select element
	var $select = jQuery(selectobj);
	// jquery container object
	var $container = setupContainer(opt);
	//jquery input object
	var $input = setupInput(opt);
	// hide select and append newly created elements
	$select.hide().before($input).before($container);
	var defaultColor = $input.css('color');
	init();

	$input
	.click(function(){
		if (!inFocus) {
			$container.toggle();
		}
	})
	.focus(function(){
		if( hasfocus > 0 && hasfocusContainer > 0){
			hasfocusContainer = -1;
			setTimeout(function(){ $input.blur(); }, 300);
		}
		else if ($container.not(':visible')) {
			inFocus = true;
			$container.show();
		}
	})
	.keydown(function(event) {
		switch(event.keyCode) {
			case 38: // up
				event.preventDefault();
				moveSelect(-1);
				break;
			case 40: // down
				event.preventDefault();
				moveSelect(1);
				break;
			case 9:  // tab
				hideMe();
				break;
			case 13: // return
				event.preventDefault(); // seems not working in mac !
				$('li.'+opt.hoverClass).trigger('click');
				break;
			case 27: //escape
			  hideMe();
			  break;
		}
	})
	.blur(function(e) {
		if ($container.is(':visible') && hasfocusContainer > 0 ) {
			$input.focus();
		} else {
			hasfocusContainer = -1;
			hideMe();
		}
	});

	$container.on({
		mouseenter : function(){
			hasfocusContainer = 1;
		},
		mouseleave : function(){
			hasfocusContainer = -1;
		}
	});

	function hideMe() {
		hasfocus = 0;
		$container.hide();
	}

	function init() {
		$container.append(getSelectOptions($input.attr('id'))).hide();
		//var width = $input.css('width');
		//var width = $input.outerWidth()-2;
		var width = $input.outerWidth()-2;
		if($container.height() > opt.maxHeight){
			//$container.width(parseInt(width)+parseInt($input.css('paddingRight'))+parseInt($input.css('paddingLeft')));
			$container.width(width);
			$container.height(opt.maxHeight);
		} else $container.width(width);
	}

	function setupContainer(options) {
		var container = document.createElement("div");
		$container = jQuery(container);
		$container.attr('id', elm_id+'_container');
		$container.addClass(options.containerClass);
			$container.css('display', 'none');
		return $container;
	}

	function setupInput(options) {
		if(opt.inputType == "span"){
			var input = document.createElement("span");
			var $input = jQuery(input);
			$input.attr("id", elm_id+"_input");
			$input.addClass(options.inputClass);
			$input.attr("tabIndex", $select.attr("tabindex"));
		} else {
			var input = document.createElement("input");
			var $input = jQuery(input);
			$input.attr("id", elm_id+"_input");
			$input.attr("type", "text");
			$input.addClass(options.inputClass);
			$input.attr("autocomplete", "off");
			$input.attr("readonly", "readonly");
			$input.attr("tabIndex", $select.attr("tabindex")); // "I" capital is important for ie
			$input.css("width", $select.parent().outerWidth()-2);
			//$input.css("width", $select.outerWidth()-2);
			}
		return $input;
	}

	function moveSelect(step) {
		var lis = jQuery("li", $container);
		if (!lis || lis.length == 0) return false;
		// find the first non-group (first option)
		firstchoice = 0;
		while($(lis[firstchoice]).hasClass(opt.groupClass)) firstchoice++;
		active += step;
			// if we are on a group step one more time
			if($(lis[active]).hasClass(opt.groupClass)) active += step;
		//loop through list from the first possible option
		if (active < firstchoice) {
			(opt.loopnoStep ? active = lis.size()-1 : active = lis.size() );
		} else if (opt.loopnoStep && active > lis.size()-1) {
			active = firstchoice;
		} else if (active > lis.size()) {
			active = firstchoice;
		}
			scroll(lis, active);
		lis.removeClass(opt.hoverClass);

		jQuery(lis[active]).addClass(opt.hoverClass);
	}

	function scroll(list, active) {
			var el = jQuery(list[active]).get(0);
			var list = $container.get(0);

		if (el.offsetTop + el.offsetHeight > list.scrollTop + list.clientHeight) {
			list.scrollTop = el.offsetTop + el.offsetHeight - list.clientHeight;
		} else if(el.offsetTop < list.scrollTop) {
			list.scrollTop = el.offsetTop;
		}
	}

	function setCurrent() {
		var li = jQuery("li."+opt.currentClass, $container).get(0);
		var ar = (''+li.id).split('_');
		var el = ar[ar.length-1];
		if (opt.onChangeCallback){
				$select.get(0).selectedIndex = $('li', $container).index(li);
				opt.onChangeParams = { selectedVal : $select.val() };
			opt.onChangeCallback(opt.onChangeParams);
		} else {
			$select.val(el);
			$select.change();
		}
		//console.log($select.get(0).selectedIndex);
		if($select.get(0).selectedIndex!=0)$input.css('color',opt.selectColor);
		else $input.css('color',defaultColor)
		if(opt.inputType == 'span') $input.html($(li).text());
		else $input.val($(li).text());
		return true;
	}

	// select value
	function getCurrentSelected() {
		return $select.val();
	}

	// input value
	function getCurrentValue() {
		return $input.val();
	}

	function getSelectOptions(parentid) {
		var select_options = new Array();
		var ul = document.createElement('ul');
		select_options = $select.children('option');
		if(select_options.length == 0) {
			var select_optgroups = new Array();
			select_optgroups = $select.children('optgroup');
			for(x=0;x<select_optgroups.length;x++){
				select_options = $("#"+select_optgroups[x].id).children('option');
				var li = document.createElement('li');
				li.setAttribute('id', parentid + '_' + $(this).val());
				li.innerHTML = $("#"+select_optgroups[x].id).attr('label');
				li.className = opt.groupClass;
				ul.appendChild(li);
				select_options.each(function() {
					var li = document.createElement('li');
					li.setAttribute('id', parentid + '_' + $(this).val());
					li.innerHTML = $(this).html();
					if ($(this).is(':selected')) {
						$input.html($(this).html());
						$(li).addClass(opt.currentClass);
					}
					ul.appendChild(li);
					$(li)
					.mouseover(function(event) {
						hasfocus = 1;
						if (opt.debug) console.log('over on : '+this.id);
						jQuery(event.target, $container).addClass(opt.hoverClass);
					})
					.mouseout(function(event) {
						hasfocus = -1;
						if (opt.debug) console.log('out on : '+this.id);
						jQuery(event.target, $container).removeClass(opt.hoverClass);
					})
					.click(function(event) {
						var fl = $('li.'+opt.hoverClass, $container).get(0);
						if (opt.debug) console.log('click on :'+this.id);
						$('li.'+opt.currentClass, $container).removeClass(opt.currentClass);
						$(this).addClass(opt.currentClass);
						setCurrent();
						$select.get(0).blur();
						hideMe();
					});
				});
			}
		} else select_options.each(function() {
			var li = document.createElement('li');
			li.setAttribute('id', parentid + '_' + $(this).val());
			li.innerHTML = $(this).html();
			if ($(this).is(':selected')) {
				$input.val($(this).text());
				$(li).addClass(opt.currentClass);
			}
			ul.appendChild(li);
			$(li)
			.mouseover(function(event) {
				hasfocus = 1;
				if (opt.debug) console.log('over on : '+this.id);
				jQuery(event.target, $container).addClass(opt.hoverClass);
			})
			.mouseout(function(event) {
				hasfocus = -1;
				if (opt.debug) console.log('out on : '+this.id);
				jQuery(event.target, $container).removeClass(opt.hoverClass);
			})
			.click(function(event) {
			  	var fl = $('li.'+opt.hoverClass, $container).get(0);
				if (opt.debug) console.log('click on :'+this.id);
				$('li.'+opt.currentClass, $container).removeClass(opt.currentClass);
				$(this).addClass(opt.currentClass);
				setCurrent();
				$select.get(0).blur();
				hideMe();
			});
		});
		return ul;
	}
};

// select 삭제  function
function selClear(selId){
	$(selId+"_input").remove();
	$(selId + '_container').remove();
}

//font Control
function fontPlus(){
	$('*').each(function(){
		var _fontSize = parseInt($(this).css('font-size'))*1.1;
		//console.log(_fontSize);
		$(this).css({'font-size':_fontSize+"px"});
	});
}
function fontMinus(){
	$('*').each(function(){
		var _fontSize = parseInt($(this).css('font-size'))/1.1;
		//console.log(_fontSize);
		$(this).css({'font-size':_fontSize+"px"});
	});
}

/**
* 중앙정렬 위치
* @param containerSize : 컨테이너의 크기
* @param targetSize : 컨테이너에 들어 있는 오브젝트의 크기
* @return
*/
function getCenterAlignPos( containerSize, targetSize ) {
  var pos = ( containerSize - targetSize ) / 2;
  return pos;
}

/**
 * 해당 포인트를 기준으로 중간에 걸칠경우
 * @param centerPos : 기준선
 * @param targetSize : 오브젝트의 크기
 * @return
 *
 */
function getCenterPos( centerPos, targetSize ) {
  var pos = centerPos - ( targetSize / 2 );
  return pos;
}

/**
 * 랜덤값 간단하게 뽑아오기
 * @param min : 가장 적은값
 * @param max  : 가장 높은값
 * @return
 *
 */
function getRandom( min, max ){
	return Math.floor(Math.random()*(max-min))+min;
}


/**
 * 브라우저 종류 알기
 * if(getBrowser.name == "msie") { ... }
 *
 */
var getBrowser = (function() {
  var s = navigator.userAgent.toLowerCase();

  var match = /(webkit)[ \/](\w.]+)/.exec(s) ||
              /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) ||
			  /(trident)(?:.*rv:([\w.]+))?/.exec(s) ||
			  /(msie) ([\w.]+)/.exec(s)||
              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
             [];
  return { name: match[1] || "", version: match[2] || "0" };
}());

/**
 * PC 인지 모바일인지 판단하기
 * return true : mobile
 * return false : pc
 *
 */
 var currentOS;
 var isMobile = (/iphone|ipad|ipod|android/i.test(navigator.userAgent.toLowerCase()));
 if (isMobile) {
 	// 유저에이전트를 불러와서 OS를 구분합니다.
 	var userAgent = navigator.userAgent.toLowerCase();
 	if (userAgent.search("android") > -1)
 		currentOS = "android";
 	else if ((userAgent.search("iphone") > -1) || (userAgent.search("ipod") > -1)
 				|| (userAgent.search("ipad") > -1))
 		currentOS = "ios";
 	else
 		currentOS = "else";
 } else {
 	// 모바일이 아닐 때
 	currentOS = "nomobile";
 }

/**
 * Input
 *
 */
$(document).ready(function() {
  var placeholderTarget = $('.input-box input[type="text"], .input-box input[type="password"]');

  //포커스시
  placeholderTarget.on('focus', function(){
    $(this).siblings('label').fadeOut('fast');
	$(this).siblings('span.fade').fadeOut('fast');
  });

  //포커스아웃시
  placeholderTarget.on('focusout', function(){
    if($(this).val() == ''){
      $(this).siblings('label').fadeIn('fast');
	  $(this).siblings('span.fade').fadeIn('fast');
    }
  });
});

//roll
jQuery(function(){
	var rollover = {
		newimage: function(src) {
			return src.substring(0, src.search(/(\.[a-z]+)$/)) + '_on' + src.match(/(\.[a-z]+)$/)[0];
		},
		oldimage: function(src) {
			return src.replace(/_on\./, '.');
		},
		init: function() {
			$('.roll').hover(
			function() {
				$(this).attr('src', rollover.newimage($(this).attr('src')));
			}, function() {
				$(this).attr('src', rollover.oldimage($(this).attr('src')));
			});
		}
	};
	rollover.init();
});
//숫자 콤마
function addComma(data_value) {
	return Number(data_value).toLocaleString('en').split(".")[0];
}
function removeComma(data_value) {  // 콤마제거
    if ( typeof data_value == "undefined" || data_value == null || data_value == "" ) {
        return "";
    }
    var txtNumber = '' + data_value;
	var replaceNum = txtNumber.replace(/(,)/g, "")
    return parseInt(replaceNum);
}
/**
 * scrollTop위치에 따라 class add remove
 * @param _selector : 셀렉터
 * @param _gap : default 0
 * @param _addclass : add 할 클래스명
 * @return
 */
 function scrollTopFunc(_triggerSelector,_gap,_addClass,_addSelector){
     $(window).load(function(){
         if ($(_triggerSelector).length > 0) {
             var _selectorTop = $(_triggerSelector).offset().top;
         }
         if(typeof _addSelector == 'undefined'){ _addSelector = _triggerSelector; }
         $(window).scroll(function () {
             if ($(this).scrollTop() > (_selectorTop - parseInt(_gap))) {
                 $(_addSelector).addClass(_addClass);
             }else{
                 $(_addSelector).removeClass(_addClass);
             }
         });
     });
 }

 /**
  * 모바일에서 br삭제
  * @class hidden-br
  * @param data  : 삭제할 해상도 넓이
  * @return
  *
  */
 var _thisText = [];
 var firstRun = true;
 $(window).resize(function(){
     var _winW = $(window).width();
     var _dataW;
     if ($('.hidden-br').length > 0) {
         //console.log($('.hidden-br').length);
         $('.hidden-br').each(function(index) {
             if (firstRun) {
                 if (index < $('.hidden-br').length - 1) {
                     _thisText.push($(this).html());
                 } else if (index == $('.hidden-br').length - 1) {
                     firstRun = false;
                 }
             };
             _dataW = $(this).attr('data');
             if (_winW < _dataW) {
                 $(this).html($(this).html().replace(/<br[^>]*>/gi," "));
             } else if (_winW > _dataW) {
                 $(this).html(_thisText[index]);
             }
         });
     }
 }).resize();
