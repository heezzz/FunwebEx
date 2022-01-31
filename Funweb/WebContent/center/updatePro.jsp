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
	<h1>WebContent/center/updatePro.jsp</h1>
	
	<%
	 // 한글처리
	 request.setCharacterEncoding("UTF-8");
	 
	 // pageNum 정보저장
	 String pageNum = request.getParameter("pageNum");
	 
	 // 전달된 수정할 정보를 저장 (이름,비밀번호,제목,내용, 글번호)
	 // => 액션태그	
	%>
	<jsp:useBean id="bdto" class="com.itwillbs.board.BoardDTO"/>
	<jsp:setProperty property="*" name="bdto"/>
	
	<%
	  System.out.println(" 수정 정보 : "+bdto);
	
	 // DAO 객체 생성
	 BoardDAO bdao = new BoardDAO();
	 // 정보 수정 메서드
	 int result = bdao.updateBoard(bdto); 
	
	 if(result == 1){ // 수정완료
		 %>
		  <script type="text/javascript">
		     alert(" 게시글 수정완료! ");
		     location.href='notice.jsp';
		  </script>		 
		 <%		 
	 }else if(result == 0){
		 %>
		  <script type="text/javascript">
		     alert(" 비밀번호 오류!");
		     history.back();
		  </script>
		 <%
	 }else{
		 %>
		  <script type="text/javascript">
		     alert(" 게시글 없음!");
		     history.back();
		  </script>
		 <%
	 }
	%>

</body>
</html>