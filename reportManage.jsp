<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="report.ReportDTO" %>
<%@ page import="report.ReportDAO" %>
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
<title>토마토 민족</title>
  	<style>
	table {
		table-layout:fixed;
		font-size:small;
		width:330px;    	
	}
	
	td, th {
	   	overflow: hidden;
	   	text-overflow: ellipsis;
	   	white-space: nowrap;
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
%>
<h4>신고 관리</h4>
  <table class="table" style="text-align:center;">
			<thead>
				<tr class="table-danger">
					<th style="width:20%;">사유</th>
					<th style="width:30%;">신고자</th>
					<th style="width:30%;">피신고자</th>
					<th style="width:20%;">날짜</th>
				</tr>
			</thead>
			<tbody>
<%
	ArrayList<ReportDTO> reportList = new ArrayList<ReportDTO>();
	reportList = new ReportDAO().getList(pageNumber);
	if(reportList != null)
		for(int i = 0; i < reportList.size(); i++) {
			if(i==10) break;
			ReportDTO report = reportList.get(i);
%>
				<tr>
					<td><a href="reportManageContent.jsp?reportID=<%=report.getReportID()%>"><%= report.getReportReason() %></a></td>
					<td><a href="reportManageContent.jsp?reportID=<%=report.getReportID()%>"><%= report.getUserEmail() %></a></td>
					<td><a href="reportManageContent.jsp?reportID=<%=report.getReportID()%>"><%= report.getReportTarget() %></a></td>
					<td><a href="reportManageContent.jsp?reportID=<%=report.getReportID()%>"><%= report.getReportDate().substring(5,10).replaceAll("-",".") %></a></td>
				</tr>
<%
		}
%>
			</tbody>
		</table>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 1) { // 이전으로 갈 페이지가 없다면
%>
	<a class="page-link disabled">이전</a>
<%
	} else { // 뒤로 갈 수 있는 페이지가 존재한다면
%>
	<a class="page-link" href="./reportManage.jsp?pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">
<%
	if(reportList.size() < 10) { // 다음 페이지가 존재하지 않는다면
%>
	<a class="page-link disabled">다음</a>
<%
	} else { // 다음 페이지가 존재한다면
%>
	<a class="page-link" href="./reportManage.jsp?pageNumber=<%= pageNumber +1 %>">다음</a>
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