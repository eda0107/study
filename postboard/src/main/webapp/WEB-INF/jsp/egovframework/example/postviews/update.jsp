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
<style>

.board_title {
	font-weight : 700;
	font-size : 22pt;
	margin : 10pt;
}

.board_info_box {
	color : #6B6B6B;
	margin : 10pt;
}

.board_author {
	font-size : 10pt;
	margin-right : 10pt;
}

.board_date {
	font-size : 10pt;
}

.board_content {
	color : #444343;
	font-size : 12pt;
	margin : 10pt;
}

.board_tag {
	font-size : 11pt;
	margin : 10pt;
	padding-bottom : 10pt;
}

.bg-white{
	border-bottom : 1px solid silver;
	background-color : white;
}
</style>
<script>
	$(document).ready(function(){
		
		 /* $("#callCommentsList").load("./commentsList.do ", {'postNo' : $('#postNo').val()},  function(){
			include 대신에 사용해도 됨 
		 });  */
		 
		 
		$("#listBtn").on("click", function(){
			frm.action = "./pBoardList.do";
			frm.submit();
		});
		
	 	$("#editBtn").on("click", function(){
			frm.action="./editView.do";
	 		frm.submit();  
		});
	 	
	 	$("#replyBtn").on("click", function(){
	 		frm.action="./replyView.do";
	 		frm.submit();
	 	})
	 	
	 	call = function(postNo){
	 		var a = postNo;
	 		$("#postNo").val(a);
	 		frm.action="./updateView.do"
			frm.submit();
	 		
	 	}
	 	
/* 	 	$(".update").on("click", function(){
	 		$("#postNo").val('');
			var a = $(this).attr("data");
			$("#postNo").val(a);
			frm.action="./updateView.do"
			frm.submit();
	 	})
	 	
	  	$(".callPostBoard").on("click", function(){
	 		$("#postNo").val('');
			var c = $(this).attr("call");
			$("#postNo").val(c);
			frm.action="./updateView.do"
			frm.submit();
	 	}) 
 */
	 	 	
	 	var $frm = $("#frm").serialize();
		$("#deleteBtn").on("click", function(){
			var c = $("input[name='postNo']").val();
			var arr = [];
			arr.push(c);
			
			$.ajax({
				 type : "POST",
				 url : "./delete.do",
			     data : {
			    	 'chk' : arr
			     },
			     success : function(data){
			    	 if(data. message == "exist"){
			    		 alert("답글 존재시 게시글 삭제 불가");
			    	 } else {
			    		 alert("삭제 성공");
			    		 window.location.href = "./pBoardList.do";
			    	 }
			        },
		       	 error : function(){
		            alert('통신 실패');
		       	}
			});
				
		}); 
		

	
		$("#cmtBtn").on("click", function(){
		
			var postNo = $("#postNo").val();
			var cno = $("#cno").val();
			var writer = $("#writer").val();
			var content = $("#content").val();
			var regDate = $("#regDate").val();
			
			//var cmtFrm = $("#cmtFrm").serialize(); //왜 postNo가 null 처리되는지?
				
				//유효성 검사 후 등록
				if(writer == ""){
					alert("작성자를 입력해주세요.")
					$("#writer").focus();
				} else if(content == ""){
					alert("댓글 내용을 입력해주세요.");
					$("#content").focus();
				} else{
					$.ajax({
						type : "POST",
						url : "./comments.do",
						data : {
							'cno' : cno,
							'regDate' : regDate,
							'postNo' : postNo,
							'writer' : writer,
							'content' : content
						},
						success : function(data){
							alert("등록 성공");
							 //window.location.href = "./commentsList.do";
							 $("#callCommentsList").load("./commentsList.do ", {'postNo' : $('#postNo').val()},  function(){
								 
							 }); 
							 
							 $("#writer").val('');
							 $("#content").val('');
						},
						error : function(){
							alert("통신 실패");
						}
					});
					
				}
		});
		
	});
	
</script>

</head>
<body>
	<div class="container" role="main" style="padding: 40px;">
		<h2>게시물 조회</h2>
		<br>
		<form name="frm" id="frm" method="post">
		<div class="bg-white rounded shadow-sm mb-3">
			<!-- Sql 쿼리에서 where 절을 postNo별 postTitle parameter 넘기기 위해 input hidden 사용//Controller에서 하나씩 조회하는 메소드에 대해 p라는 키값 사용했음  -->
			<input type="hidden" id="postNo" name="postNo" value="${p.postNo}" > 
			<input type="hidden" id="originNo" name="originNo" value="${p.originNo }">
			<div class="board_title" >
				<c:out value="${p.postTitle}" />
			</div>

			<div class="board_info_box">
				<span class="board_date"><c:out	value="${p.postInsert}" /></span> / 
				<span class="board_date"><c:out	value="${p.formattedDate}" /></span>
			</div>

			<div class="board_content"><!-- c:out value="${p.postText}" escapeXml="false"/> -->
			<%-- ${fn:replace((fn:replace((fn:replace(fn:replace(p.postText, '&lt;', ''), '&gt;', '')), 'p','')),'/','')} --%>
			<c:out value="${p.strPostText}" escapeXml="false"/>
			</div>
			
		</div>

		<br>
		<!-- 게시글 조회일 경우 좋아요, 싫어요 버튼 -->
		<jsp:include page="votePost.jsp" />
		<!-- /게시글 조회일 경우 좋아요, 싫어요 버튼 -->
		<!-- 게시글 조회일 경우 답변, 수정, 삭제, 목록 버튼//답변 조회일 경우 수정, 목록 버튼만 구현 -->
		<div align="right">
			<c:if test="${p.originNo eq ''}" >  	
				<button type="button" class="btn btn-info" id="replyBtn">답변</button>
				<button type="button" class="btn btn-info" id="deleteBtn">삭제</button>
			</c:if>	
				<button type="button" class="btn btn-info" id="editBtn">수정</button>
				<button type="button" class="btn btn-info" id="listBtn">목록</button>
		</div>
		<!-- /게시글 조회일 경우 답변, 수정, 삭제, 목록 버튼//답변 조회일 경우 수정, 목록 버튼만 구현  -->
		<!-- 게시글 조회일 경우 답글 list 출력 -->
		<c:if test="${!empty replyList}">
			<div style="padding:30px 10px 10px 10px;" class="mb-3" id="callReplyTable">
				<h3>답글 목록</h3>
					<table class="table ">
						<c:forEach var="repResult" items="${replyList}">
						<tr id="${repResult.postNo }">
							<td align="center" style="width: 75%;">
							<a href="javascript:call('${repResult.postNo }')" ><c:out value="${repResult.postTitle }" /></a></td>
							<td align="right"><c:out value="${repResult.postInsert }" /></td>
							<td align="right"><c:out value="${repResult.formattedDate }" /></td>
						</tr>
						</c:forEach>		
					</table>
				</div>
			</c:if> 
			<!-- 답글 조회일 경우 게시글 list 출력 -->
			<c:if test="${p.originNo ne '' }">
			<div style="padding:30px 10px 10px 10px;" class="mb-3" id="callPostTable">	
			<h3>게시글</h3>
				<table class="table">
					<tr id="${p.originNo }">
						
						<td align="center" style="width: 75%;">
						<a href="javascript:call('${p.originNo }')"><c:out value="${originVO.postTitle }" /></a></td>
						<td align="right"><c:out value="${originVO.postInsert }" /></td>
						<td align="right"><c:out value="${originVO.formattedDate }" /></td>
					</tr>
				</table>
			</div>
			</c:if>
		</form>
		
		<!-- 원글에 대해서 댓글 기능 -->
		<c:if test="${p.originNo eq '' }">
			<!-- 댓글 입력창 -->
			<div class="container mb-3" style="padding:30px 10px 10px 10px; ">
				<h3>댓글 등록</h3>
					<div>
						<form id="cmtFrm" name="cmtFrm" method="post">
							<div class="form-row">
								<div class="form-group col-md-3">
									<input type="text" id="writer" name="writer" class="form-control" placeholder="댓글 작성자"/>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-10">
									<textarea class="form-control" rows="3" name="content" id="content" placeholder="댓글 입력" ></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-sm-offset-2 col-sm-10"style="position: relative; top: -35px; right: -750px;">
									<button type="button" class="btn btn-primary" id="cmtBtn" name="cmtBtn">등록</button>
								</div>
							</div>
						</form>	
					</div>					
				</div>	
				
			<!-- 댓글 목록 출력 -->
			
			 <div style="padding:30px 10px 10px 10px;" class="mb-3" id="callCommentsList" name="callCommentsList">
			<!--   include file="commentsList.jsp"  -->
			 <jsp:include page="commentsList.jsp"/>
				<%-- <h3>댓글 목록</h3>
					<table class="table">
						<c:forEach var="cmtList" items="${commentsList}">
						<tr >
							<td align="center" style="width: 75%;"><c:out value="${cmtList.content }" /></td>
							<td align="right"><c:out value="${cmtList.writer }" /></td>
							<td align="right"><c:out value="${cmtList.regDate }" /></td>
						</tr>
						</c:forEach>		
					</table>  --%>
			</div> 
			
			</c:if>
		</div>
</body>
</html>