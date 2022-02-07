<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="stop.StopDTO" %>
<%@ page import="stop.StopDAO" %>
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
<script>
reloadtime =500;
function get_cookie(Name) {
	var search = Name + "="
	var returnvalue = "";

	if (document.cookie.length > 0) {
    	offset = document.cookie.indexOf(search)
		if (offset != -1) {
			offset += search.length
			end = document.cookie.indexOf(";", offset);
			if (end == -1) end = document.cookie.length;
			returnvalue=unescape(document.cookie.substring(offset, end))
		}
	}
	return returnvalue;
}

function oneload() {
	var cookiename=window.location.pathname
	var flag = eval(get_cookie(window.location.pathname));
	if(flag || flag == null) {
		var cookievalue="false;"
		document.cookie=cookiename+"="+cookievalue;
		location.reload();
	} else {
		var cookievalue="true;"
		document.cookie=cookiename+"="+cookievalue;
  }
}
</script>
</head>
<body onload="oneload()">
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
   <section class="container center mt-5" style="max-width:400px;">
   <form method="get" action="stopUserDeleteAction.jsp">
   <h4>신고회원 관리</h4>
   <table class="table mt-3" style="text-align:center;">
			<thead>
				<tr class="table-danger">
					<th style="widh:25%">바로해제</th>
					<th style="width:25%;">회원</th>
					<th style="width:25%;">정지일</th>
					<th style="width:25%;">해제일</th>
				</tr>
			</thead>
			<tbody>
<%
	ArrayList<StopDTO> stopList = new ArrayList<StopDTO>();
	stopList = new StopDAO().getList(pageNumber);
	if(stopList != null)
		for(int i = 0; i < stopList.size(); i++) {
			if(i==10) break;
			StopDTO stop = stopList.get(i);
%>
				<tr>
					<td><input type="button" class="btn btn-outline-danger ml-6" name="stopID" value="해제" onclick="location.href='stopUserDeleteAction.jsp?stopID=<%=stop.getStopID()%>'"></td>
					<td><%= stop.getUserEmail() %></td>
					<td><%= stop.getStopDate().substring(0,5) %></td>
					<td><%= stop.getStopDateEnd().substring(0,5) %></td>
				</tr>
<%
		}
%>
			</tbody>
		</table>
		</form>
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
	if(stopList.size() < 10) { // 다음 페이지가 존재하지 않는다면
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