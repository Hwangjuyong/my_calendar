<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>회원가입_MyCalendar</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
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
  height:450px;
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
input[type="email"], input[type="password"], input[type="text"]{	
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
    	<form name="joinform" method="post" action="user.do?method=join">
		<table>
		<tr>
			<td colspan="2"><h2>Join Us!</h2></td>
		</tr>
		<tr>			
			<td><input type="email" name="id" id="id" placeholder="email address" required autofocus></td>
		</tr>
		<tr>
			<td id="message"></td>
		</tr>
		<tr>
			<td><input type="password" name="password" placeholder="password" required></td>
		</tr>
		<tr>
			<td><input type="password" name="password_check" placeholder="password again" required></td>
		</tr>
		<tr>			
			<td><input type="text" name="name" placeholder="name" ></td>
		</tr>
		<tr>
			<td><a href="javascript:check();">join</a></td>
		</tr>
		<tr>
			<td><a href="javascript:history.back();">back</a></td>
		</tr>
		
	</table>
	</form>
    </div>
<script>
$(document).ready(function(){
	$('#id').focusout(function(){	
		var id = document.joinform.id.value;
		var emailCheck = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
		if(!id){		
			$('#message').html("email주소는 필수항목입니다!");
			return;
		}else if(emailCheck.test(id)){		
			$.post('user.do?method=id',
				{id: id},
				function(data){
				$('#message').html(data);
				})
		}else{
			$('#message').html('올바른 형식의 email이 아닙니다.');
		}
})
})

function check(){
	var id = document.joinform.id.value;
	var pw1=document.joinform.password.value;
	var pw2=document.joinform.password_check.value;

	if(!id){
		alert("ID를 입력해주세요!");
		return;
	}
	if(!pw1|| !pw2){
		alert("pw를 입력해주세요!");
		return;
	}
	if(pw1 != pw2){
		alert("pw를 확인해주세요!")
		return;
	}
	
	document.joinform.submit();	
}
</script>   
</body>
</html>