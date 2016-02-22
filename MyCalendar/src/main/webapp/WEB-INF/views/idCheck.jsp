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
<p>사용가능한 e-mail주소 입니다.</p>
<%} else { %>
<p>중복된 e-mail주소 입니다.</p>
<%} %>

</body>
</html>