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
<title>예매 완료</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/booking.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/ticketPay.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/okPay.css"/>

<script type="text/javascript">


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
	<main>
		<!-- 메인 -->
		<div id="container">
			<div class="containerTicket">
				<div id="navi">
					<span><a href="<%=cp%>/cinema/booking">다시 예매하기</a></span>
				</div>
				<div class="steps3">
					<div class="okTicket">
						<div class="okTicketTitle">${bookingDTO.userId } 님 예매가 완료 되었습니다.</div>
						
						<div class="okTicketBody">
							<div><img src="${moiveImage }" class="movieImg"></a></div>
							<div class="okTicketText">
								<div>예매번호: <b>${bookingDTO.bookingNo }</b></div>
								<div>영화명: <b>${bookingDTO.movieName }</b> </div>
								<div>상영관: <b>${bookingDTO.theaterLocal }</b> </div>
								<div>상영날짜: <b>${bookingDTO.theaterDay }</b> </div>
								<div>상영시간: <b>${bookingDTO.theaterTime }</b> </div>
								<div>예매좌석: <b>${bookingDTO.theaterTicket }</b> </div>
								<a href="<%=cp%>/cinema/myCinema">
									<div class="ckBtn">예매확인/취소</div>
								</a>
							</div>
						</div>
						
						<div>
							<div class="ckTicketTitle">예매 유의사항</div>
							<div class="ckTicketText">
								<p>영화 포인트는 익일 자정 자동 적립됩니다. (영화관람권, 포인트 사용 제외)</p>
								<p>영화 상영 스케줄은 영화관 사정에 의해 변경될 수 있습니다.</p>
							</div>
						
						
						</div>
					
					</div>

	
				</div>
			</div>
		</div>
	
		
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
