<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.springboard.BoardVO" %>
<%@ page import="com.spring.springboard.BoardDAO" %>
<%
	// ��ȸ�� �Խù��� seq�� ����
	int seq = Integer.parseInt(request.getParameter("seq"));

	// DB ����

	BoardVO vo = (BoardVO)request.getAttribute("boardVO");
	String userRole = (String)session.getAttribute("userRole");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�ۻ�</title>
</head>
<body>
<center>
<h3>�� ��</h3>
<hr>
<table border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>����</td>
		<td><%=vo.getTitle() %></td>
	</tr>
	<tr>
		<td>�ۼ���</td>
		<td><%=vo.getWriter() %></td>
	</tr>
	<tr>
		<td>����</td>
		<td><textarea name="content" cols="40" rows="10" disabled="disabled"><%=vo.getContent() %></textarea>
		</td>
	</tr>
	<tr>
		<td>�����</td>
		<td><%=vo.getRegdate() %></td>
	</tr>
	<tr>
		<td>��ȸ��</td>
		<td><%=vo.getCnt() %></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><a href="board.do?method=addBoardForm">�۵��</a>&nbsp;&nbsp;&nbsp;
		<a href="board.do?method=updateBoardForm&seq=<%=vo.getSeq() %>">�ۼ���</a>&nbsp;&nbsp;&nbsp;
<%
		if(userRole.equals("admin")){
%>
		<a href="board.do?method=deleteBoard&seq=<%=vo.getSeq() %>">�ۻ���</a>&nbsp;&nbsp;&nbsp;
<%
		}
%>
		<a href="board.do?method=getBoardList">�۸��</a>
	</td>
	</tr>	
</table>
</center>
</body>
</html>