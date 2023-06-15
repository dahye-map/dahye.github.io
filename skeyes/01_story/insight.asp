<%@ Language = VBScript CODEPAGE = 65001 %>
<%
	MenuCode	= "M_51_245"
	'OneMenuCode	= "33"
	'TwoMenuCode	= "91"
%>
<!--#include file="../inc/const_date.asp" -->
<!DOCTYPE HTML>

<html lang="ko">
<head>
<!--#include file="../inc/head.asp" -->
    <link rel="stylesheet" href="../lib/css/articleDesign/insight.css">
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
		<div class="article-wrap insight">
			<!-- s:headline -->
			<div id="headline">
				<div class="headline-container">
					<img src="../img/insight/headline_tit.png" data-src-base='../img/insight/' data-src='<480:headline_mo.jpg, <768:headline_mo.jpg, <960:headline_tit.png, >960:headline_tit.png'/>
				</div>
			</div>
			<!-- //e:headline -->
			<!-- s:lead -->
			<div id="lead">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<p>
								COPQ, 즉 Cost of Poor Quality는 ‘품질 실패로 초래되는 비용’을 말한다. 작은 품질실패로 인한 대수롭지 않은 재작업(Rework)들이 모이고 모여서 큰 손실을 만든다는 당연한 진실 앞에 COPQ 개선을 통해 빈틈메우기와 일하는 방식의 수준 제고, 회사 재무성과 제고에 기여하고, 좀 더 나아가서는 COPQ 개선 효과 극대화로 차별적 경쟁력을 확보하는 핵심적인 Tool로 COPQ가 자리매김할 것으로 기대된다. 2018년 1월호에는 지난 해에 실시한 COPQ 개선 활동에서 우수사례로 선정된 팀 가운데 세 팀의 성과를 살펴보고 이야기를 들어본다.
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
			<div class="bd">
				<div class="container">
					<div class="row">
						<div class="col-md-12 ta-c">
							<p><img src="../img/insight/tit01.jpg" alt=""></p>
						</div>
					</div>
				</div>
			</div>
			<div class="container">
				<div class="row mt80">
					<div class="col-md-6 ta-c">
						<p><img src="../img/insight/img01.jpg" alt=""></p>
					</div>
					<div class="col-md-6 mt-991">
						<div class="txt-pd">
							<p><img src="../img/insight/bul01.jpg" alt=""></p>
							<p class="tit">3D Model을 활용한 TML 조기확정으로 현장 Rework 최소화 <br>: JAZAP Project <span>(KNPC CFP팀 조진식 부장)</span></p>
							<p class="mt30">화공/발전플랜트 등 장치산업에서 장치 및 배관 등 설비의 잔여 사용 연한을 확인하기 위해 주기적으로 부식(Corrosion) 정도를 검사하는 취약한 위치인 TML(Thickness Measurement Location). 통상 20년 이상 사용해야 하는 설비에서 부식에 의한 유독 물질 누출(Leak)로 인해 화재나 폭발사고가 발생하기도 하는데, 이를 방지하기 위해 TML을 주기적으로 검사하고 있다. 이 TML을 2D 도면 중심 리뷰로 하다 보면 입체적 이해도가 낮아 문제점을 발견하기 어렵고, TML 설계를 완료한 이후 발주처의 추가 코멘트로 인핸 Rework의 부담이 큰 관계로, 3D Model을 통한 리뷰를 통해 비용을 절감하고 프로젝트 공기를 줄이는 개선 방향을 도출했다.</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 mt40">
						<table class="tb-type01">
							<colgroup>
								<col width="45%">
								<col width="55%">
							</colgroup>
							<thead>
								<th>
									<p>현황 및 문제점</p>
								</th>
								<th>
									<p>개선 방향성(팀별)</p>
								</th>
							</thead>
							<tbody>
								<tr>
									<td>
										<p class="td-tit num01">설계 관행</p>
										<ul class="pl45">
											<li>20도면 중심 Review로 인해 입체적 이해도가 낮아 문제점 조기 발견에 한계 노출</li>
											<li>O&amp;M 측면의 Accessibility 검토 미비</li>
										</ul>
									</td>
									<td>
										<span class="fl-l">
											<p class="td-tit">플랜드 배관팀</p>
											<ul>
												<li>3D Model에 TML조기 반영</li>
												<li>O&amp;M 관점 설계 및 Review 수행</li>
											</ul>
										</span>

										<span class="fl-l">
											<p class="td-tit">플랜트 장치팀</p>
											<ul>
												<li>3D 불가 -> 2D 도명 Review 강화</li>
											</ul>
										</span>
									</td>
								</tr>
								<tr>
									<td>
										<p class="td-tit num02">문제의식</p>
										<ul class="pl45">
											<li>Insulation 에 포함된 작은 Activity 로 인식</li>
											<li>PJT 종반에 주로 발생하는 TML에 대한 낮은 관심</li>
										</ul>
									</td>
									<td>
										<p class="td-tit">PMT</p>
										<ul>
											<li>Major Risk 요인으로 집중 관리</li>
											<li>지속적인 발주처 관심 유도</li>
											<li>조기 O&amp;M 부서 Assign 요청</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td>
										<p class="td-tit num03">발주처 추가 Comment</p>
										<ul class="pl45">
											<li>TML 설계를 완료한 이후 발주처 O&amp;M(검사팀/설비보수팀) 추가 Comment 발생</li>
										</ul>
									</td>
									<td>
										<p class="td-tit">플랜트설계지원팀(MWE)</p>
										<ul>
											<li>Corrosion Engineer의 involvement (MWE)</li>
										</ul>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row mt90">
					<div class="col-md-6 ta-c fl-r">
						<p><img src="../img/insight/img02.jpg" alt=""></p>
					</div>
					<div class="col-md-6 mt-991">
						<p><img src="../img/insight/bul02.jpg" alt=""></p>
						<p class="tit">FAB동 단차부 가시설 공법 개선 <br>: 청주 Hynix M15 Ph1 현장 <br><span>(반도체설계팀 김영의 과장)</span></p>
						<p class="mt35">반도체생산시설 FAB은 반도체산업의 특성상 ‘Super Fast Track’으로 공사가 진행되어야 한다. 일반 건축물의 준공에 해당하는 CR(Clean Room) 오픈까지 주어지는 약 18개월 중 초반 3개월의 FAB 단차부 시공(파일 및 기초 MAT 공사)의 신속 수행이 프로젝트 초기 중요 사항이다. <br>다량의 선 파일 공사 후, 지하 단차부 굴착으로 인한 COPQ가 발생했던 기존 사례를 분석하여 안전성 확보, 공사지연 방지, 장비공사의 여건 등을 금번 COPQ활동을 통해 개선하였다.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 mt40">
						<table class="tb-type01">
							<colgroup>
								<col width="40%">
								<col width="60%">
							</colgroup>
							<thead>
								<th>
									<p>문제점</p>
								</th>
								<th>
									<p>개선사항</p>
								</th>
							</thead>
							<tbody>
								<tr>
									<td>
										<p class="td-tit">안전성 미확보로 추가 사면보강 실시</p>
									</td>
									<td>
										<p class="td-tit">안전성 미확보로 추가 사면보강 실시</p>
									</td>
								</tr>
								<tr>
									<td>
										<p class="td-tit">단차부 공사지연 사항 발생</p>
									</td>
									<td>
										<p class="td-tit">Pile 공사 및 골조공사 간 시공 process 개선</p>
									</td>
								</tr>
								<tr>
									<td>
										<p class="td-tit">단차부 Pile 공사 여건 불리</p>
									</td>
									<td>
										<p class="td-tit">단차부의 파일 공사 시공을 위한 장비 접근성 개선 </p>
									</td>
								</tr>
								<tr>
									<td>
										<p class="td-tit">경사면 Pile 안정성 확보 필요</p>
									</td>
									<td>
										<p class="td-tit">단계별 토공 적용 및 단차부 H Pile+토류판 simple 공법 적용</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="row mt80">
					<div class="col-md-6 ta-c">
						<p><img src="../img/insight/img03.jpg" alt=""></p>
					</div>
					<div class="col-md-6 mt-991">
						<div class="txt-pd">
							<p><img src="../img/insight/bul03.jpg" alt=""></p>
							<p class="tit">프로세스 구축을 통한 콘크리트 할석-미장 보수 손실비용 개선<br>: 신동탄 SK VIEW Park 3차 현장<span>(김재민 과장)</span></p>
							<p class="mt30">골조 할석-미장은 건설공사 중대 하자이며 PQ벌점 건당 3점 대상으로, 현장의 중점 품질관리 항목이다. 또한 할석-미장은 기사-대리급 직원들의 업무소요량에 큰 비중을 차지하고 있고, 미조치시 마감공사 품질에 직접적인 영향력을 발휘하는 항목으로, 건축 시공관리자 업무효율성 개선을 위해 프로세스 정립이 절실한 아이템이었다.</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 mt30 mb70">
						<p class="tit type02">Form Work</p>
						<p class="mt15 ta-c"><img src="../img/insight/img_table.jpg" data-src-base='../img/insight/' data-src='<480:img_table_mo.jpg, <768:img_table_mo.jpg, <960:img_table.jpg, >960:img_table.jpg'/></p>
					</div>
				</div>
			</div>

			<div class="bg-01">
				<div class="container">
					<div class="row mt80">
						<div class="col-md-12">
							<p class="question color-fff pt0">COPQ 개선활동을 하면서 스스로, 또는 조직적으로 어떤 변화가 있었는지요?</p>
						</div>
					</div>
					<div class="row mt40">
						<div class="col-md-4">
							<p class="ta-c"><img src="../img/insight/img04.png" alt=""></p>

							<div class="speak">
								<span class="bar"></span>
								<p class="tit type03 mt35">조진식 부장</p>
								<p class="mt10">거대한 플랜트현장에서 작은 개선, 작은 성과들은 눈에 잘 안보이기 마련입니다. 커다란 성과를 향하기보다는 작은 개선사항들을 쌓여서 만들어가는 성과에 현장 조직 분위기가 Boom-Up 되는 것이 느껴져요. 적은 돈을 한 푼 두 푼 모아 목돈을 만드는 재미처럼, 작은 것들이 성과로 쌓여가는 재미가 쏠쏠할 수 밖에 없잖아요? 외부적으로도 변화된 것이 있죠. 발주처는 그들의 입장과 속성상 웬만하면 시공사의 제안에 수동적인 자세를 견지하죠. 그런데 COPQ활동을 지속적으로 하고, 아주 디테일한 내용들까지 제안/개선해 나가는 우리의 모습을 보면서 태도를 조금 바꾸고 있어요. “이 사람들이 제안하는 것들 중에 괜찮은 게 있네~”라는 것을 경험으로 알게 된 거죠. 그렇게 발주처와 소통하고 신뢰관계를 쌓아가는 데에 큰 몫을 한 것이 바로 COPQ활동이었어요.</p>
							</div>
						</div>
						<div class="col-md-4 mt-991">
							<p class="ta-c"><img src="../img/insight/img05.png" alt=""></p>

							<div class="speak">
								<span class="bar"></span>
								<p class="tit type03 mt35">김영의 과장</p>
								<p class="mt10">결국 COPQ 개선활동이라는 것은 기 경험된, 또는 예상되는 리스크를 ‘개선활동’ 이라는 시뮬레이션을 통해 미리 컨트롤 하는 건데요, 이번 활동을 통해서 배운 것이 많습니다. 원인이 있으면 그에 따른 효과가 있고, 그 효과를 비용(손실 또는 이익)으로 바라볼 줄 아는 것이 전문 기술자로서 진짜 일을 하는 건데요, 이번 활동을 통해서 ‘진짜 일’이란 이런것이구나를 알게 되었고, 프로젝트를 전체적으로 바라보는 시각을 배웠어요. 그리고 크고 화려한 성과도 중요하지만, 작은 것, 소홀히 넘어가기 쉬운 빈틈이 얼마나 많은지, 그틈을 메꾸는 것이 얼마나 중요한지를 더 절실히 느꼈어요. 아무튼 배운 점이 많습니다.</p>
							</div>
						</div>
						<div class="col-md-4 mt-991">
							<p class="ta-c"><img src="../img/insight/img06.png" alt=""></p>

							<div class="speak mb60">
								<span class="bar"></span>
								<p class="tit type03 mt35">김재민 과장 </p>
								<p class="mt10">COPQ 개선활동은 2017년에 제가 한 일 중에 가장 잘 한 일이라고 자부합니다. 개선활동을 위해 설계, 품질, 시공이 협의해야 할 일이 많았고, 업무시간에 이어, 저녁식사자리로 이어지면서 여러 가지를 논의했는데요, 그렇게 설계/품질/시공 협의회를 구성해서 품질향상을 위해 협업하기로 했어요. 저희는 ‘설.품.시’라고 부르는 조직이 생긴 게 첫 번째 변화구요, 이를 통해 공종별 Issue 및 품질관리 기준을 공유하고 해당내용을 As-built 도면에 즉시 반영함으로서 품질관리 기준을 명확히 인지한 공사진행과 Just in Time의 도면정리가 가능하게 되어 각 Part별 최적화된 관리를 실시할 수 있게 되었습니다. 두 번째는 본 과제 수행과 관련하여 “하기 싫고 귀찮은 일이었던 할석미장 체크”에 대해서 효율적인 관리를 위해 시작했었던 현장의 작은 활동을 회사에서 품질우수사례로 인정 받았다는 것에 큰 자신감이 생겼습니다. 이러한 자신감을 기반으로 전직원이 똘똘 뭉쳐서 18년도 말미에 있을 입주자 사전점검 시 하자율을 최소화하기 </p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="bg-02 hidden-sm hidden-xs">
				<div class="container">
					<div class="row mb60">
						<div class="col-md-4">
							<span class="bar"></span>
							<p class="tit type03 mt35">조진식 부장</p>
							<p class="mt10">거대한 플랜트현장에서 작은 개선, 작은 성과들은 눈에 잘 안보이기 마련입니다. 커다란 성과를 향하기보다는 작은 개선사항들을 쌓여서 만들어가는 성과에 현장 조직 분위기가 Boom-Up 되는 것이 느껴져요. 적은 돈을 한 푼 두 푼 모아 목돈을 만드는 재미처럼, 작은 것들이 성과로 쌓여가는 재미가 쏠쏠할 수 밖에 없잖아요? 외부적으로도 변화된 것이 있죠. 발주처는 그들의 입장과 속성상 웬만하면 시공사의 제안에 수동적인 자세를 견지하죠. 그런데 COPQ활동을 지속적으로 하고, 아주 디테일한 내용들까지 제안/개선해 나가는 우리의 모습을 보면서 태도를 조금 바꾸고 있어요. “이 사람들이 제안하는 것들 중에 괜찮은 게 있네~”라는 것을 경험으로 알게 된 거죠. 그렇게 발주처와 소통하고 신뢰관계를 쌓아가는 데에 큰 몫을 한 것이 바로 COPQ활동이었어요.</p>
						</div>
						<div class="col-md-4">
							<span class="bar"></span>
							<p class="tit type03 mt35">김영의 과장</p>
							<p class="mt10">결국 COPQ 개선활동이라는 것은 기 경험된, 또는 예상되는 리스크를 ‘개선활동’ 이라는 시뮬레이션을 통해 미리 컨트롤 하는 건데요, 이번 활동을 통해서 배운 것이 많습니다. 원인이 있으면 그에 따른 효과가 있고, 그 효과를 비용(손실 또는 이익)으로 바라볼 줄 아는 것이 전문 기술자로서 진짜 일을 하는 건데요, 이번 활동을 통해서 ‘진짜 일’이란 이런것이구나를 알게 되었고, 프로젝트를 전체적으로 바라보는 시각을 배웠어요. 그리고 크고 화려한 성과도 중요하지만, 작은 것, 소홀히 넘어가기 쉬운 빈틈이 얼마나 많은지, 그틈을 메꾸는 것이 얼마나 중요한지를 더 절실히 느꼈어요. 아무튼 배운 점이 많습니다.</p>
						</div>
						<div class="col-md-4">
							<span class="bar"></span>
							<p class="tit type03 mt35">김재민 과장 </p>
							<p class="mt10">COPQ 개선활동은 2017년에 제가 한 일 중에 가장 잘 한 일이라고 자부합니다. 개선활동을 위해 설계, 품질, 시공이 협의해야 할 일이 많았고, 업무시간에 이어, 저녁식사자리로 이어지면서 여러 가지를 논의했는데요, 그렇게 설계/품질/시공 협의회를 구성해서 품질향상을 위해 협업하기로 했어요. 저희는 ‘설.품.시’라고 부르는 조직이 생긴 게 첫 번째 변화구요, 이를 통해 공종별 Issue 및 품질관리 기준을 공유하고 해당내용을 As-built 도면에 즉시 반영함으로서 품질관리 기준을 명확히 인지한 공사진행과 Just in Time의 도면정리가 가능하게 되어 각 Part별 최적화된 관리를 실시할 수 있게 되었습니다. 두 번째는 본 과제 수행과 관련하여 “하기 싫고 귀찮은 일이었던 할석미장 체크”에 대해서 효율적인 관리를 위해 시작했었던 현장의 작은 활동을 회사에서 품질우수사례로 인정 받았다는 것에 큰 자신감이 생겼습니다. 이러한 자신감을 기반으로 전직원이 똘똘 뭉쳐서 18년도 말미에 있을 입주자 사전점검 시 하자율을 최소화하기 위해 최선을 다하겠다는 각오입니다. </p>
						</div>
					</div>
				</div>
			</div>

			<div class="bg-03">
				<div class="container">
					<div class="row mt75">
						<div class="col-md-12">
							<p class="question"> 2018년 무술년 새해입니다. 2017년의 성과와 더불어 <br>2018년에는 어떤 계획들이 있으신지요?</p>
						</div>
					</div>
					<div class="row mt35">
						<div class="col-md-9">
							<p><span class="name">김재민 과장 :</span> 우리 신동탄 SK VIEW Park 3차 현장이 현재까지 무재해 현장입니다. 제가 여러 현장에서 근무해 보았지만, 아쉽게도 무재해현장을 해보지 못했어요. 이번에는 꼭~ 무재해현장을 달성하겠습니다. 그리고 앞서 말했던 바와 같이 입주자 점검 시 고객들의 좋은 평가를 받는, 하자율 최소화의 현장을 위해 노력하고 있습니다. CS기준보다 좀더 획기적으로 낮은 하자율을 목표로 하고 있습니다. 그리고 2018년에도 COPQ활동을 적극적으로 추진할 계획이구요 <br>개인적으로는 현장 생활에 적응을 잘했는지 매우 왕성하게 먹는 데다가, 규칙적으로 운동하기가 어려운 탓에 체중이 조금~~ 많이 불었습니다. 게다가 슬슬 체력이 달린다는 느낌도 드네요. 건강관리에 매진하는 한 해가 되겠습니다.</p>
						</div>
						<div class="col-md-3 ta-c">
							<p><img src="../img/insight/img07.jpg" alt=""></p>
						</div>
					</div>
					<div class="row mt10 mt-991">
						<div class="col-md-9">
							<p><span class="name">김영의 과장 :</span> 이번 COPQ 활동을 통해서 밀린 숙제를 해낸 느낌인데요, 그런 만큼 자세한 히스토리로 남겨 후배들과 공유하는 것이 2018년의 또 하나의 숙제이자 계획입니다. 그리고 개인적인 새해소망이 있어요. 제가 반도체 현장에 4년동안 근무하다 보니 그동안 주말에만 집에 갔는데요. TV광고에서 ‘아빠~ 또 놀러와!’하는 상황이 저에게도 벌어졌더라구요. 집에 방이 3개인데, 엄마방, 아들방, 딸방으로 구분되어 있고, 아들 왈 ‘아빠방은 청주에 있잖아’라는 말을 듣고야 말았네요. 2018년에는 꼭~ 제 집의 재산권을 자녀들로부터 인정 받는 한 해가 되도록 노력하겠습니다.</p>
						</div>
						<div class="col-md-3 ta-c">
							<p><img src="../img/insight/img08.jpg" alt=""></p>
						</div>
					</div>
					<div class="row mt10 mb100 mt-991">
						<div class="col-md-9">
							<p><span class="name">조진식 부장 :</span> 사실 되게 어려운 과제죠. 프로젝트랑 주어진 리소스 내에서 스케쥴을 지켜내야 하는 건데, 거기에 품질은 더하는 과제인 거죠. 주어진 리소스와 스케쥴 내에서 끝내는 것만이 목적이 아닌, 거기에 더 좋게, 더 예쁜 모습으로 개선하는 일이 쉽지 않아요. 이걸 왜 해야 하는가?에 대한 인식의 틀을 깬다면 그 다음 성과는 나게 마련이죠. 앞으로는 사내에서 늘 해야 한다고 생각했고, 꼭 필요하다고 생각했지만 제대로 해내지 못했던 COPQ 활동이 연속성을 갖고 정착해야 한다고 생각해요. 저는 11월에 사우디에서 돌아왔고, 크리스마스가 지난 후(취재일 기준) 쿠웨이트로 가 CFP현장 PM대행을 맡게 됩니다. JAZAN 현장의 COPQ는 현장의 남아 있는 팀원들이 잘 하리라 생각합니다. <br>저의 새해소망이라면 쿠웨이트 CFP현장을 잘 마무리해서 2018년 12월에 무사히 종료하는 거구요, 2018년은 어쩔 수 없이 가족들의 양보와 배려를 부탁해야 하는 입장이에요. 어떤 이는 주말부부가 힘들다고 하지만, 4개월 부부인 제게 주말부부는 거의 소원의 수준이지만, 넉 달에 한 번씩 주어지는 휴가기간 만이라도 아내와 아이들에게 충실한 시간을 보내겠습니다.</p>
						</div>
						<div class="col-md-3 ta-c">
							<p><img src="../img/insight/img09.jpg" alt=""></p>
						</div>
					</div>
				</div>
			</div>

			<p><img src="../img/insight/img10.jpg" alt=""></p>

			<div class="bg-04 bd02">
				<div class="container">
					<div class="row">
						<div class="col-md-12 mt50 mb35 ta-c">
							<p><img src="../img/insight/tit02.jpg" alt=""></p>
						</div>
					</div>
				</div>
			</div>
			<div class="bg-04">
				<div class="container">
					<div class="row">
						<div class="col-md-12 mt50">
							<p>COPQ! 결코 만만한 도전이 아니다. 언뜻 눈에 보이지 않는 것들을 찾아내어 그것을 눈에 보이는 성과로 만들어내는 일이 어디 쉽겠는가? 거창하고 근사해 보이지도 않는 작은 것들을 모아모아 태산을 만드는 작업이 아닌가? 그러나 분명한 것은 그 어떤 거창한 성과도 지금 당장, 작은 것 하나를 실천한 것에서 시작되었다는 것이다. COPQ 우수 사례 인터뷰에 응해주신 구성원 3인방은 COPQ를 통해 스스로 느끼고 배운 것이 더 많았다고 입을 모았다. 2017년에 이어서 2018년에도 COPQ는 우리 회사 현장 곳곳에 뿌리내릴 것이 기대된다.</p>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 mt70 mb50 mt-991">
							<div class="box-wrap">
								<p class="title"><img src="../img/insight/tit03.png" alt=""></p>
								<div class="box">
									<ul>
										<li class="mb45">
											<p class="month"><span>3월</span><img src="../img/insight/img_new.jpg" alt="">&nbsp;&nbsp;COPQ 관리체계 운영</p>
											<ul class="con">
												<li>[적용범위 확대] Construction 단계  EPCC 전 단계의 Rework 관리</li>
												<li>체계적 개선 프로세스 구축</li>
											</ul>
										</li>
										<li class="mb60">
											<p class="month"><span>4월</span>COPQ 관리체계 설명회 실시</p>
											<ul class="con">
												<li>총 32개 팀, 90개 PJT 대상</li>
											</ul>
										</li>
										<li class="mb45">
											<p class="month"><span>5월</span>본격 COPQ 개선 Start!</p>
											<ul class="con">
												<li>127개의 개선과제 선정</li>
												<li>704명의 구성원 개선활동 실시</li>
											</ul>
										</li>
										<li class="mb55">
											<p class="month"><span>8월</span>COPQ 운영조직 결성</p>
											<ul class="con">
												<li>COPQ Control Board [사무국, Committee, 운영센터]로 구성</li>
											</ul>
										</li>
										<li class="mb45">
											<p class="month"><span>9월</span>COPQ 개선과제 Leader <br>개선역량 강화과정 실시</p>
											<ul class="con">
												<li>69명의 리더 대상 효과적 COPQ 개선활동을 위한 역량강화 교육</li>
											</ul>
										</li>
										<li class="mb50">
											<p class="month"><span>11월</span>COPQ 개선 우수사례 전시회</p>
											<ul class="con">
												<li>COPQ 개선 우수사례 13개(14팀) 공유 및 투표 실시</li>
												<li>개선사례 투표에 총 1,051명의 구성원 참여</li>
											</ul>
										</li>
										<li>
											<p class="month"><span>12월</span>COPQ 개선 우수사례 발표회</p>
											<ul class="con">
												<li>COPQ 개선 우수사례 13개 발표 실시</li>
												<li>품질혁신상(1팀), 품질개선상(5팀), <br>품질실천상(14팀, 전시회 참여팀 전원)</li>
											</ul>
										</li>
									</ul>
								</div>
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
	var currentMenu = 1;
</script>

</body>
</html>
