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

input[type="email"]{	
    width: 100%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    font-size: 18px;  
    padding: 12px 20px 12px 10px;
}input[type="password"]{
	
    width: 100%;
    box-sizing: border-box;
    border: 2px solid #ccc;
    border-radius: 4px;
    font-size: 18px;  
    padding: 12px 20px 12px 10px;
}

</style>

</head>
<body id="bg">	
    <div id="input">    	
    	<form name="loginform" method="post" action="user.do?method=login">
		<table>
		<tr>
			<td ><h2>Gain Time, Gain Life</h2></td>
		</tr>
		<tr>			
			<td><input type="email" placeholder="Hello1234@mycalendar.com" size="30"  name="id" autofocus="autofocus"></td>
		</tr>
		<tr>			
			<td><input type="password" placeholder="password" size="30" name="password"></td>
		</tr>
		<tr>
			<td><a  href="javascript:loginform.submit();">login</a></td>			
		</tr>
		<tr>
			<td><a href="user.do?method=joinform">join</a></td>
		</tr>
	</table>
	</form>
    </div>   
</body>
</html>