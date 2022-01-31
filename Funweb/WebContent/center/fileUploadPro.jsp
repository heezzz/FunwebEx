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
 <h1>WebContent/center/fileUploadPro.jsp</h1>
 <%
   // 이전페이지에서 전달된 데이터 저장
   // => 파일 + 데이터 전달될 때 항상 파일부터 처리
   
   // 파일 처리
   // 1) WebContent/upload 폴더 생성 - 파일이 업로드 될 폴더
   String uploadPath = request.getRealPath("/upload");
   
   System.out.println(uploadPath);
   // 2) 업로드 파일의 크기를 제한
   int maxSize = 10*1024*1024; // 10MB
   
   // 3) 파일 업로드 -> MultipartRequest 객체 생성
   MultipartRequest multi 
   		= new MultipartRequest(
   				request,
		   		uploadPath,
		   		maxSize,
		   		"UTF-8",
		   		new DefaultFileRenamePolicy()
		   		);
   
   System.out.println("MultipartRequest 객체 생성완료 - 파일업로드 완료!");
   
   // 전달된 데이터(파일제외) 정보를 저장
   String name = request.getParameter("name");
   String msg = request.getParameter("msg");   
   String name2 = multi.getParameter("name");
   String msg2 = multi.getParameter("msg");
   // String fileName = multi.getParameter("filename");
   String fileName = multi.getFilesystemName("filename");
   String oFileName = multi.getOriginalFileName("filename");
   
 %>
 <h2> 이름 : <%=name %></h2>
 <h2> 메세지 : <%=msg %></h2>
 <h2> 기존의 form 태그와 다른 형태의 데이터 전송을 했기 때문에 처리 X 
 		MultipartRequest 객체를 사용하여 데이터 처리해야함.
 </h2>
 <h2> 이름 : <%=name2 %></h2>
 <h2> 메세지 : <%=msg2 %></h2>
 <hr>
 <h2> 업로드한 파일명(서버에 저장된 이름) : <%=fileName %></h2>
 <h2> 업로드한 원본 파일명 : <%=oFileName %></h2>
 
 <hr><hr>
 
 <h2> 다운로드 파일 : <a href="../upload/<%=fileName%>"><%=fileName %></a></h2>
 <h2><a href="file_down.jsp?file_name=<%=fileName%>">[<%=oFileName %>]파일 다운로드 ! </a></h2>
 
 
</body>
</html>