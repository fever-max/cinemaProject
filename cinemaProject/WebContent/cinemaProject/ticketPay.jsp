<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//한글을 깨지지 않게
	request.setCharacterEncoding("UTF-8");
	//스터디까지의 주소
    String cp = request.getContextPath();
    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 결제</title>

<!-- 결제모듈 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/booking.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/ticketPay.css"/>

<script type="text/javascript">

	function sendIt() {
		const f = document.bookingForm;
		f.action = "<%=cp%>/cinema/okPay";
		
		f.submit();
	}
	
	
	//결제 모듈
	const IMP = window.IMP;
	IMP.init("imp72611382");   /* imp~ : 가맹점 식별코드*/
	let movieName = '${param.movieName}';
	let theaterLocal = '${param.theaterLocal}';
    let ticketPrice = '${param.ticketPrice}';
    let userName = '${userName }';
    let movieTicket = "";
    
	
    function ticketPay() {
        console.log('결제 시작');

        // IMP 객체를 사용하여 결제를 요청
        IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: new Date().getTime(), //임의 번호 부여
            name:  movieName + '/' + theaterLocal + '점',
            amount: ticketPrice,
            buyer_email: '',
            buyer_name: userName,
        }, function(rsp) {
            // 결제 응답 처리 함수 체크 
            console.log(rsp);

            // 결제 성공 시
            if (rsp.success) {
                console.log("결제 성공 ");
                
                //merchant_uid 값 폼에 저장 (예매번호로 씀)
                document.getElementById("movieTicket").value = rsp.merchant_uid;
                
                //기존 샌드잇으로 이동해서 완료 페이지로
                sendIt();

            } else {
                // 결제 실패 시
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
            }
        });
    }
</script>

</head>
<body>
	<header>
		<!-- 상단 -->
		<div class="header">
		
			<div id="logo">
				<a href="<%=cp%>/cinema/main">
					<img src="https://i.ibb.co/7KRHbzJ/2024-01-26-173816-removebg-preview-1.png" alt="CGV">
				</a>
			</div>
			<ul class="memberInfo">
			    <li>
			        <c:choose>
			            <c:when test="${empty sessionScope.customInfo}">
			                <!-- 세션이 없으면(로그아웃 상태) -->
			                <a href="<%=cp%>/cinema/userLogin">
			                    <img src="https://img.cgv.co.kr/R2014/images/common/ico/loginPassword.png" alt="로그인">
			                </a>
			                <span>${me}</span>
			            </c:when>
			            <c:otherwise>
			                <!-- 세션이 있으면(로그인 상태) -->
			                <a href="<%=cp%>/cinema/logout">
			                    <img src="https://img.cgv.co.kr/R2014/images/common/ico/loginPassword.png" alt="로그아웃">
			                </a>
			                <span>${me}</span>
			            </c:otherwise>
			        </c:choose>
			    </li>
			
			    <!-- 회원가입 부분 수정 -->
			    <c:if test="${empty sessionScope.customInfo}">
			        <li>
			            <a href="<%=cp%>/cinema/userCreate">
			                <img src="https://img.cgv.co.kr/R2014/images/common/ico/loginJoin.png" alt="회원가입">
			            </a>
			            <span>회원가입</span>
			        </li>
			    </c:if>
			
			    <li>
			        <!-- My Cinema 부분 수정 -->
			        <c:choose>
			            <c:when test="${empty sessionScope.customInfo}">
			                <!-- 세션이 없으면(로그인 페이지로) -->
			                <a href="<%=cp%>/cinema/userLogin">
			                    <img src="https://img.cgv.co.kr/R2014/images/common/ico/loginMember.png" alt="My Cinema">
			                </a>
			                <span>My Cinema</span>
			            </c:when>
			            <c:otherwise>
			                <!-- 세션이 있으면(로그인 상태) -->
			                <a href="<%=cp%>/cinema/myCinema">
			                    <img src="https://img.cgv.co.kr/R2014/images/common/ico/loginMember.png" alt="My Cinema">
			                </a>
			                <span>My Cinema</span>
			            </c:otherwise>
			        </c:choose>
			    </li>
			</ul>
		
		
			<!-- 서비스메뉴 -->
			<div class="nav">
				<ul class="menu">
					<li>
						<a href="<%=cp%>/cinema/movieAll" class="menuTitle">영화</a>
						<ul class="submenu">
							<li><a href="<%=cp%>/cinema/movieAll">상영중영화</a></li>
							<li><a href="#">개봉예정영화</a></li>
						</ul>
					</li>
					<li>
						<a href="<%=cp%>/cinema/booking" class="menuTitle" style="color: #FF4357">예매</a>
						<ul class="submenu">
							<li><a href="<%=cp%>/cinema/booking">빠른예매</a></li>
							<li><a href="<%=cp%>/cinema/schedule">상영스케줄</a></li>
						</ul>
						
					</li>
					<li>
						<a href="<%=cp%>/cinemaProject/inputStore.jsp" class="menuTitle">스토어</a>
						<ul class="submenu">
							<li><a href="<%=cp%>/cinema/cinemaStore.do">매점</a></li>
							<li><a href="<%=cp%>/cinema/cinemaTicket.do">상영권</a></li>
						</ul>
						
					</li>
				</ul>
			</div>
		</div>
	</header>
	<main id = "movieContainer">
		<!-- 메인 -->
		<div id="container">
		<div class="containerTicket">
			<div id="navi">
				<span><a href="<%=cp%>/cinema/booking">다시 예매하기</a></span>
			</div>
			<div class="steps">
				<!-- 예매내역확인 -->
				<div class="stepsContent">
					<div class="stepsContentHeader">예매내역 확인</div>
					<div class="stepsContentBody">
						<div class="stepsContentBody1">
							
							<div class="subName">영화 정보</div>
							<div class="movieText">
								<div><img src="${movieDTO.moiveImage }" class="movieImg"></a></div>
								<div class="movieTextSub">
									<p>영화명: <b>${param.movieName}</b></p>
									<p>극장: <b>${param.theaterLocal}</b></p>
									<p>일시: <b>${param.theaterDay}</b></p>
									<p>시간: <b>${param.theaterTime}</b></p>
									<p>인원: <b>${param.theaterPerson}</b></p>
									<p>좌석: <b>${param.theaterTicket}</b></p>
								</div>
							</div>
						</div>
						<div class="stepsContentBody1">
							<div class="subName">결제 정보</div>
							<div class="subBody">
								<div class="movieText">
									<div class="moviePay">
										<div>결제금액: <b>${param.ticketPrice }원</b></div>
										<div>결제수단: </div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="ticketBox">
						<div class="ticketPay" id="ticketPay" onclick="ticketPay();">
							결제하기
						</div>
						<a href="<%=cp%>/cinema/main">
							<div class="ticketCancle">
								취소
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
		</div>
		<!-- 선택값 숨겨서 전달 -->
		<form name="bookingForm" action="" method="post">
		    <input type="hidden" name="movieName" id="movieName" value="${param.movieName}">
		    <input type="hidden" name="theaterNo" id="theaterNo" value="${theaterNo}">
			<input type="hidden" name="theaterLocal" id="theaterLocal" value="${param.theaterLocal}">
			<input type="hidden" name="theaterDay" id="theaterDay" value=" ${param.theaterDay}">
			<input type="hidden" name="theaterTime" id="theaterTime" value="${param.theaterTime}">
			<input type="hidden" name="theaterPerson" id="theaterPerson" value="${param.theaterPerson}">
			<input type="hidden" name="theaterTicket" id="theaterTicket" value="${param.theaterTicket}">
			<input type="hidden" name="movieTicket" id="movieTicket" value="">
			<input type="hidden" name="moiveImage" id="moiveImage" value="${movieDTO.moiveImage }">
			<input type="hidden" name="ticketPrice" id="ticketPrice" value="${param.ticketPrice}">
		</form>	
		
		
		
	</main>
	<footer>
		<!-- 하단 -->
		<article class="company_info_wrap">
  	 	 <section class="company_info">
       	 <dt>(06234) 서울특별시 강남구 테헤란로 124 4층 아이티윌 </dt>
       	 <dl class="company_info_list">
            <dt>3조 </dt>
            	<dd>이재완 박기범 이혜민 김석현</dd>
            <dt>사업자등록번호</dt>
            	<dd>2024-01-27</dd>
            <dt>통신판매업신고번호</dt>
            	<dd>0123456789</dd>
       	 </dl>
       	 <p class="copyright">© 아이티윌 자바 148기 Rights Reserved</p>
   		 </section>
		</article>
	</footer>
</body>
</html>
