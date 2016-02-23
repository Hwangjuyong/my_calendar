<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<% 	
	int count=((Integer)request.getAttribute("count")).intValue();
%>
[
  {
        "count" :"<%=count %>"
  }
]