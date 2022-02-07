<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="notice.NoticeDTO" %>
<%@ page import="notice.NoticeDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
    <div>
		<span class="ml-2 mt-2" style="float:left;"><h3>공지사항</h3></span>
<%
	if(userEmail.equals("admin")) {
%>
		<span class="mr-2 mt-3" style="float:right;"><a href="noticeWrite.jsp"><img src="./images/pencil.svg" width="25px"></a></span>
<%
	}
%>
	</div>
	<section class="container center mt-5" style="max-width:400px;">
		<table class="table">
		  <thead>
		    <tr class="table-dark">
				<td scope="col" align="center" style="width:20%; font-weight:600;">번호</td>
		      	<td scope="col" align="center" style="width:35%; font-weight:600;">제목</td>
		      	<td scope="col" align="center" style="width:25%; font-weight:600;">작성자</td>
		      	<td scope="col" align="center" style="width:20%; font-weight:600;">날짜</td>
		    </tr>
		  </thead>
		  <tbody>
<%
	ArrayList<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
	noticeList = new NoticeDAO().getList(pageNumber);
	if(noticeList != null)
		for(int i = 0; i < noticeList.size(); i++) {
			if(i==10) break;
			NoticeDTO notice = noticeList.get(i);
%>
		    <tr>
				<td scope="row" align="center"><%= notice.getNoticeID() %></td>
				<td align="center"><a href="noticeContent.jsp?noticeID=<%=notice.getNoticeID()%>"><%= notice.getNoticeTitle() %></a></td>
				<td align="center">관리자</td>
				<td align="center"><%= notice.getNoticeDate().substring(5,10).replaceAll("-",".") %></td>
		    </tr>
<%
		}
%>
		  </tbody>
		</table>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 1) { // 이전으로 갈 페이지가 없다면
%>
	<a class="page-link disabled">이전</a>
<%
	} else { // 뒤로 갈 수 있는 페이지가 존재한다면
%>
	<a class="page-link" href="./notice.jsp?pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">
<%
	if(noticeList.size() < 10) { // 다음 페이지가 존재하지 않는다면
%>
	<a class="page-link disabled">다음</a>
<%
	} else { // 다음 페이지가 존재한다면
%>
	<a class="page-link" href="./notice.jsp?pageNumber=<%= pageNumber +1 %>">다음</a>
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
	<div class="bar_img unselect_menu" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
<%
	}
%>
	</nav>
</body>
</html>