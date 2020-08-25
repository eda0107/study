<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TEST!!</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script>

 $(document).ready(function(){
	/* var i=0;
	var color=["red","blue"];
	 	$("#changeBtn").click(function(){
	 		//sample class의 span 태그만
	 		//$(".sample span").css("color",color[i]);
	 		//.contains("찾고싶은 문자") 함수를 이용해서 id나 class가 지정되어있지 않아도 태그로 찾을 수 있음
	 		$('span:contains("SAMPLE")').css("color",color[i]);
	 		i++;
	 		if(i==2){
	 			i=0;
	 			}
		 }); */
	var flag = true;
	$('#changeBtn').on('click', function(){
		/* if(flag) {
			$('span').eq(4).css('color','red');
			flag = false;
		} else {
			$('span').eq(4).css('color','blue');
			flag = true;
		} */	
	
		
		 if(flag) {
			//$('span').last().css('color','red');
			$('span:contains("SAMPLE")').css("color",'red');
			flag = false;
		} else {
			//$('span').last().css('color','blue');
			$('span:contains("SAMPLE")').css("color",'blue');
			flag = true;
		} 
	});
	
 })
//jQuery id로 접근시 $("#id");				ex> $("#id")
//class로 접근시 $(".class"); 				ex> $(".section_nav")
//name으로 접근시 $(tag_name[name=name]); 	ex> $("input[name=search_value]");
</script>
<style type="text/css">
	.sample {
		font-family: 굴림;
		font-size: 11pt;
	}
</style>
</head>
<body>
	<div class="sample">
	<header></header>
	<aside></aside>
	<section>
	<div>
		<div>
			<div>
				<div>
					<div>
						<div>
							<ul>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li></li>
								<li>
									<ul>
										<li><span>TEST</span></li>
										<li><span>TEST</span></li>
										<li><span>TEST</span></li>
										<li><span>TEST</span></li>
										<li><span>SAMPLE</span></li>
									</ul>
								</li>
								<li></li>
								<li></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	</div>
	<button id="changeBtn">변경</button>
</body>
</html>
 
<!--	
		• changeBtn 을 클릭할 때마다, SAMPLE 글자가 빨간색, 파란색으로 변경하도록 하시오.
		• html 태그는 절대 수정하시면 안됩니다.
-->
