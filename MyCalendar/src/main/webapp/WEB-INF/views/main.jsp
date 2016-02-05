<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%@ page import="java.util.ArrayList" %>
<% 
	ArrayList<ScheduleVO> list = (ArrayList<ScheduleVO>)request.getAttribute("list");
	CalendarVO calendarVO=(CalendarVO)request.getAttribute("calendarVO");
	int FIRST_DAY= calendarVO.getFirstDay();
	int LAST_DATE=calendarVO.getLastDate();
	int year=calendarVO.getYear();
	int month=calendarVO.getMonth();
	int cnt=0;	
	UserVO userVO = (UserVO)session.getAttribute("vo");
%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style>
#body{
	width:99%;
	height:99%;
	margin:0px auto;
	padding:0px;
	display: flex;
}
#container{
	width : 70%;
	height: 99%;
	border: solid black;
	margin: 0px auto;
	align-content: center;
	flex=1;
}
#wrap { 
	width : 29%;
	height: 99%;
	border: solid black;
	margin : 0px auto;
	flex=1;
}

#info{
	margin : 1px;
	border : solid blue;
	width : 98%;
	height : 100px;
	
}
#mini{
	margin : 1px;
	border : solid blue;
	width : 98%;
	height : 100px;
}
#detail{
	margin : 1px;
	border : solid blue;
	width : 99%;
	height: 100%;
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
		<div id="button"><a href="#">이전</a><a href="#">다음</a><a href="#">오늘</a></div>
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
	<div class=day_blank>공백</div>
	<%	cnt++;
	}
	  for(int j=1; j<=LAST_DATE;j++){
		  if(cnt%7 == 0 ){
	%>
		</div><div class=week>
	<%	
		  };
	%>
		<div class=date><a class="day" href="#"><%=j %></a>
		<%for(int p=0;p<list.size();p++){
			ScheduleVO scheduleVO = list.get(p);
			if(scheduleVO.getS_date()==j){
		%>
		<p><%=scheduleVO.getSubject() %></p>
		<%
			}
		}
		%>
		</div>
	<% 	
	  	cnt++; 
	  }
	  for(int k=6; k>=FIRST_DAY+LAST_DATE%7;k--){
	 %>
	 	<div class=day_blank>공백</div>
	 	<%} %>
	 	<form id="vo">
	 	<input type="hidden" name="year" value="<%=year%>">
	 	</form>
	 </div>
</div>
<div id="wrap">	
	<div id="info"><%=userVO.getName() %>님 환영합니다.^^</div>
	<div id="mini">
	<%for(int i=0;i<list.size();i++){
		ScheduleVO scheduleVO = list.get(i);
	%>
	<p><%=scheduleVO.getSubject() %></p>
	<%
	}
	%>
	</div>
	<div id="detail"></div>
</div>
</div>

<script>
$(function(){
$('.day').bind('click',function(){
	var month = $('#month').text();
	var year = $('#year').text();
	var date = $(this).text();
	
	$.post('schedule.do?method=insertForm',
		{year: year, month:month, date:date},
		function(data){
			$('#detail').html(data);
		});
});
})
</script>
</body>
</html>