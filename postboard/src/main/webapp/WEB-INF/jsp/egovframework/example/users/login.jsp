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
			window.location.href="./regUserView.do";
		});
		
	});
	</script>
	<style>
	.container{
	position:absolute;
	height:500px;
	width:400px;
	margin:-215px 0px 0px -200px;
	top: 50%;
	left: 50%;
	padding:3px;
	}
	</style>
</head>

<body>
	<div class="container" role="main">
		<h2 style="text-align:center;">전자정부게시판</h2>
		<form id="loginFrm" name="loginFrm" method="post">
			<div> 
				<label for="uid" class="sr-only">아이디</label>
				<input type="text" id="uid" name="uid" class="form-control" placeholder="아이디">
			</div>
			<br>
			<div>
				<label for="upw" class="sr-only">비밀번호</label>
				<input type="password" id="upw" name="upw" class="form-control" placeholder="비밀번호">
			</div>
			<br>
			<button type="submit" class="btn btn-lg btn-primary btn-block">로그인</button>
			<div align="right">
				<button type="button" class="btn btn-link center" id="joinBtn">회원가입</button>
			</div>
		</form>
	</div>
</body>
</html>