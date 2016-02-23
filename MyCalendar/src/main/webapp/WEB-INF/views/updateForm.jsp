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
<title>update</title>
</head>
<body>
	<form name="updateForm" method="post" action="schedule.do?method=updateSchedule">
	<input type="hidden" name="s_year" value="<%=scheduleVO.getS_year() %>">
	<input type="hidden" name="s_month" value="<%=scheduleVO.getS_month() %>">
	<input type="hidden" name="s_date" value="<%=scheduleVO.getS_date() %>">
	<input type="hidden" name="content_id" value="<%=scheduleVO.getContent_id()%>">
	
	<table>
		<tr>
			<td colspan="4"><%=scheduleVO.getS_year() %>년 <%=scheduleVO.getS_month() %>월 <%=scheduleVO.getS_date() %>일</td>
		
		</tr>
		<tr>
			<td colspan="4">일정 수정하기</td>
		</tr>
			
		<tr>
			<td colspan="4"><input type="text" name="subject" required value="<%=scheduleVO.getSubject() %>"></td>
		</tr>
		
		<tr>			
			<td colspan="4"><textarea name="content" ><%=scheduleVO.getContent() %></textarea></td>
		</tr>
		<tr>
			<td>일정</td>
			<td colspan="3"><select name="startTime" >
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
			
			</td>
		</tr>
		<tr>
			<td>종료</td>
			<td colspan="3">
			<input type="number" name="e_year" step="1" max="2100" min="2015" value="<%=scheduleVO.getE_year()%>">년
			<input type="number" name="e_month" step="1" max="12" min="1" value="<%=scheduleVO.getE_month()%>">월
			<input type="number" name="e_date" step="1" max="31" min="1" value="<%=scheduleVO.getE_date()%>">일
			</td>
		</tr>
		<tr>
			<td>종일</td>
			<td><input type="checkbox" name="allday" value="1"
			<%if(scheduleVO.getAllday()!=null){ %>
			checked></td>
			<%} else { %>
			></td>
			<%} %>
			<td>D-Day</td>
			<td><input type="checkbox" name="dDay" value="1"
			<%if(scheduleVO.getdDay()!=null){ %>
			checked></td>
			<%} else { %>
			></td>
			<%} %>
			
			</tr>		
		<tr>
			<td>범주</td>
			<td><select name="category">
			<option value="<%=scheduleVO.getCategory() %>"><%=scheduleVO.getCategory() %></option>
			<%for(int i=0; i<=10; i++){ %>
			<option value="<%=i%>"><%=i %></option>
			<%} %>
			</select>
		
			<td>반복</td>
			<td><select name="repetition">
				<option value="<%=scheduleVO.getRepetition() %>"><%=scheduleVO.getRepetition() %></option>
				<option value="없음">없음</option>
				<option value="매주">매주</option>
				<option value="매월">매월</option>
				<option value="매년">매년</option>				
			
			</select></td>
			
		</tr>
		<tr>
			<td colspan="4"><a href="javascript:updateForm.submit();">일정등록</a></td>
		</tr>
		<tr>
			<td colspan="4"><a  href="javascript:insertForm.reset();">다시작성</a></td>
		</tr>
	
	</table>
	</form>
</body>
</html>