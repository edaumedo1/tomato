<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="share.ShareDAO"%>
<%@ page import="share.ShareDTO"%>
<%@ page import="likey.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%> <!-- 특정한 스크립트 구문을 출려하고자 할 때 사용 -->
<%
	String userEmail = null;
	if(session.getAttribute("userEmail") != null) { // 사용자가 로그인 상태일 때(세션값이 유효한 상태)
		userEmail = (String) session.getAttribute("userEmail");
	}
	if(userEmail == null) { // 사용자가 로그인 하지 않은 상태
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	int shareID = 0;
	if(request.getParameter("shareID") != null) {
		shareID = Integer.parseInt(request.getParameter("shareID"));
	}
	
	ShareDAO shareDAO = new ShareDAO();
	LikeyDAO LikeyDAO = new LikeyDAO();
	int result = LikeyDAO.like(userEmail, shareID);
	if (result == 1) {
		result = shareDAO.like(shareID);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back()");
			script.println("</script>");
			script.close();
			return;
		}
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천을 누른 글입니다.');");
		script.println("history.back()");
		script.println("</script>");
		script.close();
		return;
	}
%>