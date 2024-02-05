<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
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
<title>영화 사이트</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/movieChart.css"/>


<!-- Swiper CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>

<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function () {
    var swiper = new Swiper('.movie-slider', {
        slidesPerView: 4,
        slidesPerGroup: 4,  // 한 번에 이동할 슬라이드 수
        slidesPerGroupSkip: 4,  // 슬라이드 그룹 사이의 간격
        spaceBetween: 20,
        /* navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        }, */
    });
});
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
						<a href="<%=cp%>/cinema/booking" class="menuTitle">예매</a>
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
		<!-- 메인 영화 홍보 빅포스터 -->
		
		<div id = "mainBack">
			<div id = "mainContent">
				<div id = "bigPost">
					<video autoplay="" muted="">
		        		<source src="https://adimg.cgv.co.kr/images/202401/dogman/0123_Dogman_main_1080x608.mp4" type="video/mp4">        
		        	</video>
		        	
					<strong class="bigPostTitle">도그맨</strong>
					<strong class="bigPostContent">불행이 있는 곳마다 <br/> 신은 개를 보낸다.</strong>
					<div class="bigPostSelect">
						<a href="<%=cp%>/cinema/movieDetail?movieno=3" class="bigPostBtn">상세보기</a>
					</div>
				</div>
			</div>
		</div>
		

		<!-- 무비차트 -->
        <div id="movieAllChart">
            <div class="movieAllDiv">
            	<div class="movieAllTitleList">
            		<div class="movieAllTitle">무비 차트</div>
            		<a href="<%=cp%>/cinema/movieAll">
           		   	 <div class="movieAllTitle2"><span>전체보기 ></span></div>
           		   	</a>
            	</div>
                <!-- 슬라이드 컨테이너 -->
                <div class="swiper-container movie-slider">
                    <div class="swiper-wrapper">
                        <!-- 각각의 슬라이드 -->
                        <c:forEach items="${moivelists}" var="dto" varStatus="status">
                            <div class="swiper-slide">
                                <div class="movie-card">
                                    <!-- 영화 순위 -->
                                    <div class="movie-ranking">
                                        <b>NO.${status.index + 1}</b>
                                    </div>
                                    <!-- 영화 포스터 -->
                                    <div class="movie-poster">
     								
                                            <img src="${dto.moiveImage}" alt="${dto.movieName}" />
 
                                        <c:choose>
                                            <c:when test="${dto.moiveAge2 == 'ALL'}">
                                                <div class="age-rating"><b>ALL</b></div>
                                            </c:when>
                                            <c:when test="${dto.moiveAge2 == '15'}">
                                                <div class="age-orange"><b>15</b></div>
                                            </c:when>
                                            <c:when test="${dto.moiveAge2 == '19'}">
                                                <div class="age-red"><b>19</b></div>
                                            </c:when>
                                            <c:when test="${dto.moiveAge2 == '12'}">
                                                <div class="age-yellow"><b>12</b></div>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                    <!-- 영화 내용 -->
                                    <div class="movie-content">
                                        <h3 class="movie-title">${dto.movieName}</h3>
                                        <div class="movie-info">
                                            <span class="movie-rating">예매율 ${dto.moiveScore}%</span>
                                        </div>
                                        <a href="movieDetail?movieno=${dto.movieNo}">
                                        	<div class="movie-button2">상세보기</div>
                                        </a>
                                        <a href="<%=cp%>/cinema/booking">
                                        	<div class="movie-button">예매하기</div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <!-- Swiper 내비게이션 버튼 -->
                        
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 영화관 정보 -->
        
        <div id = "CinemaChart">
			<div class="movieAllTitle">영화관</div>
			<div class="cinemaDiv">
			<div class="slidebox">
			<input type="radio" name="slide" id="slide01" checked>
			<input type="radio" name="slide" id="slide02">
			<input type="radio" name="slide" id="slide03">
			<input type="radio" name="slide" id="slide04">
			<ul class="slidelist">
				<li class="slideitem">
					<div>
						<a><img src="https://img.cgv.co.kr//Front/Main/2021/1209/16390080561620.png"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://img.cgv.co.kr//Front/Main/2022/0616/16553622935690.png"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://img.cgv.co.kr//Front/Main/2021/1130/16382612660240.png"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://img.cgv.co.kr//Front/Main/2021/1130/16382612660560.png"></a>
					</div>
				</li>
			</ul>
		</div>
			
			</div>
		</div>
		
		
		<!-- 스토어 정보 -->
		
		<div id = "storeChart">
			<div class="movieAllTitle">스토어</div>
			<div class="storeDiv">
			<div class="storeDivSub">
				<div class="storeDivSubject">
				
					<span class="subjectTitle">매점</span>
					<a href="<%=cp%>/cinema/cinemaStore.do">
						<span class="subjectSub">더보기</span>
					</a>
				</div>
			
			<c:forEach var="dto" items="${lists2}">
				<div class="storeDivItem">
				<a href="<%=cp %>/cinema/productDetail.do?productNo=${dto.productNo}">
					<div class="storeDivItem1">
		               <a href="<%=cp %>/cinema/productDetail.do?productNo=${dto.productNo}">
		                   <img src="${imagePath}/${dto.saveFileName}" width="180" height="180" />
		               
	                </div>
	                
	                <div class="storeDivItem2">
	              		<p class="storeDivItemName">${dto.productName}</p>
	                	<p>${dto.productPrice}원</p>
	                </div>   
	             </a>
	             </div>

            </c:forEach>
			
			
			</div>
			
			<div class="storeDivSub">
				<div class="storeDivSubject">
					<span class="subjectTitle">상영권</span>
					<a href="<%=cp%>/cinema/cinemaTicket.do">
						<span class="subjectSub">더보기</span>
					</a>
				</div>
			
			<c:forEach var="dto" items="${lists}">
				<div class="storeDivItem">
				<a href="<%=cp %>/cinema/productDetail.do?productNo=${dto.productNo}">
					<div class="storeDivItem1">
		               <a href="<%=cp %>/cinema/productDetail.do?productNo=${dto.productNo}">
		                   <img src="${imagePath}/${dto.saveFileName}" width="180" height="180" />
		               
	                </div>
	                
	                <div class="storeDivItem2">
	              		<p class="storeDivItemName">${dto.productName}</p>
	                	<p>${dto.productPrice}원</p>
	                </div>   
	             </a>
	             </div>

            </c:forEach>
			
			
			</div>

             </div>
		</div>
		
		
	</main>
	
	<center>
            <a href="">
                <img src="https://adimg.cgv.co.kr/images/202401/dogman/0122_980x80.jpg" alt="" border="0" width="980" height="100">
            </a>
	</center>
	
	
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