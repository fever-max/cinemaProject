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
<title>로그인</title>


<script type="text/javascript">

	function login() {
		
		var f = document.myForm;
		
		if(!f.userId.value) {
			alert("아이디를 입력해 주세요.");
			f.userId.focus();
			return;
		}
		
		if(!f.userPw.value) {
			alert("비밀번호를 입력해 주세요.");
			f.userPw.focus();
			return;
		}	
		
		f.action = "<%=cp %>/cinema/memberLogin_ok";
		f.submit();
		
	}

</script>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/userLogin.css"/>

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
<div id="movieChart">
<div class="userDiv">
		
<div id = "bbs">
	<div class="bbsSub">
		<div id = "bbs_title">
			회원
		</div>
		<div id = "bbs_title2">
			비회원
		</div>
		<div id = "bbs_title3">
			소셜로그인
		</div>
	</div>
		
	<form action="" method="post" name="myForm">
	
	<div id="bbsCreate">
		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>아이디</dt>
				<dd>
				<input type="text" name="userId" size="50"
				placeholder="아이디를 입력해 주세요." maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>

  		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>비밀번호</dt>
				<dd>
				<input type="password" name="userPw" size="50"
				placeholder="비밀번호를 입력해 주세요." maxlength="20" class="boxTF"/>
				</dd>
			</dl>
			<button class="btn_login" onclick="login();">로그인</button>
		</div>

	 <div>
	  	<a href="<%=cp %>/cinema/findPw.jsp"  class="login_menu">비밀번호 찾기</a>
	</div>
	
	 <!-- 아이디,비번 틀렸습니다 -->
	  <div style="height: 30px; display: flex; align-items: center; margin-left: 159px;">
	    <font color="red" style="flex: 1;"><b>${message }</b></font>
	  </div>
	  
	   <div style="height: 30px; display: flex; align-items: center; margin-left: 159px;">
	    <font color="red" style="flex: 1;"><b>${message2 }</b></font>
	  </div>
	
	
	</div>
	
	</form>
	</div>
	 
	
	 
	</div>
	</div>

	</main>
	
	
            <a href="">
                <img src="https://cf2.lottecinema.co.kr/lotte_image/2024/Picnic/0125/Picnic_1920420.jpg" alt="" border="0">
            </a>

	
	
	
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