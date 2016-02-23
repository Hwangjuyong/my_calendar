<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입_MyCalendar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<link href="./css/login.css" type="text/css" rel="stylesheet">
</head>
<body id="bg">	
    <div id="input">    	
    	<form name="joinform" method="post" action="user.do?method=join">
		<table>
		<tr>
			<td colspan="2"><h2>Join Us!</h2></td>
		</tr>
		<tr>			
			<td><input type="email" name="id" id="id" size="30" placeholder="email address" maxlength="30" required autofocus></td>
		</tr>
		<tr>
			<td id="message">email을 입력해주세요~</td>
		</tr>
		<tr>
			<td><input type="password" name="password" placeholder="password" maxlength="16" required></td>
		</tr>
		<tr>
			<td><input type="password" name="password_check" placeholder="password again" maxlength="16" required></td>
		</tr>
		<tr>			
			<td><input type="text" name="name" placeholder="name" maxlength="16" required></td>
		</tr>
		<tr>
			<td><input type="submit" value="join"></td>
		</tr>
		<tr>		
			<td><input type="button" value="back" onclick="javascript:history.back();"></td>
		</tr>		
	</table>
	</form>
    </div>
<script>
$(document).ready(function(){
	$('#id').focusout(function(){	
		var id = document.joinform.id.value;
		var emailCheck = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		
		if (!emailCheck.test(id)){
			$('#message').html('올바른 형식의 email이 아닙니다.');
			$(":submit").attr({"disabled":"true"});
			return;
		}
		else {		
			$.post('user.do?method=id',
				{id: id},
				function(data){
				$('#message').html(data);
				})
		}
})
})
</script>   
</body>
</html>