//로그인
function member_login()
{
	var userId = $("#member_id").val();
	var userPwd = $("#member_pwd").val();

	var cookieAccess = $("input:checkbox[id='cookieAccess']").is(":checked")

	if (userId == "")
	{
		alert("아이디를 입력하세요.");
		$("#member_id").focus();
		return;
	}

	if (userPwd == "")
	{
		alert("비밀번호를 입력하세요.");
		$("#member_pwd").focus();
		return;
	}

	if (cookieAccess != true)
	{
		alert("쿠키 사용에 동의 하지 않으시면\n로그인 관련 기능을 사용 할 수 없습니다.");
		$("#cookieAccess").focus();
		return;
	}

	$.ajax({
		url : "../06_members/login_proc.asp",
		type : "POST",
		dataType : "xml",
		data : {
				"userId":userId,
				"userPwd":userPwd,
				"cookieAccess":cookieAccess
		},
		timeout : 1000 * 5,
		error : function(){
			alert('login proc error');
		},
		success : function(data, status){
			var state = $(data).find("state").text();
			var msg = $(data).find("msg").text();
			var member_name = $(data).find("name").text();

			if (state == "1")
			{
				alert("안녕하세요. " + member_name + "님 !!!");
				closePopup("Login");

				var login_utility = "<a href=\"/2017/06_members/memberEdit_confirm.asp\">회원정보수정</a>";
				login_utility += "<button type=\"button\" class=\"btn-login\" onclick=\"member_logout()\">로그아웃</button>";
				login_utility += "<button type=\"button\" onclick=\"openPopup('searchWrap')\" class=\"btn-search\"><img src=\"../images/common/ico_search.gif\" alt=\"검색\"></button>";

				$("#headerWrap > .header > .utility").html(login_utility);
			}else
			{
				$("#member_id").val("");
				$("#member_pwd").val("");
				alert(msg);
			}
		}
	});
}

//로그아웃
function member_logout()
{
	$.ajax({
		url : "../06_members/logout_proc.asp",
		type : "POST",
		dataType : "xml",
		data : {},
		timeout : 1000 * 5,
		error : function(){
			alert('logout proc error');
		},
		success : function(data, status){
			var state = $(data).find("state").text();
			var msg = $(data).find("msg").text();

			if (state == "1")
			{
				alert("로그아웃 되었습니다.");

				document.location.href = "../00_main/main.asp";

			}else
			{
				alert(msg);
			}
		}
	});
}

//프론트 페이징 세팅;
function frontPaging(intTotalCnt, intListCnt, intCurPage, intPageCnt, link_func_name)
{
	var strPagingLink = "";

	var intTotalPage = 0;
	var intTotalBlock = 0;
	var intCurBlock = 0;
	var intStartPage = 0;

	if (parseInt(intTotalCnt) > 0)
	{
		//전체 페이지
		intTotalPage = Math.ceil(intTotalCnt / intListCnt);

		//전체 블럭
		intTotalBlock = Math.ceil(intTotalPage / intPageCnt);

		//현재 블럭
		intCurBlock = Math.ceil(intCurPage / intPageCnt);

		//시작 페이지
		intStartPage = (intCurBlock - 1) * intPageCnt + 1;

		//이전페이지 가기
		if (intCurPage > 1)
		{
			strPagingLink += "		<a href=\"javascript:" + link_func_name + "(" + (parseInt(intCurPage) - 1) + ");\" class=\"pagination-controler first\"><span><img src=\"../images/common/img_pagination_arrow_left.png\" alt=\"이전\"></span>	</a>";
		}else
		{
			strPagingLink += "		<a href=\"javascript:alert('첫 페이지 입니다.');\" class=\"pagination-controler first\"><span><img src=\"../images/common/img_pagination_arrow_left.png\" alt=\"이전\"></span>	</a>";
		}

		strPagingLink += "<ul>";

		//블럭내 페이지 리스트
		for (var i = intStartPage ; (i < (intCurBlock * intPageCnt) + 1) && (i <= intTotalPage) ; i++)
		{
			if (intCurPage == i)
			{
				strPagingLink += "<li class=\"active\"><a href=\"javascript:void(0)\">" + i + "</a></li>";
			}else
			{
				strPagingLink += "<li><a href=\"javascript:" + link_func_name + "(" + i + ")\">" + i + "</a></li>";
			}
		}

		strPagingLink += "</ul>";

		//다음페이지 가기
		if (intCurPage < intTotalPage)
		{
			strPagingLink += "		<a href=\"javascript:" + link_func_name + "(" + (parseInt(intCurPage) + 1) + ");\" class=\"pagination-controler last\"><span><img src=\"../images/common/img_pagination_arrow_right.png\"  alt=\"다음\"></span>	</a>";
		}else
		{
			strPagingLink += "		<a href=\"javascript:alert('마지막 페이지 입니다.');\" class=\"pagination-controler last\"><span><img src=\"../images/common/img_pagination_arrow_right.png\"   alt=\"다음\"></span>	</a>";
		}
	}

	return strPagingLink;
}

//nl2br
function nl2br(str){

	 return str.replace(/\n/g, "<br />");

}

//문자열 자르기
function substr(str, maxlength, tail) {
	var rtnStr = "";
	if (str.length > maxlength)
	{
		rtnStr = str.substring(0, maxlength);

		if (tail != "")
		{
			rtnStr += tail;
		}
	}else
	{
		rtnStr = str;
	}

	return rtnStr;
}

function fileUploadPop(formname, fieldname, isThumb)
{
	var url = "../lib/file_upload.jsp?formname=" + formname + "&fieldname=" + fieldname + "&isThumb" + isThumb;
	window.open(url, "file_upload", "width=510px, height=200px");
}

function fileDownload(seq)
{


	var url = "/lib/filedownload.jsp?seq=" + seq;

	document.location.href = url;
}

//라인맵 세팅
function set_breadcrumbs(tm, sm, ssm)
{
	var gnb_info = $("#gnb");

	var linemap = $("#breadcrumbs").find("div > ul");

	var str = "";

	//depth1 setting
	if (tm != "")
	{
		str  = "<li>";
		str += "	<a href=\"#\" class=\"act\">" + gnb_info.find("#tm" + tm).children("a").children("img").attr("alt") + "<span class=\"arrow\"></span></a>";
		str += "	<ol>";

		$(gnb_info).children("li").each(function(){
			str += "	<li";
			if ($(this).attr("id") == "tm" + tm)
			{
				str += " class=\"current\"";
			}
			str += "><a href=\"" + $(this).children("a").attr("href") + "\">" + $(this).children("a").children("img").attr("alt") + "</a></li>";
		});
		str += "	</ol>";
		str += "</li>";

		$(linemap).append(str);
	}

	//depth2 setting
	if (sm != tm)
	{
		var depth2_ol = $(gnb_info.find("#tm" + tm + " > ul > li > ol"));

		str  = "<li>";
		str += "	<a href=\"#\" class=\"act\">" + gnb_info.find("#sm" + sm).children("a").html() + "<span class=\"arrow\"></span></a>";
		str += "	<ol class=\"sd\">";

		$(depth2_ol).children("li").each(function(){
			str += "	<li";
			if ($(this).attr("id") == "sm" + sm)
			{
				str += " class=\"current\"";
			}
			str += "><a href=\"" + $(this).children("a").attr("href") + "\">" + $(this).children("a").html() + "</a></li>";
		});

		str += "	</ol>";
		str += "</li>";

		$(linemap).append(str);
	}

	//depth3 setting

	if (ssm != sm)
	{
		var depth2_li = $(gnb_info).find("#sm" + sm);

		str  = "<li>";
		str += "	<a href=\"#\" class=\"act\">" + gnb_info.find("#ssm" + ssm).children("a").html() + "<span class=\"arrow\"></span></a>";
		str += "	<ol class=\"sd\">";

		$(depth2_li).children("ol").children("li").each(function(){
			str += "	<li";
			if ($(this).attr("id") == "ssm" + ssm)
			{
				str += " class=\"current\"";
			}
			str += "><a href=\"" + $(this).children("a").attr("href") + "\">" + $(this).children("a").html() + "</a></li>";
		});

		str += "	</ol>";
		str += "</li>";

		$(linemap).append(str);
	}

	$('#breadcrumbs').fixedMenu();
}

//네이버 지도 표시
function naver_map(x, y, map_id, branchInfo)
{
	var oBranchPoint = new nhn.api.map.LatLng(x, y);
	var defaultLevel = 11;
	var oMap = new nhn.api.map.Map(document.getElementById(map_id), {
					point : oBranchPoint,
					zoom : defaultLevel,
					enableWheelZoom : true,
					enableDragPan : true,
					enableDblClickZoom : false,
					mapMode : 0,
					activateTrafficMap : false,
					activateBicycleMap : false,
					minMaxLevel : [ 1, 14 ],
					size : new nhn.api.map.Size(468, 294)		});

	var oSlider = new nhn.api.map.ZoomControl();
	oMap.addControl(oSlider);
	oSlider.setPosition({
		top : 10,
		left : 10
	});
	/*
	var oMapTypeBtn = new nhn.api.map.MapTypeBtn();
	oMap.addControl(oMapTypeBtn);
	oMapTypeBtn.setPosition({
		bottom : 10,
		right : 80
	});

	var oThemeMapBtn = new nhn.api.map.ThemeMapBtn();
	oThemeMapBtn.setPosition({
		bottom : 10,
		right : 10
	});
	oMap.addControl(oThemeMapBtn);

	var oBicycleGuide = new nhn.api.map.BicycleGuide(); // - 자전거 범례 선언
	oBicycleGuide.setPosition({
		top : 10,
		right : 10
	}); // - 자전거 범례 위치 지정
	oMap.addControl(oBicycleGuide);// - 자전거 범례를 지도에 추가.

	var oTrafficGuide = new nhn.api.map.TrafficGuide(); // - 교통 범례 선언
	oTrafficGuide.setPosition({
		bottom : 30,
		left : 10
	});  // - 교통 범례 위치 지정.
	oMap.addControl(oTrafficGuide); // - 교통 범례를 지도에 추가.

	var trafficButton = new nhn.api.map.TrafficMapBtn(); // - 실시간 교통지도 버튼 선언
	trafficButton.setPosition({
		bottom:10,
		right:150
	}); // - 실시간 교통지도 버튼 위치 지정
	oMap.addControl(trafficButton);
	*/
	var oSize = new nhn.api.map.Size(28, 37);
	var oOffset = new nhn.api.map.Size(14, 37);
	var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);

	var branchMarker = new nhn.api.map.Marker(oIcon, { title : branchInfo });
	branchMarker.setPoint(oBranchPoint);
	oMap.addOverlay(branchMarker);

	/*
	var oInfoWnd = new nhn.api.map.InfoWindow();
	oInfoWnd.setVisible(false);
	oMap.addOverlay(oInfoWnd);

	oInfoWnd.setPosition({
		top : 20,
		left :20
	});

	var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
	oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.

	oInfoWnd.attach('changeVisible', function(oCustomEvent) {
		if (oCustomEvent.visible) {
			oLabel.setVisible(false);
		}
	});

	var oPolyline = new nhn.api.map.Polyline([], {
		strokeColor : '#f00', // - 선의 색깔
		strokeWidth : 5, // - 선의 두께
		strokeOpacity : 0.5 // - 선의 투명도
	}); // - polyline 선언, 첫번째 인자는 선이 그려질 점의 위치. 현재는 없음.
	oMap.addOverlay(oPolyline); // - 지도에 선을 추가함.

	oMap.attach('mouseenter', function(oCustomEvent) {

		var oTarget = oCustomEvent.target;
		// 마커위에 마우스 올라간거면
		if (oTarget instanceof nhn.api.map.Marker) {
			var oMarker = oTarget;
			oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
		}
	});

	oMap.attach('mouseleave', function(oCustomEvent) {

		var oTarget = oCustomEvent.target;
		// 마커위에서 마우스 나간거면
		if (oTarget instanceof nhn.api.map.Marker) {
			oLabel.setVisible(false);
		}
	});

	oMap.attach('click', function(oCustomEvent) {
		var oPoint = oCustomEvent.point;
		var oTarget = oCustomEvent.target;
		oInfoWnd.setVisible(false);
		// 마커 클릭하면
		if (oTarget instanceof nhn.api.map.Marker) {
			// 겹침 마커 클릭한거면
			if (oCustomEvent.clickCoveredMarker) {
				return;
			}
			// - InfoWindow 에 들어갈 내용은 setContent 로 자유롭게 넣을 수 있습니다. 외부 css를 이용할 수 있으며,
			// - 외부 css에 선언된 class를 이용하면 해당 class의 스타일을 바로 적용할 수 있습니다.
			// - 단, DIV 의 position style 은 absolute 가 되면 안되며,
			// - absolute 의 경우 autoPosition 이 동작하지 않습니다.
			oInfoWnd.setContent('<DIV style="border-top:1px solid; border-bottom:2px groove black; border-left:1px solid; border-right:2px groove black;margin-bottom:1px;color:black;background-color:white; width:auto; height:auto;">'+
				'<span style="color: #000000 !important;display: inline-block;font-size: 12px !important;font-weight: bold !important;letter-spacing: -1px !important;white-space: nowrap !important; padding: 2px 5px 2px 2px !important">' +
				'Hello World <br /> ' + oTarget.getPoint()
				+'<span></div>');
			oInfoWnd.setPoint(oTarget.getPoint());
			oInfoWnd.setPosition({right : 15, top : 30});
			oInfoWnd.setVisible(true);
			oInfoWnd.autoPosition();
			return;
		}
		var oMarker = new nhn.api.map.Marker(oIcon, { title : '마커 : ' + oPoint.toString() });
		oMarker.setPoint(oPoint);
		oMap.addOverlay(oMarker);

		var aPoints = oPolyline.getPoints(); // - 현재 폴리라인을 이루는 점을 가져와서 배열에 저장.
		aPoints.push(oPoint); // - 추가하고자 하는 점을 추가하여 배열로 저장함.
		oPolyline.setPoints(aPoints); // - 해당 폴리라인에 배열에 저장된 점을 추가함
	});
	*/
}

//팝업 띄우기
function goPopup(url, name, attr)
{
	window.open(url, name, attr);
}

function stripTag(str)
{
	var rtnStr = "";

	rtnStr = str.replace(/[\n\r\f]/g, ' ') ;
	rtnStr = rtnStr.replace(/<[^>]*?>/g, ' ');

	return rtnStr;
}


//페이스북 스크랩
function facebookShare(){

	var url = jQuery("meta[property='og:url']").attr("content");
	//var title = encodeURIComponent(jQuery("meta[property='og:title']").attr("content"));
	//var imageUrl = encodeURIComponent(location.href + jQuery("meta[property='og:image']").attr("content"));
	//var summary = encodeURIComponent(jQuery("meta[property='og:summary']").attr("content"));

	//var url = "http://www.facebook.com/sharer.php?s=100&p[url]=" + encodeURIComponent(location.href) + "&p[title]=" + title + "&p[summary]=" + summary + "&p[images][0]=" + imageUrl;

	if(url == null || url == '')
		url = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent(location.href);
	else
		url = "http://www.facebook.com/sharer.php?u=" + encodeURIComponent(url);

	//url = url.split("#").join("%23");
	//url = encodeURI(url);

	window.open(url);
};
//트위터 스크랩
function twitterShare(){
	window.open('http://twitter.com/share?nocache=' + Math.floor(Math.random()*10) + '&text=' + encodeURIComponent( jQuery('meta[property="og:title"]').attr('content')) +'&url=' + encodeURIComponent(location.href));
}

function blogShare()
{
	var url			= location.href;
	var domain		= jQuery("meta[property='og:domain']").attr("content");
	var title		= jQuery("meta[property='og:title']").attr("content");
	var thumbnail	= jQuery("meta[property='og:image']").attr("content");
	var summary		= jQuery("meta[property='og:summary']").attr("content");
	var description = jQuery("meta[property='og:description']").attr("content");
	var ctrlcv =	"<a href=\"" + url + "\">";
	ctrlcv += 			"<img src=\"" + thumbnail + "\" alt=\"" + description + "\">";
	ctrlcv += 		"</a>";
	prompt("Ctrl+C를 하여 복사하신 뒤, 자주 가시는 까페, 블로그 등 이벤트를 소문내고 싶은 곳에  Ctrl+V 하여 붙여넣어주세요.", ctrlcv);
}

/*
	함수 설명 : 이미지파일 확장자인지 체크하는 함수
	입력값 : 입력 필드
	리턴값 : 이미지파일이 아닌 경우 true,  이미지 파일은 false
*/

function chkImgFormat(oField) {
	var pattern;
	pattern = /\.(gif|jpe?g|png)$/i;		//gif, jpg, jpeg 이미지 파일만 등록
										// 이미지 추가 (gif|jpe?g|bmp|png)
	if(!pattern.test(oField)) {
		alert("이미지 파일 gif, jpg/jpeg, png만 업로드 가능합니다.");
		//oField.value = "";
		//oField.focus();
		return true;
	}
	return false; //이미지 파일인 경우
}

function checkPasswd(passwd)
{
	var c_n = 0;
	var c_es = 0;
	var c_eb = 0;
	var c_s = 0;

	var chk_num = passwd.search(/[0-9]/g);
	if (chk_num > -1)
	{
		c_n = 1;
	}
	var chk_eng_s = passwd.search(/[a-z]/ig);
	if (chk_eng_s > -1)
	{
		c_es = 1;
	}
	var chk_eng_b = passwd.search(/[A-Z]/ig);
	if (chk_eng_b > -1)
	{
		c_eb = 1;
	}

	//var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi;
	var stringRegx = /[~!@\#$%^&*_?~]/gi;

   	if(stringRegx.test(passwd))
	{
		c_s = 1;
 	}

	if (c_n + c_es + c_eb + c_s > 3)
	{
		return true;
	}else
	{
		return false;
	}
}

/*
함수 설명 : 영문과 숫자, 특수문자 (-,.)만 있는 String인지 비교 하는 함수
입력값 : 입력 필드
리턴값 : 조건에 맞는 형태일 경우 false,  아닐경우 true
*/
function chkEngNumMail(oField) {
	var valid = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._"
	var bFlag = false;
	var temp;

	for (var i=0; i<oField.value.length; i++) {
		temp = "" + oField.value.substring(i, i+1);
		if (valid.indexOf(temp) == "-1") bFlag = true;
	}
	if (bFlag) {
		alert("해당 항목은 반드시 영문 또는 숫자만 입력 가능 합니다.");
		oField.value = "";
		oField.focus();
		return false;
	}
	return true;
}
