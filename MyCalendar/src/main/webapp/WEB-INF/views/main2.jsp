<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.Abc" %>
<%@ page import="java.util.ArrayList" %>
<% 
	Abc abc=(Abc)request.getAttribute("abc");
	int FIRST_DAY= abc.getFirstDate();
	int LAST_DATE=abc.getLastDay();
	int year=abc.getYear();
	int month=abc.getMonth();
	int cnt=0;	
	
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#body{
	width:100%;
	height:100%;
	display:flex;
}
#container{
	width : 70%;
	height: 99%;
	border: solid black;
	align-content: center;
	flex:1;	
}
#wrap { 
	width : 29%;
	height: 99%;
	border: solid black;
	margin : 1px;
	float : left;
	flex:1;
}

#info{
	margin : 1px;
	border : solid blue;
	width : 99%;
	height : 100px;
	
}
#mini{
	margin : 1px;
	border : solid blue;
	width : 99%;
	height : 100px;
}
#detail{
	margin : 1px;
	border : solid blue;
	width : 99%;
	height: 500px;
}
#calendar{		
	height : 100%;
	margin : 1px auto;
	border :1px dotted blue;
	display : flex;
}
.clear{
	clear:both;
	padding: 0px;
	margin: 0px;
}
.day_red, .day_blank,.day_black, .day_blue, .date{
	float:left;
	flex:1;
	border: 1px solid skyblue;
	margin: 1px;
}
.day_red, .day_black, .day_blue{	
	height: 30px;
	
}
.day_blank, .date{
	height: 130px
}

.first_line{
	font-size: 19px;
	text-align: center;
	margin : auto;
}
p {
	text-align: right;
	margin:0px;
}
.day_red{
	color: red;
}
.day_black{
	color: black;
}
.day_blue{
	color: blue;
}
#header{
	width:99%;
	height:100px;	
	border: 1px solid skyblue;
	display: flex;	
	margin: 1px auto;	
	align-items: center;
}
.week{
	border : 1px solid pink;
	width : 99%;
	margin: 1px auto;	
	align-items: center;
	display:flex;
}
#month, #year, #button{
	flex: 1;
	border: 1px solid red;
}
a {
	text-decoration:none;
	color: black;
}
</style>
</head>
<body>
<div id="body">
<div id="container">
	<div id="header">
		<div id="month"><%=month %></div>
		<div id="year"><%=year %></div>
		<div id="button"><a href="#">����</a><a href="#">����</a><a href="#">����</a></div>
	</div>
	<div class="clear"></div>
	<div class="week">
		<div class='day_red'><p class="first_line">Sun</p></div>
		<div class="day_black"><p class="first_line">Mon</p></div>
		<div class="day_black"><p class="first_line">Tue</p></div>
		<div class="day_black"><p class="first_line">Wed</p></div>
		<div class="day_black"><p class="first_line">Thu</p></div>
		<div class="day_black"><p class="first_line">Fri</p></div>
		<div class="day_blue"><p class="first_line">Sat</p></div>	
	</div>
	<div class=clear></div>
	
	<div class="week">
	<%for(int i=0; i<FIRST_DAY;i++){ %>
	<div class=day_blank>����</div>
	<%	cnt++;
	}
	  for(int j=1; j<=LAST_DATE;j++){
		  if(cnt%7 == 0 ){
	%>
		</div><div class=week>
	<%	
		  };
	%>
		<div class=date><p><a href="#"><%=j %></p></a></div>
	<% 	
	  	cnt++; 
	  }
	  for(int k=6; k>=FIRST_DAY+LAST_DATE%7;k--){
	 %>
	 	<div class=day_blank>����</div>
	 	<%} %>
	 </div>
</div>
<div id="wrap">	
	<div id="info">�� ȯ���մϴ�.^^</div>
	<div id="mini"><input type="date"></div>
	<div id="detail"></div>
</div>
</div>

<script>
$(document).ready(function(){
    $("a").click(function(){
        $.get("header.jsp", function(data, status){
          $("#detail").append("<b>11</b>")
        });
    });
});
</script>
</body>
</html>