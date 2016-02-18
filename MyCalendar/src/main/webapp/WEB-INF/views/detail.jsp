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
textarea{
	width: 98%;
	height: 200px;
	margin: auto;
	font-size: 14px
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
			<td colspan="2">< textarea disabled="disabled"><%=scheduleVO.getContent() %></textarea></td>
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
			<td colspan="2"><a id="doUpdate" href="#"><input type="hidden" value="<%=scheduleVO.getContent_id() %>">�����ϱ�</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="schedule.do?method=deleteSchedule&content_id=<%=scheduleVO.getContent_id() %>">�����ϱ�</a></td>
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