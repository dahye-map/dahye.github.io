<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_54_242"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/crane.css">
	<!--[if lt IE 9]>
	    <script type="text/javascript" src="../lib/js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
		$(document).ready(function(e){
			init_game();
		});
		var win_rate = 65;

		function init_game()
		{
			var $left = $('.btn-left');
			var $right = $('.btn-right');
			var $press = $('.btn-press');
			var crane_offset;
			var winW  = $(window).width();

			var hold = false;
			$(".start").click(function(){
				$(this).hide();

				$left.click(function(){
					$(".game .crane").animate({"left" : "-=24%"}, function(){
						crane_offset = $('.game .crane').position().left;
						console.log(crane_offset);
					});

					if(winW >= 768 ) {
						if(crane_offset <= 266) {
							$(".game .crane").stop();
						}
					} else if (winW <= 768 && winW >=480) {
						if(crane_offset <= 180) {
							$(".game .crane").stop();
						}
					} else {
						if(crane_offset <= 100) {
							$(".game .crane").stop();
						}
					}

				});
				$right.click(function(){
					$(".game .crane").animate({"left" : "+=24%"}, function(){
						crane_offset = $('.game .crane').position().left;
						console.log(crane_offset);
					});
					if(winW >= 768 ) {
						if(crane_offset >= 510) {
							$(".game .crane").stop();
						}
					} else if (winW <= 768 && winW >=480) {
						if(crane_offset >= 332) {
							$(".game .crane").stop();
						}
					} else {
						if(crane_offset >= 200) {
							$(".game .crane").stop();
						}
					}

				});
				$press.click(function(){
					$(".game .crane .bar").animate({"top" : "0"});
					$(".game .crane .body").animate({"top" : "0"}, function(){
						crane_offset = $('.game .crane').position().left;

						hold = true;

						var rnd_rate = get_random_num();

						if(winW >= 768 ) {
							if(crane_offset >= 173 && crane_offset < 340) {
								$('.all').hide();

								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success01').show();
								} else {
									$('.fail01').show();
								}
							}
							if(crane_offset >= 340 && crane_offset < 511) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success02').show();
								} else {
									$('.fail02').show();
								}
							}
							if(crane_offset >= 511) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success03').show();
								} else {
									$('.fail03').show();
								}
							}
						} else if (winW <= 768 && winW >=480) {
							if(crane_offset >= 50 && crane_offset < 230) {
								$('.all').hide();

								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success01').show();
								} else {
									$('.fail01').show();
								}
							}
							if(crane_offset >= 230 && crane_offset < 350) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success02').show();
								} else {
									$('.fail02').show();
								}
							}
							if(crane_offset >= 350) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success03').show();
								} else {
									$('.fail03').show();
								}
							}
						} else {
							if(crane_offset >= 50 && crane_offset < 130) {
								$('.all').hide();

								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success01').show();
								} else {
									$('.fail01').show();
								}
							}
							if(crane_offset >= 130 && crane_offset < 200) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success02').show();
								} else {
									$('.fail02').show();
								}
							}
							if(crane_offset >= 200) {
								$('.all').hide();
								if (parseInt(rnd_rate, 10) < win_rate) {
									$('.success03').show();
								} else {
									$('.fail03').show();
								}
							}
						}
					});
				});
			});
			$(".result > *").hide();
		}

		function check_lottery(obj)
		{
			var sa_num = $("#sa_num").val();
			var user_name = $("#user_name").val();

			if (sa_num == "")
			{
				alert("사번을 입력하세요.");
				$("#sa_num").focus();
				return false;
			}

			if (user_name == "")
			{
				alert("이름을 입력하세요.");
				$("#user_name").focus();
				return false;
			}
		}

		function get_random_num()
		{
			var random = Math.floor(Math.random() * 100) + 1; //1 ~ 10 랜덤 출력
		// console.log("random : " + random);
			return random;
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
					<img src="../img/crane/headline_tit.png" data-src-base='../img/crane/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png' />
				</div>
			</div>
			<!-- //e:headline -->
			<!-- s:lead -->
			<div id="lead">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<p>대한민국에 '인형뽑기' 열풍을 일으킨 '크레인 게임기'가 드디어 우리 사보에도 상륙했습니다. 여러분, 그 동안 인형 뽑느라 허무하게 소비한 동전과 시간에 가슴 아프셨죠? 이젠 그럴 필요 없습니다~ 스카이즈의 '럭키 크레인'은 스마트폰과 약간의 인내심만 있으면 인형보다 더 탐나는 기프티콘을 겟할 수 있거든요. 동전도 필요 없어요~ SK건설 구성원이라면 기프티콘을 뽑을 때까지 무한 공짜 도전! 이번 시간에는 무술년, 개의 해를 맞이해 귀여운 강아지 인형들을 준비해보았습니다. 갖고 싶은 강아지 인형을 클릭해보세요~</p>
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
	        <div class="bg-01">
	            <div class="container">
	                <div class="row">
	                    <div class="col-md-12 ta-c">
	                        <p><img src="../img/crane/tit01.jpg" alt=""></p>
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-md-4 ta-c">
	                        <p class="mt40"><img src="../img/crane/img01.jpg" alt=""></p>
	                        <p class="mt40"><img src="../img/crane/step01.jpg" alt=""></p>
	                        <p class="mt20 step">사번과 이름을 입력한 후 게임화면을 클릭하세요. </p>
	                    </div>
	                    <div class="col-md-4 ta-c">
	                        <p class="mt40"><img src="../img/crane/img02.jpg" alt=""></p>
	                        <p class="mt40"><img src="../img/crane/step02.jpg" alt=""></p>
	                        <p class="mt20 step">보라색 버튼을 갖고 싶은 인형 쪽으로 조종한 뒤 빨간색 버튼을 누르면 크레인이 내려갑니다.</p>
	                    </div>
	                    <div class="col-md-4 ta-c">
	                        <p class="mt40"><img src="../img/crane/img03.jpg" alt=""></p>
	                        <p class="mt40"><img src="../img/crane/step03.jpg" alt=""></p>
	                        <p class="mt20 step">인형 뽑기에 성공하면 기프티콘을 받을 수 있습니다.</p>
	                    </div>
	                </div>
	            </div>

	        </div>
	        <div class="bg-02">
	            <div class="container">
	                <div class="row">
	                    <div class="col-md-12 ta-c mt100 mb40">
	                        <p><img src="../img/crane/tit02.jpg" alt=""></p>
	                    </div>
	                </div>
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="info">
	                            <div class="name">
	                                <img src="../img/crane/name.png"  />
	                                <input type="text" name="user_name" id="user_name" value="">
	                            </div>
	                            <div class="num">
	                                <img src="../img/crane/num.png"  />
	                                <input type="text" name="sa_num" id="sa_num" value="">
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-md-12 mt60 mb100 pb20">
	                        <div class="game">

	                            <!-- <p class="grass ta-c"><img src="../img/crane/bg_game.png" alt=""></p> -->
								<div class="grass-wrap">
									<div class="grass">
										<div class="all">
											<p class="shine"><img src="../img/crane/grass_shine.png" alt=""></p>
											<p class="doll"><img src="../img/crane/bg_doll.png" alt=""></p>

				                            <div class="crane">
												<p class="bar"><img src="../img/crane/bar.png" alt=""></p>
				                                <p class="body"><img src="../img/crane/crane.png" alt=""></p>
				                            </div>

				                            <div class="start ta-c">
												<p class="icon"><img src="../img/crane/ico_foot.png" alt=""></p>
				                                <p class="con">화면을 클릭하면 게임이 시작됩니다.</p>
				                            </div>

				                            <div class="doll01">
				                                <p><img src="../img/crane/doll01.png" alt=""></p>
				                            </div>
				                            <div class="doll02">
				                                <p><img src="../img/crane/doll02.png" alt=""></p>
				                            </div>
				                            <div class="doll03">
				                                <p><img src="../img/crane/doll03.png" alt=""></p>
				                            </div>
										</div>
										<div class="result">
											<div class="success01">
												<p class="ta-c"><img src="../img/crane/img_success01.png" alt=""></p>
											</div>
											<div class="success02">
												<p class="ta-c"><img src="../img/crane/img_success02.png" alt=""></p>
											</div>
											<div class="success03">
												<p class="ta-c"><img src="../img/crane/img_success03.png" alt=""></p>
											</div>

											<a href="" class="fail01">
												<p class="ta-c"><img src="../img/crane/img_fail01.png" alt=""></p>
											</a>
											<a href="" class="fail02">
												<p class="ta-c"><img src="../img/crane/img_fail02.png" alt=""></p>
											</a>
											<a href="" class="fail03">
												<p class="ta-c"><img src="../img/crane/img_fail03.png" alt=""></p>
											</a>
										</div>
									</div>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="bg-03">
	            <div class="container">
	                <div class="row mt40 mb60">
	                    <div class="col-md-12 ta-c">
	                        <div class="control">
								<a href="javascript:void(0);" class="btn-left">
									<img src="../img/crane/btn_left.jpg" alt="">
								</a>
								<a href="javascript:void(0);" class="btn-press">
									<img src="../img/crane/btn_press.jpg" alt="">
								</a>
								<a href="javascript:void(0);" class="btn-right">
									<img src="../img/crane/btn_right.jpg" alt="">
								</a>
	                        </div>
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
	var currentMenu = 11;
</script>

</body>
</html>
