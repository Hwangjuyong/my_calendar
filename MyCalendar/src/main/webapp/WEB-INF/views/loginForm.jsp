<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인_MyCalendar</title>
<link href="./css/login.css" type="text/css" rel="stylesheet">
</head>
<body id="bg">	
    <div id="input">    	
    	<form name="loginform" method="post" action="user.do?method=login">
		<table>
		<tr>
			<td ><h2>Gain Time, Gain Life</h2></td>
		</tr>
		<tr>			
			<td><input type="email" placeholder="Hello1234@mycalendar.com" size="30" maxlength="30" name="id" autofocus="autofocus" required></td>
		</tr>
		<tr>			
			<td><input type="password" placeholder="password" maxlength="16" name="password" required></td>
		</tr>
		<tr>
			<td><input type="submit" value="login"></td>
		</tr>		
		<tr>
			<td><input type="button" value="join" onclick="javascript:location.href='user.do?method=joinform'"></td>		
		</tr>
	</table>
	</form>
    </div> 
</body>
</html>