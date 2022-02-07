<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="schedule.ScheduleDTO" %>
<%@ page import="schedule.ScheduleDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0"/>
	<link rel = "stylesheet" href = "css/core.css">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
	<title>토마토 민족:일정</title>
	<style>
	h3{
		margin: 0px;
	}
	.memo_board_top{ 
		height: 54px;
		display: flex;
	    align-items: center;
	}
	.memo_board_top div{
		display: inline-block;
		padding-right: 10px;
	}
	.memo_board_top a{
		color: black;
		text-decoration: none;
		margin: 10px;
	}
	.memo_board_letter{
		padding: 10px 5px 10px 5px;
	}
	.memo_day{
		text-align : right;
		width: 100%;
	}
	.memo_board{
		margin-bottom: 10px;
	}
	.memo_title{
		padding-left: 15px;
	}
	.memo_title h3{
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
	width: 200px;
	}
	header{
		background: #ebc4c4;
	}
	</style>
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
	
	if(request.getParameter("pageNumber") != null) {
		try {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} catch(Exception e) {
			System.out.println("검색 페이지 번호 오류");
		}
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}

	ArrayList<ScheduleDTO> scheduleList = new ArrayList<ScheduleDTO>();
	scheduleList = new ScheduleDAO().getList(pageNumber, userEmail);
	if(scheduleList != null)
		for(int i = 0; i < scheduleList.size(); i++) {
			if(i==10) break;
			ScheduleDTO schedule = scheduleList.get(i);
%>
	<div class="memo_board">
		<header class="memo_board_top">
			<div class="memo_title"><h3><%=schedule.getScheduleTitle() %></h3></div>
			<div class="memo_day">
				<%=schedule.getScheduleDate() %>
			</div>
		</header>
		<div style="text-align:right">
			<input type="button" class="btn btn-secondary" value="수정" onclick="location.href='scheduleUpdate.jsp?scheduleID=<%=schedule.getScheduleID()%>'">
			<input type="button" class="btn btn-secondary" value="삭제" onclick="location.href='scheduleDeleteAction.jsp?scheduleID=<%=schedule.getScheduleID()%>'">
		</div>
	</div>
<%
		}
%>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 1) { // 이전으로 갈 페이지가 없다면
%>
	<a class="page-link disabled">이전</a>
<%
	} else { // 뒤로 갈 수 있는 페이지가 존재한다면
%>
	<a class="page-link" href="./scheduleEdit.jsp?pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">
<%
	if(scheduleList.size() < 10) { // 다음 페이지가 존재하지 않는다면
%>
	<a class="page-link disabled">다음</a>
<%
	} else { // 다음 페이지가 존재한다면
%>
	<a class="page-link" href="./scheduleEdit.jsp?pageNumber=<%= pageNumber +1 %>">다음</a>
<%
	}
%>
		</li>
	</ul>
	<br><br><br>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<nav class="bar-footer">
<% 
	if (userEmail.equals("admin")) {
%>
	<div class="bar_img"><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img"><a href="adminProfile.jsp"><img src="images/loginRed.png"/></a></div>
<%
	} else {
%>
	<div class="bar_img unselect_menu" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
<%
	}
%>
	</nav>
</body>
</html>