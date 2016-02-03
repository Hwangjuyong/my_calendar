package com.mycalendar.myapp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;

import org.springframework.stereotype.Component;

@Component
public class CalendarDAO {

		private Connection conn = null;
		private PreparedStatement stmt = null;
		private ResultSet rs = null;
				
//오늘자 첫 요일의 값을 반환
		public int getFirstDate(int year, int month){
			int x = 0;			
			
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400;
			//1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(int i=1;i<month;i++){
				total2 += m_list[i];
				}
			} else {
				for(int i=1;i<month;i++){
				total2 += m_leap_list[i];
				}
			}
			int total=total1+total2;
			x= total % 7+1;
			if (x == 7 ){
				x=0;
			}
			
			return x;
		}
		public int[] getFirstDate(){
			
			int firstDate = 0;			
			int lastDay=0;
			Calendar cal = Calendar.getInstance();
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			int i=0;
			int total1 = 365*(year-1)+(year-1)/4-(year-1)/100+(year-1)/400;
			//1년 1월부터 y년 m-1월까지의 총날짜
			int total2=0;
			int[] m_list={0,31,28,31,30,31,30,31,31,30,31,30,31,31};
			int[] m_leap_list={0,31,29,31,30,31,30,31,31,30,31,30,31,31};
			
			if(year%4!=0 || (year%100==0 && year%400!=0)){
				for(i=1;i<month;i++){
				total2 += m_list[i];
				}
				lastDay=m_list[i+1];
			} else {
				for(i=1;i<month;i++){
				total2 += m_leap_list[i];
				}
				lastDay=m_leap_list[i+1];
			}
			
			int total=total1+total2;
			firstDate= total % 7+1;
			if (firstDate == 7 ){
				firstDate=0;
			}
			int[] result = new int[4];
			result[0]=year;
			result[1]=month;
			result[2]=firstDate;
			result[3]=lastDay;
			return result;
		}
}
