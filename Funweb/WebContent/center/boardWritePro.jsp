<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>WebContent/center/boardWritePro.jsp</h1>
	<%
	    // 한글 처리
	    request.setCharacterEncoding("UTF-8");
	    // 전달되는 정보 저장(글쓴이,비밀번호,제목,내용)
	    // => 액션태그 (자바빈-BoardBean/BoardDTO)
	%>
	<!-- html -->
	<jsp:useBean id="bdto" class="com.itwillbs.board.BoardDTO"></jsp:useBean>
	<jsp:setProperty property="*" name="bdto"/>	
	<%    
	    System.out.println(" 전달된 정보 : "+bdto);
	    
	    // 사용자 IP정보 저장
	    bdto.setIp(request.getRemoteAddr());
	    
	    System.out.println(" 전달된 정보 : "+bdto);
	    // BoardDAO객체 생성 - insertBoard()
	    BoardDAO bdao = new BoardDAO();
	    bdao.insertBoard(bdto);
	    
	    
	    // 글목록 페이지(notice.jsp)이동 
	    response.sendRedirect("notice.jsp");
	    
		
	%>

















</body>
</html>