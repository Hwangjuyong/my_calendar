<!-- create table users(
id varchar(10) primary key,
password varchar2(10) not null,
name varchar2(15)not null,
role varchar2(15)
);

create table board(
seq number primary key,
title varchar(20),
writer varchar2(15),
content varchar2(1000),
regdate date,
cnt number
);

insert into users values('admin', '1234', '������', 'admin');
commit;
 -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�α���</title>
</head>
<body>
<center>
<h3>Login �ϼ���</h3>
<form action="user.do?method=login" method="post">
<table border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td>���̵�</td>
		<td><input type="text" name="id"/></td>
	</tr>
	<tr>
		<td>��й�ȣ</td>
		<td><input type="password" name="password"/></td>
	</tr>
		<tr>
		<td align="center" colspan="2"><input type="submit" value="�α���"/></td>
	</tr>
</table>
</form> 
</center>
</body>
</html>