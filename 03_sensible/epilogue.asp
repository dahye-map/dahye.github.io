<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_53_241"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/epilogue.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->

	<script type="text/javascript">
		function survey_check()
		{
			//사번 이름 입력 체크
			var sa_num = $("#s_sa_num").val();
			var user_name = $("#s_user_name").val();

			var ans1 = $(':radio[name="ans1"]:checked').val();
			var ans2 = $(':radio[name="ans2"]:checked').val();

			if (user_name == "")
			{
				alert("이름을 입력하세요.");
				$("#s_user_name").focus();
				return;
			}

			if (sa_num == "")
			{
				alert("사번을 입력하세요.");
				$("#s_sa_num").focus();
				return;
			}

			if (ans1 == undefined)
			{
				alert("답을 선택해주세요.");
				$("#ans1_1").focus();
				return;
			}

			if (ans2 == undefined)
			{
				alert("답을 선택해주세요.");
				$("#ans2_1").focus();
				return;
			}

			if (sa_num == "" || user_name == "")
			{
				alert("정상적인 접근이 아닙니다.");
			}else
			{
				$.ajax({
					url: '../xmlData/survey_insert.asp',
					type: 'POST',
					dataType: 'xml',
					data: {
						"sa_num": sa_num,
						"user_name" : user_name,
						"ans1":ans1,
						"ans2":ans2
					},
					timeout: 1000 * 5,
					error: function()					{
						alert("오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
					},
					success: function(xmlData, status)	{
						var status = $(xmlData).find("state").text();
						var msg = $(xmlData).find("msg").text();

						if(status == "1")	{
							alert("설문 이벤트에 참여 되셨습니다.");
							document.survey_frm.reset();
						}else				{
							alert(msg);
						}
					}
				});
			}
		}

		function post_check()
		{
			//사번 이름 입력 체크
			var sa_num = $("#p_sa_num").val();
			var user_name = $("#p_user_name").val();

			var contents = $('#contents').val();

			if (user_name == "")
			{
				alert("이름을 입력하세요.");
				$("#p_user_name").focus();
				return;
			}


			if (sa_num == "")
			{
				alert("사번을 입력하세요.");
				$("#p_sa_num").focus();
				return;
			}

			if (contents == "")
			{
				alert("의견을 입력해 주세요.");
				$("#contents").focus();
				return;
			}

			if (sa_num == "" || user_name == "")
			{
				alert("정상적인 접근이 아닙니다.");
			}else
			{
				$.ajax({
					url: '../xmlData/post_insert.asp',
					type: 'POST',
					dataType: 'xml',
					data: {
						"sa_num": sa_num,
						"user_name" : user_name,
						"content":contents
					},
					timeout: 1000 * 5,
					error: function()					{
						alert("오류가 발생했습니다. 잠시 후 다시 시도해 주세요.");
					},
					success: function(xmlData, status)	{
						var status = $(xmlData).find("state").text();
						var msg = $(xmlData).find("msg").text();

						if(status == "1")	{
							alert("좋은 의견 감사합니다.");
							document.post_frm.reset();
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
		<div class="article-wrap epilogue" >
			<!-- s:headline -->
			<div id="headline">
				<div class="headline-container">
					<img src="../img/epilogue/headline_tit.png" data-src-base='../img/epilogue/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png'/>
				</div>
			</div>
			<!-- //e:headline -->
			<!-- s:lead -->
			<div id="lead">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<p>
								2018년입니다. 어느덧 스카이즈도 우리 구성원의 소식을 전달한 지 14년 차를 맞이하게 되었는데요, 그간 스카이즈는 우리회사의 비전과 문화를 공유하는 SK Core Value 콘텐츠부터 사내 주요 소식 및 팀/현장/구성원들의 다양한 이야기를 전달해왔습니다. 올해는 황금개의 해 무술년을 맞이해 황금처럼 모든 사람들에게 특별한 가치를 선사하며 강아지처럼 누구든 미소 짓고 관심 가질 수 있는 소식들을 보내드릴 텐데요,
								<br>2018년 한 해도 저희 스카이즈에 많은 관심과 응원 부탁 드리며 2018년 첫 편집후기 지금 시작합니다!
							</p>
						</div>
					</div>
				</div>
			</div>
			<!-- //e:lead -->
			<!-- s:article-navi -->
			<div class="article-navi">
				<div class="prev-article"><a href="#" title="이전 기사 보기"></a></div>
				<div class="next-article"><a href="#" title="다음 기사 보기"></a></div>
			</div>
			<!-- //e:article-navi -->
			<div class="cl-b"></div>
			<!-- s:contents -->
			<div class="bg-01 pt70 pb70">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<img src="../img/epilogue/tit01.jpg" alt="당신이 궁금한 이야기 이달의 취재비화">
							<p class="ta-l mt40">
								올 겨울은 따뜻할 거라는 기상청 예보를 가볍게 무시하며 사납게 몰아치는 겨울한파 속에 취재팀은 완전무장 상태로 ACM을 취재하기 위해 부산 현장으로 내려갑니다. 부산역에 도착~ 어라?? 뭔가 이상헌디!!! 그렇습니다. 부산은 서울보다 무려 12도나 기온이 높았던 것입니다. 부산 쌀람덜~ 가벼운 코트 차림으로 샤랄라라~ 취재팀이 입었던 우중충한 패딩잠바가 부끄~부끄~했던 하루였습니다. 그러나 서울역 다시 도착! 몰아치는 겨울 바람에 역시 겨울엔 패딩이 최고라며 서로를 격려했던 아름다운 추억을 고백합니다. 우리나라가 좁다구요? 봄과 겨울이 공존하는 넓디 넓은 땅이랍니다.
							</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4 mt55 ta-c">
							<img src="../img/epilogue/img01.jpg" alt="">
						</div>
						<div class="col-md-4 mt55 ta-c">
							<img src="../img/epilogue/img02.jpg" alt="">
						</div>
						<div class="col-md-4 mt55 ta-c">
							<img src="../img/epilogue/img03.jpg" alt="">
						</div>
					</div>
				</div>
			</div>
			<div class="bg-02 pt70 pb70">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<img src="../img/epilogue/tit02.jpg" alt="우리 구성원의 고민, 당신의 조언은? 스카이즈 상담소">
						</div>
					</div>
					<div class="row">
						<div class="col-md-7 mt55 fl-r">
							<p class="sub-tit">K현장 L 과장의 고민</p>
							<p class="mt10"><strong>“어떻게 해야 가족들과 더 자주 함께할 수 있을까요?”</strong></p>
							<p>
								저의 새해 결심은 ‘가족들과 함께 하는 시간 확보하기’입니다. 그런데 이게 너무 어려워요. <br>
								집에서 자동차로 2시간 거리 지방현장 근무합니다. <br>
								금요일 밤에 집에 가서 주말 보내고 일요일 밤에 현장 복귀하는데, 매주 가려고 하지만
								한달 4주 중에 세 번의 주말 밖에 못 가는 것 같습니다. 문제는 금요일 집에 가서 잠자리에 들면
								토요일 오후까지 뒹굴뒹굴만 하다가 정작 아이들과 아무 데도 가지 못한다는 거죠. <br>
								아이들과 놀러도 가고 싶고, 아내와 오붓한 시간도 보내고 싶고, 저만의 시간도 갖고 싶은데,
								모두 마음뿐이라는 겁니다.<br><br>
								<span class="exp">* 스카이즈 상담소는? 스카이즈 상담소는 SK건설인의 고민을 우리 구성원의 투표와 조언을 통해 함께 해소하는 코너입니다.</span>
							</p>
						</div>
						<div class="col-md-5 mt55 ta-c l-man">
							<img src="../img/epilogue/img04.png" alt="">
						</div>
					</div>
					<div class="row rch-box">
						<div class="col-md-12">
							<p class="tit">가족과 함께하고픈 L 과장의 고민, 여러분의 조언은?</p>
						</div>
						<div class="col-md-12">
							<div class="con-box">
								<label for="ans1_1" class="radio"><input type="radio" name="ans1" value="1" id="ans1_1" class="a1_1">토요일 일찍 출발하는 가족 나들이 계획을 사전에 세우고, 토요일 일찍부터 움직인 후 오후 4-5시 경에 집에 도착하는 일정을 세운다. 그리고 일요일 새벽에 등산이나 골프, 자전거 등을 혼자 즐긴 후 돌아와 가족들과 점심 외식을 하고, 오후에 조금 쉬었다가 현장에 복귀한다.</label>
								<label for="ans1_2" class="radio mt30"><input type="radio" name="ans1" value="2" id="ans1_2" class="a1_2">토요일은 그냥 집에서 푹 쉰다. 대신 일요일 일찍부터 가족 나들이를 가서 하루 종일 즐긴 후 아내와 아이들은 집으로, 본인은 현장으로 향한다. 좋아는 하되 티는 내지 마세요.</label>
								<label for="ans1_3" class="radio mt30"><input type="radio" name="ans1" value="3" id="ans1_3" class="a1_3">휴무일을 조정해서 월2회만 집으로 간다. 대신 월2회(또는 1회) 1박2일이나 2박3일 정도의 짧은 가족여행이나 캠핑을 통해 짧고 굵게 가족과 함께 하는 시간을 갖는다.</label>
								<label for="ans1_4" class="radio mt30"><input type="radio" name="ans1" value="4" id="ans1_4" class="a1_4">기타 (의견을 보내주세요)</label>
								<textarea name="contents" id="contents" class="mt20" placeholder="L 과장의 고민을 시원하게 풀어줄 여러분의 의견을 적어주세요."></textarea>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-3 mt25">
							<p class="of-hi"><label for="p_user_name" class="ip-tit">이름</label><input type="text" name="user_name" value="" id="p_user_name"></p>
						</div>
						<div class="col-md-3 mt25">
							<p class="of-hi"><label for="p_sa_num" class="ip-tit">사번</label><input type="text" name="sa_num" value="" id="p_sa_num"></p>
						</div>
						<div class="col-md-offset-3 col-md-3 ta-c mt25">
							<a href="javascript:void(0);" onclick="survey_check()" class="epilogue-btn"><img src="../img/epilogue/btn01.jpg" alt="의견보내기"></a>
						</div>
					</div>
				</div>
			</div>
			<div class="wave">
				<img src="../img/epilogue/bg01.jpg" alt="">
			</div>
			<div class="bg-03 pt45 pb85">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<img src="../img/epilogue/tit03.jpg" alt="스카이즈 타임머신 그땐 이랬지~">
						</div>
					</div>
					<div class="row">
						<div class="col-md-4 mt60">
							<p class="sub-tit">스카이즈 2007년 1월 발행</p>
							<p class="coner">주요 코너 : CEO 노트, 리더의 칼럼, 현장탐방, 릴레이 부서소개, 아름다운 OB</p>
							<p class="mt30 ta-c"><a href="../../200701/index/default.asp" target="_blank"><img src="../img/epilogue/img05.jpg" alt="사보 보러 가기"></a></p>
						</div>
						<div class="col-md-4 mt60">
							<p class="sub-tit">스카이즈 2010년 1월 발행</p>
							<p class="coner">주요 코너 : 닮고 싶은 향기, 현장스케치, INFO SK건설, 패밀리가 떴다, 행복나눔</p>
							<p class="mt30 ta-c"><a href="../../201001/index/default.asp" target="_blank"><img src="../img/epilogue/img06.jpg" alt="사보 보러 가기"></a></p>
						</div>
						<div class="col-md-4 mt60">
							<p class="sub-tit">스카이즈 2015년 1월 발행</p>
							<p class="coner">주요 코너 : CEO 신년사, Prove 2016, 미생랭크, 우리회사 슈퍼맨, 응답하라 해외현장, 테마토크</p>
							<p class="mt30 ta-c"><a href="../../201501/00_main/main.asp" target="_blank"><img src="../img/epilogue/img07.jpg" alt="사보 보러 가기"></a></p>
						</div>
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
	var currentMenu = 10;

	//radio, checkbox custom style
	function setupLabel() {
		if ($('.check input').length) {
			$('.check').each(function(){
				$(this).removeClass('c_on');
			});
			$('.check input:checked').each(function(){
				$(this).parent('label').addClass('c_on');
			});
		};
		if ($('.radio input').length) {
			$('.radio').each(function(){
				$(this).removeClass('r_on');
			});
			$('.radio input:checked').each(function(){
				$(this).parent('label').addClass('r_on');
			});
		};
	};
	$(document).ready(function(){
		$('.check, .radio').click(function(){
			setupLabel();
		});
		setupLabel();
	});
</script>
<script src="../lib/js/owl.carousel.js"></script>
<script>
    $(document).ready(function() {

		$(".owl-demo").owlCarousel({

      navigation : true,
      slideSpeed : 300,
      paginationSpeed : 400,
      singleItem : true

      // "singleItem:true" is a shortcut for:
      // items : 1,
      // itemsDesktop : false,
      // itemsDesktopSmall : false,
      // itemsTablet: false,
      // itemsMobile : false

      });
    });
</script>

</body>
</html>
