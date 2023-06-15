<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_51_211"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!-- #include virtual="/cls/common.asp" -->
<!-- #include virtual="/cls/DBHelper.asp" -->
<!-- #include virtual="/cls/NewsCls.asp" -->
<%
	'변수 선언
	Dim strPage, strPageSize
	Dim DBHelper, dicParam, clsNews, newsListInfo, newsList, intNewsTotalCnt, intListCnt
	Dim total_cnt, total_page
	Dim board_no, image_5, title, contents_1

	'전달값 받기
  strPage = setDefaultStr(Request("page"), "1")
  strPageSize = 6

	'DB 접속
	Set DBHelper = new DBHelperCls
	Set clsNews = new NewsCls

  '파라메터 객체
	Set dicParam = CreateObject("Scripting.Dictionary")

	dicParam.add "page_list_cnt", 6
	dicParam.add "page", strPage

	'확인
	newsListInfo = clsNews.getTotalCnt(DBHelper, dicParam)
	newsList		= clsNews.getList(DBHelper, dicParam)

	total_page	= newsListInfo(0, 0)
	total_cnt	= newsListInfo(1, 0)

	If IsArray(newsList) Then
		intListCnt = UBound(newsList, 2) + 1
	Else
		intListCnt = 0
	End If

	'DB 연결 닫기
	DBHelper.Dispose()
	set DBHelper = Nothing
%>
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/news.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->
</head>

<body>
	<!-- s:wrap -->
	<div id="wrap">
		<!-- s:header -->
			<!--#include file="../inc/header.asp" -->
		<!-- //e:header -->
		<!-- s:gnb_list -->
			<!--#include file="../inc/gnb_list.asp" -->
		<!-- //e:gnb_list -->
		<!-- s:article-wrap -->
		<div class="article-wrap" >
			<!-- s:article-navi -->
			<div class="article-navi">
				<div class="prev-article"><a href="#" title="이전 기사 보기"></a></div>
				<div class="next-article"><a href="#" title="다음 기사 보기"></a></div>
			</div>
			<!-- //e:article-navi -->
			<div class="cl-b"></div>
			<!-- s:contents -->
			<div class="container mt-7 mb-3 news-cont-pd">
				<div class="top-newspaper"></div>
				<div class="newspaper">
					<div class="padding-lr">
						<div class="row">
							<div class="col-md-3 hidden-767">
								<p><img src="../img/news/news_logo.jpg" alt="" /></p>
							</div>
							<div class="col-md-6 center">
								<p><img src="../img/news/sknews.jpg" alt="" /></p>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12 center">
								<div class="month">
									<p><strong>skeyes.skec.co.kr <span>2018년 1월호</span></strong></p>
								</div>
							</div>
						</div>
						
						
						<div class="row pt-2 pb-2">
							<div class="col-md-6 center">
								<p><img src="../img/news/news_img04.jpg" alt="" /></p>
							</div>
							<div class="col-md-6">
								<p>12월 12일</p>
								<hr class="hr01"/>
								<p><img src="../img/news/news_tit04.jpg" alt="" /></p>
								<p>SK건설과 SK D&D는 서울시 성동구 성수동2가에서 ‘성수 SK V1 센터(성수 SK V1 center)’를 분양한다. 신흥 지식산업센터 메카로 주목받는 성수동 일대에 들어서는 성수 SK V1 센터는 총 2개동으로 연면적 5만5586m²에 지하5층~지상17층의 제1동과 연면적 1만5918m²에 지하5층~지상12층의 제2동으로 구성된다. 성수 SK V1 센터가 들어서는 성수동은 서울숲, 최고급 주상복합, 산업단지, 카페거리 등이 새롭게 들어서면서 뛰어난 인프라를 갖춘 입지로 높게 평가받고 있다.</p> 
							</div>
						</div>
						
						<div class="row pt-2 pb-2">
							<div class="col-md-6 center">
								<p><img src="../img/news/news_img03.jpg" alt="" /></p>
							</div>
							<div class="col-md-6">
								<p>12월 6일</p>
								<hr class="hr01"/>
								<p><img src="../img/news/news_tit03.jpg" alt="" /></p>
								<p>SK건설과 밀알복지재단은 6일 서울 종로구 수송동 ‘지 플랜트’(G.plant) 사옥에서 희망메이커 후원가정에 보내줄 방한키트를 제작하는 봉사활동을 벌였다. 이날 행사에는 조기행 SK건설 부회장과 임직원 70여명, 걸그룹 베이비부가 참여했다. 참가자들은 전기담요, 문풍지, 보온주머니 등 10개 방한물품과 희망메이커 후원아동에게 쓴 크리스마스 카드를 키트 상자에 담았다. SK건설∙밀알복지재단은 6000만원 상당의 희망키트 600상자를 제작했고, 후원가정에 전달할 예정이다.</p> 
							</div>
						</div>
						
						
						<div class="row pt-2 pb-2">
							<div class="col-md-6 center">
								<p><img src="../img/news/news_img02.jpg" alt="" /></p>
							</div>
							<div class="col-md-6">
								<p>12월 1일</p>
								<hr class="hr01"/>
								<p><img src="../img/news/news_tit02.jpg" alt="" /></p>
								<p>SK건설이 총 사업비 14억4천만달러(약 1조6000억원)짜리 545MW 규모의 수력 민자발전 사업권을 따내며 파키스탄에 첫 진출한다. SK건설은 파키스탄 이슬라마바드에서 ATL사(社)와 파키스탄 칸디아강 유역에 건설될 수력 민자발전사업권 확보를 위해 칸디아 하이드로파워사(社)의 주식 89%를 인수하는 주식양수도계약을 체결했다.  </p> 

<p>이번 프로젝트는 파키스탄 수도 이슬라마바드에서 북쪽으로 340km 떨어진 카이베르파크툰크주(州)에 위치한 칸디아강 유역에 발전설비용량 545 MW 규모의 초대형 수력발전소를 건설해 30년간 운영하고 정부에 이관하는 BOT(건설∙운영∙양도)방식의 개발형사업이다. SK건설은 발전소 공사를 도맡아 수행할 뿐만 아니라 완공 후에도 운영에 참여하게 된다.</p>
							</div>
						</div>
						
						<div class="row pt-2 pb-2">
							<div class="col-md-6 center">
								<p><img src="../img/news/news_img01.jpg" alt="" /></p>
							</div>
							<div class="col-md-6">
								<p>11월 30일</p>
								<hr class="hr01"/>
								<p><img src="../img/news/news_tit01.jpg" alt="" /></p>
								<p>SK건설이 시공한 터키 이스탄불의 유라시아 해저터널이 국내에서도 건설분야 최고의 프로젝트로 인정받았다. SK건설은 30일 유라시아 해저터널이 한국공학한림원이 뽑은 2017년 건설환경공학 분야의 최고의 프로젝트로 선정됐다. 유라시아 해저터널의 이번 수상은 최첨단 건설 기술뿐만 아니라 경제•사회•환경 측면의 다양한 가치를 창출한 점을 높게 평가 받았다.  

 </p>
							</div>
						</div>
						
						
						
					</div>
				</div>
				<div class="bottom-newspaper"></div>
			</div>
			<div class="bg-headline news-list">
	<div class="container padding-lr of-hi">
		<div class="row mt-3 pb-3">
<%
For i = 0 To intListCnt - 1

'board_no, board_kind, temp_no, year, month, title, contents_1, contents_2, contents_3, image_1, image_2, image_3, image_4, image_5, counter, on_off, html_yn, reg_dm

board_no    = newsList(0, i)
image_5     = newsList(13, i)
title       = newsList(5, i)
contents_1  = newsList(6, i)
reg_dm		= newsList(17, i)
%>
			<div class="col-xs-12 col-sm-6 col-md-4 mb-3">
				<a href="./news_view.asp?page=<%= strPage %>&board_no=<%= board_no %>">
<%
If image_5 = "" Then
%>
					<img src="../img/news/news_noimg.jpg" class="news-img">
<%
Else
%>
					<img src="/webupload/<%=image_5 %>" class="news-img">
<%
End If
%>
					<div class="news-txt">
						<h2><%= ReplaceLength(title, 20) %></h2>
						<p><%= ReplaceLength(contents_1, 50) %></p>
						<!--<p class="date"><%= ReplaceLength(reg_dm, 10) %></p>-->
						<p class="ta-r"><img src="../img/news/news_btn_more.jpg" class="news-btn"></p>
					</div>
				</a>
			</div>
<%
Next
%>
		</div>
	</div>
	<div class="container">
		<div id="pagination" class="pagination">
			<%= Paging( CInt(total_page), CInt(strPage), 10, "./news.asp?page=" ) %>
			<!--
			<a href="#" onclick="alert('첫 페이지 입니다.');return false;" class="direction"><img src="../img/common/paging_prev.png" alt="이전"></a>
			<strong>1</strong>
			<a href="./news.asp?page=2">2</a>
			<a href="./news.asp?page=3">3</a>
			<a href="./news.asp?page=4">4</a>
			<a href="./news.asp?page=5">5</a>
			<a href="./news.asp?page=6">6</a>
			<a href="./news.asp?page=7">7</a>
			<a href="./news.asp?page=8">8</a>
			<a href="./news.asp?page=9">9</a>
			<a href="./news.asp?page=10">10</a>
			<a href="./news.asp?page=2" class="direction"><img src="../img/common/paging_next.png" alt="다음"></a>
			-->
		</div>
	</div>
	<div class="container" style="padding-bottom: 50px;">
		<a href="#" class="btn-top"><img src="../img/common/btn_top.png"></a>
	</div>
</div>
			<!-- //e:contents -->
		</div>
		<!-- //e:article-wrap -->
		<!-- s:footer -->
			<!--#include file="../inc/footer.asp" -->
		<!-- //e:footer -->
	</div>
	<!-- //e:wrap -->

<script type="text/javascript">
	var currentMenu = 2;
</script>

</body>
</html>
