<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인_MyCalendar</title>
<style type="text/css">
#bg{
  background-image: url("http://image.shutterstock.com/z/stock-photo-mix-of-office-supplies-and-gadgets-on-a-wooden-desk-background-view-from-above-251385121.jpg");
  background-repeat: no-repeat;
  background-size:cover;
}
#input {
  text-align:center; 
  background: rgb(34,34,34); /* for IE */
  background: rgba(34,34,34,0.75);
  width:400px; 
  height:300px;
  margin: 200px auto;
}
table{
	margin:auto;
}

h2, td { text-align: center; color: #fefefe; font-weight: normal; }

a{
	text-decoration: none;
	color: white;
	font-size: 20px;
}
tr{
	width: 110px;
	font-size: 15px;
}
td{
	height: 45px;
	font-size: 15px;
}
input{
	height: 40px;
	font-size: 15px;
	padding:0px;
}
</style>

</head>
<body id="bg" onload="today();">	
    <div id="input">    	
    	<form name="loginform" method="post" action="user.do?method=login">
		<table>
		<tr>
			<td colspan="2"><h2>Gain Time, Gain Life</h2></td>
		</tr>
		<tr>
			<td>id</td>
			<td><input placeholder="이메일 주소" size="30" type="email" name="id" autofocus="autofocus"></td>
		</tr>
		<tr>
			<td>pw</td>
			<td><input type="password" placeholder="비밀번호" size="30" name="password"></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:loginform.submit();">login</a></td>			
		</tr>
		<tr>
			<td colspan="2"><a href="user.do?method=joinform">join</a></td>
		</tr>
	</table>
	</form>
    </div>   
</body>
</html>