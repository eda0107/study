<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 개발</title>
<%-- <script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script> --%>
<script src="<c:url value="/resources/tinymce/tinymce.min.js" />"></script>
<!-- <script src="https://cdn.tiny.cloud/1/4xnkl2dz9403v8le67mhtrr5pz4b0lxtvc715w84p3tgyjk1/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script> -->
<script>
  tinymce.init({
    selector: 'textarea#blobPostText',
    menubar: false
  });
</script>
<script>
	$(document).ready(function(){
		$("#modBtn").on("click", function(){
			
			tinymce.init({
			    selector: 'textarea#blobPostText',
			    menubar: false
			  }); 
			var postText = tinymce.activeEditor.getContent();
			$("#blobPostText").val(postText);
			if(postText == null ){
				alert("수정할 내용을 입력하세요.");
			} else {
				$.ajax({
					type : 'POST',
					url : './update.do',
					data : {
						'postNo' : $("#postNo").val(),
						'blobPostText' : postText
					},
					success : function(data){
						alert("수정 성공");
						$("#secondView").load("./updateView.do", {'postNo' : $("#postNo").val()});
					},
					error : function(e){
						alert("수정 실패");
					}
				});
			}
		
			
			
		})
		
		$("#listBtn3").on("click", function(){
			window.location.href="./pBoardList.do";
		})
	});
</script>
</head>
<body>
	<div>
		<h2>게시물 수정</h2>
		<br>
		<form name="modForm" id="modForm" method="post">
		<!-- id는 jsp페이지 안에서만 활용/name은 컨트롤러로 가져가서 활용 -->
			<div>
				<input type="hidden" id="postNo" name="postNo" value="${p.postNo }">
				<label for="postTitle">제목</label>
				<input type="text" name="postTitle" id="postTitle" value="${p.postTitle }"readonly>
			</div>
			<p></p>
			<div>
				<label for="blobPostText">내용</label>
				<textarea rows="5" name="blobPostText" id="blobPostText"><c:out value="${p.strPostText }" /></textarea>
			</div>
			<p></p>
			<div>
				<label for="postInsert">작성자</label>
				<input type="text" name="postInsert" id="postInsert" value="${p.postInsert}"readonly>
			</div>
		</form>
		<p></p>
		
		<div align="right">
			<button type="button" id="modBtn">수정</button>
			<button type="button" id="listBtn3">목록</button>
		</div>
	</div>

</body>
</html>