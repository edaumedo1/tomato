<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="share.ShareDTO" %>
<%@ page import="share.ShareDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="likey.LikeyDAO" %>
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
	
	LikeyDAO likeyDAO = new LikeyDAO();
	int likeyCheck = 0;
	
	ArrayList<ShareDTO> shareList = new ArrayList<ShareDTO>();
	shareList = new ShareDAO().getList(pageNumber);
	if(shareList != null)
		for(int i = 0; i < shareList.size(); i++) {
			if(i==10) break;
			ShareDTO share = shareList.get(i);
			
			
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
			<div style="width:500%; text-align: left"><a href="otherProfile.jsp?shareID=<%=share.getShareID()%>"><%=share.getUserNick() %></a></div> <!-- 프로필 링크 -->
			<!-- <span style="vertical-align:middle;"><%=share.getLikeCount() %></span> -->
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
			<div class="main_board_images"><a href="shareContent.jsp?shareID=<%=share.getShareID() %>" ><%=shareImgstr %></a></div><!-- 게시물 사진 -->
		</div>
		<div class="main_board_letter"><!-- 사용자 게시글 -->
			<a href="shareContent.jsp?shareID=<%=share.getShareID() %>" ><%=share.getShareContent() %></a></div>
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
	<a class="page-link" href="./index.jsp?pageNumber=<%= pageNumber -1 %>">이전</a>
<%
	}
%>
		</li>
		<li class="page-item">
<%
	if(shareList.size() < 10) { // 다음 페이지가 존재하지 않는다면
%>
	<a class="page-link disabled">다음</a>
<%
	} else { // 다음 페이지가 존재한다면
%>
	<a class="page-link" href="./index.jsp?pageNumber=<%= pageNumber +1 %>">다음</a>
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