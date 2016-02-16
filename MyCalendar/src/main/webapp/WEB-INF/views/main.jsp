<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%@ page import="com.mycalendar.myapp.HolidayVO" %>
<%@ page import="java.util.ArrayList" %>
<% 
	ArrayList<ScheduleVO> list = (ArrayList<ScheduleVO>)request.getAttribute("list");
	CalendarVO calendarVO=(CalendarVO)request.getAttribute("calendarVO");
	ArrayList<HolidayVO> holidayList = (ArrayList<HolidayVO>)request.getAttribute("holidayList");
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
<title>일정-MyCalendar</title>
<style>
#body{
	width:99%;
	height:99%;
	margin:0px auto;
	padding:0px;
	display: flex;
	min-width:880px;
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
	border : 1px solid #7F7F7F;
	width : 98%;
	height : 100px;	
	text-align:center;
}
#mini{
	margin : 1px;
	border : 1px solid #7F7F7F;
	width : 98%;
	height : 100px;
}
#detail{
	margin : 1px;
	border : 1px solid #7F7F7F;
	width : 98%;
	height: 100%;
}
#calendar{		
	height : 100%;
	margin : 1px auto;
	border :1px dotted #7F7F7F;
	display : flex;
}

.clear{
	clear:both;
	padding: 0px;
	margin: 0px;
}
.day_red, .day_black, .day_blue, .date, .today, .date_not{
	float:left;
	flex:1;
	border: 1px solid #7F7F7F;
	margin: 1px;
}
.date_not{
	background-color:#EAEAEA;
}
.day_red, .day_black, .day_blue{	
	height: 25px;
	
}
.date,.date_not, .today{
	height: 120px;
}
.today{
	background-color:#FFFFE4;
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
	width:98.6%;
	height:80px;	
	border: 1px solid #7F7F7F;
	display: flex;	
	margin: 1px auto;	
	align-items: center;
}
.week{
	width : 99%;
	margin: 1px auto;	
	align-items: center;
	display:flex;
}
#header, .week{
	min-width: 600px;
}
.button_container{
	flex: 1;
	display: flex;
}
a {
	text-decoration:none;
	color: black;
	font-weight: bold;
}
.date:nth-child(1) {
    background: #FFEAEA;
}
.date:nth-child(7) {
    background: #EBF7FF;
}
.button{
	float:left;
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
	margin-left:1px;
	margin-right:1px;
	margin-bottom:2px;
	font-size:12px;
	
}
.holiday {	
	position:relative;
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
<div id="body">
<div id="container">
	<div id="header">
		<div class="button_container" >
			<div class="button"><a href="#">month</a></div>
			<div class="button"><a href="#">week</a></div>
			<div class="button"><a href="#">today</a></div>
		</div>
		<div class="button_container">
			<div id="month"><%=month %></div>
			<div id="year"><%=year %></div>
		</div>
		<div class="button_container">
			<div class="button"><input type="hidden" value="schedule.do?method=main&showYear=<%=year%>&showMonth=<%=month-1%>">이전</div>
			<div class="button"><input type="hidden" value="schedule.do?method=main&showYear=<%=year%>&showMonth=<%=month+1%>">다음</div>
			<div class="button"><input type="hidden" value="schedule.do?method=main&showYear=0">오늘</div>				
		</div>
	</div>
	<div class="clear"></div>
	<div class="week" style="background-color:#ffd966;">
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
	<div class=date_not></div>
	<%	cnt++;
	}
	  for(int j=1; j<=LAST_DATE;j++){
		  if(cnt%7 == 0 ){
	%>
		</div><div class=week>
	<%	
		  };
		
		if(j==calendarVO.getToday()){
	%>
		<div class=today>
		<a class="day" href="#"><%=j %></a>
		<%for(int n=0;n<holidayList.size();n++){
			HolidayVO holidayVO = holidayList.get(n);
			if(holidayVO.getHolDate()==j){
		%>
			<span class="holiday"><%=holidayVO.getHolName() %></span>
			<%}} %>
		<ul class="box">
		<% for(int p=0;p<list.size();p++){
			ScheduleVO scheduleVO = list.get(p);
			if(scheduleVO.getS_date()==j){
		%>
			<li>(<%=scheduleVO.getStartTime()%>)&nbsp;<%=scheduleVO.getSubject() %>
				<input type="hidden" value="<%=scheduleVO.getContent_id()%>"></li>
		<%	}
		  }
		%>
		</ul>
		</div>		
		<%} else { 
		%>
		<div class=date>
		<a class="day" href="#"><%=j %></a>
		<%for(int n=0;n<holidayList.size();n++){
			HolidayVO holidayVO = holidayList.get(n);
			if(holidayVO.getHolDate()==j){
		%>
			<span class="holiday"><%=holidayVO.getHolName() %></span>
			<%}} %>
		<ul class="box">
		<% for(int p=0;p<list.size();p++){
			ScheduleVO scheduleVO = list.get(p);
			if(scheduleVO.getS_date()==j){
		%>
			<li>(<%=scheduleVO.getStartTime()%>)&nbsp;<%=scheduleVO.getSubject() %>
			<input type="hidden" value="<%=scheduleVO.getContent_id()%>"></li>
		<%
			}
		}
		%></ul>
		</div>
		<%	
		}	
	  	cnt++; 
	  }
	  int last = FIRST_DAY+LAST_DATE%7;
	  if(last>=8){
		  last = (FIRST_DAY+LAST_DATE%7)%8+1;
	  }
	  for(int k=6; k>=last;k--){
	 %>
	 	<div class=date_not></div>
	 	<%} %>
	 	<form id="vo">
	 	<input type="hidden" name="year" value="<%=year%>">
	 	</form>
	 </div>
</div>
<div id="wrap">	
	<div id="info">
		<h2><%=userVO.getName() %>님 환영합니다.^^</h2>
		<a href="user.do?method=logout">로그아웃</a>
	</div>	
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
$('.button').bind({
	mouseenter:function(){
		$(this).css({'cursor':'pointer',
		'background-color':'#E4F7BA',
		'border':'1px solid #ABF200'
		});		
	},
	mouseout:function(){
		$(this).css({'cursor':'default',
			'background-color':'white',
			'border':'1px dotted pink'
			});
	},
	click:function(){
		var url = $(this).children(':first').val();
		location.href =	url;
	}
})

})

</script>
</body>
</html>