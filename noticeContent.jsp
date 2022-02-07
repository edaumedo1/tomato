<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.NoticeDTO" %>
<%@ page import="notice.NoticeDAO" %>
<!DOCTYPE html>
<html>
<head>
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
%>
	<a href="notice.jsp"><h4>공지사항</h4></a>
	<div class="mt-5">
		<h5>[제목]<%=notice.getNoticeTitle()%></h5>
		<div style="font-size:small">[작성자] 관리자</div>
	</div>
	<hr>
	<div>
	[내용]<br>
		<%=notice.getNoticeContent()%>
	</div>
	<br>
	<hr>
<%
	if(userEmail.equals("admin")){
%>
		<span style="float:right;"><a href="noticeUpdate.jsp?noticeID=<%= noticeID %>">수정</a> | <a a onclick="return confirm('정말로 삭제하시겠습니까?')" href="noticeDeleteAction.jsp?noticeID=<%= noticeID %>">삭제</a> </span>
<%
	}
%>
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