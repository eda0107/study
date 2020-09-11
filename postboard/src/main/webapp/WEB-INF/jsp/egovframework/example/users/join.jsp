<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
	<script type="text/javascript" src="<c:url value="/user/js/jsbn.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/user/js/rsa.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/user/js/prng4.js"/>"></script>
	<script type="text/javascript" src="<c:url value="/user/js/rng.js"/>"></script>

	<meta charset="UTF-8">
	<title>게시판 개발</title>
	<script>
		$(document).ready(function(){
			
			$("#joinBtn").on("click", function(){
				
				
				var userId = $("#userId").val();
				var userPw = $("#userPw").val();
				
				//웹 암호화 설정
				var rsa = new RSAKey();
				var RSAModulus = $("#RSAModulus").val();
				var RSAExponent = $("#RSAExponent").val();
				
				rsa.setPublic(RSAModulus, RSAExponent);
				var encUserId = rsa.encrypt(userId);
				var encUserPw = rsa.encrypt(userPw);
				alert("encUserPw: " + encUserPw);
				//"encUserId: " + encUserId +
				
				$("#userId").val(encUserId);
				$("#userPw").val(encUserPw);

				
				var $join = $("#joinFrm").serialize();
				
				//가입 로직
				
				/*
				if(userId == ""){
					alert("사용할 아이디를 입력해주세요.");
					$("#userId").focus();
				} else if(userPw == ""){
					alert("사용할 비밀번호를 입력해주세요.");
					$("#userPw").focus();
				} else if($("#userPwChk") == ""){
					alert("확인할 비밀번호를 입력해주세요.")
					$("#userPwChk").focus();
				} else if (userPw != $("#userPwChk")) {
					alert("비밀번호를 동일하게 입력해주세요.");
				} else if(userName == ""){
					alert("이름을 입력해주세요.");
					$("#userName").focus();
				} else if(userEmail == ""){
					alert("이메일을 입력해주세요.");
					$("#userEmail").focus();
				} else { */
					$.ajax({
						type: "POST",
						url : "./regUser.do",
						data : $join,
						dataType : "json",
						success : function(data){
							alert("회원 가입 성공")
							window.location.href="./pBoardList.do";
						},
						error : function(){
							alert("통신 실패");
						}
					});
					
				//}
				
				//중복검사 안 했을 때 추가
			
			});
			
			
			$("#listBtn").on("click", function(){
				window.location.href="./pBoardList.do"
			});
		});
	
	</script>
</head>
<body style="margin:0 auto; display:inline; padding-top:100px;">
	<div class="container" role="main" style="padding:50px;">
	<h2 style="text-align:center;">회원가입</h2>
		<form id="joinFrm" name="joinFrm" method="post" action="./regUserView.do" style="margin:auto; width:55%;" >
			
			<!-- 서버에서 전달한 값 세팅 -->
			<input type="hidden" id="RSAModulus" value="${RSAModulus }" >
			<input type="hidden" id="RSAExponent" value="${RSAExponent }">

			<div id="content">
				<div class="mb-3">
					<label for="userId">아이디</label>
					<input type="text" class="form-control" name="userId" id="userId" placeholder="사용할 아이디를 입력하세요.">
					<input type="button" class="btn btn-link" value="중복확인">
				</div>
				<br>
				<div class="mb-3">
					<label for="userPw">비밀번호</label>
					<input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호를 입력하세요.">
				</div>
				<br>
				<div class="mb-3">
					<label for="userPwChk">비밀번호 확인</label>
					<input type="password" class="form-control" name="userPwChk" id="userPwChk" placeholder="비밀번호를 확인하세요.">
				</div>
				<br>
				<div class="mb-3">
					<label for="userName">이름</label>
					<input type="text" class="form-control" name="userName" id="userName" placeholder="이름을 입력하세요.">
				</div>
				<br>
				<div class="mb-3">
					<label for="userEmail">이메일</label>
					<input type="text" class="form-control" name="userEmail" id="userEmail" placeholder="이메일을 입력하세요.">
				</div>
			</div>
		</form>
		<br><br>
		<div align="center">
			<button type="button" class="btn btn-primary" id="joinBtn">가입</button>
			<button type="button" class="btn btn-default" id="listBtn">취소</button>
		</div>
	</div>

</body>
</html>