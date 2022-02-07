<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="share.ShareDAO" %>
<%@ page import="share.ShareDTO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=devie-width, initial-scale=1, shrink-to-fit=no">
	<title>토마토 민족</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
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
	
	ShareDAO shareDAO = new ShareDAO();
	int shareID = 0;
	if (request.getParameter("shareID") != null) {
		shareID = Integer.parseInt(request.getParameter("shareID"));
	}
	
	if (shareID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	
	String shareContent = shareDAO.getShareContent(shareID);
%>
	<section class="container center mt-4" style="max-width:400px;">
	<div>
		<span class="ml-2 mt-3" style="float:left; color:gray;"><h4>공유글 수정</h4></span>
	</div>
	<div>
		<form method="post" action="shareUpdateAction.jsp?shareID=<%=shareID %>" enctype="multipart/form-data">
			<table class="table table" style="text-align:center; border:none solid #dddddd">
					<tr>
						<td><input type="file" id="shareImg" name="shareImg" required></td>
					</tr>
					<tr>
						<td><textarea class="form-control" name="shareContent" maxlength="2048" style="height:350px;"><%=shareContent.replaceAll("&lt;", "<").replaceAll("&gt;", ">").replaceAll("<br>", "\r\n") %></textarea></td>
					</tr>
			</table>
			<div align="center">
			<input type="submit" class="btn btn-secondary" value="수정">
			<input type="button" class="btn btn-secondary" value="취소" onclick="location.href='shareContent.jsp?shareID=<%=shareID%>'">
			</div>
		</form>
	</div>
	</section>
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