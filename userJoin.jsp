<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=divice-width, initial-scale=1.0"/>
<link rel = "stylesheet" href = "css/core.css">
<title>토마토 민족:회원가입</title>
</head>
<body>
<%
	session.invalidate();
%>
	<div class="join_title">
	<h1>회원가입</h1>
	</div>
	<div class="join_wrap">
	<form action="userJoinAction.jsp">
	<table>
		<tr>
			<td class="join_table_box" >
			<div class="join_box_div" >
				<img src="images/email.png"/>
				<input type="text" name="userEmail" placeholder="이메일">
			</div>
			</td>
		</tr>
		<tr>
			<td class="join_table_box" >
			<div class="join_box_div" >
				<img src="images/nickname.png"/>
				<input class="join_box" type="text" name="userNick" placeholder="닉네임">
			</div>
			</td>
		</tr>
		<tr>
			<td class="join_table_box" >
			<div class="join_box_div" >
				<img src="images/pw.png"/>
				<input class="join_box" type="password" name="userPassword" placeholder="비밀번호">
			</div>
			</td>
		</tr>
		<tr>
			<td class="join_table_box" >
			<div class="join_box_div" >
				<img src="images/pw.png"/>
				<input class="join_box" type="password" name="userPassword2" placeholder="비밀번호 확인">
			</div>
			</td>
		</tr>
	</table>
	<div class="join_button">
	<table>
		<tr>
			<td><input type="submit" value="회원가입"></td>
		</tr>
		<tr>
			<td><input type="button" onclick="location.href='userLogin.jsp'" value="취소"></td>
		</tr>
	</table>
	</div>
	</form>
	</div>
	</body>
</html>