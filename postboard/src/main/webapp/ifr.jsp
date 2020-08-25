<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>

<div>
	<button>클릭!</button>	
</div>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>

<!-- 위 소스는 수정하지 마십시오. -->

<!-- 아래는 main.jsp 'iframe 호출'에 있는 input 값의 값을 가져와서 alert으로 띄워 주십시오. -->
<script type="text/javascript">
	
$(document).ready(function(){
	
	$("button").on("click", function(){
		
		alert("입력 값은"+$("input" , parent.document).eq(2).val()+" 입니다.");
	}); 
	
	
});
</script>