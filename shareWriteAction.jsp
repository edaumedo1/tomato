<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.*" %>
<%@ page import="util.*" %>
<%@ page import="share.ShareDAO" %>
<%@ page import="share.ShareDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String shareImg = null;
	String shareContent = null;
	String shareDate = null;
	String userEmail = null;
	String userNick = null;
	String userImg = null;
	byte[] ufile = null;
	
	ShareDAO shareDAO = new ShareDAO();
	shareDate = shareDAO.getDate();
	
	ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
	List items = sfu.parseRequest(request);
	Iterator iter = items.iterator();
	while(iter.hasNext()) {
		FileItem item = (FileItem) iter.next();
		String name = item.getFieldName();
		if(item.isFormField()) {
			String value = item.getString("utf-8");
			if (name.equals("shareContent")) shareContent = value; //request.getParameter 대신
		}
		else {
			if (name.equals("shareImg")) {
				shareImg = item.getName();
				ufile = item.get();
				String root = application.getRealPath(java.io.File.separator);
				FileUtil.saveImage(root, shareImg, ufile);
			}
		}
	}
	
	/**/
	
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
	
	UserDAO userDAO = new UserDAO();
	userNick = userDAO.getUserNick(userEmail);
	userImg = userDAO.getUserImg(userEmail);
	/*
	if(userImg == null) {
		userImg = "null";
	}
	*/
	
	if(shareContent == null || shareContent.equals("")) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
	int result = shareDAO.write(new ShareDTO(0, shareImg, shareContent, shareDate, 0, userEmail, userNick, userImg, null));
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
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>