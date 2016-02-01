<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.springboard.BoardVO" %>
<%@ page import="com.spring.springboard.BoardDAO" %>
<%
	// 조회할 게시물의 seq값 추출
	int seq = Integer.parseInt(request.getParameter("seq"));

	// DB 연동

	BoardVO vo = (BoardVO)request.getAttribute("boardVO");
	String userRole = (String)session.getAttribute("userRole");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>글상세</title>
</head>
<body>
<center>
<h3>글 상세</h3>
<hr>
<table border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>제목</td>
		<td><%=vo.getTitle() %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%=vo.getWriter() %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><textarea name="content" cols="40" rows="10" disabled="disabled"><%=vo.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<td>등록일</td>
		<td><%=vo.getRegdate() %></td>
	</tr>
	<tr>
		<td>조회수</td>
		<td><%=vo.getCnt() %></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><a href="board.do?method=addBoardForm">글등록</a>&nbsp;&nbsp;&nbsp;
		<a href="board.do?method=updateBoardForm&seq=<%=vo.getSeq() %>">글수정</a>&nbsp;&nbsp;&nbsp;
<%
		if(userRole.equals("admin")){
%>
		<a href="board.do?method=deleteBoard&seq=<%=vo.getSeq() %>">글삭제</a>&nbsp;&nbsp;&nbsp;
<%
		}
%>
		<a href="board.do?method=getBoardList">글목록</a>
	</td>
	</tr>	
</table>
</center>
</body>
</html>