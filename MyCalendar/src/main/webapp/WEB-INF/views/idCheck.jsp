<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 	
	int count=((Integer)request.getAttribute("count")).intValue();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%if(count==0){%>
<p>��밡���� e-mail�ּ� �Դϴ�.</p>
<%} else { %>
<p>�ߺ��� e-mail�ּ� �Դϴ�.</p>
<%} %>

</body>
</html>