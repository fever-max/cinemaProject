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
<title>My Cinema</title>

<script type="text/javascript">

function sendIt(bookingNo, userId, theaterPerson, theaterNo) {
    var confirmation = confirm('예매를 취소하시겠습니까?');
    if (confirmation) {
        // 확인 클릭시 이동
        var url = '<%=cp%>/cinema/deleteMovie?bookingNo=' + bookingNo + '&userId=' + userId + '&theaterPerson=' + theaterPerson + '&theaterNo=' + theaterNo;
        window.location.href = url;
    }
}


function openNewWindow(url) {
    // window.open 메서드를 사용하여 새 창을 엽니다.
	window.open(url, '_blank', 'width=643, height=519, resizable=yes, scrollbars=yes');
}



</script>


<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/myCinema.css"/>


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
						<a href="" class="menuTitle">영화</a>
						<ul class="submenu">
							<li><a href="<%=cp%>/cinema/movieAll">상영중영화</a></li>
							<li><a href="#">개봉예정영화</a></li>
						</ul>
					</li>
					<li>
						<a href="" class="menuTitle">예매</a>
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
		
		<div id="movieChart">
			<div class="myCinemaDiv">
			
				<div id="contaniner">	
				<div class="contaninerSub">
						
					<!-- 프로필 이미지 -->
					<div class="box-image">
						<span class="thumb-image">
							<img src="http://img.cgv.co.kr/R2014/images/common/default_profile.gif" alt="프로필사진">
						</span>
			        </div>
			        
			       <div id="person">
				        <!-- 회원정보 -->
				        <div class="person-info">
							<span class="personName">${userDTO.userName }님</span>
							<p class="personId">${userDTO.userId }</p>
							<span>회원정보 수정</span>
							<button type="button" class="btn" onclick="openNewWindow('<%=cp%>/cinemaProject/update.jsp');">나의 정보 변경</button>
						</div>
						<!-- 멤버쉽 등급 -->
						<div class="person-member">
							고객님 등급은 일반입니다.
						</div>
					</div>
				</div>
					
				</div>
				
				<!-- 예매내역 -->
				<div class="myTicket">
					<span class="myTicketTitle">My 예매내역</span>
					
							<c:forEach var="bookingDTO" items="${bookingDTO}">
							<div class="movieInfo">
								<div class="movieInfoSub">
									<img src="${bookingDTO.movieImg}" class="movieImg"></div>
									<div class="movieText">
										<span class="movieName">${bookingDTO.movieName}</span>
										<div class="movieInfoSub">
											<span>예매번호: ${bookingDTO.bookingNo}</span>
											<span>지점: ${bookingDTO.theaterLocal}점</span>
											<span>상영일시: ${bookingDTO.theaterDay} / ${bookingDTO.theaterTime}</span>
											<span>인원 및 좌석: ${bookingDTO.theaterPerson}인 / ${bookingDTO.theaterTicket}</span>
										</div>
										<div class="line"></div>
										<div class="movieInfo2">
										<span class="ticketPrice">총결제금액: <span class="ticketPriceColor">${bookingDTO.ticketPrice}</span></span>
										<a href="#" onclick="sendIt('${bookingDTO.bookingNo}', '${userDTO.userId}', '${bookingDTO.theaterPerson}', '${bookingDTO.theaterNo}');">
             							   <span class="cancle">예매 취소</span>
           								 </a>
										</div>
									</div>
								</div>
							</c:forEach>
							
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