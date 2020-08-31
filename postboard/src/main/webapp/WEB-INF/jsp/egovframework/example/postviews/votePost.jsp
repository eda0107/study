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
			
			$.ajax({
				type : "POST",
				url : "./votePost.do",
				data : {
					'postNo' : postNo,
					'voteYn' : voteYn
				},
				success : function(data){
					$.ajax({
						type : "POST",
						url : "./selectVoteCnt.do",
						data : {
							'postNo' : postNo,
							'voteYn' : voteYn
						},
						success : function(result){
							alert(result.yCnt);
						},
						error : function(){
							alert("error");
						}
						
					})
					alert("투표 완료");
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
		<input type="hidden" id="voteYn" name="voteYn">
		<input type="hidden" id="voteKey" name="voteKey" value="">
		<input type="hidden" id="voteDate" name="voteDate">
			<c:if test="${p.originNo eq '' }">
				<button type="button" class="btn btn-sm" id="likePost" >좋아요(<c:out value=""/>)</button>
				<button type="button" class="btn btn-sm" id="hatePost" >싫어요(<c:out value=""/>)</button>	
			</c:if>
		</div>
	</div>
</body>
</html>