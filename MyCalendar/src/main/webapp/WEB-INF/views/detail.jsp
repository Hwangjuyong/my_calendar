<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%
	ScheduleVO scheduleVO = new ScheduleVO();
	scheduleVO = (ScheduleVO) request.getAttribute("scheduleVO");
	
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<style type="text/css">

table{
	width:100%;
	height:100%;
	border: 1px dotted pink;
}
td{
	border: 1px solid pink;
}
</style>
</head>
<body>
<body>	
	<table>
		<tr>
			<td colspan="2"><%=scheduleVO.getS_year() %>년 <%=scheduleVO.getS_month() %>월 <%=scheduleVO.getS_date() %>일의</td>
		</tr>
		<tr>
			<td colspan="2">일정 확인하기</td>
		</tr>
			
		<tr>
			<td colspan="2"><%=scheduleVO.getSubject() %></td>
		</tr>
		
		<tr>			
			<td colspan="2"><%=scheduleVO.getContent() %></td>
		</tr>
		<tr>
			<td>일정</td>
			<td>
			</td>
		</tr>
		<tr>
			<td>종료</td>
			<td>
			
			</td>
		</tr>
		<tr>
			<td>범주</td>
			<td><select name="category">
			<%for(int i=0; i<=10; i++){ %>
			<option value="<%=i%>"><%=i %></option>
			<%} %>			
			</select>
		</tr>
		
		<tr>
			<td>반복</td>
			<td><select name="repetition">
				<option value="없음">없음</option>
				<option value="매일">매일</option>
				<option value="매주">매주</option>
				<option value="매월">매월</option>
				<option value="매년">매년</option>				
			
			</select></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:submit();">수정하기</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="schedule.do?method=deleteSchedule&content_id=<%=scheduleVO.getContent_id() %>">삭제하기</a></td>
		</tr>
	
	
	</table>	
</body>
</body>
</html>