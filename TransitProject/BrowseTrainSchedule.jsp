<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Browse Train Schedule</title>
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
select, input[type="submit"] {
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
@media screen and (max-width: 700px) {
  .popup {
    width: 70%;
  }
}
</style>
</head>
<body>
<%
  String personType = (String) session.getAttribute("role");
  ApplicationDB db = new ApplicationDB(); 
  Connection con = db.getConnection();
  Statement stmt = con.createStatement();
  ResultSet rs = stmt.executeQuery("SELECT tl_name from transit_line;");
  ArrayList<String> lines = new ArrayList<String>();
  while (rs.next()) {
    lines.add(rs.getString("tl_name"));
  }
  db.closeConnection(con);
%>
<button style="position:absolute; top:20px; left:30px;"><a href="HandleBrowse.jsp?clear=true">Home</a></button>
<button class="red" style="position:absolute; top:20px; right:30px;"><a href="logout.jsp">Logout</a></button>
<h1>View All Train Schedules</h1>
<div style="display: flex; justify-content: center;">
  <form method="get" action="HandleBrowse.jsp">
    <table>
      <tr>
        <td>
          <select name="b_line" id="b_line"> 
            <% if (session.getAttribute("b_line") == null) { %>
              <option disabled selected>Select a Transit Line</option>
            <% } %>
            <% for (String s : lines) { 
              String s_temp = s.replace(" ", "+");
              if (session.getAttribute("b_line") != null && session.getAttribute("b_line").equals(s)) {
            %>
              <option value="<%= s_temp %>" selected><%= s %></option>
            <% } else { %>
              <option value="<%= s_temp %>"><%= s %></option>
            <% }} %>
          </select>
        </td>
        <td>
          <select name="sort" id="sort"> 
            <% if (session.getAttribute("b_sort") == null) { %>
              <option disabled selected>Sort By</option>
              <option value="fare">Fare</option>
              <option value="tsm2.arrival_time">Arrival Time</option>
              <option value="tsm1.departure_time">Departure Time</option>
              <option value="start">Origin Station</option>
              <option value="end">Destination Station</option>
            <% } else { %>
              <% if (session.getAttribute("b_sort").equals("fare")) { %>
                <option value="fare" selected>Fare</option>
              <% } else { %>
                <option value="fare">Fare</option>
              <% } %>
              <% if (session.getAttribute("b_sort").equals("tsm2.arrival_time")) { %>
                <option value="tsm2.arrival_time" selected>Arrival Time</option>
              <% } else { %>
                <option value="tsm2.arrival_time">Arrival Time</option>
              <% } %>
              <% if (session.getAttribute("b_sort").equals("tsm1.departure_time")) { %>
                <option value="tsm1.departure_time" selected>Departure Time</option>
              <% } else { %>
                <option value="tsm1.departure_time">Departure Time</option>
              <% } %>
              <% if (session.getAttribute("b_sort").equals("start")) { %>
                <option value="start" selected>Origin Station</option>
              <% } else { %>
                <option value="start">Origin Station</option>
              <% } %>
              <% if (session.getAttribute("b_sort").equals("end")) { %>
                <option value="end" selected>Destination Station</option>
              <% } else { %>
                <option value="end">Destination Station</option>
              <% } %>
            <% } %>
          </select>
        </td>
        <td>
          <input type="submit" value="Filter" />
        </td>
      </tr>
    </table>
  </form>
</div>
<div style="display: flex; justify-content: center;">
  <table>
    <% if (session.getAttribute("b_data") != null) { %>
      <tr> 
        <th>Transit Line</th>
        <th>Schedule Number</th>
        <th>Start Station</th>
        <th>End Station</th>
        <th>Departure Time</th>
        <th>Arrival Time</th>
        <th>Cost</th>
      </tr>
      <% for (TrainScheduleObject t : (ArrayList<TrainScheduleObject>) session.getAttribute("b_data")) { %>
        <tr>
          <%= t.getBrowseData() %>
        </tr>
      <% } %>
    <% } %>
  </table>
  <% if (session.getAttribute("b_msg") != null) { %>
    <div id="popup1" class="overlay">
      <div class="popup">
        <p><%= session.getAttribute("b_msg") %></p>
        <% session.removeAttribute("b_msg"); %>
        <div class="content">
          <button><a href="">close</a></button>
        </div>
      </div>
    </div>
  <% } %>
</div>
</body>
</html>
