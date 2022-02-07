<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="stop.StopDTO"%>
<%@ page import="stop.StopDAO"%>
<%@ page import="report.ReportDAO"%>
<%@ page import="report.ReportDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>
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

	if (!userEmail.equals("admin")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");				
	}
	
	int reportID = 0;
	if(request.getParameter("reportID") != null){
		reportID = Integer.parseInt(request.getParameter("reportID"));
	}
	
	int stopDays = 0;
	String stopUserEmail = null;
	String stopDate = null;
	String stopDateEnd = null;
	
	StopDAO stopDAO = new StopDAO();
	
	if(request.getParameter("stopUserEmail") != null){
		stopUserEmail = (String) request.getParameter("stopUserEmail");
	}
	if(request.getParameter("stopDays") != null){
		stopDays = Integer.parseInt(request.getParameter("stopDays"));
	}
	
	//stopDateEnd 계산
	Date date = new Date(); //현재시간
	SimpleDateFormat sdformat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	cal.setTime(date); // cal에 현재시간 담기
	
	stopDate = sdformat.format(cal.getTime());
	
	cal.add(Calendar.DATE, stopDays);
	stopDateEnd = sdformat.format(cal.getTime());
	
	int result = stopDAO.stop(new StopDTO(0, stopDays, stopUserEmail, stopDate, stopDateEnd));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원정지에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		ReportDAO reportDAO = new ReportDAO();
		reportDAO.delete(reportID); // 해당 신고글은 삭제
		session.setAttribute("userEmail", userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'reportManage.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>