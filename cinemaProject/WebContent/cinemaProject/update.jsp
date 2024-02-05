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
<title>프로필 수정(팝업)</title>

<script type="text/javascript">
	function closePopup() {
		
		var f = document.myForm;
		
		window.close();
	}
</script>

<script type="text/javascript">

	function pwUpdate() {
		
		var f = document.myForm;
		var pwValue = f.newPw.value;

		if (!pwValue) {
			alert("비밀번호를 입력해주세요.");
			f.newPw.focus();
			return;
		} else {
		var pwPattern = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{8,16}$/;
		if (!pwPattern.test(pwValue)) {
			alert("비밀번호: 8~16자의 영문 대/소문자, 숫자, 특수문자를 포함하여 사용해 주세요.");
			f.userPw.focus();
			return;
		}else {
			alert("사용 가능한 비밀번호입니다.");	
		}
		}
	}
	function sendIt() {
	    var f = document.myForm;

	    // hidden input 필드에 userId 값을 추가
	    var userIdInput = document.createElement("input");
	    userIdInput.type = "hidden";
	    userIdInput.name = "userId";
	    userIdInput.value = "${sessionScope.customInfo.userId}";
	    f.appendChild(userIdInput);

	    // 서블릿으로 폼을 전송
	    f.action = "<%=cp %>/cinema/udt";
	    alert("비밀번호가 변경되었습니다")
	    f.submit();
    	
      
	}
	  
	  
	  
</script>

<script type="text/javascript">

	function displayUserInfo() {
		// 세션에서 userId와 userTel 정보 가져오기
		const userName = "${sessionScope.customInfo.userName}";
		const userId = "${sessionScope.customInfo.userId}";
		// 가져온 정보를 화면에 출력
		document.getElementById("name").textContent = userName;
		document.getElementById("id").textContent = userId;
}

	window.onload = displayUserInfo;
</script>


<link rel="stylesheet" type="text/css" href="<%=cp%>/cinemaProject/css/update.css"/>

</head>
<body id="body">

<div class="layer-wrap" style="position: static; top: auto; left: auto;">
	<div class="popwrap" style="width: 633px;">
		<h1>나의 프로필 수정</h1>
		<div class="pop-contents">
		<form name="myForm" method="post" action="">
				<div>
					<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" 
					value="/wEPDwULLTEzMzEyMTU4NDhkZKBq30lYyDwm3Ruh/yZqZxg++4HF">
				</div>
				<div>
					<input type="hidden" name="__VIEWSTATEGENERATOR" 
					id="__VIEWSTATEGENERATOR" value="4E92C5CF">
				</div>
				<div class="sect-profile-modify">
                <div class="profile-name">
                    <strong id="name" ></strong>                                                                                                                
                    <em id="id" ></em>
                </div>
                <div class="profile-modify">
                    <dl>
                        <dt><strong>비밀번호</strong></dt>
                        <dd>
                            <p>
                                <label for="pw">비밀번호 입력</label>
    					<input type="text" id="newPw" name="newPw" maxlength="20"> 

   						 <!-- 다른 필요한 필드들을 추가할 수 있음 -->

    						<button type="button" class="round black" onclick="pwUpdate();"><span>비밀번호 수정</span></button>

                            
                        </dd>
                        <dt><strong>프로필</strong></dt>
                        <dd>
                            <input type="hidden" id="user_small_image" name="user_small_image" value="">
                            <div class="thumb-image">
	                            <img id="profile_image" src="http://img.cgv.co.kr/R2014/images/common/default_profile.gif" alt="김석현님 프로필 사진" onerror="errorImage(this, {type:'profile'})">
                                <span class="profile-mask"></span>
                                
                            </div>
                            <div class="profile-search">
                                <p>JPG, GIF, BMP 파일만 등록 가능합니다.(최대 3M)</p>
                                <input id="profile_upload_file" name="profile_upload_file" type="file" title="프로필사진 업로드">
                            </div>
                        </dd>
                    </dl>
                </div>
            
            </div>
            
            <div class="set-btn">
            	<button type="submit" id="save" class="round inblack" onclick="sendIt()">
            		<span>등록하기</span>
            	</button>
            	<button type="button" id="btn_cancel" class="round gray" onclick="closePopup()"><span>취소</span>
            
            	</button>
            
            </div>
			
			
			
			</form>
		
		
		</div>
	</div>
</div>

</body>
</html>