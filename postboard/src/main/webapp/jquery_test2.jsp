<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script>
$(document).ready(function(){
	liClick = function(o){ // o == this == $("li").eq(4)
		//parent() parents()-자신 포함 closest()-자신 포함 children()
		var find = $(o).parent().parent().siblings("div").eq(0).children().children().eq(2).trigger("click");
		//console.log(find);
	}
	
});
</script>
</head>
<!-- 
	html 절대 수정 금지
	'click' <li>를 클릭하면 위의 '3' <li>가 클릭 되도록 구현. 
-->
<body>
	<div>
		<div>
			<ul>
				<li><span>1</span></li>
				<li><span>2</span></li>
				<li onclick="alert('success'); return false;"><span>3</span></li>
				<li><span>4</span></li>
			</ul>
		</div>
		
		<div>
		</div>
		
		<div>
			<ul>
				<li onclick="liClick(this);"><span>click</span></li>
			</ul>
		</div>
		
	</div>
</body>
</html>
