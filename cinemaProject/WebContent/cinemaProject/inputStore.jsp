<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8"); 
	String cp = request.getContextPath(); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이미지 업로드</title>


<link rel="stylesheet" type="text/css" href="<%=cp%>/imageTest/css/style.css"/>
<link rel="stylesheet" type="text/css" href="<%=cp%>/imageTest/css/created.css"/>

</head>
<body>


<div id="bbs">
	<div id="bbs_title">
		이 미 지 게 시 판 
	</div>
<form action="<%=cp%>/cinema/inputStore_ok.do" method="post" enctype="multipart/form-data" name="myForm">


<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품번호</dt>
				<dd>	
				 <input type="text" name="productNo"/><br/>
				</dd>
			</dl>
		</div>
<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품이름</dt>
				<dd>	
				 <input type="text" name="productName"/><br/>
				</dd>
			</dl>
		</div>
		
<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품가격</dt>
				<dd>	
				 <input type="text" name="productPrice"/><br/>
				</dd>
			</dl>
		</div>
		
<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품갯수</dt>
				<dd>	
				 <input type="text" name="productCount"/><br/>
				</dd>
			</dl>
		</div>

<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>파&nbsp;&nbsp;&nbsp;&nbsp;일 </dt>
				<dd>	
				<input type="file" name="upload"><br/></dd>
			</dl>
		</div>
		
		
<div id="bbsCreated">
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>제품내용 </dt>
				<dd>	
				<input type="text" name="productContent"><br/></dd>
			</dl>
		</div>
		
</div>
</div>
		



<input type="submit" value="등록하기" onclick="location='<%=cp%>/cinema/cinemaStore.do';"/>
<input type="reset" value="다시입력"  onclick="document.myForm.subject.focus();"/>
<input type="button" value="작성취소" onclick="location='<%=cp %>';">




</form>

</body>
</html>