<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_54_248"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/cafe.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
		function cafe_check()
		{
			//사번 이름 입력 체크
			var bu_name = $("#c_bu_name").val();
			var sa_num = $("#c_sa_num").val();
			var user_name = $("#c_user_name").val();

			var contents = $('#c_contents').val();

			if (bu_name == "")
			{
				alert("보낼 사람을 입력하세요.");
				$("#p_bu_name").focus();
				return;
			}
			if (sa_num == "")
			{
				alert("보내는 사람 사번을 입력하세요.");
				$("#p_sa_num").focus();
				return;
			}
			if (user_name == "")
			{
				alert("이름을 입력하세요.");
				$("#p_user_name").focus();
				return;
			}

			if (contents == "")
			{
				alert("내용을 입력해 주세요.");
				$("#c_contents").focus();
				return;
			}

			if (bu_name == "" || sa_num == "" || user_name == "")
			{
				alert("정상적인 접근이 아닙니다.");
			}else
			{
				$.ajax({
					url: '../xmlData/cafe_insert.asp',
					type: 'POST',
					dataType: 'xml',
					data: {
						"bu_name": bu_name,
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
							alert("따뜻한 감사의 마음이 전해 졌습니다.");
							document.location.href = "./cafe.asp";
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
					<img src="../img/cafe/headline_tit.png" data-src-base='../img/cafe/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png' />
				</div>

			</div>
			<!-- //e:headline -->
			<!-- s:lead -->
			<!-- <div id="lead">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<p>어서 오세요~ 스카이즈 행복 카페에 오신 여러분을 환영합니다! 이달 오픈한 스카이즈 행복 카페는 SK건설 구성원과 그의 소중한 사람들을 위해 마련되었습니다. 무척 고마운 선후배 및 동료가 있지만 평소 마음을 전하기 어려웠다면? 주저 없이 스카이즈 행복 카페의 문을 두드리세요. <br>스카이즈 행복 카페는 평소 고마웠던 선후배 및 동료에게 사연을 적어 올리면 부드러운 커피 기프티콘과 함께 전달해드리는 행복 나눔 코너입니다. 추첨을 통해 사연을 보내는 분과 받는 분 모두에게 커피 기프티콘을 증정해드리오니, 나 한잔, 동료 한잔! 사이 좋게 커피를 기울이며 그간 드러내지 못했던 고마운 마음을 표현하세요!</p>
						</div>
					</div>
				</div>
			</div> -->
			<!-- //e:lead -->
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
						<div class="col-md-12 ta-c bd01">
							<p id="lead">어서 오세요~ 스카이즈 행복 카페에 오신 여러분을 환영합니다! 행복 카페는 SK건설 구성원과 그의 소중한 사람들을 위해 마련되었습니다. 무척 고마운 선후배 및 동료가 있지만 평소 마음을 전하기 어려웠다면? 주저 없이 스카이즈 행복 카페의 문을 두드리세요. <br>스카이즈 행복 카페는 평소 고마웠던 선후배 및 동료에게 사연을 적어 올리면 부드러운 커피 기프티콘과 함께 전달해드리는 행복 나눔 코너입니다. 추첨을 통해 <span class="highlight02">사연을 보내는 분과 받는 분 모두</span>에게 커피 기프티콘을 증정해드리오니, 나 한잔, 동료 한잔! 사이 좋게 커피를 기울이며 그간 드러내지 못했던 고마운 마음을 표현하세요!</p>
						</div>
					</div>

					<div class="row">
						<div class="col-md-12 ta-c bd02 pt60">
							<p><img src="../img/cafe/tit02.png" alt=""></p>
						</div>
					</div>
					<div class="letter-wrap">
						<div class="row">
							<div class="col-xs-10 col-xs-offset-1 letter">
								<p class="tit mb40">첫 번째 당첨자 플랜트Discipline Estimating팀 유명규 대리</p>
								<p><span class="sub-tit">플랜트Project Estimating팀 이기정 대리 님께</span><br><br>이기정 대리님은 견적실의 터줏대감이자 입찰 Cost의 핵심인 Service Cost를 책임지고 있습니다. 수많은 프로젝트의 입찰에서 당당하게 본인의 몫을 다 해주고 계신 대리님에게 요즘처럼 추운 겨울날, 따뜻한 커피 한잔을 선물하고 싶습니다. 대리님, 올해 초 함께 입찰했었던 프로젝트, 생각나시나요? 6개월이 넘는 입찰 기간 동안 밤낮을 가리지 않고 수주를 위해 고생하시던 모습이 떠오르네요. 특히 타 function 팀과 갈등을 빚었을 때 부드러운 카리스마로 의견을 조율해 나가시는 모습이 아직도 기억에 남습니다. 깊어가는 겨울, 대리님과 따뜻한 커피한잔을 나누며 소소한 여유를 즐기고 싶습니다.^^ </p>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 ta-c img-letter">
								<p><img src="../img/cafe/img_letter01.png" alt=""></p>
							</div>
						</div>
					</div>
					<div class="letter-wrap">
						<div class="row">
							<div class="col-xs-10 col-xs-offset-1 letter">
								<p class="tit mb40">두 번째 당첨자 SK HYNIX M14 PH-2B PROJECT(이천) 김재규 과장</p>
								<p><span class="sub-tit">Polyols Project팀 박길준 대리 님께</span><br><br>박길준 대리와는 같은 공정팀원으로 M14 Ph-2A와 Side FAB Project를 진행하면서 많은 정을 나눈 사이입니다. 그런데 박 대리가 갑자기 본사로 발령이 나는 바람에 서울로 돌아가게 되었습니다. 평소 무뚝뚝하고 표현도 잘 못하는 성격인 탓에 ‘그 동안 나를 도와주고 서포트해줘서 고맙다’라고 표현하고 싶었는데, 말도 전하기 전에 본사로 돌아갔네요. ㅠㅠ  지금은 타 프로젝트에서 멋지게 활약 중이라는 박길준 대리! 같이 일하는 동안 많이 가르쳐 주지도 못하고 일만 시킨 것 같아서 미안하네요. 이 자리를 빌어 고마움을 전하고 싶습니다.</p>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 ta-c img-letter">
								<p><img src="../img/cafe/img_letter02.png" alt=""></p>
							</div>
						</div>
					</div>
					<div class="letter-wrap">
						<div class="row">
							<div class="col-xs-10 col-xs-offset-1 letter">
								<p class="tit mb45">세 번째 당첨자 플랜트배관설계지원팀 서미경 사원</p>
								<p><span class="sub-tit">화공Physical기본설계팀 김문희 과장 님께</span><br><br>어느덧 SK건설에 재직한 지 2년이 다 되어가네요. ‘12년도에 과장님과 인연을 맺고, ‘15년도에는 직장을 찾아 헤매던 저에게 손을 내밀어주신 고마운 분입니다. 늘 가족처럼 챙겨주셨고 미래가 불투명한 저에게 현실적인 조언도 많이 해주셨으며 배려 가득한 과장님의 따뜻한 보살핌 덕분에 너무나 즐겁고 편안히 근무할 수 있었습니다. 직장 동료임을 떠나서 같은 여자, 인생 선배님으로 편하게 고민도 털어놓을 수 있었고, 늘 자상하게 대해주셔서 많은 위로를 받았습니다. 언제나 잊지 않고 감사한 마음을 갖고 있으며, 평생 저의 정신적 지주가 되어 주셨으면 좋겠습니다. 과장님 고맙습니다! :D  </p>
							</div>
						</div>
						<div class="row bd01 pb50">
							<div class="col-xs-12 ta-c img-letter">
								<p><img src="../img/cafe/img_letter01.png" alt=""></p>
							</div>
						</div>
					</div>

                    <div class="row">
                        <div class="col-md-12">
                            <p class="ta-c bd02 pt60"><img src="../img/cafe/tit01.png" alt=""></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-3 ta-c mt50">
                            <p><img src="../img/cafe/img01.png" alt=""></p>
                            <p class="cafe-txt mt15"><span class="num">01</span><br>행복 카페 이용 기간은 <span class="highlight">12월 1일(금)부터 12월 22일(금)까지</span>입니다.</p>
                        </div>
                        <div class="col-md-3 ta-c mt50">
                            <p><img src="../img/cafe/img02.png" alt=""></p>
                            <p class="cafe-txt mt15"><span class="num">02</span><br>아래 사연란에 감사의 마음을 전하고 싶은 분들의 <span class="highlight">이름, 연락처, 사연</span>을 꼭 적어주세요.</p>
                        </div>
                        <div class="col-md-3 ta-c mt50">
                            <p><img src="../img/cafe/img03.png" alt=""></p>
                            <p class="cafe-txt mt15"><span class="num">03</span><br>추첨을 통해 채택된 세 분과 사연 속 주인공에게 모두 <span class="highlight">커피 기프티콘</span>을 보내드립니다.</p>
                        </div>
                        <div class="col-md-3 ta-c mt50">
                            <p><img src="../img/cafe/img04.png" alt=""></p>
                            <p class="cafe-txt mt15"><span class="num">04</span><br>채택된 사연은 <span class="highlight">다음 호 스카이즈 ‘행복카페’</span>에 소개됩니다.</p>
                        </div>
                    </div>
					<form name="cafe_frm">
                        <div class="bg-02 mt55">
                            <div class="row personal mt35">
        						<div class="col-md-offset-1 col-md-2">
        							<p>받는 사람 : </p>
        						</div>
								<div class="col-md-3">
									<input type="text" name="bu_name" id="c_bu_name" value="">
								</div>
        					</div>
							<div class="row personal mt20">
								<div class="col-md-offset-1 col-md-2">
									<p>보내는 사람 : </p>
								</div>
								<div class="col-md-1">
									<p>사번</p>
								</div>
								<div class="col-md-2">
									<input type="text" name="sa_num" id="c_sa_num" value="">
								</div>
								<div class="col-md-1 col-md-offset-1">
									<p>이름</p>
								</div>
								<div class="col-md-2">
									<input type="text" name="user_name" id="c_user_name" value="">
								</div>
							</div>
                            <div class="row question">
                                <div class="col-md-10 col-md-offset-1 ta-c">
                                    <p class="pt25">내용</p>
                                    <textarea id="c_contents" name="contents" placeholder="커피 기프티콘을 받을 분의 이름과 연락처를 꼭 기입해주세요."></textarea>
                                </div>
                            </div>

                            <div class="row mt50 mb60">
        						<div class="col-md-12 ta-c">
        							<a href="javascript:void(0);" onclick="cafe_check();"><img src="../img/cafe/btn01.jpg" alt=""></a>
        						</div>
        					</div>
                        </div>
					</form>
					<!-- <div class="row">
						<div class="col-md-12 ta-c mt50 mb75">
							<p class="cafe-des">많은 참여 부탁 드립니다~</p>
						</div>
					</div> -->
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
	var currentMenu = 13;
</script>

</body>
</html>
