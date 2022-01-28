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
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>답글쓰기 페이지</h1>

<%
  // 전달된 파라미터 데이터 저장(num,re_ref,re_lev,re_seq)
  int num = Integer.parseInt(request.getParameter("num"));
  int re_ref = Integer.parseInt(request.getParameter("re_ref"));
  int re_lev = Integer.parseInt(request.getParameter("re_lev"));
  int re_seq = Integer.parseInt(request.getParameter("re_seq"));
%>

<form action="reWritePro.jsp" method="post">
    <!-- 화면에 표현없이 단순히 정보(데이터)만 전달 -->
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="re_ref" value="<%=re_ref%>">
	<input type="hidden" name="re_lev" value="<%=re_lev%>">
	<input type="hidden" name="re_seq" value="<%=re_seq%>">

<table id="notice">
<tr><th class="tno" colspan="5">ITWILL 게시판</th></tr>
    
	<tr>
		<td colspan="2"> 글쓴이 : </td>
		<td class="left" colspan="3"><input type="text" name="name"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 비밀번호 : </td>
		<td class="left" colspan="3"><input type="password" name="pass"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 제목 : </td>
		<td class="left" colspan="3"><input type="text" name="subject" value="[답글]"> </td>
	</tr>
	
	<tr>
		<td colspan="2"> 글 내용 : </td>
		<td class="left" colspan="3">
		   <textarea rows="10" cols="20" name="content"></textarea>
		</td>
	</tr>
	 
</table>


<div id="table_search">
	<input type="submit" value="답글쓰기" class="btn">
</div>

</form>

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