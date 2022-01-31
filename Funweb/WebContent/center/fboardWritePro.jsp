<%@page import="com.itwillbs.board.BoardDAO"%>
<%@page import="com.itwillbs.board.BoardDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>WebContent/center/fboardWritePro.jsp</h1>

	<%
	  // 파일 업로드
	  // 파일이 저장될 가상경로 - upload라는 폴더가 있어야함
	  String realPath = request.getRealPath("upload");
	
	  // 업로드 파일크기 지정
	  int maxSize = 10 * 1024 * 1024; // 10MB
	  
	  MultipartRequest multi = new MultipartRequest(
			  						request,
			  						realPath,
			  						maxSize,
			  						"UTF-8",
			  						new DefaultFileRenamePolicy()
			  						);
	  // 파일 업로드 완료 ! -> 서버(톰캣-폴더)	  
	
	
	  // 디비에 저장 -> 파일이름 정보를 디비에 저장
	  BoardDTO bdto = new BoardDTO();
	  // 전달된 정보를 저장
	  
	  bdto.setName(multi.getParameter("name"));
	  bdto.setPass(multi.getParameter("pass"));
	  bdto.setSubject(multi.getParameter("subject"));
	  bdto.setContent(multi.getParameter("content"));
	  bdto.setFile(multi.getFilesystemName("file")); // 파일명
	  bdto.setIp(request.getRemoteAddr());
	  
	  // DB저장
	  BoardDAO bdao = new BoardDAO();
	  
	  bdao.insertBoard(bdto);
	  
	  // 리스트로 페이지 이동
	  response.sendRedirect("notice.jsp");
	
	
	%>





</body>
</html>