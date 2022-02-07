<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="report.ReportDTO"%>
<%@ page import="report.ReportDAO"%>
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

	String reportTarget = null;
	String reportReason = null;
	String reportContent = null;
	String reportAddr = null;
	
	if(request.getParameter("reportTarget") != null){
		reportTarget = (String) request.getParameter("reportTarget");
	}
	if(request.getParameter("reportReason") != null){
		reportReason = (String) request.getParameter("reportReason");
	}
	if(request.getParameter("reportContent") != null){
		reportContent = (String) request.getParameter("reportContent");
	}
	if(request.getParameter("reportAddr") != null){
		reportAddr = (String) request.getParameter("reportAddr");
	}
	
	if(reportContent == null || reportContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	ReportDAO reportDAO = new ReportDAO();
	String reportDate = null;
	reportDate = reportDAO.getDate();
	
	int result = reportDAO.write(new ReportDTO(0, userEmail, reportTarget, reportReason, reportContent, reportAddr, reportDate));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('신고에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail", userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('신고에 성공했습니다.');");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>