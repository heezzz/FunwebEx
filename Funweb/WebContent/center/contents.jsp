<%@page import="com.itwillbs.board.BoardDTO"%>
<%@page import="com.itwillbs.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
  <jsp:include page="../inc/top.jsp" />
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="boardWrite.jsp">글쓰기(new)</a></li>
<li><a href="notice.jsp">게시판 목록(List)</a></li>
<li><a href="#">파일 다운로드</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>글 본문 보기 페이지</h1>

<%
  // 전달된 파라미터값 저장(num,pageNum)
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

  // DAO 객체 생성
  BoardDAO bdao = new BoardDAO();
  
  // 조회수 1증가  - updateReadcount();
  bdao.updateReadcount(num);  
  
  // 기존의 글정보를 가져오기
  BoardDTO bdto = bdao.getBoard(num);  

%>


<table id="notice">
<tr><th class="tno" colspan="5">ITWILL 게시판</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name" value="<%=bdto.getName()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="subject" value="<%=bdto.getSubject()%>"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="20" name="content"><%=bdto.getContent() %></textarea>
		</td>
	</tr>
	
	<tr>
		<td colspan="2"> 첨부파일 : </td>
		<td class="left" colspan="3">
			<%=bdto.getFile()%>
			<a href="file_down.jsp?file_name=<%=bdto.getFile()%>"></a></td>
	</tr>
	 
</table>


<div id="table_search">
	<input type="button" value="수정하기" class="btn" onclick="location.href='updateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="삭제하기" class="btn" onclick="location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
	<input type="button" value="답글쓰기" class="btn" onclick="location.href='reWriteForm.jsp?num=<%=num%>&re_ref=<%=bdto.getRe_ref()%>&re_lev=<%=bdto.getRe_lev()%>&re_seq=<%=bdto.getRe_seq()%>';">
	<input type="button" value="목록으로" class="btn" onclick=" location.href='notice.jsp?pageNum=<%=pageNum %>'" >
</div>


<div class="clear"></div>


</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
 <jsp:include page="../inc/bottom.jsp" />
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>