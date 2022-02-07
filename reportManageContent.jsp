<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="report.ReportDTO" %>
<%@ page import="report.ReportDAO" %>
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

	int reportID = 0;
	if (request.getParameter("reportID") != null) {
		reportID = Integer.parseInt(request.getParameter("reportID"));
	}
	if (reportID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'reportManage.jsp'");
		script.println("</script>");
	}
	
	ReportDTO report = new ReportDAO().getReportView(reportID);
%>
<a href="reportManage.jsp"><h4>신고 관리</h4></a>
<hr>
   <div>
   		<a href="<%=report.getReportAddr() %>">[해당 주소 바로가기]</a>
   </div><br>
   <div>
		신고자:<%=report.getUserEmail() %><br>
		피신고자:<%=report.getReportTarget() %><br>
		신고사유:<%=report.getReportReason() %><br>
   </div>
   <div>
		내용:<p><%=report.getReportContent() %></p>
   </div>
   <div>
   		<form method="post" action="./stopAction.jsp" class="form-inline">
   			<div style="width:120px;">
   			<input type="hidden" name="stopUserEmail" value="<%=report.getReportTarget()%>">
   			<input type="hidden" name="reportID" value="<%=reportID%>">
   			<input type="number" name="stopDays" class="form-control" style="width:100px" placeholder="n일 정지">
    		</div>
    		<div class="ml-4" align="center">
				<input type="submit" class="btn btn-secondary" value="확인">
				<input type="button" class="btn btn-secondary" value="취소" onclick="location.href='reportManage.jsp'">
				<input type="button" class="btn btn-secondary" value="삭제" onclick="location.href='reportDeleteAction.jsp?reportID=<%=reportID%>'">
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