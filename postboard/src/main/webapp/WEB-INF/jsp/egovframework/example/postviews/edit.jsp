<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css" />">
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-theme.min.css " />">
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<meta charset="UTF-8">
<title>게시판 개발</title>
<script type="text/javascript">
	$(document).ready(function() {
			$("#editBtn").on("click", function() {
				
				var $frm = $("#frm").serialize();
				
				$.ajax({
					 type : "POST",
					 url : "./update.do",
				     data : $frm,
				     success : function(data){
				    	 alert("수정 성공");
				    	 window.location.href = "./pBoardList.do";
				        },
			      	 error : function(){
			          	 alert('통신 실패');
				       	}
				});

		});

			$("#listBtn").on("click", function() {
				frm.action = "./pBoardList.do";
				frm.submit();
			});

	});

</script>
</head>
<body>
	<div class="container" role="main" style="padding: 40px;">
		<h2>게시물 수정</h2>
		<br>
		<form name="frm" id="frm" method="post">
			<div class="mb-3">
				<label for="postTitle">제목</label> 
				<input type="hidden" id="postNo" name="postNo" value="${p.postNo}" > 
				<input type="text" class="form-control" name="postTitle" id="postTitle" value="${p.postTitle}" readonly>
			</div>
			<br>
			<div class="mb-3">
				<label for="postText">내용</label>
				<textarea class="form-control" rows="5" name="postText" id="postText" placeholder="수정할 내용을 입력해 주세요"></textarea>
			</div>
			<br>
			<div class="mb-3">
				<label for="postInsert">작성자</label> 
				<input type="text" class="form-control" name="postInsert" id="postInsert" value="${p.postInsert}"  readonly>
			</div>
		</form>
		<br>
		<div align="right">
			<button type="button" class="btn btn-info" id="editBtn">수정</button>
			<button type="button" class="btn btn-info" id="listBtn">목록</button>
		</div>
	</div>


</body>
</html>