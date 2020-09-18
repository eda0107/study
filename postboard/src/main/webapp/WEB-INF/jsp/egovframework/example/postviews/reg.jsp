<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>게시판 개발</title>
<%-- <script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script> --%>
<script src="<c:url value="/resources/tinymce/tinymce.min.js" />"></script>
<!-- 4xnkl2dz9403v8le67mhtrr5pz4b0lxtvc715w84p3tgyjk1 -->
<script>
	 
</script>
<script>
	$(document).ready(function(){
		
		tinymce.init({
		    selector: 'textarea#blobPostText',
		    menubar: false
		  }); 
		
		$("#writeBtn").on("click", function(){
			var postTitle = $("#postTitle").val(); //val(): form 양식의 값을 가져오거나 설정하는 메소드
			var postText = tinymce.activeEditor.getContent(); //에디터의 콘텐츠 갖고오기
			var postInsert = $("#postInsert").val(); 
			//var blobPostText = $("#blobPostText").val(postText); 
			
			var regForm = $("#regForm").serialize();
			console.log(regForm);
			console.log(blobPostText);
			if(postTitle == ""){
				alert("제목을 입력하세요.");
			} else if(postText == ""){
				alert("내용을 입력하세요.");
			} else if(postInsert == ""){
				alert("작성자를 입력하세요.");
			} else {
				
				$.ajax({
					type : 'POST',
					url : './register.do',
					data :{ //console에 찍히는 값(필드, input name):변수값
						'postTitle' : postTitle,
						'blobPostText' : postText, //등록하는 컨트롤러에서 vo.getBlobPostText()가 되는 부분
						'postInsert' : postInsert
					},
					success: function(data){
						alert("등록 성공")
						window.location.href = "./pBoardList.do";						
					},
					error : function(e){
						alert("통신 실패");
					}
				});
			}
		});
		
		
		$("#listBtn").on("click", function(){
			window.location.href="./pBoardList.do";
		});
	});
	
</script>
</head>
<body>
	<div>
		<h2>게시물 등록</h2>
		<br>
		<form name="regForm" id="regForm" method="post">
		<!-- id는 jsp페이지 안에서만 활용/name은 컨트롤러로 가져가서 활용 -->
			<div>
				<label for="postTitle">제목</label>
				<input type="text" name="postTitle" id="postTitle" placeholder="제목을 입력하세요.">
			</div>
			<p></p>
			<div>
				<label for="blobPostText">내용</label>
				<textarea rows="5" name="blobPostText" id="blobPostText"></textarea>
			</div>
			<p></p>
			<div>
				<label for="postInsert">작성자</label>
				<input type="text" name="postInsert" id="postInsert" placeholder="작성자를 입력하세요.">
			</div>
		</form>
		<p></p>
		
		<div align="right">
			<button type="button" id="writeBtn">등록</button>
			<button type="button" id="listBtn">목록</button>
		</div>
	</div>
</body>
</html>