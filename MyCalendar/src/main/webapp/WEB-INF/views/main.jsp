<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%@ page import="com.mycalendar.myapp.UserVO" %>
<% 
	UserVO userVO = (UserVO) session.getAttribute("vo"); 
		
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<style>
#container{
	width : 70%;
	height: 99%;
	border: solid black;
	float : left;		
}
#wrap { 
	width : 29%;
	height: 99%;
	border: solid black;
	margin : 1px;
	float : left;
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
#calendar{		
	height : 100%;
	margin : 1px auto;
	border :1px dotted blue;
	display : flex;
}
#detail{
	float : left;
	margin : 1px;
	border : solid blue;
	width : 99%;
	height: 500px;
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
	height: 120px;
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
	height:50px;
	border: 1px solid skyblue;
	margin: 1px auto;
}
#month, #year, #link{
	float: left;
	padding-left:3px;
}
.week{
	border : 1px solid pink;
	width : 99%;
	margin: 1px auto;
	height:50px;
	align-items: center;
	display:flex;
}
</style>
<script>
function showCalendar(){
	var div=document.getElementById("container");
	var str='';
	var FIRST_DAY=<%=request.getParameter("firstDate")%>;
	var year =<%=request.getParameter("year")%>;
	var month = <%=request.getParameter("t_month")%>;
	var DAY_OF_WEEK = 7;
	var LAST_DATE = 31;
	var cnt=0;
	var next_month = month+1;
	var prev_month = month-1;
	
	str +="<div id='header'><div id='month'>";
	str += month; // 월 데이터 받기
	str +="</div><div id='year'>";
	str += year;//년 데이터 받기
	str +="</div><div id='link'><a href=";
	str +="'calendar.do?method=main&month="+next_month;
	str +="&year="+year+"'>이전</a><a href=";//#에 get방식 이전달 전송
	str +="'#'>다음</a><a href=";//#에 get방식 다음달 전송
	str +="'#'>오늘</a></div></div><div class=clear></div>";//#에 오늘날짜 전송	
	
	str +="<div class='week'>";
	str += "<div class='day_red'><p class='first_line'>Sun</p></div>";
	str += "<div class='day_black'><p class='first_line'>Mon</p></div>";
	str += "<div class='day_black'><p class='first_line'>Tue</p></div>";
	str += "<div class='day_black'><p class='first_line'>Wed</p></div>";
	str += "<div class='day_black'><p class='first_line'>Thu</p></div>";
	str += "<div class='day_black'><p class='first_line'>Fri</p></div>";
	str += "<div class='day_blue'><p class='first_line'>Sat</p></div>";	
	str +="</div><div class=clear></div>";
	
	str += "<div id=calendar>";
	str += "<div class='day_red'><p class='first_line'>Sun</p></div>";
	str += "<div class='day_black'><p class='first_line'>Mon</p></div>";
	str += "<div class='day_black'><p class='first_line'>Tue</p></div>";
	str += "<div class='day_black'><p class='first_line'>Wed</p></div>";
	str += "<div class='day_black'><p class='first_line'>Thu</p></div>";
	str += "<div class='day_black'><p class='first_line'>Fri</p></div>";
	str += "<div class='day_blue'><p class='first_line'>Sat</p></div><div class=clear></div>";
	
	for(var i=0; i<FIRST_DAY;i++){
		str+="<div class=day_blank>"+"공백"+"</div>";
		cnt++;
	}
	for(var i=1;i<=LAST_DATE;i++){
		
		if(cnt%7 == 0){
			str+="<div class=clear></div>";
		}
		str+="<div class=date><p>"+i+"</p></div>";
		cnt++;
	}
	str += "</div>";
	div.innerHTML = str;
}
</script>
</head>
<body onload="showCalendar();">
<div id="container">	
	
</div>
<div id="wrap">	
	<div id="info"><%=userVO.getName() %>님 환영합니다.^^</div>
	<div id="mini"><input type="date"></div>
	<div id="detail">
		<form>
		<table>
			<tr>
				<td></td>
			</tr>
		
		</table>
		</form>
	</div>
</div>
</body>
</html>