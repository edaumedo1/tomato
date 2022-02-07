<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="schedule.ScheduleDTO"%>
<%@ page import="schedule.ScheduleDAO"%>
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
	
	int scheduleID = 0;
	if (request.getParameter("scheduleID") != null) {
		scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
	}
	
	if (scheduleID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	
	
	ScheduleDAO scheduleDAO = new ScheduleDAO();
	
	int result1 = scheduleDAO.delete(scheduleID);
	if (result1 == -1) {
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
		script.println("location.href = 'scheduleEdit.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>