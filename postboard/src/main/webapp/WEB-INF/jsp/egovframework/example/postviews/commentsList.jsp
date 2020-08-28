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

</head>
<body>
	 <div class="container" style="padding:20px 60px 10px 10px;">
		<div class="mb-3" id="getCmtList"> 
			<h3>댓글 목록</h3>	
			<input type="hidden" id="getPostNo" name="getPostNo" value="${p.postNo}" >
			<table class="table">
				<c:forEach var="cmtList" items="${commentsList}">
					<tr id="${cmtList.postNo }">
						<td align="center" style="width: 75%;"><c:out value="${cmtList.content }" /></td>
						<td align="right"><c:out value="${cmtList.writer }" /></td>
						<td align="right"><c:out value="${cmtList.regDate }" /></td>
					</tr>
				</c:forEach>		
			</table>	
		</div>
	</div> 
</body>
</html>