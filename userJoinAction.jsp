<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="util.SHA256"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8"); //사용자에게 입력받은 요청정보는 전부 UTF-8으로 처리
	String userEmail = null;
	String userNick = null;
	String userPassword = null;
	String userPassword2 = null;
	if(request.getParameter("userEmail") != null){ //userID라는 것을 사용자가 입력을 했다면 userID에 사용자의 입력값 넣는 것
		userEmail = (String) request.getParameter("userEmail");
	}
	if(request.getParameter("userNick") != null){
		userNick = (String) request.getParameter("userNick");
	}
	if(request.getParameter("userPassword") != null){
		userPassword = (String) request.getParameter("userPassword");
	}
	if(request.getParameter("userPassword2") != null){
		userPassword2 = (String) request.getParameter("userPassword2");
	}
	
	if(userEmail == null || userNick == null || userPassword == null || userPassword2 == null || userEmail.equals("") || userNick.equals("") || userPassword.equals("") ||userPassword2.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else if(!userPassword.equals(userPassword2)) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 다시 확인해주세요.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.join(new UserDTO(userEmail, userNick, userPassword, null, null, null, true));
	if (result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이메일 또는 닉네임이 이미 존재합니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		session.setAttribute("userEmail",userEmail); //회원가입 성공시 로그인 상태 유지
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'"); //이메일 인증페이지로 사용자를 보낸다
		script.println("</script>");
		script.close();
		return;
	}
	
%>