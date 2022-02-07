<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0"/>
	<link rel = "stylesheet" href = "css/core.css">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
	<title>토마토 민족:회원 탈퇴</title>
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
%>
<div>
	<span class="ml-2 mt-3" style="float:left;"><h4>회원 탈퇴</h4></span>
	</div>
	<div>
		<span class="ml-2" style="float:left;">
		<br>-탈퇴를 하는 즉시 로그인이 불가능합니다.
		<br>-작성한 게시글은 삭제하지 않는한 유지됩니다.
		<br>-회원 정보가 삭제되고 복구가 불가능합니다.
		</span>
	</div>
	<div>
		<span class="ml-2 mb-3" style="float:left; font-size:samll;">-탈퇴를 진행하시려면 빈칸에 
		<br>"지금 탈퇴하겠습니다."를 정확하게 입력해주세요.<br>(따옴표 제외)</span>
	</div>
	<div>
	<form method="post" action="withdrawAction.jsp">
		<div class="mb-3">
			<input type="text" name="withdrawText" class="form-control" maxlength="30" placeholder="지금 탈퇴하겠습니다." />
		</div>
		<div class="ml-2 mb-3">
			<span>
			<input type="checkbox" name="withdrawCheck" value="회원탈퇴" /> 위 내용을 모두 확인했으며, 이에 동의합니다.
			</span>
		</div>
		<div align="center">
			<input type="submit" class="btn btn-secondary" value="회원탈퇴">
			<input type="button" class="btn btn-secondary" value="취소" onclick="location.href='myHome.jsp'">
		</div>
	</form>
	</div>
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