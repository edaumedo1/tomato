<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="schedule.ScheduleDTO" %>
<%@ page import="schedule.ScheduleDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<link href='packages/core/main.css' rel='stylesheet' />
<link href='packages/daygrid/main.css' rel='stylesheet' />
<link href='packages/timegrid/main.css' rel='stylesheet' />
<link href='packages/list/main.css' rel='stylesheet' />
<link rel = "stylesheet" href = "css/core.css">
<script src='packages/core/main.js'></script>
<script src='packages/interaction/main.js'></script>
<script src='packages/daygrid/main.js'></script>
<script src='packages/timegrid/main.js'></script>
<script src='packages/list/main.js'></script>

<style>

  html, body {
    overflow: hidden; /* don't do scrollbars */
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 24px;
  }

  #calendar-container {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
  }

  .fc-header-toolbar {
    /*
    the calendar will be butting up against the edges,
    but let's scoot in the header's buttons
    */
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }
  .bar-footer{
  height: 135px;
  padding-top: 10px;
  }
  .bar-footer img{
  width: 125px;
  }
  .bar_img{
  width: 23%;
  }

</style>
<title>토마토: 일정</title>
</head>
<body>
<%
	String userEmail = null;
	if(session.getAttribute("userEmail") != null){ //유저가 로그인했을 경우
		userEmail = (String) session.getAttribute("userEmail");
	}
	if(userEmail == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	 ArrayList<ScheduleDTO> scheduleList = new ArrayList<ScheduleDTO>();
	  scheduleList = new ScheduleDAO().getList(1, userEmail);
	  if(scheduleList != null)%>
<script>
var today = new Date();

var year = today.getFullYear();
var month = ('0' + (today.getMonth() + 1)).slice(-2);
var day = ('0' + today.getDate()).slice(-2);

var dateString = year + '-' + month  + '-' + day;
console.log(dateString);
	  document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
		
	    var calendar = new FullCalendar.Calendar(calendarEl, {
	      plugins: [ 'interaction', 'dayGrid', 'timeGrid', 'list' ],
	      height: 'parent',
	      header: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	      },
	      defaultView: 'dayGridMonth',
	      defaultDate: dateString,
	      navLinks: true, // can click day/week names to navigate views
	      editable: true,
	      eventLimit: true, // allow "more" link when too many events
	      events: [
	  	<%
	  	for(int i = 0; i < scheduleList.size(); i++) {
	  		ScheduleDTO schedule = scheduleList.get(i);

  			
  				String title= schedule.getScheduleTitle();
  				String start= schedule.getScheduleDate();
  			%>
  			{
			title: "<%=title%>",
			start: "<%=start%>"
			},
	  	<%}%>
    ]});

    calendar.render();
    console.log(calendar);
  });
</script>
  <div id='calendar-container' class="calendar-container">
    <div id='calendar'></div>
  </div>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/popper.js"></script>
	<script src="./js/bootstrap.min.js"></script>
	<nav class="bar-footer">
<% 
	if (userEmail.equals("admin")) {
%>
	<div class="bar_img"><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img"><a href="adminProfile.jsp"><img src="images/loginRed.png"/></a></div>
<%
	} else {
%>
	<div class="bar_img unselect_menu" ><a href="index.jsp"><img src="images/sns.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="contentWrite.jsp"><img src="images/plus.png"/></a></div>
	<div class="bar_img"><a href="userSchedule.jsp"><img src="images/schedule.png"/></a></div>
	<div class="bar_img unselect_menu"><a href="userProfile.jsp"><img src="images/login.png"/></a></div>
<%
	}
%>
	</nav>
</body>
</html>