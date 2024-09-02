<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Train Schedule</title>
<style>
body {
  font-family: Arial, sans-serif;
  background-color: #f4f4f4;
  margin: 0;
  padding: 0;
}
h1 {
  text-align: center;
  color: #333;
  margin-top: 20px;
}
button {
  background-color: green;
  border: none;
  border-radius: 10px;
  color: white;
  padding: 10px 20px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 20px;
  margin: 4px 2px;
  cursor: pointer;
}
button.red {
  background-color: gray;
}
button a {
  color: white;
  text-decoration: none;
}
table {
  width: 80%;
  margin: 20px auto;
  border-collapse: collapse;
  background-color: #fff;
}
th, td {
  padding: 12px;
  border: 1px solid #ddd;
  text-align: center;
}
th {
  background-color: #f2f2f2;
}
select, input[type="submit"], input[type="date"] {
  padding: 10px;
  margin: 10px;
  border-radius: 5px;
  border: 1px solid #ccc;
}
.overlay {
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.7);
  transition: opacity 500ms;
  visibility: hidden;
  opacity: 0;
}
.overlay:target {
  visibility: visible;
  opacity: 1;
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
@media screen and (max-width: 700px){
  .popup {
    width: 70%;
  }
}
a {
  text-decoration: none;
}
</style>
</head>
<body>
<%
  String personType = (String) session.getAttribute("role");
  ApplicationDB db = new ApplicationDB(); 
  Connection con = db.getConnection();
  Statement stmt = con.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT * from station;");
  ArrayList<String> stations = new ArrayList<String>();
  while (rs.next()) {
    stations.add(rs.getString("name"));
  }
  rs = stmt.executeQuery("Select username from users where role='customer';");
  ArrayList<String> users = new ArrayList<String>();
  while (rs.next()) {
    users.add(rs.getString("username"));
  }
  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  Date date = new Date();
  db.closeConnection(con);
%>
<button style="position:absolute; top:20px; left:30px;"><a href="HandleTrainSchedule.jsp?clear=true">Home</a></button>
<button class="red" style="position:absolute; top:20px; right:30px;"><a href="logout.jsp">Logout</a></button>
<h1>Train Schedule</h1>
<div style="display: flex; justify-content: center;">
  <form method="get" action="HandleTrainSchedule.jsp">
    <table>
      <tr>
        <td>
          <% if (session.getAttribute("date") == null) { %>
            <input type="date" id="date" name="date" min="<%= dateFormat.format(date) %>">
          <% } else { %>
            <input type="date" id="date" name="date" min="<%= dateFormat.format(date) %>" value="<%= session.getAttribute("date") %>">
          <% } %>
        </td>
        <td>
          <select name="origin" id="origin">
            <% if (session.getAttribute("origin") == null) { %>
              <option disabled selected>Select Your Origin Station</option>
            <% } %>
            <% for (String s : stations) {
              String s_temp = s.replace(" ", "+");
              if (session.getAttribute("origin") != null && session.getAttribute("origin").equals(s)) { %>
                <option value="<%= s_temp %>" selected><%= s %></option>
              <% } else { %>
                <option value="<%= s_temp %>"><%= s %></option>
              <% } } %>
          </select>
        </td>
        <td>
          <select name="destination" id="destination">
            <% if (session.getAttribute("destination") == null) { %>
              <option disabled selected>Select Your Destination Station</option>
            <% } %>
            <% for (String s : stations) {
              String s_temp = s.replace(" ", "+");
              if (session.getAttribute("destination") != null && session.getAttribute("destination").equals(s)) { %>
                <option value="<%= s_temp %>" selected><%= s %></option>
              <% } else { %>
                <option value="<%= s_temp %>"><%= s %></option>
              <% } } %>
          </select>
        </td>
        <td>
          <input type="submit" value="Filter">
        </td>
      </tr>
    </table>
  </form>
</div>
<div style="display: flex; justify-content: center;">
  <br>
  <br>
</div>
<div style="display: flex; justify-content: center;">
  <% if (session.getAttribute("t_error") != null) {
    out.println(session.getAttribute("t_error"));
    session.removeAttribute("t_error");
  } else { %>
  <table>
    <% if (session.getAttribute("data") != null) { %>
    <tr>
      <th>Transit Line</th>
      <th>Schedule Number</th>
      <th>Departure Time</th>
      <th>Arrival Time</th>
      <th>Start Station</th>
      <th>End Station</th>
      <th>Travel Time</th>
      <th>Cost</th>
      <th></th>
    </tr>
    <% for (TrainScheduleObject t : (ArrayList<TrainScheduleObject>) session.getAttribute("data")) { %>
      <tr>
        <%= t.getData(personType) %>
      </tr>
    <% } %>
    <% } %>
  </table>
  <% } %>
</div>
<% if (request.getParameter("fare") != null) { %>
<div id="popup1" class="overlay">
  <div class="popup">
    <%
      session.setAttribute("r_fare", request.getParameter("fare"));
      session.setAttribute("schedule", request.getParameter("schedule"));
    %>
    <h3>Select More Ticket Information</h3>
    <b>Date:</b> <%= session.getAttribute("date") %><br>
    <b>Train Number:</b> <%= request.getParameter("schedule") %><br>
    <b>Origin:</b> <%= session.getAttribute("origin") %><br>
    <b>Destination:</b> <%= session.getAttribute("destination") %><br>
    <div class="content">
      <form action="HandleTrainSchedule.jsp">
        <% if (!personType.equals("customer")) { %>
        <b>Please select user:</b>
        <select name="username" id="username">
          <% for (String s : users) { %>
            <option value="<%= s %>"><%= s %></option>
          <% } %>
        </select>
        <% } %>
        <p><b>Please select ticket type:</b></p>
        <input type="radio" id="one" name="trip" value="One" checked>
        <label for="one">One-Way</label>
        <input type="radio" id="two" name="trip" value="Round">
        <label for="two">Round-Trip</label><br>
        <p><b>Please select discount type:</b></p>
        <input type="radio" id="normal" name="discount" value="Normal" checked>
        <label for="normal">Normal</label>
        <input type="radio" id="senior/child" name="discount" value="Senior/Child">
        <label for="senior">Senior</label>
        <input type="radio" id="disabled" name="discount" value="Disabled">
        <label for="disabled">Child/Disabled</label><br>
        <br>
        <input type="submit" value="Submit">
        <button><a href="#">Close</a></button>
      </form>
    </div>
  </div>
</div>
<% } %>
</body>
</html>
