<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="notice.NoticeDTO"%>
<%@ page import="notice.NoticeDAO"%>
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

	String noticeTitle = null;
	String noticeContent = null;
	if(request.getParameter("noticeTitle") != null){
		noticeTitle = (String) request.getParameter("noticeTitle");
	}
	if(request.getParameter("noticeContent") != null){
		noticeContent = (String) request.getParameter("noticeContent");
	}
	if(noticeTitle == null || noticeContent == null || noticeTitle.equals("") || noticeContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	NoticeDAO noticeDAO = new NoticeDAO();
	String noticeDate = null;
	noticeDate = noticeDAO.getDate();
	
	int result = noticeDAO.write(new NoticeDTO(0, noticeTitle, noticeContent, noticeDate));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail", userEmail);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
%>