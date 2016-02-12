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
	margin: 0px auto;
	align-content: center;
	flex=1;
}
#wrap { 
	width : 29%;
	height: 99%;
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
	width : 98%;
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
.day_red, .day_black, .day_blue, .date{
	float:left;
	flex:1;
	border: 1px solid skyblue;
	margin: 1px;
}
.day_red, .day_black, .day_blue{	
	height: 25px;
	
}
.date{
	height: 120px
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
	height:80px;	
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
.button{
	flex: 1;	
}
.button{
	display: flex;
}
a {
	text-decoration:none;
	color: black;
}
.date:nth-child(1) {
    background: #FFEAEA;
}
.date:nth-child(7) {
    background: #EBF7FF;
}
.prev, .next{
	float:left;
}
.prev, .next, .today{
	flex: 1;
	border: 1px dotted pink;
	text-align: center;
	font-size:19px;
}
#month{
	flex:1;
	text-align : center;
	font-size: 65px;
}
#year{
	flex:1;
	font-size:38px;
	text-align : center;
	padding-top:5%;
}
.box{
	list-style-type:none;
	margin:2px;
	padding-left:2px;	
}
.box li{
	background-color:#FAEBFF;
	margin:2px;
}
</style>
</head>
<body>
<div id="body">
<div id="container">
	<div id="header">
		<div class="button">
			<div class="prev"><a href="#">month</a></div>
			<div class="next"><a href="#">week</a></div>
			<div class="today"><a href="#">today</a></div>
		</div>
		<div class="button">
			<div id="month"><%=month %></div>
			<div id="year"><%=year %></div>
		</div>
		<div class="button">
			<div class="prev"><a href="schedule.do?method=main&showYear=<%=year%>&showMonth=<%=month-1%>">����</a></div>
			<div class="next"><a href="schedule.do?method=main&showYear=<%=year%>&showMonth=<%=month+1%>">����</a></div>
			<div class="today"><a href="schedule.do?method=main&showYear=0">����</a></div>				
		</div>
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
	<div class=date></div>
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
		<ul class="box">
		<% for(int p=0;p<list.size();p++){
			ScheduleVO scheduleVO = list.get(p);
			if(scheduleVO.getS_date()==j){
		%>
		<li><%=scheduleVO.getSubject() %>
		<input type="hidden" value="<%=scheduleVO.getContent_id()%>">
		</li>
		<%
			}
		}
		%>
		</ul>
		</div>
	<% 	
	  	cnt++; 
	  }
	  int last = FIRST_DAY+LAST_DATE%7;
	  if(last>=8){
		  last = (FIRST_DAY+LAST_DATE%7)%8+1;
	  }
	  for(int k=6; k>=last;k--){
	 %>
	 	<div class=date></div>
	 	<%} %>
	 	<form id="vo">
	 	<input type="hidden" name="year" value="<%=year%>">
	 	</form>
	 </div>
</div>
<div id="wrap">	
	<div id="info"><%=userVO.getName() %>�� ȯ���մϴ�.^^</div>
	<div id="mini">
	<%for(int i=0;i<list.size();i++){
		ScheduleVO scheduleVO = list.get(i);
	%>
	<a><%=scheduleVO.getSubject() %></a>
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
$('.box li').bind({
	mouseenter:function(){
		$(this).css('cursor','pointer');
	},
	click:function(){
		var content_id = $(this).children(':first').val();
				
		$.post('schedule.do?method=detail',
				{content_id:content_id},
				function(data){
					$('#detail').html(data);
				});
	}});
})

</script>
</body>
</html>