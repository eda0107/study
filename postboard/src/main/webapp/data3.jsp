<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/* 이 파일은 절대 수정 하지 마십시오. */
	
	String listSize = request.getParameter("listSize");
	String returnType = request.getParameter("returnType");
	//returnType: span에서 뭘 클릭할지에 따라서 밑에 생기는 게 달라짐
	//<select>, <span>, <iframe>
	
	int n = 0;
	if (listSize != null) {
		n = Integer.parseInt(listSize);
	}
	
	
	
	StringBuilder s = new StringBuilder();
	
	if (returnType.equals("0")) {
		s.append("<select>");
		s.append("<option value=''>선택</option>");
		for (int i = 0; i < n; i++) {
			s.append("<option value='").append(i).append("'>").append(i).append("</option>");
		}
		s.append("</select>");
		
	} else if (returnType.equals("1")) {
		s.append("<span>").append(n*n).append("</span>");
		
	} else if (returnType.equals("2")) {
		s.append("<iframe src='ifr.jsp' style='border : solid 1px green; background-color : gray; width : 100%; height : 100px; z-index=0'></iframe>");
	}
%>
<%=s.toString()%>