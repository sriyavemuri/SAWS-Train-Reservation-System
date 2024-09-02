<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Train Schedule</title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    h2, p {
        text-align: center;
        color: #333;
    }

    button {
        border: none;
        border-radius: 10px;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .home-button {
        background-color: #4CAF50;
        position: absolute;
        top: 20px;
        left: 30px;
    }

    .home-button:hover {
        background-color: #45a049;
    }

    .logout-button {
        background-color: #f44336;
        position: absolute;
        top: 20px;
        right: 30px;
    }

    .logout-button:hover {
        background-color: #e53935;
    }

    .popup {
        margin: 70px auto;
        padding: 20px;
        background: #fff;
        border-radius: 5px;
        width: 30%;
        position: relative;
        transition: all 5s ease-in-out;
        text-align: center;
    }

    .popup h2 {
        margin-top: 0;
        color: #333;
        font-family: Tahoma, Arial, sans-serif;
    }

    .popup .content {
        max-height: 30%;
        overflow: auto;
    }

    .overlay {
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        background: rgba(0, 0, 0, 0.7);
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: white;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        padding: 12px;
        border: 1px solid #ddd;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
        color: #333;
    }

    form {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        margin-bottom: 20px;
    }

    input[type="submit"] {
        margin: 10px;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }

    @media screen and (max-width: 700px) {
        .popup {
            width: 70%;
        }

        table {
            width: 90%;
        }
    }

    a {
        text-decoration: none;
        color: white;
    }

</style>
</head>
<body>
<%
    if (request.getParameter("schedule") != null){
        session.setAttribute("schedule", request.getParameter("schedule"));
    }
    if (session.getAttribute("update") == null){
        response.sendRedirect("HandleUpdateTrainSchedule.jsp?schedule="+request.getParameter("schedule"));
    }
%>
<button class="home-button"><a href="HandleUpdateTrainSchedule.jsp?clear=true">Home</a></button>
<button class="logout-button"><a href="logout.jsp">Logout</a></button>
<h2>Update Train Schedule</h2>
<p>Selected train schedule: <%= session.getAttribute("schedule") %></p>
<div style="display: flex; justify-content: center;">
<% if (session.getAttribute("update") != null){ %>
    <form method="get" action="HandleUpdateTrainSchedule.jsp">
        <table>
            <tr> 
                <th>Stop Number</th>
                <th>Station</th>
                <th>Time</th>
            </tr>
            <% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("update")){ %>
            <tr>
                <%= t.getUpdateData() %>
            </tr>
            <% } %>
        </table>
        <br><br>
        <input type="submit" value="Update Schedule" />
    </form>
<% } %>
</div>
<% if (session.getAttribute("update_msg") != null) { %>
    <% if (session.getAttribute("update_msg").equals("Successfully Updated!")) {
        session.removeAttribute("update");
        session.removeAttribute("schedule_nums");
        session.removeAttribute("changeType");
        session.removeAttribute("schedule");
        session.removeAttribute("change_line");
    %>
    <div id="popup1" class="overlay">
        <div class="popup">
            <p><%= session.getAttribute("update_msg") %></p>
            <% session.removeAttribute("update_msg"); %>
            <div class="content">
                <button><a href="manageTrainSchedule.jsp">Go Back to Manage Train Schedule</a></button>
            </div>
        </div>
    </div>
    <% } %>
<% } %> 
</body>
</html>
