<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String selectPortal = request.getParameter("selectPortal"); //main2에서 data로 넘어오는 부분
	String[] portal = {new String("daum"), new String("naver"), new String("nate")};
	
	StringBuilder s = new StringBuilder();
	//String 비교할 때는 ==가 아니라 .equals()여야 함
	if(selectPortal.equals(portal[0])) {
		s.append("<div style='border:solid 1px blue;cursor:pointer;' url='http://m.daum.net'>");
		s.append(selectPortal).append("</div>");
		
	} else if(selectPortal.equals(portal[1])) {
		s.append("<div style='border:solid 1px green;cursor:pointer;'url='http://m.naver.com'>");
		s.append(selectPortal).append("</div>");
		
	} else {
		s.append("<div style='border:solid 1px red;cursor:pointer;' url='http://m.nate.com'>");
		s.append(selectPortal).append("</div>");
	}
%>

<%=s.toString()%>

