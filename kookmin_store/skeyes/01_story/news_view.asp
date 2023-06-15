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
	Dim strPage, strBoardNo
	Dim DBHelper, dicParam, clsNews, newsInfo, newsPrevInfo, newsNextInfo
	Dim total_cnt, total_page
	Dim board_no, strHtmlYn, strTitle, strContents, strImage1, strImage2, strImage3, strImage4, strCount, strDate
  Dim strPrevBoardNo, strNextBoardNo

	'전달값 받기
  strPage     = setDefaultStr(Request("page"), "1")
  strBoardNo  = setDefaultStr(Request("board_no"), "")

  If strBoardNo = "" Then
    Call showMsgGoUrl("필요값이 없습니다.", "./news.asp")
  End If

	'DB 접속
	Set DBHelper = new DBHelperCls
	Set clsNews = new NewsCls

  '파라메터 객체
	Set dicParam = CreateObject("Scripting.Dictionary")

	dicParam.add "board_no", strBoardNo


	'확인
  intRtn = clsNews.upViewCnt(DBHelper, dicParam )

	newsInfo      = clsNews.getInfo(DBHelper, dicParam)
	newsPrevInfo  = clsNews.getPrevInfo(DBHelper, dicParam)
  newsNextInfo  = clsNews.getNextInfo(DBHelper, dicParam)

	'DB 연결 닫기
	DBHelper.Dispose()
	set DBHelper = Nothing

  If Not IsArray(newsInfo) Then
    Call showMsgGoUrl("정보가 없습니다.", "./news.asp")
  End If
'board_no, html_yn, title, contents_1, image_1, image_2, image_3, image_4, counter, reg_dm
  strHtmlYn   = newsInfo(1, 0)
  strTitle    = newsInfo(2, 0)
  strContents = newsInfo(3, 0)
  strImage1   = newsInfo(4, 0)
  strImage2   = newsInfo(5, 0)
  strImage3   = newsInfo(6, 0)
  strImage4   = newsInfo(7, 0)
  strCount    = newsInfo(8, 0)
  strDate     = newsInfo(9, 0)

  If Not IsArray(newsPrevInfo) Then
    strPrevBoardNo = ""
  Else
    strPrevBoardNo = newsPrevInfo(0, 0)
  End If

  If Not IsArray(newsNextInfo) Then
    strNextBoardNo = ""
  Else
    strNextBoardNo = newsNextInfo(0, 0)
  End If
%>
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/news.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
<!--
  $(document).ready(function(){
    $("#btn_list").bind("click", function(e){
      e.preventDefault();
      document.location.href = "./news.asp?page=<%= strPage %>";
    });

    $("#btn_prev").bind("click", function(e){
      e.preventDefault();
      var next_board_id = "<%= strNextBoardNo %>";

      if (next_board_id != "")
      {
        document.location.href = "./news_view.asp?page=<%= strPage %>&board_no=" + next_board_id;
      }else
      {
        alert("마직막 자료 입니다.");
      }
    });

	$(".prev-article").bind("click", function(e){
      e.preventDefault();
      var next_board_id = "<%= strNextBoardNo %>";

      if (next_board_id != "")
      {
        document.location.href = "./news_view.asp?page=<%= strPage %>&board_no=" + next_board_id;
      }else
      {
        alert("마직막 자료 입니다.");
      }
    });

    $("#btn_next").bind("click", function(e){
      e.preventDefault();
      var prev_board_id = "<%= strPrevBoardNo %>";

      if (prev_board_id != "")
      {
        document.location.href = "./news_view.asp?page=<%= strPage %>&board_no=" + prev_board_id;
      }else
      {
        alert("첫번째 뉴스 입니다.");
      }
    });

	$(".next-article").bind("click", function(e){
      e.preventDefault();
      var prev_board_id = "<%= strPrevBoardNo %>";

      if (prev_board_id != "")
      {
        document.location.href = "./news_view.asp?page=<%= strPage %>&board_no=" + prev_board_id;
      }else
      {
        alert("첫번째 뉴스 입니다.");
      }
    });

  });
//-->
</script>
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
			<div class="newspaper pt-2">
				<div class="padding-lr">
					<div class="row">
						<div class="col-md-12 center">
							<div class="month">
								<p><span class="view-logo"><img src="../img/news/view_sknews.jpg" alt="" /></span><strong><span class="view-url">skeyes.skec.co.kr</span> <span><%=Replace(strDate,"-", ". ")%></span></strong></p>
							</div>
						</div>
					</div>
					<div class="row pt-2 pb-2">
<%
  If strImage1 <> "" Then
%>
						<div class="col-sm-6 fl-r pb-1">
							<p><img src="/webupload/<%= strImage1 %>" class="img-box"></p>
						</div>
<%
  End If
%>
						<div class="col-sm-12">
							<div class="news-view-tit"><%= strTitle %></div>
<%
	If strHtmlYn = "0" Then
		Response.Write ConvertBrTag(strContents)
	Else
		Response.Write strContents
	End If
%>
							</p>
						</div>
					</div>
					<div class="line"></div>
					<div class="row pb-2 ta-r">
						<div class="news-view-btn">
							<a href="#" id="btn_prev">이전뉴스보기</a>
							<a href="#" id="btn_next">다음뉴스보기</a>
							<a href="#" id="btn_list">목록보기</a>
						</div>
					</div>
				</div>
			</div>
			<div class="bottom-newspaper"></div>
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
