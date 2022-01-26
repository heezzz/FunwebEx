<%@page import="com.itwillbs.board.BoardDTO"%>
<%@page import="java.util.List"%>
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
	<jsp:include page="../inc/top.jsp"/>
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
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<%
	// BoardDAO 객체 생성
	BoardDAO bdao = new BoardDAO();
	// 게시판 DB에 있는 글 개수를 확인
	int cnt = bdao.getBoardCount();
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// 페이징 처리
	
	// 한 페이지에 출력될 글 수 
	int pageSize = 3;
	
	// 현 페이지 정보 설정
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	// 첫행번호를 계산
	int currentPage = Integer.parseInt(pageNum);	
	int startRow = (currentPage-1)*pageSize + 1;
	



%>
<!-- 게시판 -->
<article>
<h1>게시판 목록 [글 갯수 : <%=cnt %>]</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>

<% if(cnt !=0){ 
	// DB에 있는 게시판의 글정보 모두를 가져오기
	
	//List boardList = bdao.getBoardList();
	List boardList = bdao.getBoardList(startRow,pageSize);
	for(int i=0;i<boardList.size();i++){
		BoardDTO bdto = (BoardDTO)boardList.get(i);
%>	
<tr>
	<td><%=bdto.getNum()%></td>
	<td class="left">
		<a href="contents.jsp?num=<%=bdto.getNum()%>&pageNum=<%=pageNum%>"><%=bdto.getSubject()%></a>
	</td>
    <td><%=bdto.getName() %></td>
    <td><%=bdto.getDate()%></td>
    <td><%=bdto.getReadcount() %></td>
</tr>
<%
	}//for
	}else{%>
<tr>
	<td colspan ="5">
	게시판에 글이 없습니다.<br>
	새 글을 작성하세요 ~ ! <br>
	<a href="boardWrite.jsp"> 글 쓰기 페이지로 </a>
	</td>
</tr>
<%} %>    
</table>
<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="search" class="btn">
</div>
<div class="clear"></div>
	<div id="page_control">
	<%if(cnt != 0){ 
		////////////////////////////////////////////////////////////////
		// 페이징 처리
		// 전체 페이지수 계산
		int pageCount = cnt / pageSize + (cnt%pageSize==0?0:1);
		
		// 한 페이지에 보여줄 페이지 블럭
		int pageBlock = 10;
		
		// 한 페이지에 보여줄 페이지 블럭 시작번호 계산
		int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
		
		// 한 페이지에 보여줄 페이지 블럭 끝 번호 계산
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
	
	%>
	<% if(startPage>pageBlock){ %>
		<a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
	<%} %>
	<% for(int i=startPage;i<=endPage;i++){ %>
		<a href="notice.jsp?pageNum=<%=i%>"><%=i %></a>
	<%} %>
	<% if(endPage<pageCount){ %>
		<a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
	<%} %>
	<%} %>
	</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
	<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>