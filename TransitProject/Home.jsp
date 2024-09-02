
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
        text-align: center;
    }
    header {
        background-color: #333;
        color: white;
        padding: 10px 0;
        position: relative;
    }
    header h1 {
        margin: 0;
    }
    .logout-button {
        position: absolute;
        top: 10px;
        right: 30px;
        background-color: gray;
        border: none;
        border-radius: 10px;
        padding: 10px 20px;
        cursor: pointer;
    }
    .logout-button a {
        color: black;
        text-decoration: none;
        font-size: 20px;
    }
    .container {
        margin: 50px auto;
        width: 80%;
        max-width: 600px;
        background-color: white;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        padding: 20px;
        border-radius: 10px;
    }
    .container input[type="button"] {
        display: block;
        width: 100%;
        margin: 10px 0;
        padding: 10px;
        font-size: 18px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .container input[type="button"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
<header>
    <h1>Home</h1>
    <button class="logout-button"><a href="logout.jsp">Logout</a></button>
</header>
<div class="container">
    <% 
    session.setAttribute("filterRole", "all");
    String browseLink = "BrowseTrainSchedule.jsp";
    String scheduleLink = "TrainSchedule.jsp";
    String manageLink = "manageTrainSchedule.jsp";
    String mesLink = "messaging.jsp";
    String resLink = "resPage.jsp";
    String saleLink = "salesReport.jsp";
    String userLink = "People.jsp";
    %>

    <% if(session.getAttribute("role").equals("customer_service_rep")) { %>
        <input type="button" value="Browse All Train Schedules" onClick="javascript:window.location='<%=browseLink%>';">
        <input type="button" value="Reserve/View Train Schedules" onClick="javascript:window.location='<%=scheduleLink%>';">
        <input type="button" value="Manage Train Schedule" onClick="javascript:window.location='<%=manageLink%>';">
        <input type="button" value="View Reservations" onClick="javascript:window.location='<%=resLink%>';">
        <input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">

    <% } else if(session.getAttribute("role").equals("customer")) { %>
        <input type="button" value="Browse All Train Schedules" onClick="javascript:window.location='<%=browseLink%>';">
        <input type="button" value="Reserve/View Train Schedules" onClick="javascript:window.location='<%=scheduleLink%>';">
        <input type="button" value="View Reservations" onClick="javascript:window.location='<%=resLink%>';">
        <input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">

    <% } else if(session.getAttribute("role").equals("administrator")) { %>
        <input type="button" value="View Users" onClick="javascript:window.location='<%=userLink%>';">
        <input type="button" value="Browse All Train Schedules" onClick="javascript:window.location='<%=browseLink%>';">
        <input type="button" value="Reserve/View Train Schedules" onClick="javascript:window.location='<%=scheduleLink%>';">
        <input type="button" value="Manage Train Schedule" onClick="javascript:window.location='<%=manageLink%>';">
        <input type="button" value="View Sales Reports" onClick="javascript:window.location='<%=saleLink%>';">
        <input type="button" value="View Reservations" onClick="javascript:window.location='<%=resLink%>';">
        <input type = "button" value = "View Messages" onClick = "javascript:window.location='<%=mesLink%>';">

    <% } %>
</div>
</body>
</html>

