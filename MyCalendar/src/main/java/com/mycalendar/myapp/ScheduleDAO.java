package com.mycalendar.myapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.stereotype.Component;



@Component
public class ScheduleDAO {

		private Connection conn = null;
		private PreparedStatement stmt = null;
		private ResultSet rs = null;
		
		private final String ADD_SCHEDULE
		="insert into calendar_ex "
				+ "values(?,?,?,?,0,?,?,?,?,?,?,?,?,?,?, TO_CHAR(schedule_seq.nextval),?)";
		
		private final String GET_MONTH_SCHEDULE
		="select * from calendar_ex "
				+"where id=? and s_year=? and s_month=? order by starttime";
		
		private final String GET_DETAIL
		="select * from calendar_ex where content_id=?";
		
		private final String DELETE_SCHEDULE
		="delete from calendar_ex where content_id=?";
		
		private final String GET_DDAY
		="select * from calendar_ex where id=? and dday=?";
				
//오늘자 첫 요일의 값을 반환
		public CalendarVO getCalendarData(int year, int month){
			
			if(month == 13){
				year = year+1;
				month = 1;
			}
			if(month == 0){
				year = year-1;
				month = 12;
			}
			Calendar cal = Calendar.getInstance();
			int today; 
			int this_year = cal.get(Calendar.YEAR);
			int this_month = cal.get(Calendar.MONTH)+1;
			
			if(year==this_year && month==this_month){
				today=cal.get(Calendar.DATE);
			} else{
				today=0;
			}
			
			CalendarVO calendarVO= new CalendarVO();
			int firstDay = 0;			
			int lastDate = 0;
			int i = 0;
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400;
			//1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += m_list[i];
				}
				lastDate=m_list[i];
			} else {
				for(i=1;i<month;i++){
				total2 += m_leap_list[i];
				}
				lastDate=m_leap_list[i];
			}
			int total=total1+total2;
			firstDay= total % 7+1;
			if (firstDay == 7 ){
				firstDay=0;
			}
			
			
			calendarVO.setYear(year);
			calendarVO.setMonth(month);
			calendarVO.setFirstDay(firstDay);
			calendarVO.setLastDate(lastDate);
			calendarVO.setToday(today);
			return calendarVO;
			
		}
		public CalendarVO getCalendarData(){
			
			CalendarVO calendarVO= new CalendarVO();
			int firstDay = 0;
			int lastDate=0;
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int today = cal.get(Calendar.DATE);
			int i=0;
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += m_list[i];
				}
				lastDate=m_list[i];
			} else {
				for(i=1;i<month;i++){
				total2 += m_leap_list[i];
				}
				lastDate=m_leap_list[i];
			}
			
			int total=total1+total2;
			firstDay= total % 7+1;
			if (firstDay == 7 ){
				firstDay=0;
			}
			
			calendarVO.setYear(year);
			calendarVO.setMonth(month);
			calendarVO.setFirstDay(firstDay);
			calendarVO.setLastDate(lastDate);
			calendarVO.setToday(today);
			
			return calendarVO;
		}
		
		public void addSchedule(ScheduleVO scheduleVO){
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(ADD_SCHEDULE);
				stmt.setString(1, scheduleVO.getId());
				stmt.setString(2, scheduleVO.getStartTime());
				stmt.setString(3, scheduleVO.getEndTime());
				stmt.setString(4, scheduleVO.getAllday());
				stmt.setString(5, scheduleVO.getSubject());
				stmt.setString(6, scheduleVO.getContent());
				stmt.setInt(7, scheduleVO.getS_year());
				stmt.setInt(8, scheduleVO.getS_month());
				stmt.setInt(9, scheduleVO.getS_date());
				stmt.setInt(10, scheduleVO.getE_year());
				stmt.setInt(11, scheduleVO.getE_month());
				stmt.setInt(12, scheduleVO.getE_date());
				stmt.setString(13, scheduleVO.getCategory());
				stmt.setString(14, scheduleVO.getRepetition());
				stmt.setString(15, scheduleVO.getdDay());
				
				stmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}
			
		}
	
		public ArrayList<ScheduleVO> getMonthSchedule(CalendarVO vo, String id){
			ArrayList<ScheduleVO> scheduleList=new ArrayList<ScheduleVO>();
			ScheduleVO scheduleVO= null;
			
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(GET_MONTH_SCHEDULE);
				
				stmt.setString(1, id);
				stmt.setInt(2, vo.getYear());
				stmt.setInt(3, vo.getMonth());				
				
				rs = stmt.executeQuery();
				
				while(rs.next()){
					
					scheduleVO = new ScheduleVO();
					scheduleVO.setSubject(rs.getString("SUBJECT"));
					scheduleVO.setStartTime(rs.getString("STARTTIME"));
					scheduleVO.setS_date(rs.getInt("S_DATE"));
					scheduleVO.setContent_id(rs.getString("CONTENT_ID"));
					scheduleList.add(scheduleVO);
				}
				
				
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}
			return scheduleList;
			
		}
		public ScheduleVO getDetail(String content_id) {
			ScheduleVO scheduleVO = null;
			
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(GET_DETAIL);
				stmt.setString(1, content_id);				
				
				rs=stmt.executeQuery();
				
				while(rs.next()){
					scheduleVO = new ScheduleVO();
					
					scheduleVO.setStartTime(rs.getString("starttime"));
					scheduleVO.setEndTime(rs.getString("endtime"));
					scheduleVO.setAllday(rs.getString("allday"));
					scheduleVO.setSubject(rs.getString("SUBJECT"));
					scheduleVO.setContent(rs.getString("content"));
					scheduleVO.setS_year(rs.getInt("s_year"));
					scheduleVO.setS_year(rs.getInt("s_year"));
					scheduleVO.setS_month(rs.getInt("s_month"));
					scheduleVO.setS_date(rs.getInt("s_date"));
					scheduleVO.setE_year(rs.getInt("e_year"));
					scheduleVO.setE_month(rs.getInt("e_month"));
					scheduleVO.setE_date(rs.getInt("e_date"));
					scheduleVO.setCategory(rs.getString("category"));
					scheduleVO.setRepetition(rs.getString("repetition"));
					scheduleVO.setContent_id(content_id);
					scheduleVO.setdDay(rs.getString("dDay"));
				}
				
				
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}
						
			return scheduleVO;
		}
		public void deleteSchedule(String content_id){
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(DELETE_SCHEDULE);
				stmt.setString(1, content_id);
				stmt.executeUpdate();
			}catch (Exception e){
				e.printStackTrace();
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}
		}
		public int getTotal(){
			Calendar cal = Calendar.getInstance();
			int date = cal.get(Calendar.DATE);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int i, total, total1;
			int total2=0;
			
			total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //현재년 1월전까지의 총 일수
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += m_list[i];//이번년도 현재월 -1월까지의 총 일수
				}						
			} else {
				for(i=1;i<month;i++){
				total2 += m_leap_list[i];
				}						
			}			
			total = total1 + total2 + date; //오늘날짜 까지의 총 일수
						
			return total;
		}
		public int getTotal(int year, int month, int date){
			int i, total, total1;
			int total2=0;
			
			total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //현재년 1월전까지의 총 일수
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += m_list[i];//이번년도 현재월 -1월까지의 총 일수
				}						
			} else {
				for(i=1;i<month;i++){
				total2 += m_leap_list[i];
				}						
			}			
			total = total1 + total2 + date; //오늘날짜 까지의 총 일수
						
			return total;
		}
		
		public ArrayList<DDayVO> getDDayList(String id){
			DDayVO dDayVO = null;
			ArrayList<DDayVO> dDayList = new ArrayList<DDayVO>();
			int total1 = getTotal();
			
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(GET_DDAY);
				stmt.setString(1, id);
				stmt.setString(2, "1");
				rs = stmt.executeQuery();
				
				while(rs.next()){
					dDayVO = new DDayVO();
					int year = rs.getInt("s_year");
					int month = rs.getInt("s_month");
					int date = rs.getInt("s_date");
					int total2 = getTotal(year, month, date);					
					int dDay = total1-total2; 
					dDayVO.setdDay(dDay);
					dDayVO.setName(rs.getString("subject"));
					
					dDayList.add(dDayVO);
				}
			}catch (Exception e){
				e.printStackTrace();
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}	
			
			
			return dDayList;			
		}
		
		
		public ArrayList<HolidayVO> getHolidaySchedule(CalendarVO vo){
			ArrayList<HolidayVO> holidayList=new ArrayList<HolidayVO>();
			HolidayVO holidayVO = null;
			switch(vo.getMonth()){
			case 1:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(1);
				holidayVO.setHolName("신정");
				holidayList.add(holidayVO);
				break;
			case 2:
				
				break;
			case 3:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(1);
				holidayVO.setHolName("삼일절");
				holidayList.add(holidayVO);
				break;
			case 4:
				
				break;
			case 5:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(5);
				holidayVO.setHolName("어린이날");
				holidayList.add(holidayVO);
				break;
			case 6:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(6);
				holidayVO.setHolName("현충일");
				holidayList.add(holidayVO);
				break;
			case 7:
				
				break;
			case 8:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(15);
				holidayVO.setHolName("광복절");
				holidayList.add(holidayVO);
				break;
			case 9:
				
				break;
			case 10:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(3);
				holidayVO.setHolName("개천절");
				holidayList.add(holidayVO);
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(9);
				holidayVO.setHolName("한글날");
				holidayList.add(holidayVO);
				break;
			case 11:
				
				break;
			case 12:
				holidayVO = new HolidayVO();
				holidayVO.setHolDate(25);
				holidayVO.setHolName("크리스마스");
				holidayList.add(holidayVO);
				break;				
			
			}
			
			
			return holidayList;
		}
		
}
