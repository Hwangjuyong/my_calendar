<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%@ page import="com.mycalendar.myapp.HolidayVO" %>
<%@ page import="com.mycalendar.myapp.DDayVO" %>
<%@ page import="java.util.ArrayList" %>
<% 
	ArrayList<DDayVO> dDayList = (ArrayList<DDayVO>)request.getAttribute("dDayList");
	ArrayList<ScheduleVO> list = (ArrayList<ScheduleVO>)request.getAttribute("list");
	CalendarVO calendarVO=(CalendarVO)request.getAttribute("calendarVO");
	ArrayList<HolidayVO> holidayList = (ArrayList<HolidayVO>)request.getAttribute("holidayList");
	int FIRST_DAY= calendarVO.getFirstDay();
	int LAST_DATE=calendarVO.getLastDate();
	int year=calendarVO.getYear();
	int month=calendarVO.getMonth();
	int prevMonth=calendarVO.getPrevMonth();
	int cnt=0;
	int nextMonthDate = 1;
	UserVO userVO = (UserVO)session.getAttribute("vo");
%>
<!DOCTYPE html>
<html>
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
		<script src="./js/jquery.xdomainajax.js"></script>
		<script src="./js/weather.js"></script>
		<link href="./css/main.css" type="text/css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
		<title>일정-MyCalendar</title>
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
		<div class=date_not><a class="prevMonthDate" href="#"><%=prevMonth %></a></div>
		<%	
			prevMonth++;
			cnt++;
		}
		for(int j=1; j<=LAST_DATE;j++){
			if(cnt%7 == 0 ){
		%>
		</div><div class=week>
		<%};
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
				String subject = scheduleVO.getSubject();
				if(subject.length()>4){
					subject = subject.substring(0,3)+" ..";
				}
		%>
			<li><%=scheduleVO.getStartTime()%>)&nbsp;<%=scheduleVO.getSubject() %>
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
				String subject = scheduleVO.getSubject();
				if(subject.length()>4){
					subject = subject.substring(0,3)+" ..";
				}
		%>
			<li><%=scheduleVO.getStartTime()%>)&nbsp;<%=subject %>
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
	 	<div class=date_not><a class="nextMonthDate" href="#"><%=nextMonthDate %></a></div>
	 	<%
	 	nextMonthDate++;
	  } %>
	 	<form id="vo">
	 	<input type="hidden" name="year" value="<%=year%>">
	 	</form>
	 </div>
</div>

<div id="wrap">	
	<div id="info">
		<h3><%=userVO.getName() %>님 환영합니다.^^</h3>
		<a href="user.do?method=logout">로그아웃</a>
	</div>	
	<div id="mini">
	<%for(int i=0; i<dDayList.size();i++){ 
		DDayVO dDayVO = dDayList.get(i);%>
	<p><%=dDayVO.getName()%> : D<%=dDayVO.getdDay()%></p>
	<%} %>	
	</div>
	<div id="weather">
	
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
$('.nextMonthDate').bind('click',function(){
	var month = parseInt($('#month').text())+1;
	var year = $('#year').text();
	var date = $(this).text();
	
	$.post('schedule.do?method=insertForm',
		{year: year, month:month, date:date},
		function(data){
			$('#detail').html(data);
		});
});
$('.prevMonthDate').bind('click',function(){
	var month = parseInt($('#month').text())-1;
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
$('.box').bind({
	mouseover:function(){
		$(this).css({'overflow':"auto"});
		
	},
	mouseout:function(){
		$(this).css({'overflow':"hidden"});
	}
})
})
	
//getLocation();
</script>
</body>
</html>