<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDTO"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8"); //사용자에게 입력받은 요청정보는 전부 UTF-8으로 처리
	String userEmail = null;
	String withdrawText = null;
	String withdrawCheck = null;
	
	if(session.getAttribute("userEmail") != null){ //유저가 로그인했을 경우
		userEmail = (String) session.getAttribute("userEmail");
	}
	
	if(request.getParameter("withdrawText") != null){
		withdrawText = (String) request.getParameter("withdrawText");
	}
	
	if(request.getParameter("withdrawCheck") != null){
		withdrawCheck = (String) request.getParameter("withdrawCheck");
	}
	
	if(withdrawText == null || withdrawCheck == null || withdrawText.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
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
	
	UserDAO userDAO = new UserDAO();
	//int result = userDAO.delete(userID);
	if(withdrawCheck.equals("false") || !withdrawText.equals("지금 탈퇴하겠습니다.")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('텍스트가 정확하지 않거나 위에 내용에 동의하지 않았습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		int result = userDAO.delete(userEmail);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원탈퇴에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		} else {
			session.setAttribute("userEmail", userEmail);
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원탈퇴에 성공했습니다.');");
			script.println("location.href = 'userLogin.jsp'");
			script.println("</script>");
			script.close();
			return;
		}
		
	} 
	
%>