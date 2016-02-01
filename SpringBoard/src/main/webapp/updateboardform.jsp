<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.springboard.BoardVO" %>
<%@ page import="com.spring.springboard.BoardDAO" %>

<%
	if(session.getAttribute("loginID") == null )
		response.sendRedirect("./loginForm.jsp");
	
	int seq = Integer.parseInt(request.getParameter("seq"));
	
	BoardDAO boardDAO = new BoardDAO();
	BoardVO boardVO = new BoardVO();
	boardVO.setSeq(seq);
	BoardVO vo = boardDAO.getBoard(boardVO);
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ۼ���</title>
</head>
<body>
<center>
<h3>�� �����ϱ�</h3>
<hr>
<form action="board.do?method=updateBoard" method="post">
<input type="hidden" name="seq" value="<%=vo.getSeq() %>"/>
<table border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>����</td>
		<td><input type="text" name="title" value="<%=vo.getTitle() %>"/></td>
	</tr>
	<tr>
		<td>�ۼ���</td>
		<td><%=vo.getWriter() %></td>
	</tr>
	<tr>
		<td>����</td>
		<td><textarea name="content" cols="40" rows="10"><%=vo.getContent() %></textarea></td>
	</tr>
		<tr>
		<td colspan="2" align="center"><input type="submit" value="�����ϱ�"/></td>
		</tr>
</table>
</form>
<hr>
</center>
</body>
</html>