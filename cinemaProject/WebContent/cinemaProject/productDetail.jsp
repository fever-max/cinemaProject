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
    <title>제품 상세 정보</title>
 	<script>
 	
 	
 	function addToCart() {
 	    var f = document.myForm;
 	    var productCount = document.getElementById("productCount").value;

 	    // 확인 대화상자 띄우기
 	    var isLoggedIn = '<%=session.getAttribute("customInfo") != null%>';
 	    var confirmMessage = isLoggedIn ? "장바구니에 추가하시겠습니까?" : "이용을 위해서는 로그인이 필요합니다. 로그인을 하시겠습니까?";
 	    var confirmed = confirm(confirmMessage);

 	    // 확인을 선택한 경우
 	    if (confirmed) {
 	        // 로그인 상태일 경우
 	        if (isLoggedIn) {
 	            f.productCount.value = productCount;
 	            f.action = "<%=cp%>/cinema/productDetail_ok?productNo=${productDetail.productNo}&productCount=" + productCount;
 	            f.submit();
 	        } else {
 	            // 로그인 상태가 아닐 경우
 	            alert("장바구니 이용을 위해 로그인이 필요합니다.");
 	            // 로그인 페이지로 이동하거나 다른 처리를 수행하도록 수정
 	            window.location.href = "<%=cp%>/cinema/userLogin.jsp";
 	        }
 	    }
 	}
 	
 	

 	
    </script>



	<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/main.css"/>
	<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/style-product.css"/>

</head>




<body>

<form action="" method="post" name="myForm">
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
	
	 <main>
	 <div class="detailDiv">
	 <div id="productDetail">
	 
	 <div class="cinemaStoreTitle">
		<span class="cinemaStoreTitle1">스토어</span>
		<div class="cinemaStoreTitle2">
			<span></span>
			<a href="<%=cp%>/cinemaProject/buyPage.jsp" class="cart">
	           <b>장바구니</b>
	        </a>
        </div>
		</div>
		<hr class="line">
		
	<div class="products-detail">
	<!-- 상단 박스 시작 -->
	<div class="products-detail-box">
		<div class="products-box-info">
			<div class="products-info-image swiper-container">
				<div class="swiper-wrapper">
			
					<div class="swiper-slide">
						<img src="<%=cp%>/pds/imageFile/${productDetail.saveFileName}" width="50" height="50" />
						<!-- 동기적으로 불러오기 -->
					</div>
				</div>
			</div>
		</div>
		<div class="products-box-detail">
		
		<div class="products-box-detail-price">
				<!-- 가격 -->
				<span class="products-box-detail-price-figure">${productDetail.productName}</span>
			</div>
				<div class="products-box-detail-postInfo border-btm-e1e1e1">
				<span class="products-box-detail-postInfo-title">제품 가격</span> <span
					class="products-box-detail-postInfo-content" id="productPrice">${productDetail.productPrice}원</span>
			</div>
			<div class="products-box-detail-realInfo border-btm-e1e1e1">
				<span class="products-box-detail-realInfo-title">사용가능 쿠폰</span> <span
					class="products-box-detail-realInfo-content">0개</span> <span class="products-box-detail-realInfo-popover"
					onclick="realInfoBox();"> ∨ </span>
			</div>
				<!-- 버튼 시작 -->
			 
	    <div class="products-box-detail-postInfo border-btm-e1e1e1">
	        <label for="productCount">수량:</label>
	        <button type="button" onclick="decreaseCount()">-</button>
	        <input type="text" id="productCount" name="productCount" value="1" readonly>
	        <button type="button" onclick="increaseCount()">+</button>
	    </div>

			<div class="products-box-detail-postInfo border-btm-e1e1e1">
				<span class="products-box-detail-postInfo-title">제품 설명</span> <span
					class="products-box-detail-postInfo-content">${productDetail.productContent}</span>
			</div>		
			<div class="products-box-detail-postInfo border-btm-e1e1e1">
   		 <span class="products-box-detail-postInfo-title">총 금액</span> 
   		 <span class="products-box-detail-postInfo-content" id="totalAmount">${productDetail.productPrice}원</span>
		</div>
			
			<!-- 장바구니 버튼 시작 -->
			 <div style="margin-top: 20px;">
                    <img src="../cinemaProject/img/cart.png" alt="장바구니 추가" onclick="addToCart()" style="cursor: pointer;">
                    <img src="../cinemaProject/img/buy.png" alt="구매하기" onclick="addToCart()" style="cursor: pointer;">
                </div>
                
			<!-- 장바구니 버튼 끝 -->
			
			
		<script>
	    function updateTotalAmount() {
	        var productCount = parseInt(document.getElementById("productCount").value);
	        var productPrice = parseInt(${productDetail.productPrice}); // JSP 표현식 사용하여 서버에서 받아온 가격 가져오기
	        var totalAmount = productCount * productPrice;
	
	        document.getElementById("totalAmount").innerText = totalAmount + "원";
	    }
	
	    function decreaseCount() {
	        var count = parseInt(document.getElementById("productCount").value);
	        if (count > 1) {
	            count--;
	            document.getElementById("productCount").value = count;
	            updateTotalAmount(); // 수량 변경 시 총 금액 업데이트
	        }
	    }
	
	    function increaseCount() {
	        var count = parseInt(document.getElementById("productCount").value);
	        if (count < 10) {
	            count++;
	            document.getElementById("productCount").value = count;
	            updateTotalAmount(); // 수량 변경 시 총 금액 업데이트
	        }
	    }
	
	    // 페이지 로드 시 총 금액 업데이트
	    window.onload = function() {
	        updateTotalAmount();
	    };
	    
	</script>
			  
			<!-- 버튼 끝 -->
		</div>
	</div>
</div>
</div>
       <hr>
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
	
</form>
</body>
</html>