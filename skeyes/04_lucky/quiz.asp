<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_54_247"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/quiz.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->

	<script type="text/javascript">

		$(document).ready(function(e){
			$(".initial").click(function(){
				$(this).hide();
			});
		});
		function quiz_check()
		{
			//사번 이름 입력 체크
			var sa_num = $("#sa_num").val();
			var user_name = $("#user_name").val();

			var ans1_1 = $("#ans1_1").val();
			var ans1_2 = $("#ans1_2").val();

			var ans2_1 = $("#ans2_1").val();
			var ans2_2 = $("#ans2_2").val();
			var ans2_3 = $("#ans2_3").val();
			var ans2_4 = $("#ans2_4").val();

			var ans3_1 = $("#ans3_1").val();
			var ans3_2 = $("#ans3_2").val();

			var ans4_1 = $("#ans4_1").val();
			var ans4_2 = $("#ans4_2").val();

			var ans5_1 = $("#ans5_1").val();
			var ans5_2 = $("#ans5_2").val();
			var ans5_3 = $("#ans5_3").val();
			var ans5_4 = $("#ans5_4").val();

			if (sa_num == "")
			{
				alert("사번을 입력하세요.");
				$("#sa_num").focus();
				return;
			}

			if (user_name == "")
			{
				alert("이름을 입력하세요.");
				$("#user_name").focus();
				return;
			}

			if (ans1_1 == "")
			{
				alert("답을 입력하세요.");
				$("#ans1_1").focus();
				return;
			}

			if (ans1_2 == "")
			{
				alert("답을 입력하세요.");
				$("#ans1_2").focus();
				return;
			}

			if (ans2_1 == "")
			{
				alert("답을 입력하세요.");
				$("#ans2_1").focus();
				return;
			}

			if (ans2_2 == "")
			{
				alert("답을 입력하세요.");
				$("#ans2_2").focus();
				return;
			}

			if (ans2_3 == "")
			{
				alert("답을 입력하세요.");
				$("#ans2_3").focus();
				return;
			}

			if (ans2_4 == "")
			{
				alert("답을 입력하세요.");
				$("#ans2_4").focus();
				return;
			}

			if (ans3_1 == "")
			{
				alert("답을 입력하세요.");
				$("#ans3_1").focus();
				return;
			}

			if (ans3_2 == "")
			{
				alert("답을 입력하세요.");
				$("#ans3_2").focus();
				return;
			}

			if (ans4_1 == "")
			{
				alert("답을 입력하세요.");
				$("#ans4_1").focus();
				return;
			}

            if (ans4_2 == "")
			{
				alert("답을 입력하세요.");
				$("#ans4_2").focus();
				return;
			}

			if (ans5_1 == "")
			{
				alert("답을 입력하세요.");
				$("#ans5_1").focus();
				return;
			}

			if (ans5_2 == "")
			{
				alert("답을 입력하세요.");
				$("#ans5_2").focus();
				return;
			}

			if (ans5_3 == "")
			{
				alert("답을 입력하세요.");
				$("#ans5_3").focus();
				return;
			}

			if (ans5_4 == "")
			{
				alert("답을 입력하세요.");
				$("#ans5_4").focus();
				return;
			}

			var ans1 = ans1_1 + "" + ans1_2;
			var ans2 = ans2_1 + "" + ans2_2 + "" + ans2_3 + "" + ans2_4;
			var ans3 = ans3_1 + "" + ans3_2;
			var ans4 = ans4_1 + "" + ans4_2;
			var ans5 = ans5_1 + "" + ans5_2 + "" + ans5_3 + "" + ans5_4;

			if (sa_num == "" || user_name == "")
			{
				alert("정상적인 접근이 아닙니다.");
			}else
			{
				$.ajax({
					url: '../xmlData/quiz_insert.asp',
					type: 'POST',
					dataType: 'xml',
					data: {
						sa_num: $("#sa_num").val(),
						user_name : $("#user_name").val(),
						"ans1":ans1,
						"ans2":ans2,
						"ans3":ans3,
						"ans4":ans4,
						"ans5":ans5
					},
					timeout: 1000 * 5,
					error: function()					{
						alert("오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
					},
					success: function(xmlData, status)	{
						var status = $(xmlData).find("state").text();
						var msg = $(xmlData).find("msg").text();

						if(status == "1")	{
							alert("이벤트에 등록되었습니다.");
							document.quiz_frm.reset();
						}else				{
							alert(msg);
						}
					}
				});
			}
		}
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
			<!-- s:headline -->
			<div id="headline">
				<div class="headline-container">
					<img src="../img/quiz/headline_tit.png" data-src-base='../img/quiz/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png' />
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
					<div class="row">
						<div class="col-md-12 ta-c mt95 mb100 pb20">
							<p><img src="../img/quiz/tit01.jpg" alt=""></p>
							<p class="mt40"><img src="../img/quiz/img01.jpg" data-src-base='../img/quiz/' data-src='<480:img01_mo.jpg, <768:img01_mo.jpg, <991:img01_mo.jpg, >991:img01.jpg' /></p>
							<p class="deco01 hidden-sm hidden-xs"><img src="../img/quiz/deco01.png" alt=""></p>
						</div>
					</div>

					<div class="row">
						<div class="col-md-12 ta-c">
							<p><img src="../img/quiz/tit02.jpg" alt=""></p>
							<p class="mt25">정답을 맞춘 분들 중 추첨을 통해 다양한 기프티콘을 선물로 드립니다.</p>
						</div>
					</div>

					<div class="row mb100 pb50">
						<div class="col-md-4 ta-c mt35">
							<p><img src="../img/quiz/img02.jpg" alt=""></p>
						</div>
						<div class="col-md-4 ta-c mt35">
							<p><img src="../img/quiz/img03.jpg" alt=""></p>
						</div>
						<div class="col-md-4 ta-c mt35">
							<p><img src="../img/quiz/img04.jpg" alt=""></p>
						</div>
						<p class="deco02 hidden-sm hidden-xs"><img src="../img/quiz/deco02.png" alt=""></p>
					</div>
				</div>
			</div>

			<div class="bg-01">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c mb15">
							<img src="../img/quiz/tit03.jpg" alt="">
						</div>
						<p class="deco03"><img src="../img/quiz/deco03.png" alt=""></p>
					</div>
					<form name="quiz_frm">
					<div class="row personal">
						<div class="col-md-offset-2 col-md-1 col-sm-2 col-xs-3 mt35">
							<p>사번</p>
						</div>
						<div class="col-md-3 col-sm-10 col-xs-9 mt35">
							<input type="text" name="sa_num" id="sa_num" class="user-info" value="">
						</div>
						<div class="col-md-1 col-sm-2 col-xs-3 mt35">
							<p>이름</p>
						</div>
						<div class="col-md-3 col-sm-10 col-xs-9 mt35">
							<input type="text" name="user_name" id="user_name" class="user-info" value="">
						</div>
					</div>
					<div class="row question mt45">
						<div class="col-md-12">
							<p class="q q01">SUPEX 포상을 비롯해 우리회사를 위해 다양한 성과를 이룩하며 타 구성원의 롤모델로 손꼽히는 SK건설의 영웅들을 만나보는 코너! 스카이즈의 간판 코너이기도 한 이 코너의 이름은 무엇일까요? <br>
							<span><img src="../img/quiz/q01_4.jpg" alt=""></span>
							<span class="init">
								<img src="../img/quiz/q01_1.jpg" alt="" class="initial"><input type="text" name="ans1_1" id="ans2_1" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q01_2.jpg" alt="" class="initial"><input type="text" name="ans1_2" id="ans1_2" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q01_3.jpg" alt="" class="initial"><input type="text" name="ans1_3" id="ans1_3" value="" maxlength="1">
							</span>
							<a href="#" target="_blank" class="hint"><img src="../img/quiz/hint.jpg" alt=""></a>
							</p>

							<p class="q q02">이달 일혁신 인사이트에는 지난 12월 진행된 품질 개선 사례 전시 및 발표회에서 우수 사례 수상자를 모시고 다양한 이야기를 나눠보았는데요, 여기서 문제! 품질 실패로 초래되는 비용을 뜻하는 이 용어는 무엇일까요? <br>
							<span class="init">
								<img src="../img/quiz/q02_1.jpg" alt="" class="initial"><input type="text" name="ans2_1" id="ans2_1" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q02_2.jpg" alt="" class="initial"><input type="text" name="ans2_2" id="ans2_2" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q02_3.jpg" alt="" class="initial"><input type="text" name="ans2_3" id="ans2_3" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q02_4.jpg" alt="" class="initial"><input type="text" name="ans2_4" id="ans2_4" value="" maxlength="1">
							</span>
							<a href="#" target="_blank" class="hint"><img src="../img/quiz/hint.jpg" alt=""></a></p>

							<p class="q q03">2018년은 육십간지 35번째에 해당하는 무술년입니다. 십이간지 '무(戊)’에 해당되는 이 색으로 인해 올해는 ㅇㅇ개의 해라고 불리는데요, 부를 상징하는 이 색의 이름은 무엇일까요? <br>
							<span class="init">
								<img src="../img/quiz/q03_1.jpg" alt="" class="initial"><input type="text" name="ans3_1" id="ans3_1" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q03_2.jpg" alt="" class="initial"><input type="text" name="ans3_2" id="ans3_2" value="" maxlength="1">
							</span>
							<a href="#" target="_blank" class="hint"><img src="../img/quiz/hint.jpg" alt=""></a></p>

							<p class="q q04">이달 ACM에 출연한 이 현장은 매일 오전 8시 전 구성원 참여 하에 30분씩 다양한 ACM을 전개하고 있는데요, 듣기만 해도 열정이 넘치는 이 현장의 이름은 무엇일까요? <br>
							<span class="init">
								<img src="../img/quiz/q04_1.jpg" alt="" class="initial"><input type="text" name="ans4_1" id="ans4_1" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q04_2.jpg" alt="" class="initial"><input type="text" name="ans4_2" id="ans4_2" value="" maxlength="1">
							</span>
							<span><img src="../img/quiz/q04_3.jpg" alt=""></span>
							<a href="#" target="_blank" class="hint"><img src="../img/quiz/hint.jpg" alt=""></a></p>

							<p class="q q05">화공Commissioning팀 허준섭 부장의 취미생활로 다수의 참여를 통해 팀워크와 커뮤니케이션을 향상시키고 스트레스도 해소해주는 이 운동의 이름은 무엇일까요? <br>
							<span class="init">
								<img src="../img/quiz/q05_1.jpg" alt="" class="initial"><input type="text" name="ans5_1" id="ans5_1" value="" maxlength="1">
							</span>
							<span class="init">
								<img src="../img/quiz/q05_2.jpg" alt="" class="initial"><input type="text" name="ans5_2" id="ans5_2" value="" maxlength="1">
							</span>
							<a href="#" target="_blank" class="hint"><img src="../img/quiz/hint.jpg" alt=""></a></p>
						</div>
					</div>
					<div class="row mt80 mb80">
						<div class="col-md-12 ta-c">
							<a href="javascript:void(0);" onclick="quiz_check();"><img src="../img/quiz/btn_subs.png" alt=""></a>
						</div>
					</div>
					</form>
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
	var currentMenu = 12;
</script>

</body>
</html>
