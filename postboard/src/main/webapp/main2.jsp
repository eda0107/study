<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script>
	$(document).ready(function(){
		 
		//select box안에 option을 바꿀 때마다 이벤트 발생
		/* $('select').on('change', function(){
	
			 $.ajax({
		        type : "POST",
		        url : "data2.jsp",
		        data : {
					//selectPortal : $("select option:selected").val()
					selectPortal : $(this).val()
		        },
		        success : function(data){
		            $("#content").html(data);
		        },
		        error : function(){
		            alert('통신실패');
		       	}
		        
		       });	
		  });
		 */
		//포탈명을 클릭하면 포탈사이트를 팝업
		
		//동적으로 생성된 태그에 이벤트를 주는 것
		//36~ 의 코드는 div 태그 안에 또 다른 div 태그를 만들어서 생성된 div가 동작하는 것
		//$("#content").on('click',function(){
	 	//var call = $("#content div").attr("url"); 38과 같다
	 	//var call = $(this).find('div').attr("url"); 37과 같다
	 	//	window.open(call); 
	 	//}); */
	 	
	 	func = function(obj){ // == this
			$(this).val(this);
	 		$.ajax({
	 			type: "POST",
	 			url : "data2.jsp",
	 			data : {
	 				selectPortal : 
	 			}, 
	 			success : function(data){
	 				$("#content").html(data);
	 			},
	 			error : function(){
	 				alert("통신 실패");
	 			}
	 		})
	 	}
	});
		
		
	//동적으로 생성된 태그에 이벤트
	//36의 코드보다 이쪽이 적합하다
	//click 했을 때 content div안에서 37,38이 발생하는 것과 같다
	$(document).on('click','#content div', function(){
		var call = $(this).attr("url");
 		window.open(call);
	});
	
	
	


</script>
</head>
<body>

<div>
	<select onchange="func(this)">
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
	</select>
	<select onchange="func(this)">
		<option value="daum">daum</option>
		<option value="naver">naver</option>
		<option value="nate">nate</option>
	</select>

</div>
<div id="content">
</div>
</body>
</html>

<!--
- main.jsp 의 select 박스를 선택할 때마다 옵션의 값을 data.jsp 로 보냅니다.
- data.jsp 에서는 파라메터 값에 따라서 div 태그를 만듭니다.
- 만들어진 div 태그 값은 main.jsp 로 리턴합니다.
- main.jsp 에서는 'content' div 에 리턴 받은 태그를 만듭니다.
-?그리고 포탈명을 클릭을 하면 해당 포탈 사이트를 팝업합니다.
?

두 파일을 수정하여 위의 기능이 정상적으로 실행되도록 합니다.?
-->