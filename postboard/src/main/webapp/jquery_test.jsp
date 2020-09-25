<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
</head>
<!-- 
	html 절대 수정 금지
	하나의 selectbox 값이 변경되면 나머지 selectbox를 초기화 시키세요.
-->
<body>
	<div>
		<select>
			<option value="">- 과일 -</option>
			<option value="">바나나</option>
			<option value="">사과</option>
			<option value="">복숭아</option>
		</select>
		<select>
			<option value="">- 동물 -</option>
			<option value="">강아지</option>
			<option value="">원숭이</option>
			<option value="">사자</option>
		</select>
		<select>
			<option value="">- 언어 -</option>
			<option value="">한국어</option>
			<option value="">영어</option>
			<option value="">중국어</option>
		</select>
	</div>
</body>
</html>
<script>
$(document).ready(function(){
	$("select").on("change", function(){
		//$("select").not($(this)).find("option:first").prop("selected", true); //1. 셀렉트 요소 중에 본인이 아닌 거(this->change된 select)의 첫번째 옵션을 찾아 selected로 하라
		$(this).siblings('select').find("option:first").prop("selected", true); //2. 형제 노드 찾아서 제어
		//$("select option:first").prop('selected',true);
		//prop("selected", true); js의 프로퍼티
		//attr("selected", "selected"); html의 속성, selected = selected 속성 부여
	});
	

});
</script>