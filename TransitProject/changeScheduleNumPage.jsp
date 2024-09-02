<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Select Schedule</title>
<style>
    body {
        font-family: Arial, Helvetica, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 20px;
    }

    h2 {
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
        margin-bottom: 20px;
    }

    select, input[type="submit"], button {
        margin: 10px;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
    }

    input[type="submit"], button {
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
    }

    input[type="submit"]:hover, button:hover {
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
        color: black;
    }
</style>
</head>
<body>
<%  
    if (request.getParameter("button") != null){
        session.setAttribute("changeType", request.getParameter("button"));
    }
    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * from transit_line;");
    ArrayList<String> lines = new ArrayList<String> ();
    while (rs.next()){
        lines.add(rs.getString("tl_name"));
    }
    db.closeConnection(con);
%>
<button class="home-button"><a href="HandleChangeTrainSchedule.jsp?clear=true">Home</a></button>
<button class="logout-button"><a href="logout.jsp">Logout</a></button>
<h2>Modify Train Schedule</h2>
<div style="display: flex; justify-content: center;">
    <form method="get" action="HandleChangeTrainSchedule.jsp">
        <select name="line" id="line" <% if (session.getAttribute("schedule_nums") != null){ %> disabled <%} %>> 
            <% if (session.getAttribute("schedule_nums") == null){ %>
                <option disabled selected>Select Transit Line</option>
            <% } %>
            <% for (String s : lines){  
                String s_temp = s.replace(" ", "+");
                if (session.getAttribute("schedule_nums") != null 
                    && session.getAttribute("change_line").equals(s)){
            %>
                <option value=<%= s_temp %> selected><%= s %></option>
            <% } else { %>
                <option value=<%= s_temp %>><%= s %></option>
            <% } } %>
        </select> 
        <input type="submit" value="Select" />
        <button onClick="HandleChangeTrainSchedule.jsp" name="clear" id="clear">Clear</button> 
    </form>
</div>

<div style="display: flex; justify-content: center;">
    <% if (session.getAttribute("schedule_nums") != null){ %>
    <table>
        <tr> 
            <th>Schedule Num</th>
            <th>Action</th>
        </tr>
        <% for (Integer t: (ArrayList<Integer>)session.getAttribute("schedule_nums")){ %>
        <tr>
            <td><%= t %></td>
            <% if (session.getAttribute("changeType").equals("delete")){ %>
                <td><button><a href="HandleChangeTrainSchedule.jsp?schedule=<%=t%>">Delete</a></button></td>
            <% } else { %>
                <td><button><a href="updateTrainSchedule.jsp?schedule=<%=t%>">Update</a></button></td>
            <% } %>
        </tr>
        <% } %>
    </table>
    <% } %>
</div>

<% if (session.getAttribute("change_msg") != null && !session.getAttribute("change_msg").equals("Please input transit line.")) { %>
    <% if (session.getAttribute("change_msg").equals("Successfully Deleted!")) {
        session.removeAttribute("schedule_nums");
        session.removeAttribute("changeType");
        session.removeAttribute("change_line");
    %>
    <div id="popup1" class="overlay">
        <div class="popup">
            <p><%= session.getAttribute("change_msg") %></p>
            <% session.removeAttribute("change_msg"); %>
            <div class="content">
                <button><a href="manageTrainSchedule.jsp">Go Back to Manage Train Schedule</a></button>
            </div>
        </div>
    </div>
    <% } %>
<% } %>

<% if (session.getAttribute("change_msg") != null && session.getAttribute("change_msg").equals("Please input transit line.")) { %>
    <div id="popup1" class="overlay">
        <div class="popup">
            <p><%= session.getAttribute("change_msg") %></p>
            <% session.removeAttribute("change_msg"); %>
            <div class="content">
                <button><a href="">Close</a></button>
            </div>
        </div>
    </div>
<% } %>  
</body>
</html>
