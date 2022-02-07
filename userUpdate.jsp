<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=devie-width, initial-scale=1, shrink-to-fit=no">
	<title>토마토 민족:프로필 수정</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
</head>
<body>
<%
	String userEmail = null;
	int pageNumber = 1;
	if(session.getAttribute("userEmail") != null){ //유저가 로그인했을 경우
		userEmail = (String) session.getAttribute("userEmail");
	}
	if(userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	
	String userNick = userDAO.getUserNick(userEmail);
	String userImg = userDAO.getUserImg(userEmail);
	String userIntro = userDAO.getUserIntro(userEmail);
%>
	<section class="container center mt-4" style="max-width:400px;">
	<div>
		<span class="ml-2 mt-3" style="float:left; color:gray;"><h4>프로필 수정</h4></span>
	</div>
	<div>
		<form method="post" action="userUpdateAction.jsp" enctype="multipart/form-data">
			<table class="table table" style="text-align:center; border:none solid #dddddd">
					<tr>
						<td><input type="text" class="form-control" placeholder="닉네임" name="userNick" maxlength="50" value="<%=userNick%>"></td>
					</tr>
					<tr>
						<td><input type="file" id="userImg" name="userImg" required></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="자기소개" name="userIntro" maxlength="2048" style="height:350px;"><%=userIntro %></textarea></td>
					</tr>
			</table>
			<div align="center">
			<input type="submit" class="btn btn-secondary" value="수정">
			<input type="button" class="btn btn-secondary" value="취소" onclick="location.href='userProfile.jsp'">
			</div>
		</form>
	</div>
	</section>
	<br><br><br>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<nav class="bar-footer">
		<div class="bar_img unselect_menu" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
		<div class="bar_img unselect_menu"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
		<div class="bar_img unselect_menu"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
		<div class="bar_img"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
	</nav>
</body>
</html>