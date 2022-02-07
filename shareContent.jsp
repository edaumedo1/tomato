<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="share.ShareDTO" %>
<%@ page import="share.ShareDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=devie-width, initial-scale=1, shrink-to-fit=no">
	<title>토마토 민족:공유 글</title>
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel = "stylesheet" href = "css/core.css">
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
	
	if (shareID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	
	LikeyDAO likeyDAO = new LikeyDAO();
	int likeyCheck = 0;
	
	ArrayList<ShareDTO> shareContentView = new ArrayList<ShareDTO>();
	shareContentView = new ShareDAO().shareContentView(shareID);
	if(shareContentView != null)
		for(int i = 0; i < shareContentView.size(); i++) {
			if(i==10) break;
			ShareDTO share = shareContentView.get(i);
			
			
			String userImg = share.getUserImg(), userImgstr = "";
			String shareImg = share.getShareImg(), shareImgstr = "";
			if(userImg != null){
				userImgstr = "<img src='images/"+userImg+"'>";
			} 
			
	        if (shareImg != null) {
	            shareImgstr = "<img src='images/" + shareImg + "'>";
	        }
%>
	<div class="main_board">
		<header class="main_board_top">
			<div class="main_board_userImg"><%=userImgstr%></div>
			<div style="width:500%; text-align: left"><a href="otherProfile.jsp"><%=share.getUserNick() %></a></div> <!-- 프로필 링크 -->
			<span style="vertical-align:middle;"><%=share.getLikeCount() %></span>
<%
	likeyCheck = likeyDAO.likeCheck(share.getShareID(), userEmail);
	if(likeyCheck == 1) { // 이미 추천
%>
			<div class="favorite">
				<input type="image" src="images/favorite_click .png" alt="button" onclick="location.href='shareLikeAction.jsp?shareID=<%=share.getShareID()%>'">
			</div>
<%
	} else if(likeyCheck == -1) {
%>
			<div class="favorite">
				<input type="image" src="images/favorite.png" alt="button" onclick="location.href='shareLikeAction.jsp?shareID=<%=share.getShareID()%>'">
			</div>
<%
	}
%>
		</header>
		<div>
			<div class="main_board_images"><%=shareImgstr %></div>
		</div>
		<div class="main_board_letter"><!-- 사용자 게시글 -->
			<%=share.getShareContent() %>
		</div>
	</div>
<%
		}
%>
<hr>
	<div>
		<table style="margin:auto;">
		<tr>
<%
	ShareDTO share = new ShareDAO().getShareInfo(shareID);
	if (userEmail.equals(share.getUserEmail())) {
							
%>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='shareUpdate.jsp?shareID=<%=shareID%>'">수정</button></td>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='shareDeleteAction.jsp?shareID=<%=shareID%>'">삭제</button></td>
<%
	} else if (userEmail.equals("admin")) {
%>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='shareUpdate.jsp?shareID=<%=shareID%>'">수정</button></td>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='shareDeleteAction.jsp?shareID=<%=shareID%>'">삭제</button></td>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='report.jsp?reportEmail=<%=share.getUserEmail()%>'">신고</button></td>
<%
	} else {
%>
			<td><button type="button" class="btn btn-secondary" onclick="location.href='report.jsp?reportEmail=<%=share.getUserEmail()%>'">신고</button></td>
<%
	}
%>
		</tr>
		</table>
	</div>

	<br><br><br>
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