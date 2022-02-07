<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="share.ShareDTO" %>
<%@ page import="share.ShareDAO" %>
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
	
	String reportEmail = null;
	if(request.getParameter("reportEmail") != null){
		reportEmail = (String) request.getParameter("reportEmail");
	}
	if(reportEmail.equals("admin")) { // 이메일 인증이 안된 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자는 신고할 수 없습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	String reportAddr = request.getHeader("referer");
%>
<div style="font-size:30px;"><b>신고하기</b></div>
	<form class="form-inline" method="post" action="./reportWriteAction.jsp">
		<table class="table mt-2">
			<tr>
				<td>
					신고대상:
					<input class="form-control" type="text" name="reportTarget" maxlength="20" value=<%=reportEmail %> readonly>
				</td>
			</tr>
			<tr>
         		<td>
					신고사유:
					<select name="reportReason" class="form-control">
						<option value="욕설">욕설</option>
						<option value="광고">광고</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					내용:
					<textarea class="form-control" rows="5" name="reportContent" maxlength="1024"></textarea>
				</td>
			</tr>
		</table>
		<input type="submit" class="btn btn-secondary ml-auto mr-1" value="신고하기">
		<input type="button" class="btn btn-secondary mr-auto ml-1" value="취소" onclick="history.back()">
		<input type="hidden" name="reportAddr" maxlength="1024" value=<%= reportAddr %>>
	</form>
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