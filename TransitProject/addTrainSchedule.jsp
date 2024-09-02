<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Train Schedule</title>
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
        flex-direction: column;
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
        color: white;
    }
</style>
</head>
<body>
<%
    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    
    /* Get stations for the Origin and Destination Dropdown */
    ResultSet rs = stmt.executeQuery("SELECT * from transit_line;");
    ArrayList<String> lines = new ArrayList<String> ();
    while (rs.next()){
        lines.add(rs.getString("tl_name"));
    }
    rs = stmt.executeQuery("SELECT * from train;");
    ArrayList<String> trains = new ArrayList<String> ();
    while (rs.next()){
        trains.add(rs.getString("train_id"));
    }
    db.closeConnection(con);
%>
<button class="home-button"><a href="HandleAddTrainSchedule.jsp?clear=true">Home</a></button>
<button class="logout-button"><a href="logout.jsp">Logout</a></button>
<h2>Add Train Schedule</h2>
<div style="display: flex; justify-content: center;">
    <form method="get" action="HandleAddTrainSchedule.jsp">
        <select name="line" id="line" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
            <% if (session.getAttribute("add") == null){ %>
                <option disabled selected>Select Transit Line</option>
            <% } %>
            <% for (String s : lines){  
                String s_temp = s.replace(" ", "+");
                if (session.getAttribute("add") != null && session.getAttribute("add_line").equals(s)){
            %>
                <option value=<%= s_temp %> selected><%= s %></option>
            <% } else { %>
                <option value=<%= s_temp %>><%= s %></option>
            <% } } %>
        </select> 
        <select name="train" id="train" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
            <% if (session.getAttribute("add") == null){ %>
                <option disabled selected>Select Train</option>
            <% } %>
            <% for (String s : trains){ 
                String s_temp = s.replace(" ", "+");
                if (session.getAttribute("add") != null && session.getAttribute("add_train").equals(s)){
            %>
                <option value=<%= s_temp %> selected><%= s %></option>
            <% } else { %>
                <option value=<%= s_temp %>><%= s %></option>
            <% } } %>
        </select> 
        <select name="direction" id="direction" <% if (session.getAttribute("add") != null){ %> disabled <%} %>> 
            <% if (session.getAttribute("add") == null){ %>
                <option disabled selected>Select Direction</option>
            <% } %>
            <% if (session.getAttribute("add") != null && session.getAttribute("add_dir").equals("up")){ %>
                <option value="up" selected>up</option>
                <option value="down">down</option>
            <% } else if (session.getAttribute("add") != null && session.getAttribute("add_dir").equals("down")){ %>
                <option value="up">up</option>
                <option value="down" selected>down</option>
            <% } else { %>
                <option value="up">up</option>
                <option value="down">down</option>
            <% } %>
        </select> 
        <input type="submit" value="Select" />
        <button onClick="HandleAddTrainSchedule.jsp" name="clear" id="clear">Clear</button> 
    </form>
</div>
<br><br>
<div style="display: flex; justify-content: center;">
    <% if (session.getAttribute("add") != null){ %>
    <form method="get" action="HandleAddTrainSchedule.jsp">
        <table>
            <tr> 
                <th>Stop Number</th>
                <th>Station</th>
                <th>Time</th>
            </tr>
            <% for (TrainScheduleObject t: (ArrayList<TrainScheduleObject>)session.getAttribute("add")){ %>
            <tr>
                <%= t.getAddData() %>
            </tr>
            <% } %>
        </table>
        <br><br>
        <input type="submit" value="Add Schedule" />
    </form>
    <% } %>
</div>
<% if (session.getAttribute("add_msg") != null) {  %>
    <% if (session.getAttribute("add_msg").equals("Successfully Added!")) {
        session.removeAttribute("add");
        session.removeAttribute("add_train");
        session.removeAttribute("add_line");
        session.removeAttribute("add_dir");
    %>
    <div id="popup1" class="overlay">
        <div class="popup">
            <p><%= session.getAttribute("add_msg") %></p>
            <% session.removeAttribute("add_msg"); %>
            <div class="content">
                <button><a href="manageTrainSchedule.jsp">Go Back to Manage Train Schedule</a></button>
            </div>
        </div>
    </div>
    <% } else { %>
    <div id="popup1" class="overlay">
        <div class="popup">
            <p><%= session.getAttribute("add_msg") %></p>
            <% session.removeAttribute("add_msg"); %>
            <div class="content">
                <button><a href="">Close</a></button>
            </div>
        </div>
    </div>
    <% } %>    
<% } %>
</body>
</html>
