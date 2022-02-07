<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	session.invalidate(); // 사용자의 모든 세션정보 파기
%>
<script>
	location.href = 'userLogin.jsp';
</script>