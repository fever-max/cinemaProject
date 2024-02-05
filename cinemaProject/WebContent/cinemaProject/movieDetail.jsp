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
<title>영화 상세정보</title>


<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css" />
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css" />
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/moviedetail.css" />


<script type="text/javascript">

function checkLogin() {
    console.log("버튼클릭");
    
    var isLoggedIn = <%= session.getAttribute("customInfo") != null %>;

    if (!isLoggedIn) {
        var confirmLogin = confirm("리뷰를 남기려면 로그인이 필요합니다. \n로그인 페이지로 이동하시겠습니까?");
        
        if (confirmLogin) {
            window.location.href = '<%=cp%>/cinema/userLogin';
            return false;
        } else {
            return false;
        }
    }

    return true;
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
						<a href="<%=cp%>/cinema/movieAll" class="menuTitle" style="color: #FF4357">영화</a>
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
	<div id="movieAllChart">
		<div class="movieAllDiv">
			<div class="movieAllTitle">영화 정보</div>
			<hr class="line">
			
			
			<div class="movieDetail">
				<div class="movieImg">
					<img src="${Moviedto.moiveImage}"/>
				</div>
				<div class="movieText">
				
					<div class="movieTextName">
						<c:choose>
						<c:when test="${Moviedto.moiveAge2 == 'ALL'}">
							<div class="age-rating"><b>ALL</b></div>
						</c:when>
						<c:when test="${Moviedto.moiveAge2 == '15'}">
							<div class="age-orange"><b>15</b></div>
						</c:when>
						<c:when test="${Moviedto.moiveAge2 == '19'}">
							<div class="age-red"><b>19</b></div>
						</c:when>
						<c:when test="${Moviedto.moiveAge2 == '12'}">
							<div class="age-yellow"><b>12</b></div>
						</c:when>
					</c:choose>
						<div class="movieTextName2">${Moviedto.movieName}</div>
					</div>
					
					<div>장르: ${Moviedto.movieGenre}</div>
					<div>예매율: ${Moviedto.moiveScore}%</div>
					<div>감독: ${Moviedto.movieDirector}</div>
					<div>배우: ${Moviedto.moiveActor}</div>
					<div>상영시간: ${Moviedto.movieTime}</div>
					<div>개봉일: ${Moviedto.movieDate}</div>
					<a href="<%=cp%>/cinema/booking">
						<div class="movieTextBtn"><div>예매하기</div></div>
					</a>
				</div>
			</div>
			
			<div class="movieDetailLong">
				<div class="LongText">줄거리</div>
				<div>${Moviedto.movieContent}</div>
			</div>
			
			<!-- 영화리뷰 -->
			<div class="movieReview">
				<div class="movieReviewTitle"><div>영화 리뷰</div></div>
				<form action="<%=cp%>/cinema/detail_ok" method="post" name="reviewForm" onsubmit="return checkLogin();">
				    <input type="text" rows="12" cols="60" id="comentContent" name="comentContent" onclick="checkLogin();">
				    
				    <input type="hidden" name="movieNo" id="movieNo" value="${Moviedto.movieNo}">
				    <input type="hidden" name="userId" id="userId" value="${userId}">
				    <input type="submit" class="reviewBtn" value=" 등록하기"/>
				</form>
				
				<!-- 댓글창 -->
				
					<div class="movieReviewText">
					<c:forEach var="dto" items="${comentList}">
						<div class="movieReviewTextSub">
							<div class="movieReviewImg">
								<img src="http://img.cgv.co.kr/R2014/images/common/default_profile.gif" alt="프로필사진">
							</div>
							<div class="movieReviewInfo">
								<div class="userInfo">
									<div class = "review-user">${dto.name}</div>
									<div class = "review-date">${dto.comentCreated}</div>
									<c:if test="${sessionScope.customInfo != null and sessionScope.customInfo.userId eq dto.name}">
			                              <a href="<%=cp%>/cinema/movieDetail?movieno=${movieNo}&deleteNum=${dto.comentNo}">
			                              <div class = "review-delete">삭제</div>
			                              </a>
			                        </c:if>
								</div>
								
								<div class="userReview">
									<div>${dto.comentContent}</div>
								</div>
							</div>
							</div>
					</c:forEach>
		        	</div>
		       		</div>
		       		
		       		<!-- 페이지 번호 -->
					<div class="pageDiv">
						<div>
			            <c:if test="${dataCount!=0 }">
			            ${pageIndexList }
			           	</c:if>
			           	<c:if test="${dataCount==0 }">
			            등록된 댓글이 없습니다.
			            </c:if>
		            	</div>
					</div>
			
			
	</div>
	</div>


   </main>
	
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