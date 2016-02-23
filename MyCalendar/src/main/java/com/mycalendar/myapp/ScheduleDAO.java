package com.mycalendar.myapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Calendar;

import org.springframework.stereotype.Component;

import com.ibm.icu.util.ChineseCalendar;


@Component
public class ScheduleDAO {

		private Connection conn = null;
		private PreparedStatement stmt = null;
		private ResultSet rs = null;
		
		private static int lunar_lastDate=0;
		
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
		
		private final String UPDATE_SCHEDULE
		="update calendar_ex set id=?, starttime=?,endtime=?,allday=?,subject=?,content=?,"
				+ "s_year=?,s_month=?,s_date=?,e_year=?,e_month=?,e_date=?,category=?,repetition=?, dday=? where content_id=? ";
		
		private final int[] M_LIST=new int[]{31,31,28,31,30,31,30,31,31,30,31,30,31,31}; 
		private final int[] M_LEAP_LIST=new int[]{31,31,29,31,30,31,30,31,31,30,31,30,31,31};
		private static String[] solarArr = new String[]{"0101", "0301", "0505", "0606", "0815","1003","1009", "1225"};
		private static String[] solarArr_name = new String[]{"신정","3.1절","어린이날","현충일","광복절","개천절","한글날","크리스마스"};
	    private static String[] lunarArr = new String[]{"0101", "0102", "0408", "0814", "0815", "0816"};
	    private static String[] lunarArr_name= new String[]{"설날","설날연휴","부처님오신날","추석연휴","추석","추석연휴"};		
		//해당하는 년 월의 달력을 출력하기위한 정보 객체 반환
		public CalendarVO getCalendarData(int year, int month){
			
			if(month == 13){
				year = year+1;
				month = 1;  // 다음이나 통해 전달받은 달의 값이 13이면 내년 1월로
			}
			if(month == 0){
				year = year-1;
				month = 12; // 이전을 통해 전달받은 달의 값이 0이면 작년 12월로
			}
			Calendar cal = Calendar.getInstance();
			int today; 
			int this_year = cal.get(Calendar.YEAR);
			int this_month = cal.get(Calendar.MONTH)+1;
			
			if(year==this_year && month==this_month){
				today=cal.get(Calendar.DATE);
			} else{
				today=0; // 다음달이나 이전달에 오늘날짜를 표시하지 않기 위해 0으로 처리
			}
			
			CalendarVO calendarVO= new CalendarVO();
			int firstDay = 0;			
			int lastDate = 0;
			int i = 0;
			int prevMonth =0;
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400;
			//1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
						
			if(year%4!=0 || (year%100==0 && year%400!=0)){  //윤년이 아닐경우 
				for(i=1;i<month;i++){
				total2 += M_LIST[i];
				}
				lastDate=M_LIST[i];
				prevMonth =M_LIST[i-1];
				
			} else {										//윤년일 경우에
				for(i=1;i<month;i++){
				total2 += M_LEAP_LIST[i];
				}
				lastDate=M_LEAP_LIST[i];
				prevMonth = M_LEAP_LIST[i-1];
			}
			
			int total=total1+total2;
			firstDay= total % 7+1;
			if (firstDay == 7 ){
				firstDay=0;
			}
			
			int prevMonthDate = prevMonth-firstDay+1; 
			calendarVO.setYear(year);
			calendarVO.setMonth(month);
			calendarVO.setFirstDay(firstDay);
			calendarVO.setLastDate(lastDate);
			calendarVO.setToday(today);
			calendarVO.setPrevMonth(prevMonthDate);
			return calendarVO;
			
		}
		
		//로그인 후 초기진입시 오늘날짜가 있는 캘린더 출력을위한 객체 반환		
		public CalendarVO getCalendarData(){
			
			CalendarVO calendarVO= new CalendarVO();
			int firstDay=0;
			int lastDate=0;
			int prevMonth=0;
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int today = cal.get(Calendar.DATE);
			int i=0;
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += M_LIST[i];
				}
				lastDate=M_LIST[i];
				prevMonth =M_LIST[i-1];
			} else {
				for(i=1;i<month;i++){
				total2 += M_LEAP_LIST[i];
				}
				lastDate=M_LEAP_LIST[i];
				prevMonth = M_LEAP_LIST[i-1];
			}
			
			int total=total1+total2;
			firstDay= total % 7+1;
			if (firstDay == 7 ){
				firstDay=0;
			}
			int prevMonthDate = prevMonth-firstDay+1; 
			
			calendarVO.setYear(year);
			calendarVO.setMonth(month);
			calendarVO.setFirstDay(firstDay);
			calendarVO.setLastDate(lastDate);
			calendarVO.setToday(today);
			calendarVO.setPrevMonth(prevMonthDate);
			
			return calendarVO;
		}

		//일정 입력 메서드
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
		//일정 수정 메서드
		public void updateSchedule(ScheduleVO scheduleVO, String id){
		
			try{
				conn = JDBCUtil.getConnection();
				stmt = conn.prepareStatement(UPDATE_SCHEDULE);
				stmt.setString(1, id);
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
				stmt.setString(16, scheduleVO.getContent_id());
				
				stmt.executeUpdate();
			}catch(Exception e){
				e.printStackTrace();
				
			}finally{
				JDBCUtil.closeResource(stmt, conn);
			}
			
		}
		
		//달력에 일정제목을 출력하기위한 정보를 담은 리스트를 반환하는 메서드
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
		
		//달력에서 일정 제목 클릭시 일정의 세부정보를 가져오기위한 메서드
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
		
		//특정 일정을 지우기위한 메서드
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
		
		//1년 1월 1일부터 오늘까지의 총 날짜 수 반환 메서드		
		public int getTotal(){
			Calendar cal = Calendar.getInstance();
			int date = cal.get(Calendar.DATE);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int i, total, total1;
			int total2=0;
			
			total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //현재년 1월전까지의 총 일수
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += M_LIST[i];//이번년도 현재월 -1월까지의 총 일수
				}						
			} else {
				for(i=1;i<month;i++){
				total2 += M_LEAP_LIST[i];
				}						
			}			
			total = total1 + total2 + date; //오늘 날짜 까지의 총 일수
						
			return total;
		}
		
		//1년 1월 1일부터 해당년 해당월 해당일 까지의 총 날짜 수 반환 메서드
		public int getTotal(int year, int month, int date){
			int i, total, total1;
			int total2=0;
			
			total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400; //현재년 1월전까지의 총 일수
						
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += M_LIST[i];//이번년도 현재월 -1월까지의 총 일수
				}						
			} else {
				for(i=1;i<month;i++){
				total2 += M_LEAP_LIST[i];
				}						
			}			
			total = total1 + total2 + date; //해당 날짜 까지의 총 일수
						
			return total;
		}

		// D-Day를 출력하기위한 메서드
		public ArrayList<DDayVO> getDDayList(String id){
			DDayVO dDayVO = null;
			ArrayList<DDayVO> dDayList = new ArrayList<DDayVO>();
			int total1 = getTotal(); // 1년 1월 1일부터 오늘까지의 총 날짜 수
			
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
					int dDay = total1-total2; //1년 1월 1일부터 오늘까지의 총 날짜 수 - 해당년 해당월 해당일 까지의 총 날짜 수
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
		
		// 공휴일을 출력하기 위한 메서드	
		public ArrayList<HolidayVO> getHolidaySchedule(CalendarVO vo){
			ArrayList<HolidayVO> holidayList=new ArrayList<HolidayVO>();
			int year = vo.getYear();
			int month = vo.getMonth();
			int lastDate = vo.getLastDate();
			
			HolidayVO solar_holidayVO = null;
			HolidayVO lunar_holidayVO = null;	
			for(int date=1;date<=lastDate;date++){					
				StringBuilder sb = new StringBuilder();
				sb.append(String.format("%02d", month));
				sb.append(String.format("%02d", date));
					
				String holName= solarCheckOut(sb.toString());
				if(!holName.equals("not")){
					solar_holidayVO=new HolidayVO();
					solar_holidayVO.setHolName(holName);
					solar_holidayVO.setHolDate(date);
					holidayList.add(solar_holidayVO);
				}										
				
				String lunar = convertSolarToLunar(year,month,date);
				holName = lunarCheckOut(lunar);
				if(!holName.equals("not")){
					lunar_holidayVO=new HolidayVO();
					lunar_holidayVO.setHolName(holName);
					lunar_holidayVO.setHolDate(date);
					holidayList.add(lunar_holidayVO);
				}
			}
			return holidayList;
		}
		
		//양력날짜로 음력날짜를 구하는 메서드
		 public static String convertSolarToLunar(int year, int month, int date){
				ChineseCalendar cc = new ChineseCalendar();
		        Calendar cal = Calendar.getInstance();
		         
		        cal.set(Calendar.YEAR, year);
		        cal.set(Calendar.MONTH, month-1);
		        cal.set(Calendar.DAY_OF_MONTH, date);
		         
		        cc.setTimeInMillis(cal.getTimeInMillis());
		         
		        int y = cc.get(ChineseCalendar.EXTENDED_YEAR) - 2637;
		        int m = cc.get(ChineseCalendar.MONTH) + 1;
		        int d = cc.get(ChineseCalendar.DAY_OF_MONTH);
		        lunar_lastDate = cc.getActualMaximum(ChineseCalendar.DAY_OF_MONTH);
		       
		        StringBuffer ret = new StringBuffer();
		        ret.append(String.format("%04d", y));
		        ret.append(String.format("%02d", m));
		        ret.append(String.format("%02d", d));
		         
		        return ret.toString();		
			}
		
		// 음력날짜가 공휴일인지 확인하고 맞으면 해당공휴일의 이름을 반환 아닐경우 not
		public static String lunarCheckOut(String lunar){
			String holName="not";
			String str = lunar.substring(4);
			int year = Integer.parseInt(lunar.substring(0,4));
			int month = Integer.parseInt(lunar.substring(4,6))-1;
			int date = Integer.parseInt(lunar.substring(6));		
		
			for(int i=0; i<lunarArr.length;i++){
				if(str.equals(lunarArr[i])){					
					holName = lunarArr_name[i];
					return holName;
				}			
			}
		
			if(lunar.substring(4, 6).equals("12")){
				ChineseCalendar chinaCal = new ChineseCalendar();
				chinaCal.set(year, month, date);			
				
				if(Integer.parseInt(lunar.substring(6))==lunar_lastDate){
					holName="설날연휴";
				}
			}
			return holName;
		}
		
		// 양력날짜가 공휴일인지 확인하고 맞으면 해당공휴일의 이름을 반환 아닐경우 not
		public static String solarCheckOut(String solar){
			String holName="not";										
				
			for(int i=0; i<solarArr.length;i++){
				if(solar.equals(solarArr[i])){							
					holName = solarArr_name[i];
					return holName;
				}			
			}					
			return holName;
		}
		
}
