<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
</head>
<body>
	
	<section>
		<!-- 입력한 숫자만큼 select option 을 생성해서 'content' div 에 나타나도록 합니다. -->
		<div>
			<input type="text" maxlength="2"/>
			<span><a href="#">선택하기</a></span>
		</div>
		
		<!-- 입력한 숫자를 곱해서 결과 값을 받아서 값이 값이 정확하게 넘어왔는지 검증을 한 후에'content' div 에 나타나도록 합니다. -->
		<div>
			<input type="text" maxlength="2"/>
			<span><a href="#">곱하기</a></span>
		</div>
		
		<!-- 입력한 숫자를 ifr.jsp 에서 호출 합니다. -->
		<div>
			<input type="text" maxlength="1"/>
			<span><a href="#">iframe 호출</a></span>
		</div>
	</section>
	
	<div id="content"></div>
</body>
</html>
<!-- 
위 소스는 절대 수정 하시면 안됩니다. 
- input 에는 숫자만 입력이 가능해야 합니다.
- 선택하기, 곱하기, iframe 호출 을 클릭할 때마다 화면 초기화가 되어야 합니다.
- eq 사용 불가
-->

<script>
$(document).ready(function() {
	
	$("span").on("click", function(){ 	
		//부묘요소 기준으로 몇번째 자식인지 알 수 없을땐 var i = $(this).index()
		//var j + $("button").index(this) 존재하는 모든 버튼을 기준으로 index 찾기
		//제이쿼리 객체이기 때문에 this=span
		var selIndex =  $("span").index(this);
		//.siblings() 같은 노드 위치에서 선택된 요소를 제외한 나머지 요소들을 찾음
		//span 태그의 형제에서 input 태그의 value값을 전부 가져옴
		var inputNum = $(this).siblings("input").val(); 		
		
		if(inputNum == "") {
			alert("값을 입력하여 주십시오");
			return;
		}
		
		$('input').val('');
		$(this).siblings("input").val(inputNum);
	
		$.ajax({
			 type : "POST",
		     url : "data3.jsp",
		     data : {
		    	  returnType: selIndex,
		          listSize: inputNum		    	 
		        },
		     success : function(data){
		    	 	if(selIndex == "0") {
						$("#content").html(data);
		    	 	} else if(selIndex == "1") {
		    	 		var content = inputNum+"*"+inputNum+"="+data.trim()+" 입니다.";
				        $("#content").html(content);
		    	 	} else if(selIndex == "2") {
				        $("#content").html(data);
		    	 	}
		        },
		        error : function(){
		            alert('통신실패');
		       	}
		});
		

	});
	
	$(document).on('change', 'select', function(){
		alert("선택하신 번호는"+$(this).val()+"입니다.");
	});
	
	$('input').on('keyup', function(){
		 $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
});
		

		
		
		
</script>