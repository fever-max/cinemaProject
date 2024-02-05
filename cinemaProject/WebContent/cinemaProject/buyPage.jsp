<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//한글을 깨지지 않게
	request.setCharacterEncoding("UTF-8");
	
    String cp = request.getContextPath();
    
%>

<c:set var="cart" value="${sessionScope.cart}" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>영화 사이트</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/style-buy.css"/>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript"	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<script type="text/javascript">

	function sendIt() {
		const f = document.myForm;
		f.action = "<%=cp%>/cinema/okBuy";
		
		f.submit();
	}
	
	//결제 모듈
	const IMP = window.IMP;
	IMP.init("imp70081281");   /* imp~ : 가맹점 식별코드*/
	let CartName = '${cartItem.productName}';
	let CartPrice = '${totalPaymentAmount}';
    let CartCount = '${cartItem.productCount}';
   // let movieTicket = "";
    
	
    function ticketPay() {
        console.log('결제 시작');

        // IMP 객체를 사용하여 결제를 요청
        IMP.request_pay({
            pg: 'html5_inicis',
            pay_method: 'card',
            merchant_uid: new Date().getTime(), //임의 번호 부여
            name:  "상품구매",
            amount: CartPrice,
            buyer_email: '',
            buyer_name: "${sessionScope.customInfo.userId}",
        }, function(rsp) {
            // 결제 응답 처리 함수 체크 
            console.log(rsp);

            // 결제 성공 시
            if (rsp.success) {
                console.log("결제 성공 ");
                
                //merchant_uid 값 폼에 저장 (예매번호로 씀)
                document.getElementById("productPrice").value = rsp.merchant_uid;
                
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
    
    // 사용자 정보를 가져와서 화면에 출력하는 함수
    function displayUserInfo() {
        // 세션에서 userId와 userTel 정보 가져오기
        const userName = "${sessionScope.customInfo.userName}";
        const userTel = "${sessionScope.customInfo.userTel}";

        // 가져온 정보를 화면에 출력
        document.getElementById("name").textContent = userName;
        document.getElementById("phone").textContent = userTel;
    }

    // 페이지 로드 시 사용자 정보 출력 함수 호출
    window.onload = displayUserInfo;
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
						<a href="<%=cp%>/cinemaProject/inputStore.jsp" class="menuTitle" style="color: #FF4357">스토어</a>
						<ul class="submenu">
							<li><a href="<%=cp%>/cinema/cinemaStore.do">매점</a></li>
							<li><a href="<%=cp%>/cinema/cinemaTicket.do">상영권</a></li>
						</ul>
						
					</li>
				</ul>
			</div>
		</div>
	</header>


<div class=product-table-Div>
 <table class="maejeom-table">
        <tr>
            <td class="maejeom-header">구매 상품 정보</td>
        </tr>
        <tr>
            <td class="underline"></td>
        </tr>
        </table>
        <br/>
        <br/>
        <div class="product-table">
            <table>
                <thead>
                    <tr>
                        <th></th>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>금액</th>
                        <th>선택</th>
                    </tr>
                </thead>
                
                <tbody>
                    <c:forEach var="cartItem" items="${cart}">
                <tr>
                	<td> <img src="${imagePath}/${cartItem.saveFileName}" width="180" height="180" /></td>
                	<td>${cartItem.productName}</td>
                    <td>${cartItem.productCount}</td>
                    <td>${cartItem.productPrice}</td>
                    <td><a href="<%=cp%>/cinema/removeCart?productNo=${cartItem.productNo}">삭제</a></td>
                    
                </tr>
            </c:forEach>
                    
                </tbody>
            </table>	
        </div>
    </div>

		<div class="order-summary">
    <div class="total-amount-header" style="background-color: #f2f2f2; padding: 4px; text-align: center; font-size: 25px; width: 35%; margin: 0 auto; border: 1px solid #ddd; height: 40px;">
        총 결제 예정금액
    </div>
    <div class="total-amount" style="padding: 4px; text-align: center; font-size: 35px; font-weight: bold; width: 35%; margin: 0 auto; border: 1px solid #ddd; height: 60px;">
        ${totalPaymentAmount}원
    </div>


             <div style="margin-top: 20px;">
                    <img src="../cinemaProject/img/pay.png" alt="결제하기" onclick="ticketPay()" style="cursor: pointer;">
                </div>
					       

<!-- <div class="order-info">
    <div class="border-line"></div>
    <h2>주문자 정보 확인</h2>
    <div class="border-line"></div>

    사용자 정보 출력
    <p><strong>이름:</strong> <span id="name"></span></p>
    <p><strong>휴대전화번호:</strong> <span id="phone"></span></p>
    <div class="border-line"></div>
</div> -->
                
		<form action="" method="post" name="myForm">	
			<input type="hidden" name="totalPaymentAmount" id="totalPaymentAmount" value="${totalPaymentAmount}">
		</form>
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