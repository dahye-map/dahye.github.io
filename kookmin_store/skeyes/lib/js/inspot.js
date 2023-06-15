$(document).ready(function(e) {
    resize();
    $(window).resize(function() {
        resize();
    });
});
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
수정!!
 * PC 인지 모바일인지 판단하기
 * return true : pc
 * return false : mobile
 *
 */
var isPc = (function() {
	var filter = "win16|win32|win64|macintel|mac";
	var isPc = true;
	if(navigator.platform){
		if(filter.indexOf(navigator.platform.toLowerCase())<0){
			return false;
		}else{
			return true;
		}
	}
});

/**
 * 모바일에서 br삭제
 * @class hidden-br
 * @param data  : 삭제할 해상도 넓이
 * @return
 *
 */
var _thisText = [];
var firstRun = true;

function resize() {
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
              /(msie) ([\w.]+)/.exec(s) ||
              /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) ||
             [];
  return { name: match[1] || "", version: match[2] || "0" };
}());


/**
 * URL에서 get방식의 파라메터 받아오기
 *
 */
function getUrlParameters(){
	var url = location.href;
	var param = null;
	var params = new Object;
	param = url.split("?");
	if(param.length > 1){
	    param = param[1].split("&");
		for(var i = 0 ; i < param.length; ++i){
			var imsi = param[i].split("=");
			params[imsi[0]] = imsi[1];
	    }
		params.getString = function(str){
			if(this[str]) return this[str];
			else return null;
		}
		params.getNumber = function(str){
			if(this[str]) return Number(this[str]);
			else return null;
		}
		return params;
	}
	return null;
}

function goLastzine(obj)
{
	if (obj.options[obj.selectedIndex].value != "")
	{
		top.location.href = obj.options[obj.selectedIndex].value;
	}
}

function dataChk(str, maxLen)
{
	if (str.value.length > maxLen)
	{
		alert(maxLen + "자까지만 입력해 주세요");
		str.value = str.value.substring(0,maxLen);
		str.focus();
		return;
	}
}

var isMobile = (function() {
  var keyword = new Array('iPhone', 'iPod', 'Android', 'Windows CE',
                          'BlackBerry', 'Symbian', 'Windows Phone',
                          'webOS', 'Opera Mini', 'Opera Mobi', 'POLARIS',
                          'IEMobile', 'lgtelecome', 'LG', 'MOT', 'SAMSUNG', 'Samsung', 'SonyEricsson')
                    , ua = navigator.userAgent
                    , re = null
                    , index = ''
                    , res = false;

    for(index in keyword) {
		re = new RegExp(keyword[index]);
        res = re.test(ua);
        if(res == true) { break; }
	}

  return res;
}());


// 응답하라 해외현장 tab

// Tab Content
function initTabMenu(tabContainerID) {
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var i = 0;

	for(i=0; i<tabAnchor.length; i++) {
//    for(i=0; i<2; i++) {
		if (tabAnchor.item(i).className == "tab") thismenu = tabAnchor.item(i);
		else continue;
		thismenu.container = tabContainer;
		thismenu.targetEl = document.getElementById(tabAnchor.item(i).href.split("#")[1]);
		thismenu.targetEl.style.display = "none";
		thismenu.imgEl = thismenu.getElementsByTagName("img").item(0);
		thismenu.onclick = function tabMenuClick() {
			currentmenu = this.container.current;
			if (currentmenu == this)
				return false;
			if (currentmenu) {
				currentmenu.targetEl.style.display = "none";
				if (currentmenu.imgEl) {
					currentmenu.imgEl.src = currentmenu.imgEl.src.replace("_on.gif", ".gif");
				} else {
					currentmenu.className = currentmenu.className.replace("gif", "");
				}
			}
			this.targetEl.style.display = "";
			if (this.imgEl) {
				this.imgEl.src = this.imgEl.src.replace(".gif", "_on.gif");
			} else {
				this.className += " on";
			}
			this.container.current = this;
			return false;
		};
		if (!thismenu.container.first) thismenu.container.first = thismenu;
	}
	if (tabContainer.first) tabContainer.first.onclick();
}

//var cMenuID = 2;
function selTabMenu(tabContainerID) {
//alert(cMenuID)
	var tabContainer = document.getElementById(tabContainerID);
	var tabAnchor = tabContainer.getElementsByTagName("a");
	var thismenu = tabAnchor.item(cMenuID - 1);
	thismenu.onclick();
}
function setTabMenu(tabContainerID, tabMenuNo) {
	document.getElementById(tabContainerID).getElementsByTagName("a").item(tabMenuNo-1).onclick();
}
