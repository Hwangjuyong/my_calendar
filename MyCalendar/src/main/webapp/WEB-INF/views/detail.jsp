<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%
	ScheduleVO scheduleVO = new ScheduleVO();
	scheduleVO = (ScheduleVO) request.getAttribute("scheduleVO");	
%>    
<!DOCTYPE html>
<html>
<head>
<link href="./css/table.css" type="text/css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�󼼺���</title>
</head>
<body>
<body>	
	<table>
		<tr>
			<td colspan="4"><%=scheduleVO.getS_year() %>�� <%=scheduleVO.getS_month() %>�� <%=scheduleVO.getS_date() %>��</td>
		</tr>
		<tr>
			<td colspan="4">���� �󼼺���</td>
		</tr>
			
		<tr>
			<td colspan="4"><input type="text" name="subject" readonly value="<%=scheduleVO.getSubject() %>"></td>
		</tr>
		
		<tr>			
			<td colspan="4"><textarea disabled="disabled"><%=scheduleVO.getContent() %></textarea></td>
		</tr>
		<tr>
			<td width="50px">����</td>
			<td colspan="3">
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
			<td colspan="3">
			<%=scheduleVO.getE_year() %>�� <%=scheduleVO.getE_month() %> �� <%=scheduleVO.getE_date() %> ��
			</td>
		</tr>
		<tr>
			<td>����</td>
			<td><%if(scheduleVO.getAllday()==null){%>
			no
			<%	} else{ %>
			yes
			<%} %>
			</td>
			
			<td>D-Day</td>
			<td><%if(scheduleVO.getdDay()==null){%>
			no
			<%	} else{ %>
			yes
			<%} %>
			</td>
			</tr>
		<tr>
			<td>����</td>
			<td><%=scheduleVO.getCategory() %></td>
		
			<td>�ݺ�</td>
			<td><%=scheduleVO.getRepetition() %></td>
		</tr>
		<tr>
			<td colspan="4"><a id="doUpdate" href="#"><input type="hidden" value="<%=scheduleVO.getContent_id() %>">�����ϱ�</a></td>
		</tr>
		<tr>
			<td colspan="4"><a href="schedule.do?method=deleteSchedule&content_id=<%=scheduleVO.getContent_id() %>">�����ϱ�</a></td>
		</tr>	
	
	</table>	
<script>
$('#doUpdate').bind({
	click:function(){
		var content_id = $(this).children(':first').val();
				
		$.post('schedule.do?method=updateForm',
				{content_id:content_id},
				function(data){
					$('#detail').html(data);
				});
	}});

</script>	
</body>
</html>