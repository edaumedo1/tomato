<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="share.ShareDTO"%>
<%@ page import="share.ShareDAO"%>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8"); //사용자에게 입력받은 요청정보는 전부 UTF-8으로 처리
	String userEmail = null;
	if(session.getAttribute("userEmail") != null){ //유저가 로그인했을 경우
		userEmail = (String) session.getAttribute("userEmail");
	}
	if(userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
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
	
	
	ShareDAO shareDAO = new ShareDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	
	int result1 = shareDAO.delete(shareID);
	int result2 = likeyDAO.deleteAll(shareID);
	if (result2 == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('추천삭제에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result1 == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글삭제에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail", userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>