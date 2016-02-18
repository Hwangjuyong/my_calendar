<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.mycalendar.myapp.ScheduleVO" %>
<%@ page import="com.mycalendar.myapp.CalendarVO" %>
<%@ page import="com.mycalendar.myapp.UserVO" %>
<%
	CalendarVO calendarVO=(CalendarVO)request.getAttribute("calendarVO");
	int year = calendarVO.getYear();
	int date = calendarVO.getDate();
	int month = calendarVO.getMonth();
	UserVO userVO = (UserVO)session.getAttribute("vo");
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
input[type="text"]{
	width: 98%;
	height: 40px;
	margin: auto;
	font-size: 18px;
	
}
textarea{
	width: 98%;
	height: 160px;
	margin: auto;
	font-size: 14px
}
input[type="number"]{
	width: 50px;
}

</style>
</head>
<body>
	<form name="insertForm" method="post" action="schedule.do?method=addSchedule">
	<input type="hidden" name="s_year" value="<%=year %>">
	<input type="hidden" name="s_month" value="<%=month %>">
	<input type="hidden" name="s_date" value="<%=date %>">
	<input type="hidden" name="id" value="<%=userVO.getId()%>">
	<table>
		<tr>
			<td colspan="4"><%=year %>년 <%=month %>월 <%=date %>일의</td>
		</tr>
		<tr>
			<td colspan="4">일정 등록하기</td>
		</tr>
			
		<tr>
			<td colspan="4"><input type="text" name="subject" placeholder="제목을 입력하세요" required></td>
		</tr>
		
		<tr>			
			<td colspan="4"><textarea name="content" placeholder="내용을 입력하세요"></textarea></td>
		</tr>
		<tr>
			<td>일정</td>
			<td colspan="4"><select name="startTime">
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
			</select>&nbsp;~&nbsp; 
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
			</select></td>
			</tr>
			<tr>
				<td>종일</td>
				<td><input type="checkbox" name="allday" value="1"></td>
				<td>D-day</td>
				<td><input type="checkbox" name="dDay" value="1"></td>
			</tr>
	
	
		<tr>
			<td>종료</td>
			<td colspan="4">
			<input type="number" name="e_year" step="1" max="2100" min="2015" value="<%=year%>">년
			<input type="number" name="e_month" step="1" max="12" min="1" value="<%=month%>">월
			<input type="number" name="e_date" step="1" max="31" min="1" value="<%=date%>">일
			</td>
		</tr>
		<tr>
			<td>범주</td>
			<td><select name="category">
			<%for(int i=0; i<=10; i++){ %>
			<option value="<%=i%>"><%=i %></option>
			<%} %>			
			</select>
			<td>반복</td>
			<td><select name="repetition">
				<option value="없음">없음</option>
				<option value="매주">매주</option>
				<option value="매월">매월</option>
				<option value="매년">매년</option>				
			
			</select></td>
		</tr>
				
		<tr>
		
			<td colspan="4"><a  href="javascript:insertForm.submit();">일정등록</a></td>
			
		</tr>
		<tr>
			<td colspan="4"><a href="#">다시작성</a></td>
		</tr>
		
	
	</table>
	</form>

</body>
</html>