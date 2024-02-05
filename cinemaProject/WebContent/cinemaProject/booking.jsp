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
<title>영화 예매</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/booking.css"/>


<script type="text/javascript">



let movieNo;
let movieName;
let theaterLocal;
let theaterDay;
let theaterTime;


	// 1. 영화 선택 시 극장 정보 (AJAX) 사용
	function loadTheaters(no, name) {
		//비동기적 호출 가능한 XMLHttpRequest(); 객체
	    const xhttp = new XMLHttpRequest();
		
		//전역변수에 저장
		movieNo = no;
	    movieName = name;
	    
	    //폼에 극장 정보 저장
    	document.getElementById("movieName").value = movieName;
	    
	    displayMovieInfo();
	  
	  //(콜백) 네트워크 서버가 정상적으로 연결되면 
	    xhttp.onreadystatechange = function() {
	        if (this.readyState == 4 && this.status == 200) {
	        	//JSON으로 바꿔서 displayTheaters 함수로 전달
	            const theaters = JSON.parse(this.responseText);
	            displayTheaters(theaters);
	        }
	    };
	
	    //// 서블릿 loadTheaters로 moiveNo를 넘김
	    xhttp.open("GET", "<%=cp%>/cinema/loadTheaters?movieNo=" + movieNo, true);
	    xhttp.send();
	}


    // 1-1. 극장 정보 출력
    function displayTheaters(theaters) {

    	
    	//설정해둔 ul 아이디 갖고옴
        const theaterList = document.getElementById("theaterList");
        theaterList.innerHTML = "";  //값이 있다면 비워둠
        
        //받은 json을 순서대로 출력
        for (let i = 0; i < theaters.length; i++) {
            let theaterDTO = theaters[i];
            //console.log(theaterDTO);
            
            //li를 만들어서 관 이름 출력
            const li = document.createElement("li");
            li.textContent = theaterDTO.theaterLocal;
            
            //순서대로 붙여서 나옴
            theaterList.appendChild(li);
            
        	//클릭시 실행하는 함수 설정
        	//클릭시 함수로 theaterDTO 정보 전달
            li.onclick = clickTheater(theaterDTO);
         
        }
    }
    
    // 1-2. 극장 클릭시 실행 함수
    function clickTheater(theaterDTO) {
        return function() {
        	// 극장을 클릭할 때 영화관 정보 전역변수로 전달
        	// 이후 loadDates 함수로 전달
        	theaterLocal = theaterDTO.theaterLocal;
            loadDates(theaterDTO.theaterLocal);
            
            //폼에 정보 저장
            document.getElementById("theaterLocal").value = theaterLocal;
            
            displayMovieInfo();
        };
    }
    
    //2. 극장 선택 시 날짜 정보 (AJAX)
    function loadDates(local) {
        const xhttp = new XMLHttpRequest();
        
      //전역변수에 저장
		theaterLocal = local;

        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                const dates = JSON.parse(this.responseText);
                displayDates(dates);
            }
        };

        // 극장정보를 서블릿 loadDates로 전달
        xhttp.open("GET", "<%=cp%>/cinema/loadDates?theaterLocal=" + theaterLocal + "&movieName=" + movieName, true);
        xhttp.send();
    }
    
    //2-1. 날짜 정보 출력
    function displayDates(dates) {
    	
    	//설정해둔 ul 아이디 갖고옴
        const theaterList = document.getElementById("theaterDate");
        theaterList.innerHTML = "";  //값이 있다면 비워둠
        
        //받은 json을 순서대로 출력
        for (let i = 0; i < dates.length; i++) {
            let theaterDTO = dates[i];
            //console.log(theaterDTO);
            
            //li를 만들어서 관 이름 출력
            const li = document.createElement("li");
            li.textContent = theaterDTO.theaterDay;
            
            //순서대로 붙여서 나옴
            theaterList.appendChild(li);
            
        	//클릭시 함수로 theaterDTO 정보 전달
            li.onclick = clickDate(theaterDTO);
         
        }
    }
    
 	// 2-2. 날짜 클릭시 실행 함수
    function clickDate(theaterDTO) {
        return function() {
        	// 날짜를 클릭할 때 시간 정보를 전달
            theaterDay = theaterDTO.theaterDay;
            loadTime(theaterDTO.theaterDay);
            
            //날짜 폼에 저장
            document.getElementById("theaterDay").value = theaterDay;
            
            displayMovieInfo();
        };
    }
 	
  //3. 날짜 선택 시 시간 정보 (AJAX)
    function loadTime(day) {
        const xhttp = new XMLHttpRequest();
        
     	 //전역변수에 저장
		theaterDay = day;

        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                const times = JSON.parse(this.responseText);
                displayTimes(times);
            }
        };

        // 극장정보를 서블릿 loadTimes로 전달
        xhttp.open("GET", "<%=cp%>/cinema/loadTimes?theaterLocal=" + theaterLocal + "&movieName=" + movieName + "&theaterDay=" + theaterDay, true);
        xhttp.send();
    }
  
  //3-1.시간정보 출력
  function displayTimes(times) {
    	
    	//설정해둔 ul 아이디 갖고옴
        const theaterList = document.getElementById("theaterTime");
        theaterList.innerHTML = "";  //값이 있다면 비워둠
        
        //받은 json을 순서대로 출력
        for (let i = 0; i < times.length; i++) {
            let theaterDTO = times[i];
            
            //li를 만들어서 관 이름 출력
            const li = document.createElement("li");
            li.textContent = theaterDTO.theaterTime;
            
            //순서대로 붙여서 나옴
            theaterList.appendChild(li);
            
          //클릭시 함수로 theaterDTO 정보 전달
           li.onclick = clickTime(theaterDTO);
            
        
        }
    }
  
  //3-2.시간 클릭시 실행 함수
  function clickTime(theaterDTO) {
        return function() {
            // 시간을 클릭할 때 시간정보를 전역변수에 저장
            theaterTime = theaterDTO.theaterTime;
            loadCk(theaterDTO.theaterTime);
            displayMovieInfo();
        };
    }
  
  //4. 전체정보 서블릿 전달
  function loadCk(time) {
        const xhttp = new XMLHttpRequest();
        
     	 //전역변수에 저장
		theaterTime = time;

        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                const times = JSON.parse(this.responseText);
                displayCk(times);
                
            }
        };

        // 극장정보를 서블릿 loadTimes로 전달
        xhttp.open("GET", "<%=cp%>/cinema/loadCk?theaterLocal=" + theaterLocal + "&movieName=" + movieName + "&theaterDay=" + theaterDay + "&theaterTime=" + theaterTime, true);
        xhttp.send();
    }
  
  //4-1. 전체정보 선택값 히든 인풋에 저장
  function displayCk(times) {
	  
	// 선택된 정보를 폼에도 저장
	//document.getElementById("movieName").value = movieName;
	//document.getElementById("theaterLocal").value = theaterLocal;
	//document.getElementById("theaterDay").value = theaterDay;
	
	// 이상하게 타임만 아이디로 안돼서 네임으로 갖고옴
	const theaterTimeElements = document.getElementsByName("theaterTime");

	// 배열에서 첫 번째 요소를 선택하여 값을 설정 (네임은 배열로 반환함)
	if (theaterTimeElements.length > 0) {
	    theaterTimeElements[0].value = theaterTime;
	}
	
	console.log("Selected Movie: " + movieName);
    console.log("Selected Theater: " + theaterLocal);
    console.log("Selected Date: " + theaterDay);
    console.log("Selected Time: " + theaterTime);
  
	
	}

  
  //영화 정보 전달 (맨아래에 뜨게)
 function displayMovieInfo () {
	  
	 const CkmovieName = document.getElementById("CkmovieName");
	 const CkTheater = document.getElementById("CkTheater");
	 const CkDate = document.getElementById("CkDate");
	 const CkTime = document.getElementById("CkTime");
	 
	 //html에 텍스트 추가
	 CkmovieName.textContent = movieName;
	 CkTheater.textContent = theaterLocal;
	 CkDate.textContent = theaterDay;
	 CkTime.textContent = theaterTime;
	 
	  
  }
  
  
 var customInfo = <%= request.getAttribute("customInfoJson") %>;

 function sendIt() {
     const f = document.bookingForm;
     f.action = "<%=cp%>/cinema/seatBooking";
     
     
     console.log("Movie Name: " + f.movieName.value);
     console.log("Theater Local: " + f.theaterLocal.value);
     console.log("Theater Day: " + f.theaterDay.value);
     console.log("Theater Time: " + f.theaterTime.value);
     
     
     //값 선택을 안하면
	if (!f.movieName.value) {
    alert("영화를 선택하세요.");
    return;
	}

	if (!f.theaterLocal.value) {
	    alert("극장을 선택하세요.");
	    return;
	}
	
	if (!f.theaterDay.value) {
	    alert("날짜를 선택하세요.");
	    return;
	}
	
	if (!f.theaterTime.value) {
	    alert("시간을 선택하세요.");
	    return;
	}
     
     
     //로그인이 안 되어있으면
     if (!customInfo) {
    	 const userResponse = confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
         
         if (userResponse) {
             window.location.href = "<%=cp %>/cinema/userLogin";
         }
     } else {
         f.submit();
     }
 }
 
 
 //영화 연령 색깔
	window.onload = function() {
    applyMovieAgeStyles();
};

// 영화 연령에 따라 배경색 적용
window.onload = function() {
    applyMovieAgeStyles();
};

function applyMovieAgeStyles() {
    const movieAgeElements = document.querySelectorAll(".movieAge");
    
    movieAgeElements.forEach(function(movieAgeElement) {
        const movieAgeText = movieAgeElement.textContent.trim().toLowerCase();
        let backgroundColorClass;

        switch (movieAgeText) {
            case "all":
                backgroundColorClass = "bg-all";
                break;
            case "19":
                backgroundColorClass = "bg-19";
                break;
            case "15":
                backgroundColorClass = "bg-15";
                break;
            case "12":
                backgroundColorClass = "bg-12";
                break;
            default:
                // 따로 설정된 배경이 없으면 기본 배경색을 적용
                backgroundColorClass = "bg-default";
                break;
        }

        // 기존 클래스를 모두 삭제하고, 새로운 배경색 클래스를 추가
        movieAgeElement.classList.remove("bg-all", "bg-19", "bg-15", "bg-12", "bg-default");
        movieAgeElement.classList.add(backgroundColorClass);
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
		<div id = "container">
			<div id ="navi">
				<span><a href="<%=cp%>/cinema/booking">다시 예매하기</a></span>
			</div>

			
			<div class="steps" >
			
				<div class="selectMovie">
					<div class="selectHead">영화</div>
					<div class="selectBody">
						<ul>
						    <c:forEach var="movieDTO" items="${movieDTO}">
						        <li class="movie">
						            <a href="javascript:void(0);" onclick="loadTheaters(${movieDTO.movieNo}, '${movieDTO.movieName}')">
						                <span class="movieAge">${movieDTO.moiveAge2}</span> <span>${movieDTO.movieName}</span>
						            </a>
						        </li>
						    </c:forEach>
						</ul>
					</div>
				
				</div>
				
				<div class="selectTheater">
					<div class="selectHead">극장</div>
					<div class="selectBody">
						 <ul id="theaterList" >
						 <p class="theaterSub">영화를 선택하세요. </p>
						 </ul>
					</div>
				</div>
				
				
				<div class="selectDate">
					<div class="selectHead">날짜</div>
					<div class="selectBody">
						<ul id="theaterDate">
						<p class="theaterSub">극장을 선택하세요. </p>
						</ul>
					</div>
				</div>
				
				
				<div class="selectTime">
					<div class="selectHead">시간</div>
					<div class="selectBody">
						<ul id = "theaterTime">
						<p class="theaterSub">날짜를 선택하세요. </p>
						</ul>
					
					</div>
				
				</div>
			</div>
			
			
			<!-- 정보 선택시 뜨는 정보들 -->
			<div class="selectMovieInfo">
			
				<div class="ticketCk">
					<div class="Ckitem">선택영화</div>
					<div id = "CkmovieName"></div>
				</div>
				
				<div class="ticketCk">
					<div class="Ckitem">선택극장</div>
					<div id = "CkTheater"></div>
				</div>
				
				<div class="ticketCk">
					<div class="Ckitem">선택날짜</div>
					<div id = "CkDate"></div>
				</div>
				
				<div class="ticketCk">
					<div class="Ckitem">선택시간</div>
					<div id = "CkTime"></div>
				</div>
				
				<div class="ticketCk">
					<div id="ticketStep" onclick="sendIt();">좌석 선택하기</div>
				</div>
			
			
			</div>
	
		</div>
		
	<!-- 선택값 숨겨서 전달 -->
	<form name="bookingForm" action="" method="post">
	    <input type="hidden" name="movieName" id="movieName" value="">
		<input type="hidden" name="theaterLocal" id="theaterLocal" value="">
		<input type="hidden" name="theaterDay" id="theaterDay" value="">
		<input type="hidden" name="theaterTime" id="theaterTime" value="">
	</form>	
	
	<center>
            <a href="">
                <img src="https://adimg.cgv.co.kr/images/202401/dogman/0122_980x80.jpg" alt="" border="0" width="980" height="100">
            </a>
	</center>
		
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