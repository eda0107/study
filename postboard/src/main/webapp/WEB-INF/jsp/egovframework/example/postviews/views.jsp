<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

	//function 사용 전에  taglib prefix="fn" 추가
	/*  function fn_paging(currentPageNo) {
		//get방식
 		//location.href = "./pBoardList.do?pageIndex="+currentPageNo+"&searchCondition="+$('#searchCondition').val()+"&searchKeyword="+$('#searchKeyword').val();	
 		
 		// post방식
 		$("#pageIndex").val(currentPageNo);
 		list.action = "./pBoardList.do";
		list.submit();
		} */
		
	/* 	function fnSearch(){ 		
	 		//get방식
			//var url = "./pBoardList.do";
			//url = url + "?searchCondition=" + $('#searchCondition').val();
			//url = url + "&searchKeyword=" + $('#searchKeyword').val();
			//location.href = url;
	
			// post방식
			list.action = "./pBoardList.do";
			list.submit();
			}  */	

	//상세조회시 제목 버튼 누르면 rownum별로 저장된 정보 불러오는 jQuery
	//data는 rownum이 담겨있음(rownum을 postNo로...)
	$(document).on("click", ".update", function(){
		//답글 이벤트를 위해서 ready가 아니라 따로 빼줘야함(동적 이벤트라서 ready 안에 들어가면 실행X)
			$("#postNo").val('');
			var a = $(this).attr("data");
			$("#postNo").val(a);
			list.action="./updateView.do"
			list.submit();
	});	
			
	$(document).ready(function(){
		//페이징 관련 jQuery 함수
		//attr로 사용자 정의 class의 속성값을 가져와 변수에 지정
		//페이징 처리 함수
			paging = function(pageToMove){
				var pageNo = pageToMove;
				$("#pageIndex").val(pageNo);
				list.action = "./pBoardList.do";
				list.submit();
				};
			
			//답글 이벤트
			reply = function(postNo){	
				//a태그 클릭시 slideToggle처럼 움직이게
				//data에 가져오는 건 SQL에서 조건절에 해당하는 컬럼값을 받아와야 함
				if($('.reply_' + postNo).length > 0){ //답글 리스트가 출력된 상태라면 다시 없애고
					$('.reply_' + postNo).remove();
				} else { //답글 리스트가 출력되지 않은 상태라면 출력하기
					$.ajax({
						type : "POST",
						url : "replyList.do",
						data :  {
							//'해당 ajax에서 server로 넘길 때 요구하는 데이터(조회시 sql에서 요구하는)': '내가 parameter로 넣어줘야할? 전송할? 데이터'
							'postNo' : postNo
							},
						dataType:'json',
						success : function(data){
							//게시글의 postNo를 가져온다 - postNo별로 답글을 mapping 시켜 table 생성하기 위해서
							var $tr = $('#' + postNo);
							//게시글 별로 답글 table tag 작성 
							for(var i = 0; i < data.replyList.length; i++){
								var html = '';
								html +='<tr class="reply_' + postNo + '">';
								html +='<td></td>';
								html +='<td></td>';
								html +='<td align="left"><a href="#" class="update" data="' + data.replyList[i].postNo +'">' + data.replyList[i].postTitle + '</a></td>';
								html +='<td align="left">' + data.replyList[i].blobPostText + '</td>';
								html += '<td></td>';
								html +='<td align="center">' + data.replyList[i].postInsert + '</td>';
								html +='<td align="center">' + data.replyList[i].postInsdt + '</td>';
								html +='</tr>';
								//고유한 postNo에 table tag 추가(아래쪽에 넣기 위해 after // append 쓰면 옆에 붙는다)
								$tr.after(html);
						
								console.log(data.replyList[i]);
								}
							},
						error : function(request){
							alert(request.responseText);
							}
							}); 
				}
			};	
		
		//검색 버튼 jQuery 함수
		$("input[name=searchBtn]").on("click",function(){
			list.action = "./pBoardList.do";
			list.submit();
		});

		//두개 검색창 띄우기 위한 jQuery
		// 검색 타이틀이 바뀔 때 마다 변환
		$("select[name=s1]").change(function(){
			$("select[name=searchCondition]").val($("select[name=s1]").val());
		});
		
		// 검색 내용이 적용될 때 마다 변환
		$("input[name=s2]").keyup(function(){
			$("input[name=searchKeyword]").val($("input[name=s2]").val());
		})
		
		//삭제 이벤트
		$("button[name=deleteBtn]").on("click",function(){
			var conf = confirm("삭제하시겠습니까?");
			
			if(conf){
					 var arr = [];
					 var postNo = '';
					$("input[name='chk']:checked").each(function(){
						postNo += $(this).val() + ',';
						//211,332,331,
						arr.push($(this).val());
					});
					/* var c = $("input[name='postNo']").val();
					var a = $(".reply_" + postNo).length;
					$.ajax({
						type : "POST",
						url : "./getReplyCount.do",
						data : {
							'postNo' : c
						},
						dataType : "json",
						async : false,
						success : function(data){
							alert(data.replyCnt);
							replyCnt = data.replyCnt;
						},
						error : function(){
							alert("통신 실패");
						}
					});
					
					if(replyCnt > 0){
						alert("답글 존재시 게시글 삭제 불가");
					} else { */
						$.ajax({
							type : "POST",
							url : "./delete.do",
							data : {
								chk : arr
								}, 
							dataType:"json",
							success : function(data){
								if(data.message == "exist"){
									alert("답글 존재시 게시글 삭제 불가");
								} else{
									alert(data.data+'건 삭제 성공');
									window.location.href = "./pBoardList.do";
								}
								},
							error : function(request){
								alert(request.responseText);
		 						}
							}); 
					//}
				}
			});
		});
		
</script>
	
<style>
	.post{
	padding: 40px;
	}
	
	
</style>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
	<!-- form:form 사용 전 taglib  prefix="form" 추가  -->
	<!-- form 옵션 중 commandName은 5버전부터 에러가 나므로 modelAttribute을 대신 사용해야 함 / Controller에 @ModelAttribute("")과 같은 이름-->
	<form:form commandName="PostBoardVO" id="list" name="list" method="post" action="./pBoardList.do">
		<div id="content" class="post">
		
			<!-- 타이틀 -->
	       	<div id="title">
	       		<p><h2>전자정부프레임워크 게시판</h2></p>
	       	</div><br>
        	<!-- // 타이틀 -->
               	
        	<!-- 검색창, 등록 버튼 -->
        	<!-- 위 아래로 두 개 놓기 위해선 name이 중복되면 form 태그가 parameter를 넘길 때 어떤 name 속성을 취해야하는지 모르기 때문에 밑에 태그는 name없이... -->
			<div id="writebtn" align="right">
				 <div style="width:60%;" >    
			        <div class="col-xs-8 col-xs-offset-2" style="position: relative; left: 20px;">
					    <div class="input-group">
			                <div class="input-group-btn search-panel">
			                     <select id="searchCondition" name="searchCondition" class="form-control" style="width:80px;">
			                     	  <option selected value="0" <c:out value="${PostBoardVO.searchCondition eq '0' ? 'selected' : ''}" />>전체</option>
									  <option value="1" <c:out value="${PostBoardVO.searchCondition eq '1' ? 'selected' : ''}" /> >제목</option>
									  <option value="2" <c:out value="${PostBoardVO.searchCondition eq '2' ? 'selected' : ''}" /> >내용</option>
									  <option value="3" <c:out value="${PostBoardVO.searchCondition eq '3' ? 'selected' : ''}" /> >작성자</option>
								</select>
			                </div>
			                <!-- currentPage 넘기기 위해서 hidden으로 넘겨줌 -->
			           		<input type="hidden" id="pageIndex" name="pageIndex" value="${PostBoardVO.pageIndex }" > 
			           		<!-- postNo 넘기기 위한 input value는 위에서 jQuery 태그가 넣어줄 것-->
			           		<input type="hidden" id="postNo" name="postNo" value="" > 
			           		
			           		
			                <input type="text" id="searchKeyword" name="searchKeyword" class="form-control "  placeholder="검색어를 입력하세요" width="30" value="${PostBoardVO.searchKeyword }">
			                <span class="input-group-btn">
			                	<!-- input type="submit"이어야 form에서 action을 탄다 -->
			                    <input type="submit" class="btn btn-default" id="searchBtn" name="searchBtn"  value="검색">
			                </span>
			            </div>
			        </div>
			        <div>
			        	<button type="button" class="btn btn-default" id="deleteBtn" name="deleteBtn" style="position: relative; right: 56px;">삭제</button>
			        </div>
				</div>
			
				<span> 
					<!-- a가 버튼처럼 활용되려면 a 태그 안에 role="button" 必 -->
					<a class="btn btn-info" href="./registerView.do" role="button" style="position: relative; top: -34px;">등록</a>
				</span>
				<span>
					
				</span>
			</div>
			<!-- //검색창, 등록 버튼 -->
			
        	
			<!-- List -->
			<!-- class=update인 태그는 postTitle 별로 postNo를 가져오기 위해서 사용//위에 jQuery 함수 참고 -->
			<div id="table" >
				<table class="table table-striped" id="postBoardList">
					<tbody>
						<tr>
							<th class="text-center"></th>
							<th class="text-center">No</th>
							<th class="text-center">제목</th>
							<!-- <th class="text-center">내용</th> -->
							<th class="text-center">조회수</th>
							<th class="text-center">작성자</th>
							<th class="text-center">작성일자</th>
						</tr>
						<c:forEach var="result" items="${postList}">
							<tr class="tr" id="${result.postNo }">	
								<td align="center"><input type="checkbox" id="chk" name="chk" value="${result.postNo}"></td>
								<td align="center"><c:out value="${result.rn}" /></td>
								<td align="left">
								<a href="#" class="update" data="${result.postNo}"><c:out value="${result.postTitle }" /></a>
									<span class="reprep">
										<c:if test="${result.cnt>0}"><a href="javascript:reply('${result.postNo}')" >[${result.cnt}]</a></c:if>
									</span>
								</td>
								<%-- <td align="left"><c:out value="${result.strPostText }" escapeXml="false"/></td> --%>
								<td align="center"><c:out value= "${result.postViews }" /></td>
								<td align="center"><c:out value= "${result.postInsert }" /></td>
								<td align="center"><c:out value= "${result.formattedDate }" /></td>
								<%-- <fmt:parseDate pattern="yyyy-MM-dd" var="insdt" value="${result.postInsdt }" />
								<fmt:formatDate pattern="yyyy/MM/dd" value="${insdt }" /> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div> <br>
			<!--// List -->
	
			<!-- 검색창, 등록 버튼 -->
			<div id="" align="right">
			 <div style="width:60%">    
			        <div class="col-xs-8 col-xs-offset-2"  style="position: relative; left: 20px;">
					    <div class="input-group">
			                <div class="input-group-btn search-panel">
			                     <select id="" name="s1" class="form-control" style="width:80px;">
			                     	  <option selected value="0" <c:out value="${PostBoardVO.searchCondition eq '0' ? 'selected' : ''}" />>전체</option>
									  <option value="1" <c:out value="${PostBoardVO.searchCondition eq '1' ? 'selected' : ''}" /> >제목</option>
									  <option value="2" <c:out value="${PostBoardVO.searchCondition eq '2' ? 'selected' : ''}" /> >내용</option>
									  <option value="3" <c:out value="${PostBoardVO.searchCondition eq '3' ? 'selected' : ''}" /> >작성자</option>
								</select>
			                </div>
			                <input type="text" id="" name="s2" class="form-control "  placeholder="검색어를 입력하세요" width="30" value="${PostBoardVO.searchKeyword }">
			                <span class="input-group-btn">
			                	<!-- input type="submit"이어야 form에서 action을 탄다 -->
			                    <input type="submit" class="btn btn-default" id="searchBtn" name="searchBtn"  value="검색">
			                </span>
			            </div>
			        </div>
			        <div>
			        	<button type="button" class="btn btn-default" id="deleteBtn" name="deleteBtn" style="position: relative; right: 56px;">삭제</button>
			        </div>
				</div>
				
				<span>
					<!-- a가 버튼처럼 활용되려면 a 태그 안에 role="button" 必 -->
					<a class="btn btn-info" href="./registerView.do" role="button" style="position: relative; top: -34px;">등록</a>
				</span>
			</div><br>
			<!-- //검색창, 등록 버튼 -->
			
			<!-- Paging -->
			<div id="paging">
				<!-- eq: equal(==), ne: not equl(!=), empty: 객체의 값이 있다 없다를 구분 -->
				<!-- 처음 -->
				<c:if test="${!empty paginationInfo.firstPageNoOnPageList }">
					<ul class="pagination" style="margin: 20px -3px;" >
						<li><a href="javascript:paging('1')" >처음</a></li>
					</ul>
				</c:if>

				<!-- 이전 -->
				<c:if test="${!empty paginationInfo.currentPageNo && paginationInfo.currentPageNo >1 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="javascript:paging('${paginationInfo.currentPageNo-1}')">이전</a></li>
					</ul>
				</c:if>
				
				<!-- 페이지 숫자 표시 -->
				<ul class="pagination"  style="margin: 20px -3px;">
					<!-- c:forEach var="사용할 변수명" items="배열, 리스트 등" varStatus="인덱스에 사용할 변수명" -->
					<c:forEach begin="1" end="${paginationInfo.lastPageNoOnPageList}" varStatus="status">
						 <li <c:if test="${paginationInfo.currentPageNo eq status.index}"> class='active'</c:if>>
						 <a href="javascript:paging('${status.index}')" >${status.index }</a></li>
					</c:forEach>
				</ul>
				
				<!-- 다음 -->
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.totalPageCount && paginationInfo.totalPageCount > 0 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="javascript:paging('${paginationInfo.currentPageNo+1}')" >다음</a></li>
					</ul>
				</c:if>
				
				<!-- 끝 -->
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.pageSize && paginationInfo.pageSize > 0 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="javascript:paging('${paginationInfo.lastPageNoOnPageList}')" >끝</a></li>
					</ul>
				</c:if>
				
				<div align="right">
					<p>총 게시글 수: ${paginationInfo.totalRecordCount }</p>
				</div> 
				
			</div>
			<!-- //Paging -->
			
		</div>	
	</form:form>	
</body>
</html>