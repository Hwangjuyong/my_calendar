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
</head>
<style type="text/css">

table{
	width:100%;
	height:100%;
	border: 1px dotted pink;
}
td{
	border: 1px solid pink;
}
input[type="text"]{
	width: 98%;
	height: 40px;
	margin: auto;
	font-size: 20px;
	
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
	<form name="inserform" method="post" action="schedule.do?method=updateSchedule">
	<input type="hidden" name="s_year" value="<%=scheduleVO.getS_year() %>">
	<input type="hidden" name="s_month" value="<%=scheduleVO.getS_month() %>">
	<input type="hidden" name="s_date" value="<%=scheduleVO.getS_date() %>">
	
	<table>
		<tr>
			<td colspan="2"><%=scheduleVO.getS_year() %>�� <%=scheduleVO.getS_month() %>�� <%=scheduleVO.getS_date() %>����</td>
		</tr>
		<tr>
			<td colspan="2">���� �����ϱ�</td>
		</tr>
			
		<tr>
			<td colspan="2"><input type="text" name="subject" required value="<%=scheduleVO.getSubject() %>"></td>
		</tr>
		
		<tr>			
			<td colspan="2"><textarea name="content" ><%=scheduleVO.getContent() %></textarea></td>
		</tr>
		<tr>
			<td>����</td>
			<td><select name="startTime" >
			<%
				for(int i=0; i<12; i++){
					String str1=null;
					String str2=null;
					String str=null;
					if(i>9){
						str1 = "AM "; 
					} else {
						str1 = "AM 0";
					}
					
					str2=Integer.toString(i)+":00";
					str=str1+str2;
			%>
					<option value="<%=str%>"
			<%
					if (str.equals(scheduleVO.getStartTime())){
			%>
					selected><%=str %></option>
			<%
					}else {
			%>
						><%=str %></option>
			<%
					}					
					str2=Integer.toString(i)+":30";
					str=str1+str2;
			%>	
					<option value="<%=str%>"
			<%
					if (str.equals(scheduleVO.getStartTime())){
			%>
					selected><%=str %></option>
			<%
					}else {
			%>
						><%=str %></option>
			<%
					}
			%>
			<%				
				}
			%>
				<%
				for(int i=0; i<12; i++){
					String str1=null;
					String str2=null;
					String str=null;
					if(i>9){
						str1 = "PM "; 
					} else {
						str1 = "PM 0";
					}
					
					str2=Integer.toString(i)+":00";
					str=str1+str2;
			%>
					<option value="<%=str%>"><%=str %></option>
			<%		str2=Integer.toString(i)+":30";
					str=str1+str2;
			%>	
					<option value="<%=str%>"><%=str %></option>
			<%				
				}
			%>
			
			
			</select>~
			<select name="endTime">
		<%
				for(int i=0; i<12; i++){
					String str1=null;
					String str2=null;
					String str=null;
					if(i>9){
						str1 = "AM "; 
					} else {
						str1 = "AM 0";
					}
					
					str2=Integer.toString(i)+":00";
					str=str1+str2;
			%>
					<option value="<%=str%>"><%=str %></option>
			<%		str2=Integer.toString(i)+":30";
					str=str1+str2;
			%>	
					<option value="<%=str%>"><%=str %></option>
			<%				
				}
			%>
				<%
				for(int i=0; i<12; i++){
					String str1=null;
					String str2=null;
					String str=null;
					if(i>9){
						str1 = "PM "; 
					} else {
						str1 = "PM 0";
					}
					
					str2=Integer.toString(i)+":00";
					str=str1+str2;
			%>
					<option value="<%=str%>"><%=str %></option>
			<%		str2=Integer.toString(i)+":30";
					str=str1+str2;
			%>	
					<option value="<%=str%>"><%=str %></option>
			<%				
				}
			%>
			</select>
			&nbsp;<label for="allday">����</label>
			<input type="checkbox" name="allday" value="1">
			</td>
		</tr>
		<tr>
			<td>����</td>
			<td>
			<input type="number" name="e_year" step="1" max="2100" min="2015" value="<%=scheduleVO.getE_year()%>">��
			<input type="number" name="e_month" step="1" max="12" min="1" value="<%=scheduleVO.getE_month()%>">��
			<input type="number" name="e_date" step="1" max="31" min="1" value="<%=scheduleVO.getE_date()%>">��
			</td>
		</tr>
		<tr>
			<td>����</td>
			<td><select name="category">
			<%for(int i=0; i<=10; i++){ %>
			<option value="<%=i%>"><%=i %></option>
			<%} %>			
			</select>
		</tr>
		
		<tr>
			<td>�ݺ�</td>
			<td><select name="repetition">
				<option value="����">����</option>
				<option value="����">����</option>
				<option value="����">����</option>
				<option value="�ſ�">�ſ�</option>
				<option value="�ų�">�ų�</option>				
			
			</select></td>
		</tr>
		<tr>
			<td colspan="2"><a href="javascript:submit();">�������</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="#">�ٽ��ۼ�</a></td>
		</tr>
		<tr>
			<td><input type="submit" value="����"></td>
		</tr>
	
	</table>
	</form>
</body>
</html>