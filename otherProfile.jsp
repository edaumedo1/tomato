<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="share.ShareDTO" %>
<%@ page import="share.ShareDAO" %>
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
	
	int shareID = 0;
	if (request.getParameter("shareID") != null) {
		shareID = Integer.parseInt(request.getParameter("shareID"));
	}
	
	ShareDAO shareDAO = new ShareDAO();
	ShareDTO shareInfo = new ShareDAO().getShareInfo(shareID);
	
	String otherEmail = shareInfo.getUserEmail();
	
	UserDAO userDAO = new UserDAO();
	String otherIntro = userDAO.getUserIntro(otherEmail);
%>
	<div class="profile_box">
		<div>
			<div class="profile_userImg">
				<img src="images/<%=shareInfo.getUserImg()%>"/>
			</div>
			<div class="profile_userName">
				<br><h4><%= shareInfo.getUserNick() %></h4>
			</div>
			
			<div class="profile_userBoard">
				<%=otherIntro %>
			</div>
		</div>
	</div>
	
	<div class="profile_img">
			<div class="profile_img_floor">
<%
	ArrayList<ShareDTO> getUserShare1 = new ArrayList<ShareDTO>();
	getUserShare1 = new ShareDAO().getUserShare1(otherEmail);
	if(getUserShare1 != null)
		for(int i = 0; i < getUserShare1.size(); i++) {
			if(i==3) break;
			ShareDTO share = getUserShare1.get(i);
			
			String shareImg = share.getShareImg(), shareImgstr = "";
	        if (shareImg != null) {
	            shareImgstr = "<img src='images/" + shareImg + "'>";
	        }
%>
				<div class="profile_img_block">
					<a href="shareContent.jsp?shareID=<%=share.getShareID() %>" >
						<%=shareImgstr %>
					</a>
				</div>
<%
		}
%>
			</div>
			<div class="profile_img_floor">
<%
	ArrayList<ShareDTO> getUserShare2 = new ArrayList<ShareDTO>();
	getUserShare2 = new ShareDAO().getUserShare2(otherEmail);
	if(getUserShare2 != null)
		for(int i = 0; i < getUserShare2.size(); i++) {
			if(i==10) break;
			ShareDTO share = getUserShare2.get(i);
			
			String shareImg = share.getShareImg(), shareImgstr = "";
	        if (shareImg != null) {
	            shareImgstr = "<img src='images/" + shareImg + "'>";
	        }
%>
				<div class="profile_img_block">
					<a href="shareContent.jsp?shareID=<%=share.getShareID() %>" >
						<%=shareImgstr %>
					</a>
				</div>
<%
		}
%>
			</div>
	</div>
	<br><br><br>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<nav class="bar-footer">
		<div class="bar_img unselect_menu" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
		<div class="bar_img unselect_menu"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
		<div class="bar_img unselect_menu"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
		<div class="bar_img unselect_menu"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
	</nav>
</body>
</html>