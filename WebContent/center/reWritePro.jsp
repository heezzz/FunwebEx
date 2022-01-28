<%@page import="com.itwillbs.board.BoardDAO"%>
<%@page import="com.itwillbs.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/center/reWritePro.jsp</h1>
	<%
		// 한글처리 
		request.setCharacterEncoding("UTF-8");
		// 전달된 파라미터값 저장(num,re_ref,re_lev,re_seq,name,pass,subject,content)
		// 액션태그 사용-> 자바빈객체 생성
		//BoardDTO dto = new BoardDTO();
	%>
	 <jsp:useBean id="bdto" class="com.itwillbs.board.BoardDTO"/>
	 <jsp:setProperty property="*" name="bdto"/>
	
	<%
	  // bdto 객체안에 답글쓴 사람의 IP주소를 추가
	  bdto.setIp(request.getRemoteAddr());
	
	  // BoardDAO객체 생성
	  BoardDAO bdao = new BoardDAO();
	  // 답글쓰기 메서드 - reInsertBoard(dto);
	  bdao.reInsertBoard(bdto);
	  
	  // 페이지 이동
	  response.sendRedirect("notice.jsp");	
	%> 
	 









</body>
</html>