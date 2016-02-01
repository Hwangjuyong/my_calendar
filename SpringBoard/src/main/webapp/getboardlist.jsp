<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.spring.springboard.BoardVO" %>
<%@ page import="com.spring.springboard.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>

<%
	if(session.getAttribute("loginID") == null)
		response.sendRedirect("./loginForm.jsp");

	request.setCharacterEncoding("euc-kr");

	BoardDAO boardDAO = new BoardDAO();
	BoardVO boardVO = new BoardVO();
	ArrayList<BoardVO> boardList = (ArrayList<BoardVO>)request.getAttribute("boardList");
	String userName = (String)session.getAttribute("userName");

	int listcount=((Integer)request.getAttribute("listcount")).intValue();
	int nowpage=((Integer)request.getAttribute("page")).intValue();
	int maxpage=((Integer)request.getAttribute("maxpage")).intValue();
	int startpage=((Integer)request.getAttribute("startpage")).intValue();
	int endpage=((Integer)request.getAttribute("endpage")).intValue();

	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<center>
<h3>Gurum's BOARD LIST</h3>
<h3><font color="orange"><%=userName %></font>�� ȯ���մϴ�.........
<a href="./logout.jsp">LOG-OUT</a></h3>
<hr>
<form action="./getboardlist.jsp" method="post">
<table border="1" cellpadding="0" cellspacing="0" width="700">
	<tr>
		<td align="right">
			<select name="searchCondition">
			<option value="TITLE" selected>����
			<option value="CONTENT">����
			<option value="MIXED">����+����
			</select>
			<input type="text" name="searchKeyword"/><input type="submit" value="�˻�"/>
		</td>
	</tr>
	</table>
	</form>
	<table border = "1" cellpadding="0" cellspacing="0" width="700">
	<tr>	
		<th bgcolor="orange">��ȣ</th>
		<th bgcolor="orange">����</th>
		<th bgcolor="orange">�ۼ���</th>
		<th bgcolor="orange">�����</th>
		<th bgcolor="orange">��ȸ��</th>
	</tr>
<%
	for (int i=0; i<boardList.size(); i++){
		BoardVO vo = boardList.get(i);
%>
	<tr>
		<td align="center" width="50"><%=vo.getSeq() %></td>
		<td align="left" width="300"><a href='board.do?method=getBoard&seq=<%=vo.getSeq()%>'><%=vo.getTitle()%></a></td>
		<td align="center" width="100"><%=vo.getWriter() %></td>
		<td align="center" width="150"><%=vo.getRegdate() %></td>
		<td align="center" width="100"><%=vo.getCnt() %></td>
	</tr>
<%
	}
%>
</table>
	<a href="./BoardList.bo?page=<%=nowpage-1 %>">����</a>&nbsp;
						
			<%for(int a=startpage;a<=endpage;a++){%>
				
			<a href="./BoardList.bo?page=<%=a %>"><%=a %></a>
				
			<%} %>			
		
		<a href="./BoardList.bo?page=<%=nowpage+1 %>">����</a>
<hr><br>
<a href="board.do?method=addBoardForm">���� ����</a>
</center>
</body>
</html>