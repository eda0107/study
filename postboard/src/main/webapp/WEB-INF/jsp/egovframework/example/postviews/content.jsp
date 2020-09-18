<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<meta charset="UTF-8">
<title>게시판 개발</title>
<script>
	$(document).ready(function(){
		//목록으로 가는 이벤트
		$("#listBtn2").on("click", function(){
			window.location.href="./pBoardList.do";
		});
		//삭제 이벤트
		$("#delBtn").on("click", function(){
			
		})
		//수정 이벤트
	 	$("#editBtn").on("click", function(){
	 		$("#secondView").load("./editView.do", {'postNo' : $('#postNo').val()});
		});
	 	//답변 이벤트
	 	$("#replyBtn").on("click", function(){
	 		$("#secondView").load("./replyView.do", {'postNo' : $('#postNo').val()});
	 	})
	});

</script>
</head>
<body>
	<div>
		<h2>게시물 조회</h2>
		<p></p>
		<form id="contentForm" name="contentForm" method="post">
			<input type="hidden" id="postNo" name="postNo" value="${p.postNo }">
			<input type="hidden" id="originNo" name="originNo" value="${p.originNo }">
			<div class="contentTitle">
				제목: <c:out value="${p.postTitle }" />
			</div>
			
			<div class="contentInsert">
				작성자: <c:out value="${p.postInsert }" />
				작성일자: <c:out value="${p.formattedDate }" />
			</div>
			
			<div class="contentText">
				내용 <c:out value="${p.strPostText }" escapeXml="false"/>
			</div>
			
			<!-- 게시글(원글)/답글 조회시 구현할 버튼 -->
			<div align="right">
				<!-- 게시글(원글) 조회일 때 originNo = null -->
				<c:if test="${p.originNo eq '' }" >
					<button type="button" id="replyBtn">답변</button>
					<button type="button" id="delBtn">삭제</button>
				</c:if>
					<button type="button" id="editBtn">수정</button>
					<button type="button" id="listBtn2">목록</button>
			</div>
			<!-- /게시글(원글)/답글 조회시 구현할 버튼 -->
		</form>
	</div>
</body>
</html>