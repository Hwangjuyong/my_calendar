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
			<td colspan="2"><%=scheduleVO.getS_year() %>�� <%=scheduleVO.getS_month() %>�� <%=scheduleVO.getS_date() %>����</td>
		</tr>
		<tr>
			<td colspan="2">���� Ȯ���ϱ�</td>
		</tr>
			
		<tr>
			<td colspan="2"><%=scheduleVO.getSubject() %></td>
		</tr>
		
		<tr>			
			<td colspan="2"><%=scheduleVO.getContent() %></td>
		</tr>
		<tr>
			<td>����</td>
			<td>
			<%if(scheduleVO.getAllday()==null){ %>
			<%=scheduleVO.getStartTime()%>~<%=scheduleVO.getEndTime() %>
			<%}else{ %>
			����
			<% }
			%>
			</td>
		</tr>
		<tr>
			<td>����</td>
			<td>
			
			</td>
		</tr>
		<tr>
			<td>����</td>
			<td><%=scheduleVO.getCategory() %></td>
		</tr>
		
		<tr>
			<td>�ݺ�</td>
			<td><%=scheduleVO.getRepetition() %></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:submit();">�����ϱ�</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="schedule.do?method=deleteSchedule&content_id=<%=scheduleVO.getContent_id() %>">�����ϱ�</a></td>
		</tr>
	
	
	</table>	
</body>
</body>
</html>