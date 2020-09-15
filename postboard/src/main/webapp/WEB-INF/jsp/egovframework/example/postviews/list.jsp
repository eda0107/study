<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 개발</title>
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script>
	$(document).ready(function(){
		//등록 이벤트
		$("#regBtn").on("click", function(){
			window.location.href = "./registerView.do";
		});
		
		//검색 이벤트
		$("input[name=searchBtn]").on("click",function(){
			board.action = "./pBoardList.do";
			board.submit();
		});
		
		//답글 목록 이벤트
		reply = function(postNo){
			if($('.reply_' + postNo).length > 0){
				$('.reply_' + postNo).remove();
			} else {
				$.ajax({
					type: 'POST',
					url : './replyList.do',
					data : { //답글 조회시 postNo 필요
						'postNo' : postNo
					},
					dataType : 'json',
					success : function(data){
						var $tr = $("#" + postNo); //원글 postNo를 가져와 테이블 생성 + 밑의 tr 태그에서 원글 번호-답글 mapping
						for(var i=0; i < data.replyList.length; i++){
							var html = '';
							html += '<tr class="reply_' + postNo + '">'; //답글 class=원글 postNo
							html += '<td></td>'; //체크박스
							html += '<td></td>'; //rownum
							html += '<td><a href="#" class="update" data="' + data.replyList[i].postNo +'">' + data.replyList[i].postTitle + '</a></td>'; //제목
							html += '<td></td>'; //조회수
							html += '<td>' + data.replyList[i].postInsert + '</td>'; //작성자
							html += '<td>' + data.replyList[i].formattedDate +  '</td>'; //작성일
							html += '</tr>';
							//원글마다 답글 테이블 추가
							$tr.after(html);
						}
					}, 
					error : function(e){
						alert("통신 실패");
					}
					
				});
			}
		}
		
		//페이징 이벤트
		paging = function(pageToMove){
			alert();
			var pageNo = pageToMove;
			$("#pgIdx").val(pageNo); // javascript:paging('a') --> $("#pgIdx").val('a') --> paginationInfo.currentPageNo  == 'a'
			board.action = "./pBoardList.do";
			board.submit();
		};
		
	});
</script>
</head>
<body>
	<form name="board" id="board" method="post" action="./pBoardList.do">
		<div style="padding: 40px;">
			<!-- 타이틀 -->
			<div>
				<!-- <p><button type="button" id="loginBtn">로그인</button></p> -->
				<p><h2>전자정부프레임워크 게시판</h2>
			</div><br>
			
			<!-- 검색창, 삭제 버튼 -->
			<div>
				<div style="width:25%;  float:left;">
					<div style="position: relative;  float:left;">
						<select name="searchCondition" id="searchCondition" style="width:80px; ">
							<option selected value="0" <c:out value="${PostBoardVO.searchCondition eq '0' ? 'selected' : ''}" />>전체</option>
							<option value="1" <c:out value="${PostBoardVO.searchCondition eq '1' ? 'selected' : ''}" />>제목</option>
							<option value="3" <c:out value="${PostBoardVO.searchCondition eq '3' ? 'selected' : ''}" />>작성자</option>
						</select>
					</div>
					
					<!-- currentPage -->
					<input type="hidden" id="pgIdx" name="pgIdx" value="${paginationInfo.currentPageNo }">
					<!-- postNo 넘길 것: ajax -->
					<input type="hidden" id="postNo" name="postNo" value="">
					
					<input type="text" id="searchKeyword" name="searchKeyword" placeholder="검색어를 입력하세요">
						<span>
							<input type="submit" id="searchBtn" name="searchBtn" value="검색">
						</span>
				</div>
				<div>
					<button type="button" id="deleteBtn" name="deleteBtn" style="position:relative; float:left;">삭제</button>
					<button type="button" id="regBtn" name="regBtn" style="position:relative; ">등록</button>
				</div>
			</div>
			<br><br>
			
			<!-- 목록 조회 -->
			<div>
				<table id="boardList">
					<tbody>
						<tr>
							<th></th>
							<th>No</th>
							<th>제목</th>
							<th>조회수</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
						<c:forEach items="${postList }" var="result">
							<tr id="${result.postNo }">
								<td><input type="checkbox" id="chk" name="chk" value="${result.postNo }"></td>
								<td><c:out value="${result.rn }" /></td>
								<td>
									<a href="#" class="update" data="${result.postNo }"><c:out value="${result.postTitle }" />
										<span>
											<c:if test="${result.cnt > 0 }">
												<a href="javascript:reply('${result.postNo }')">[${result.cnt}]</a>
											</c:if>
										</span>
									</a>
								</td>
								<td><c:out value="${result.postViews }" /></td>
								<td><c:out value="${result.postInsert }" /></td>
								<td><c:out value="${result.formattedDate }" /></td>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<br>
			
			<!-- 페이징 -->
			<div>
				<!-- 처음 -->
				<c:if test="${paginationInfo.firstPageNoOnPageList > 0 }">
						<a href="javascript:paging('1')" >처음</a>
				</c:if>
				<!-- 이전 -->
				<c:if test="${paginationInfo.currentPageNo > 1 }">
					<a href="javascript:paging('${paginationInfo.currentPageNo - 1 }')">이전</a>
				</c:if>
				<!-- 페이지갯수 -->
				<c:forEach begin="1" end="${paginationInfo.lastPageNoOnPageList}" varStatus="status">
					<!-- 현재 페이지 == 0부터 시작하는 루프의 index 번호 -->
					<c:if test="${paginationInfo.currentPageNo eq status.index}"> </c:if>
						<a href="javascript:paging('${status.index }')">${status.index }</a>
				</c:forEach>
				<!-- 다음 -->
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.totalPageCount && paginationInfo.totalPageCount > 0 }">
						<a href="javascript:paging('${paginationInfo.currentPageNo + 1}')">다음</a>
				</c:if>
				<!-- 끝 -->	
				<c:if test="${paginationInfo.currentPageNo ne paginationInfo.pageSize && paginationInfo.pageSize > 0 }">
					<a href="javascript:paging('${paginationInfo.lastPageNoOnPageList}')" >끝</a>
				</c:if>
			</div>
		</div>
	</form>
</body>
</html>