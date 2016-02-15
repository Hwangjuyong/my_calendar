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
	<form name="inserform" method="post" action="schedule.do?method=addSchedule">
	<input type="hidden" name="s_year" value="<%=year %>">
	<input type="hidden" name="s_month" value="<%=month %>">
	<input type="hidden" name="s_date" value="<%=date %>">
	<input type="hidden" name="id" value="<%=userVO.getId()%>">
	<table>
		<tr>
			<td colspan="2"><%=year %>년 <%=month %>월 <%=date %>일의</td>
		</tr>
		<tr>
			<td colspan="2">일정 등록하기</td>
		</tr>
			
		<tr>
			<td colspan="2"><input type="text" name="subject" placeholder="제목을 입력하세요" required></td>
		</tr>
		
		<tr>			
			<td colspan="2"><textarea name="content" placeholder="내용을 입력하세요"></textarea></td>
		</tr>
		<tr>
			<td>일정</td>
			<td><select name="startTime">
			<%
				for(int i=0; i<13; i++){
					
					String str=null;
					str="AM0"+Integer.toString(i)+":00";
			%>
					<option value="<%=str%>"><%=str %></option>
			<%		str="AM0"+Integer.toString(i)+":30";
			%>	
					<option value="<%=str%>"><%=str %></option>
			<%	}
			%>
			<option value="AM00:00">AM00:00</option>
			<option value="오전00:30">오전00:30</option>
			</select>~
			<select name="endTime">
			<option value="오전00:00">오전00:00</option>
			<option value="오전00:30">오전00:30</option>
			</select>
			&nbsp;<label for="allday">종일</label>
			<input type="checkbox" name="allday" value="1">
			</td>
		</tr>
		<tr>
			<td>종료</td>
			<td>
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
			<td colspan="2"><a href="javascript:submit();">일정등록</a></td>
		</tr>
		<tr>
			<td colspan="2"><a href="#">다시작성</a></td>
		</tr>
		<tr>
			<td><input type="submit" value="제출"></td>
		</tr>
	
	</table>
	</form>
</body>
</html>