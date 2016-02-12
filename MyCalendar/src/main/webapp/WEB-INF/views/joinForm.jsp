<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
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

tr{
	width: 110px;
	font-size: 15px;
}
a{
	text-decoration: none;
	color: white;
	font-size: 20px;
}
td{
	height: 40px;
	font-size: 15px;
}
input{
	height: 35px;
	font-size: 15px;
	padding:0px;
}
</style>


</head>
<body id="bg">	
    <div id="input">    	
    	<form name="joinform" method="post" action="user.do?method=join">
		<table>
		<tr>
			<td colspan="2"><h2>Join Us!</h2></td>
		</tr>
		<tr>
			<td>id</td>
			<td><input type="text" name="id"></td>
		</tr>
		<tr>
			<td>pw</td>
			<td><input type="password" name="password"></td>
		</tr>
		<tr>
			<td>pw check</td>
			<td><input type="password" name="password_check"></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:check();">join</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:history.back();">back</a></td>
		</tr>
	</table>
	</form>
    </div>
<script>
function check(){
	var pw1=document.joinform.password.value;
	var pw2=document.joinform.password_check.value;
	
	if(pw1 != pw2){
		alert("pw를 확인해주세요!");
	} else {
		document.joinform.submit();
	}
	
}    
</script>   
</body>
</html>