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
<script>
	$(document).ready(function(){
		
		
		//좋아요 버튼
		$("#likePost").on("click", function(){
			$("#frm #voteYn").val('Y');
			saveVote();
		});
		
		//싫어요 버튼
		$("#hatePost").on("click", function(){
			$("#frm #voteYn").val('N');
			saveVote();
		});
		
		saveVote = function(){
			var postNo = $("#postNo").val();
			var voteYn = $("#voteYn").val();
			var voteKey = $("#voteKey").val();
			var voteDate = $("#voteDate").val();
			var yCnt;
			var nCnt; 
			
			$.ajax({
				type : "POST",
				url : "./votePost.do",
				data : {
					'postNo' : postNo,
					'voteYn' : voteYn
				},
				success : function(data){
					
					var promise = $.ajax({
						type : "POST",
						url : "./selectVoteCnt.do",
						data : { //게시글 당 Y/N 세어줘야 하는 거니까 여기서도 같이 sql에 data로 보내줘야 함
							'postNo' : postNo,
							'voteYn' : voteYn
						},
						 async : false, //동기식
						success : function(result){
						 	yCnt = result.yCnt;
							nCnt = result.nCnt;
							$("#likePost").html("좋아요(" + yCnt + ")");
							$("#hatePost").html("싫어요(" + nCnt + ")"); 
						},
						error : function(){
							alert("error");
						}
					}); 
				},
				error : function(){
					alert("ajax 실패");
				}
			});
		}
		
	});
</script>
</head>
<body>

	<div align ="left" style="float:left;" id="postVote">
		<div >
		<input type="hidden" id="voteYn" name="voteYn" >
		<input type="hidden" id="voteKey" name="voteKey" value="">
		<input type="hidden" id="voteDate" name="voteDate">
			<c:if test="${p.originNo eq '' }">
			<!-- value 값 지정할 때 객체 안에서 꺼낼 게 하나밖에 없음(cnt) -->
				<button type="button" class="btn btn-sm" id="likePost" name="likePost">좋아요(<c:out value="${yCnt}"/>)</button>
				<button type="button" class="btn btn-sm" id="hatePost" name="hatePost">싫어요(<c:out value="${nCnt}"/>)</button>	
			</c:if>
		</div>
	</div>
</body>
</html>