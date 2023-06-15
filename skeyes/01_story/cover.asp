<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_51_209"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/cover.css">
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
		<div class="article-wrap cover" >
			<!-- s:headline -->
			<div id="headline">
				<div class="headline-container">
					<img src="../img/cover/headline_tit.png" data-src-base='../img/cover/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png'/>
				</div>
			</div>
			<!-- //e:headline -->
			<!-- s:article-navi -->
			<div class="article-navi">
				<div class="prev-article"><a href="#" title="이전 기사 보기"></a></div>
				<div class="next-article"><a href="#" title="다음 기사 보기"></a></div>
			</div>
			<!-- //e:article-navi -->
			<div class="cl-b"></div>
			<!-- s:contents -->

			<div class="bg-01">
				<div class="container">
					<div class="col-md-12 ta-c mb90">
						<img src="../img/cover/img01.png" alt="">
					</div>
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
	var currentMenu = 0;
</script>

</body>
</html>
