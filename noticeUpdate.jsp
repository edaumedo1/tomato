<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.NoticeDTO" %>
<%@ page import="notice.NoticeDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0"/>
	<link rel = "stylesheet" href = "css/core.css">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
<title>토마토 민족</title>
</head>
<body>
<%
	String userEmail = null;
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
	int noticeID = 0;
	if (request.getParameter("noticeID") != null) {
		noticeID = Integer.parseInt(request.getParameter("noticeID"));
	}
	
	if (noticeID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
	}
	
	NoticeDTO notice = new NoticeDAO().getNoticeView(noticeID);
	if (!userEmail.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");				
	}
	
%>
	<div>
		<span class="ml-2 mt-3" style="float:left; color:gray;"><h4>공지사항 수정하기</h4></span>
	</div>
	<div>
		<form method="post" action="noticeUpdateAction.jsp?noticeID=<%= noticeID %>">
			<table class="table table" style="text-align:center; border:none solid #dddddd">
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="noticeTitle" maxlength="50" value="<%= notice.getNoticeTitle().replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("<br>", "\r\n") %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="noticeContent" maxlength="2048" style="height:350px;"><%= notice.getNoticeContent().replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("<br>", "\r\n") %></textarea></td>
					</tr>
			</table>
			<div align="center">
			<input type="submit" class="btn btn-secondary pull-right" value="수정">
			<input type="button" class="btn btn-secondary pull-right" value="취소" onclick="history.back()">
			</div>
		</form>
	</div>

	<br><br><br>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<nav class="bar-footer">
<% 
	if (userEmail.equals("admin")) {
%>
	<div class="bar_img" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img"><a href="adminProfile.jsp"><img src="images/loginRed.png"/></a></div>
<%
	} else {
%>
	<div class="bar_img" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
<%
	}
%>
	</nav>
</body>
</html>