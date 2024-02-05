
<%@ page import="com.google.gson.Gson" %>
<%@page import="java.util.List"%>
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
<title>좌석 예매</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/booking.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/seatBooking.css"/>

<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script type="text/javascript">


//티켓가격 (고정)
const ticketPrice = 100;

//정보 페이지 (가격x인원=총합)
function updateSelectedInfo() {
    const CkTheaterElement = document.getElementById("CkTheater");
    const CkDateElement = document.getElementById("CkDate");
    const CkTimeElement = document.getElementById("CkTime");

    CkTheaterElement.textContent = ticketPrice + "원";
    CkDateElement.textContent = selectedPersonCount + "명";

    // 총 금액 계산
    const totalAmount = selectedPersonCount * ticketPrice;
    CkTimeElement.textContent = totalAmount + "원";
}

//로딩시 예약 정보 json 받아옴
document.addEventListener("DOMContentLoaded", function () {
    var jsonBooking = '${jsonBooking}';
    var bookingDTO = JSON.parse(jsonBooking);

    //console.log("예매된 좌석 정보:", bookingDTO);

    // 예약된 좌석 비활성화 함수 호출
    disableBookedSeats(bookingDTO);
});

//예약된 좌석 비활성화 함수
function disableBookedSeats(bookingDTO) {
    var bookedSeats = document.querySelectorAll('.seat');

    // 각 예매된 좌석 번호를 확인하고 해당 좌석을 비활성화 처리
    bookingDTO.forEach(function (booking) {
    	//, 로 저장된 거 분리해서 각각 실행
        var bookedSeatNumbers = booking.theaterTicket.split(',').map(Number);

        bookedSeats.forEach(function (seat) {
            var seatNumber = parseInt(seat.dataset.count);

            if (bookedSeatNumbers.includes(seatNumber)) {
                console.log("Disabling seat:", seatNumber);
                seat.classList.add('booked');
                
            }
        });
    });
}




//선택값 저장 전역변수
let selectedPersonCount = null;
let seatNo = []; 

// 선택인원 저장
document.addEventListener("DOMContentLoaded", function () {
    const selectPerson = document.getElementById("selectPerson");

    selectPerson.addEventListener("click", function (event) {
        // 클릭된 요소가 li인지 확인
        if (event.target.tagName.toLowerCase() === "li") {
            // 전역변수에 저장
            selectedPersonCount = parseInt(event.target.dataset.count);

            // 모든 항목의 selected 클래스 제거
            let allItems = selectPerson.querySelectorAll("li");
            allItems.forEach(function (item) {
                item.classList.remove("selected");
            });

            // 선택된 항목에 selected 클래스 추가
            event.target.classList.add("selected");
            
            //선택변경되면 정보창도 변경
            updateSelectedInfo();

            console.log("선택된 예약 인원 수:", selectedPersonCount);
        }
    });
});


//선택좌석 저장
document.addEventListener("DOMContentLoaded", function () {
    const selectSeat = document.getElementById("selectSeat");

    selectSeat.addEventListener("click", function (event) {
        // 클릭된 요소가 seat인지 확인
        if (event.target.classList.contains("seat")) {
            // 예약된 좌석이면 클릭 무시
            if (event.target.classList.contains("booked")) {
                alert('이미 예매된 좌석입니다.');
                return;
            }

            let seatNumber = parseInt(event.target.dataset.count);

            // 선택하지 않은 상태에서 클릭한 경우
            if (selectedPersonCount === null) {
                alert("예약 인원을 선택해주세요.");
                return;
            }

            // 좌석이 이미 선택되어 있는지 확인
            const isSeatSelected = event.target.classList.contains("selected");

            // 선택된 좌석수가 선택된 인원을 초과하는지 확인
            if (!isSeatSelected && seatNo.length >= selectedPersonCount) {
                alert("선택 인원을 초과했습니다.");
                return;
            }

            // 선택좌석 토글
            if (isSeatSelected) {
                // 좌석이 이미 선택되어 있으면 "selected" 클래스 제거
                event.target.classList.remove("selected");

                // 배열에서 좌석 번호 제거
                seatNo = seatNo.filter(number => number !== seatNumber);
            } else {
                // 좌석이 선택되어 있지 않으면 "selected" 클래스 추가
                event.target.classList.add("selected");

                // 배열에 좌석 번호 추가
                seatNo.push(seatNumber);
            }

            //선택변경되면 정보창도 변경
            updateSelectedInfo();

            console.log("선택된 좌석번호:", seatNo);
        }
    });
});



	//결제 버튼
	function sendIt() {
		
	if (selectedPersonCount !== seatNo.length) {
		alert("관람인원과 선택 좌석 수가 일치하지 않습니다.");
		return;
	}	
		
	const f = document.bookingForm;
	f.action = "<%=cp%>/cinema/ticketPay";
	
	// 인풋값에 추가해서 전달
    f.querySelector("#theaterPerson").value = selectedPersonCount;
    f.querySelector("#theaterTicket").value = seatNo.join(","); // 배열을 문자열로 변환하여 넘겨줌
    f.querySelector("#ticketPrice").value = ticketPrice*selectedPersonCount;
	
	f.submit();
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
		<div id = "container">
			<div id ="navi">
				<span><a href="<%=cp%>/cinema/booking">다시 예매하기</a></span>
			</div>

			
			<div class="steps" >
			<!-- 좌석 선택창 -->
				<div class="stepsContent">
					<div class="stepsContentHeader" >인원/좌석</div>
	
					<div class="stepsContentBody">
					
						<div class="stepsContentBody1">
							<div class="stepsContentSub"> <h2> ${theaterDTO.theaterDay } ${theaterDTO.theaterTime } </h3></h3></div>
							<div class="stepsContentSub"> <h3> 영화이름: ${theaterDTO.movieName } / 영화관: ${theaterDTO.theaterLocal } </h3></div>
						</div>
						
						<div class="stepsContentBody2">
							<div class="stepsContentSub">전체좌석: ${theaterDTO.theaterFullSeats } / 남은좌석: ${theaterDTO.theaterNowSeats }</div>
						<div class="stepsContentSub">
								<div class="stepsContentSub1" id="selectPerson">
								<div>예매인원:</div>
								<ul>
								    <li data-count="1">1</li>
									<li data-count="2">2</li>
									<li data-count="3">3</li>
									<li data-count="4">4</li>
									<li data-count="5">5</li>
								</ul> 
								</div>
							</div>
							
							
						</div>
	
					</div>
					
					<div class="stepsCinema">
					
					<div id="selectSeat">
						<div id="screen">Screen</div>
						
						<div class="row">
			                <span class="seat" data-count="1">1</span>
			                <span class="seat" data-count="2">2</span>
			                <span class="seat" data-count="3">3</span>
			                <span class="seat" data-count="4">4</span>
			                <span class="seat" data-count="5">5</span>
			                <span class="seat" data-count="6">6</span>
			                <span class="seat" data-count="7">7</span>
			                <span class="seat" data-count="8">8</span>
           				 </div>
           				 
           				 <div class="row">
			                <span class="seat" data-count="9">9</span>
			                <span class="seat" data-count="10">10</span>
			                <span class="seat" data-count="11">11</span>
			                <span class="seat" data-count="12">12</span>
			                <span class="seat" data-count="13">13</span>
			                <span class="seat" data-count="14">14</span>
			                <span class="seat" data-count="15">15</span>
			                <span class="seat" data-count="16">16</span>
           				 </div>
           				 
           				 <div class="row">
			                <span class="seat" data-count="17">17</span>
			                <span class="seat" data-count="18" >18</span>
			                <span class="seat" data-count="19">19</span>
			                <span class="seat" data-count="20">20</span>
			                <span class="seat" data-count="21">21</span>
			                <span class="seat" data-count="22">22</span>
			                <span class="seat" data-count="23">23</span>
			                <span class="seat" data-count="24">24</span>
           				 </div>
           				 
           				 <div class="row">
						    <span class="seat" data-count="25">25</span>
						    <span class="seat" data-count="26">26</span>
						    <span class="seat" data-count="27">27</span>
						    <span class="seat" data-count="28">28</span>
						    <span class="seat" data-count="29">29</span>
						    <span class="seat" data-count="30">30</span>
						    <span class="seat" data-count="31">31</span>
						    <span class="seat" data-count="32">32</span>
						</div>
						
						<div class="row">
						    <span class="seat" data-count="33">33</span>
						    <span class="seat" data-count="34">34</span>
						    <span class="seat" data-count="35">35</span>
						    <span class="seat" data-count="36">36</span>
						    <span class="seat" data-count="37">37</span>
						    <span class="seat" data-count="38">38</span>
						    <span class="seat" data-count="39">39</span>
						    <span class="seat" data-count="40">40</span>
						</div>
           				 
					</div>
					
	
					</div>
		
				</div>
			
				
			</div>
			
			
			<!-- 정보 선택시 뜨는 정보들 -->
			<div class="selectMovieInfo">
			
				<div class="ticketCk">
					<div class="Ckitem">관람가격</div>
					<div id = "CkTheater"></div>
				</div>
				
				<div class="ticketCk">
					<div class="Ckitem">관람인원</div>
					<div id = "CkDate"></div>
				</div>
				
				<div class="ticketCk">
					<div class="Ckitem">총 금액</div>
					<div id = "CkTime"></div>
				</div>
				
				<div class="ticketCk">
					<div id="ticketStep" onclick="sendIt();">결제하기</div>
				</div>
			
			
			</div>
	
		</div>
		
	<!-- 선택값 숨겨서 전달 -->
	<form name="bookingForm" action="" method="post">
	    <input type="hidden" name="movieName" id="movieName" value="${theaterDTO.movieName }">
	    <input type="hidden" name="theaterNo" id="theaterNo" value="${theaterDTO.theaterNo }">
		<input type="hidden" name="theaterLocal" id="theaterLocal" value="${theaterDTO.theaterLocal }">
		<input type="hidden" name="theaterDay" id="theaterDay" value="${theaterDTO.theaterDay }">
		<input type="hidden" name="theaterTime" id="theaterTime" value="${theaterDTO.theaterTime }">
		<input type="hidden" name="theaterPerson" id="theaterPerson" value="">
		<input type="hidden" name="theaterTicket" id="theaterTicket" value="">
		<input type="hidden" name="ticketPrice" id="ticketPrice" value="">
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