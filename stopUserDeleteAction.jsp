<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="stop.StopDTO"%>
<%@ page import="stop.StopDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*"%>
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

	int stopID = 0;
	if (request.getParameter("stopID") != null) {
		stopID = Integer.parseInt(request.getParameter("stopID"));
	}
	
	if (stopID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
	}
	
	if (!userEmail.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");				
	}
	
	StopDAO stopDAO = new StopDAO();
	
	int result = stopDAO.delete(stopID);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('해제에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail", userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'stopUserManage.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>