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
<title>회원가입</title>
<script type="text/javascript" src="<%=cp%>/cinemaProject/js/addr.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

function sendIt() {
	
	event.preventDefault();
	
    var f = document.myForm;

    /* 아이디 체크 */
    var userIdValue = f.userId.value.trim();
    if (!userIdValue) {
        alert("아이디: 필수 정보입니다.");
        f.userId.focus();
        return;
    } else {
        //아이디 유효성 검사
        var idPattern = /^[a-z0-9]{5,20}$/;
        if (!idPattern.test(userIdValue)) {
            alert("아이디: 5~20자의 영문 소문자, 숫자만 사용 가능합니다.");
            f.userId.focus();
            return;
        }
    }
    f.userId.value = userIdValue;

    /* 비밀번호 체크 */
    var pwValue = f.userPw.value.trim();
    if (!pwValue) {
        alert("비밀번호: 필수 정보입니다.");
        f.userPw.focus();
        return;
    } else {
        //비밀번호 유효성 검사
        var pwPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$/;
        if (!pwPattern.test(pwValue)) {
            alert("비밀번호: 8~16자의 영문 대/소문자, 숫자, 특수문자를 포함하여 사용해 주세요.");
            f.userPw.focus();
            return;
        }
    }
    f.userPw.value = pwValue;

    /* 이름 체크 */
    str = f.userName.value.trim();
	if (!str) {
		alert("이름: 필수 정보입니다.");
    	f.userName.focus();
    	return;
	} else {
    	//이름 유효성 검사
    	var namePattern = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/;
   	 	if (!namePattern.test(str)) {
        	alert("이름: 한글, 영문 대/소문자를 사용해 주세요. (특수기호, 공백 사용 불가)");
        	f.userName.focus();
        	return;
   	 	}
	}
	f.userName.value = str;

	/* 주민번호 체크 */
	str = f.userJumin.value.trim();
	var juminFirst = f.userJumin.value.trim();
	if (!juminFirst) {
	    alert("주민번호: 필수 정보입니다.");
	    f.userJumin.focus();
	    return;
	}else {
	    // 주민번호 앞자리 유효성 검사
	    var juminPattern = /^[0-9]{6}$/;
	    if (!juminPattern.test(juminFirst)) {
	        alert("주민등록번호를 올바르게 입력해주세요.");
	        f.userJumin.focus();
	        return;
	    }
	}
	f.userJumin.value = str;
	
	// 주민등록번호 뒷자리 유효성 검사
	str = f.userJuminSecond.value.trim();
	var juminSecond = f.userJuminSecond.value.trim();
	if (!juminSecond) {
	    alert("주민번호: 필수 정보입니다.");
	    f.userJumin.focus();
	    return;
	}else {
		// 뒷자리가 1, 2, 3, 4 중 하나인지 확인
		var validSecond = /^[1-4]$/;
		if (!validSecond.test(juminSecond)) {
	    alert("주민등록번호를 올바르게 입력해주세요.");
	    f.userJumin.focus();
	    return;
		}
	}
	f.userJuminSecond.value = str;
	
	/* 통신사 선택 */
	var selectedTelecom = f.userTelecom.value.trim(); // 선택된 통신사
	f.userTelecom.value = selectedTelecom;

	
	/* 전화번호 체크 */
	// 전화번호 앞자리 선택
	var selectedTel = f.userTelecom.value.trim(); // 선택된 통신사
	f.userTelecom.value = selectedTel;

	// 전화번호 두번째 자리
	var telSecond = f.userTelSecond.value.trim(); // 중간 4자리
	if (!telSecond) {
	    alert("휴대전화번호: 필수 정보입니다.");
	    f.userTelSecond.focus();
	    return;
	} else {
	    // 휴대전화번호 중간자리 유효성 검사
	    var telPattern = /^[0-9]{4}$/;
	    if (!telPattern.test(telSecond)) {
	        alert("휴대전화번호: 휴대전화번호가 정확한지 확인해 주세요.");
	        f.userTelSecond.focus();
	        return;
	    }
	}
	f.userTelSecond.value = telSecond;

	// 전화번호 세번째 자리
	var telThird = f.userTelThird.value.trim(); // 끝 4자리
	if (!telThird) {
	    alert("휴대전화번호: 필수 정보입니다.");
	    f.userTelSecond.focus();
	    return;
	} else {
	    // 휴대전화번호 끝자리 유효성 검사
	    var telPattern = /^[0-9]{4}$/;
	    if (!telPattern.test(telThird)) {
	        alert("휴대전화번호: 휴대전화번호가 정확한지 확인해 주세요.");
	        f.userTelSecond.focus();
	        return;
	    }
	}
	f.userTelThird.value = telThird;
	
	/* 주소 체크 */
	var sample4_postcode = f.sample4_postcode.value.trim();
	if (!sample4_postcode) {
	    alert("주소: 필수 정보입니다.");
	    f.sample4_postcode.focus();
	    return;
	}
	
	var sample4_roadAddress = f.sample4_roadAddress.value.trim();
	if (!sample4_roadAddress) {
	    alert("주소: 필수 정보입니다.");
	    f.sample4_postcode.focus();
	    return;
	}
	
	var sample4_jibunAddress = f.sample4_jibunAddress.value.trim();
	if (!sample4_jibunAddress) {
	    alert("주소: 필수 정보입니다.");
	    f.sample4_postcode.focus();
	    return;
	}
	
	var sample4_detailAddress = f.sample4_detailAddress.value.trim();
	if (!sample4_detailAddress) {
	    alert("상세주소를 입력하세요.");
	    f.sample4_detailAddress.focus();
	    return;
	}
	
	var sample4_extraAddress = f.sample4_extraAddress.value.trim();
	if (!sample4_extraAddress) {
	    alert("주소: 필수 정보입니다.");
	    f.sample4_postcode.focus();
	    return;
	}
	
	
	f.action = "<%=cp %>/cinema/membershipCreate_ok";
    f.submit();
}


</script>     

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 사이트</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/userCreate.css"/>



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
<div id = "movieChart">
<div class="userCreateDiv">
	
	<div id = "title">
		회원가입
	</div>
	<div id = "bbs">
	<div id = "bbs_title">
		회원정보 입력
	</div>
	
	<form action="" method="post" name="myForm">
	<div id = "bbsCreate">
	
		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>아이디</dt>
				<dd>
				<input type="text" name="userId" size="50"
				placeholder="아이디" maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>비밀번호</dt>
				<dd>
				<input type="password" name="userPw" size="50"
				placeholder="비밀번호" maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</dt>
				<dd>
				<input type="text" name="userName" size="50"
				placeholder="한글 또는 영문으로 입력해주세요." maxlength="50" class="boxTF boxTF:hover"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreate_bottomLine">
    <dl>
        <dt>생년월일/성별</dt>
        <dd>
            <input type="text" name="userJumin" id="userJumin" size="23" placeholder="생년월일을 입력해주세요." maxlength="6" class="boxTF">
            - 
            <input type="text" name="userJuminSecond" id="userJuminSecond" size="3" maxlength="1" class="boxTF" >
            <font color="gray"><b>●●●●●●</b></font>
        </dd>
    </dl>
</div>
		
<div class="bbsCreate_bottomLine">
    <dl>
        <dt>휴대폰 번호</dt>
        <dd>
            <select name="userTelecom" id="userTelecom" class="select">
                <option selected="selected">SKT</option>
                <option>KT</option>
                <option>LG</option>
                <option>SKT 알뜰폰</option>
                <option>KT 알뜰폰</option>
                <option>LG 알뜰폰</option>
            </select>
            <select name="userTelFirst" id="userTelFirst">
                <option selected="selected">010</option>
                <option>011</option>
                <option>016</option>
                <option>017</option>
                <option>018</option>
                <option>019</option>
            </select> - 
            <input type="text" name="userTelSecond" id="userTelSecond" size="11" maxlength="4" class="boxTF">
            - 
            <input type="text" name="userTelThird" id="userTelThird" size="11" maxlength="4" class="boxTF">
            <script>
                var userTel = document.getElementById("userTelFirst").value +
                              document.getElementById("userTelSecond").value +
                              document.getElementById("userTelThird").value;
            </script>
        </dd>
    </dl>
</div>
		
		<div class="bbsCreate_bottomLine">
			<dl>
				<dt>이메일</dt>
				<dd>
				<input type="text" name="userEmail" size="50"
				placeholder="[선택] 이메일주소(비밀번호 찾기 등 본인 확인 용)" maxlength="50" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreate_bottomLine_addr">
			<dl>
				<dt>주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</dt>
				<dd>
				<input type="text" id="sample4_postcode" name ="sample4_postcode" placeholder="우편번호" class="input-text">
<input type="button" onclick="sample4_execDaumPostcode();" value="우편번호 찾기"><br>
<input type="text" id="sample4_roadAddress"  name ="sample4_roadAddress" placeholder="도로명주소" class="input-text">
<input type="text" id="sample4_jibunAddress"  name ="sample4_jibunAddress" placeholder="지번주소" class="input-text">
<span id="guide" style="color:#999;display:none"></span>
<input type="text" id="sample4_detailAddress"  name ="sample4_detailAddress" placeholder="상세주소" class="input-text">
<input type="text" id="sample4_extraAddress"  name ="sample4_extraAddress" placeholder="참고항목" class="input-text">
				</dd>
			</dl>
			
		</div>
		
		<button class="btn_create" onclick="sendIt()">회원가입</button>
		
		
		</div>


	</div>
	
	</div>
	
	

	</form>
	
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