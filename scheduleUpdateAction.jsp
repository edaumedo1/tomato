<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>
<%@ page import="schedule.ScheduleDAO" %>
<%@ page import="schedule.ScheduleDTO" %>
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
	String scheduleTitle = null;
	String scheduleDate = null;
	
	if (request.getParameter("scheduleID") != null) {
		scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
	}
	if(request.getParameter("scheduleTitle") != null){
		scheduleTitle = (String) request.getParameter("scheduleTitle");
	}
	if(request.getParameter("scheduleDate") != null){
		scheduleDate = (String) request.getParameter("scheduleDate");
	}
	
	if(scheduleTitle == null || scheduleDate == null || scheduleTitle.equals("") || scheduleDate.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	if (scheduleID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	
	ScheduleDAO scheduleDAO = new ScheduleDAO();
	
	int result = scheduleDAO.update(scheduleID, scheduleTitle, scheduleDate);
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글수정에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail", userEmail);
%>
		<script>
		window.location.href = "userSchedule.jsp";
		</script>
<%
		return;
	}
	
%>