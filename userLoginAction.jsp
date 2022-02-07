<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="stop.StopDTO"%>
<%@ page import="stop.StopDAO"%>
<%
	request.setCharacterEncoding("UTF-8");
	UserDAO userDAO = new UserDAO();
	String userEmail = null;
	String userPassword = null;
	
	if(request.getParameter("userEmail") != null){
		userEmail = (String) request.getParameter("userEmail");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = (String) request.getParameter("userPassword");
	}
	
	if(userEmail == null || userPassword == null || userEmail.equals("") || userPassword.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	int result = userDAO.login(userEmail, userPassword);
	int stopCheck = userDAO.stopCheck(userEmail);
	
	StopDAO stopDAO = new StopDAO();
	
	Date date = new Date();
	SimpleDateFormat sdformat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	cal.setTime(date);
	String now = sdformat.format(cal.getTime());
	
	if (result == 1) {
		if (stopCheck == -1) { // stop DB에 없음
			session.setAttribute("userEmail",userEmail);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'index.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else if(stopCheck == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back();"); 
			script.println("</script>");
			script.close();
			return;
		} else if(stopCheck == 1) { // stop DB에 있음
			StopDTO stop = new StopDAO().getStopView(userEmail);
			String stopDateEnd = stop.getStopDateEnd();
			int compareTime = now.compareTo(stopDateEnd);
			if(compareTime < 0) { // 해제일 전
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이용 정지된 회원입니다.');");
				script.println("history.back();"); 
				script.println("</script>");
				script.close();
				return;
			} else if(compareTime > 0) { // 해제일 후
				stopDAO.delete(userEmail);
				session.setAttribute("userEmail",userEmail);
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'index.jsp'");
				script.println("</script>");
				script.close();
				return;
			}
		}
	} else if (result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if (result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.');");
		script.println("history.back();"); 
		script.println("</script>");
		script.close();
		return;
	}
	
%>