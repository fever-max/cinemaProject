<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"%>
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
<title>영화 스케줄</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/schedule.css"/>


<script type="text/javascript">

let movieName;
let theaterLocal;
let theaterDay;
let theaterTime;

//극장 선택시 해당 극장 정보 출력 

function loadMovies(local) {
		//비동기적 호출 가능한 XMLHttpRequest(); 객체
	    const xhttp = new XMLHttpRequest();
		
		//전역변수에 저장
		theaterLocal = local;

	  
	  //(콜백) 네트워크 서버가 정상적으로 연결되면 
	    xhttp.onreadystatechange = function() {
	        if (this.readyState == 4 && this.status == 200) {
	        	//JSON으로 바꿔서 displayTheaters 함수로 전달
	            const movies = JSON.parse(this.responseText);
	        	
	            document.getElementById("movieList").innerHTML = '';

	            for (let i = 0; i < movies.length; i++) {
	                displayTheaterInfo(movies[i]);
	            }

	        
	        }
	    };
	
	    //// 서블릿 loadTheater로 theaterLocal를 넘김
	    xhttp.open("GET", "<%=cp%>/cinema/getMoives?theaterLocal=" + theaterLocal, true);
	    xhttp.send();
	}
	
	
function displayTheaterInfo(movie) {
	
    // 새로운 <div> 요소 생성
    const movieContainer = document.createElement('div');
    
    movieContainer.classList.add('movieSub');

    // <p> 요소를 생성하고 텍스트 콘텐츠를 설정하여 정보 추가
    const movieNameParagraph = document.createElement('p');
    movieNameParagraph.textContent = '영화명: ' + movie.movieName;
    movieContainer.appendChild(movieNameParagraph);

    const theaterDayParagraph = document.createElement('p');
    theaterDayParagraph.textContent = '상영일: ' + movie.theaterDay;
    movieContainer.appendChild(theaterDayParagraph);

    const theaterTimeParagraph = document.createElement('p');
    theaterTimeParagraph.textContent = '상영시간: ' + movie.theaterTime;
    movieContainer.appendChild(theaterTimeParagraph);

    const theaterFullSeatsParagraph = document.createElement('p');
    theaterFullSeatsParagraph.textContent = '전체좌석: ' + movie.theaterFullSeats;
    movieContainer.appendChild(theaterFullSeatsParagraph);

    const theaterNowSeatsParagraph = document.createElement('p');
    theaterNowSeatsParagraph.textContent = '현재좌석: ' + movie.theaterNowSeats;
    movieContainer.appendChild(theaterNowSeatsParagraph);
    
 	// 클릭시 좌석 선택 페이지로 이동
    movieContainer.addEventListener('click', function() {
    	
    	//로그인 정보
    	var customInfo = <%= request.getAttribute("customInfoJson") %>;

    	
        //전역 변수에 값 영화정보 추가
        movieName = movie.movieName;
        theaterDay = movie.theaterDay;
        theaterTime = movie.theaterTime;
        
        if (!customInfo) {
       	 const userResponse = confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
            
            if (userResponse) {
                window.location.href = "<%=cp %>/cinema/userLogin";
            }
        } else {
        	window.location.href = "<%=cp%>/cinema/seatBooking?movieName=" + movieName +
            "&theaterLocal=" + theaterLocal + "&theaterDay=" + theaterDay +
            "&theaterTime=" + theaterTime;
        }

        
    });


    // 생성한 HTML 요소를 화면에 추가
    document.getElementById("movieList").appendChild(movieContainer);
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
		
		
		<div class="slidebox">
			<input type="radio" name="slide" id="slide01" checked>
			<input type="radio" name="slide" id="slide02">
			<input type="radio" name="slide" id="slide03">
			<input type="radio" name="slide" id="slide04">
			<ul class="slidelist">
				<li class="slideitem">
					<div>
						<a><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/Picnic/0125/Picnic_1920420.jpg"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/DOGMAN/0118/DOGMAN_1920420.jpg"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/Sumikkogurashi/0124/Sumikkogurashi_1920420.jpg"></a>
					</div>
				</li>
				<li class="slideitem">
					<div>
						<a><img src="https://cf2.lottecinema.co.kr/lotte_image/2024/DOGMAN/0118/DOGMAN_1920420.jpg"></a>
					</div>
				</li>
			</ul>
		</div>

		<!-- 메인 -->
		<div id = "container">
		
			<div class="containerSub">
				<div class="movieLocal">
					<div class="movieListTitle">지역선택</div>
					<ul>
					<c:forEach var="theaterDTO" items="${theaterDTO}">
						<li class="local">
							<a href="javascript:void(0);" onclick="loadMovies('${theaterDTO.theaterLocal}')">
							&nbsp; ${theaterDTO.theaterLocal} &nbsp;|
							</a>
						</li>
					
					</c:forEach>
					</ul>
				</div>
				
				<div class="movieSchedule">
					<div class="movieListTitle">상영 스케줄</div>
					<div id = "movieList">
						<div id = "listMessage">지역을 선택하세요.</div>
					
					</div>
				</div>


		
			
		</div>
		
		<!-- 선택값 숨겨서 좌석 선택 페이지로 전달 -->
		<form name="bookingForm" action="" method="post">
		    <input type="hidden" name="movieName" id="movieName" value="">
			<input type="hidden" name="theaterLocal" id="theaterLocal" value="">
			<input type="hidden" name="theaterDay" id="theaterDay" value="">
			<input type="hidden" name="theaterTime" id="theaterTime" value="">
		</form>	
		
		
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
	
	
	
	</div>
</body>
</html>