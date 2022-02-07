<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=divice-width, initial-scale=1.0"/>
<link rel = "stylesheet" href = "css/core.css">
<title>토마토 민족:로그인</title>
</head>
<body>
<%
	session.invalidate();
%>
	<div class="login_logo_image">
	<img src="images/tomato_logo.jpg"/>
	</div>
	<div class="login_wrap">
	<form action="userLoginAction.jsp">
	<table>
		<tr>
			<td><input class="login_box" type="text" name="userEmail" value="" placeholder="이메일"></td>
		</tr>
		<tr>
			<td><input class="login_box" type="password" name="userPassword" value="" placeholder="비밀번호"></td>
		</tr>
		<tr>
			<td><input class="login_button" type="submit" value="로그인"></td>
		</tr>
	</table>
	</form>
	</div>
	<div>
	<table class="login_bar-footer">
	<tr>
		<td>이메일 찾기</td>
		<td>비밀번호 찾기</td>
		<td></td>
		<td><a href="userJoin.jsp">회원가입</a></td>
	</tr>
	</table>
	</div>
</body>
</html>