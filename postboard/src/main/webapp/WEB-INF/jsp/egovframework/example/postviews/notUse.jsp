<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	$(document).ready(function(){
		$(".startPage").on("click",function(){
			var start = $(this).attr("start");
			$("#pageIndex").val(start);
	 		list.action = "./pBoardList.do";
			list.submit();
		});
		
		$(".prePage").on("click",function(){
			var pre = $(this).attr("pre")	
			$("#pageIndex").val(pre);
	 		list.action = "./pBoardList.do";
			list.submit()
		});
		
		$(".numbering").on("click",function(){
			var num = $(this).attr("num");
			$("#pageIndex").val(num);
	 		list.action = "./pBoardList.do";
			list.submit();
		});
		
		$(".nextPage").on("click",function(){
			var next = $(this).attr("next")
			$("#pageIndex").val(next);
	 		list.action = "./pBoardList.do";
			list.submit();
		});
		
		$(".endPage").on("click",function(){
			var end = $(this).attr("end")
			$("#pageIndex").val(end);
	 		list.action = "./pBoardList.do";
			list.submit();
		});
		
		$("#searchBtn").on("click",function(){
			list.action = "./pBoardList.do";
			list.submit();
		});
		
		// jquery 이용하여 등록 화면 들어가기
	/* 	$("#writebtn").on("click",function(){
			window.href = "./registerView.do";
		});  */
			
		$(".update").on("click", function(){
			$("#postNo").val('');
			var a = $(this).attr("data");
			$("#postNo").val(a);
			list.action="./updateView.do"
			list.submit();
			
		});
			
	});
/* 	
 	function fnSearch(){ 		
 		//get방식
		//var url = "./pBoardList.do";
		//url = url + "?searchCondition=" + $('#searchCondition').val();
		//url = url + "&searchKeyword=" + $('#searchKeyword').val();
		//location.href = url;

		// post방식
		list.action = "./pBoardList.do";
		list.submit();
		}  */
		
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
        	</div>
        	<!-- // 타이틀 -->
        	
        	<!-- 검색창 -->
		      <div class="container">
			    <div class="row" style="width:60%">    
			        <div class="col-xs-8 col-xs-offset-2">
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
				</div>
			</div>
        	<!-- //검색창 -->
        	
        	<!-- 검색창, 등록 버튼 -->
			<!-- a가 버튼처럼 활용되려면 a 태그 안에 role="button" 必 -->
			<div id="writebtn" align="right">
				<span> 
					<a class="btn btn-info" href="./registerView.do" role="button">등록</a>
				</span>
			</div>
			<!-- //검색창, 등록 버튼 -->
			<br>
        	
			<!-- List -->
			<div id="table">
				<table class="table table-striped">
					<tbody>
							<tr>
								<th class="text-center">No</th>
								<th class="text-center">제목</th>
								<th class="text-center">내용</th>
								<th class="text-center">조회수</th>
								<th class="text-center">작성자</th>
								<th class="text-center">작성일자</th>
							</tr>
						<c:forEach var="result" items="${postList}" >
							<tr >
								<td align="center"><c:out value="${result.rn}" /></td>
								<td align="left"><a href="#" class="update" data="${result.postNo}"><c:out value="${result.postTitle }" /></a></td>
								<td align="left"><c:out value="${result.postText }" /></td>
								<td align="center"><c:out value="${result.postViews }" /></td>
								<td align="center"><c:out value="${result.postInsert }" /></td>
								<td align="center"><c:out value="${result.postInsdt }" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div> 
			<!-- //List -->

			
			<!-- 검색창, 등록 버튼 -->
			<!-- a가 버튼처럼 활용되려면 a 태그 안에 role="button" 必 -->
			<div id="writebtn" align="right">
						<span>
							<a class="btn btn-info" href="./registerView.do" role="button">등록</a>
						</span>
			</div>
			<!-- //검색창, 등록 버튼 -->
			
			<!-- Paging -->
			<div id="paging">
				<!-- eq: equal(==), ne: not equl(!=), empty: 객체의 값이 있다 없다를 구분 -->
				
				<!-- 처음 -->
				<c:if test="${!empty paginationInfo.firstPageNoOnPageList }">
					<ul class="pagination" style="margin: 20px -3px;" >
						<li><a href="#" class="startPage" start="1" >처음</a></li>
					</ul>
				</c:if>
				
				<!-- 이전 -->
				<c:if test="${!empty paginationInfo.currentPageNo && paginationInfo.currentPageNo >1 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="#" class="prePage" pre="${paginationInfo.currentPageNo-1}">이전</a></li>
					</ul>
				</c:if>
				
				<!-- 페이지 숫자 표시 -->
				<ul class="pagination"  style="margin: 20px -3px;">
					<!-- c:forEach var="사용할 변수명" items="배열, 리스트 등" varStatus="인덱스에 사용할 변수명" -->
					<c:forEach begin="1" end="${paginationInfo.lastPageNoOnPageList}" varStatus="status">
						 <li <c:if test="${paginationInfo.currentPageNo eq status.index}"> class='active'</c:if>><a href="#" class="numbering" num="${status.index}" >${status.index }</a></li>
					</c:forEach>
				</ul>
				
				<!-- 다음 -->
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.totalPageCount && paginationInfo.totalPageCount > 0 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="#" class="nextPage" next="${paginationInfo.currentPageNo+1}">다음</a></li>
					</ul>
				</c:if>
				
				<!-- 끝 -->
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.pageSize && paginationInfo.pageSize > 0 }">
					<ul class="pagination"  style="margin: 20px -3px;">
						<li><a href="#" class="endPage" end="${paginationInfo.lastPageNoOnPageList}" >끝</a></li>
					</ul>
				</c:if>
				<div align="right">
					<p>총 게시글 수: ${paginationInfo.totalRecordCount }</p>
				</div> 
			</div>
			<!-- //Paging -->
		
				<%-- <div> 테스트 ${pageInfo.firstIndex} / ${pageInfo.endIndex+1}</div> --%>
			
		</div>	
	</form:form>	
</body>
</html>