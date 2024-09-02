<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <title>Sales Reports</title>
    <% 
    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    Statement stmt = con.createStatement(); 
    %>
    
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1, h3 {
            text-align: center;
            color: #333;
        }

        .button {
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

        .selection {
            margin: auto;
            width: 50%;
            padding: 10px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .selection select, .selection button {
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        .selection button {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }

        .selection button:hover {
            background-color: #45a049;
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
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        a {
            text-decoration: none;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Sales Reports</h1>
    
    <a href="Home.jsp" class="button home-button">Home</a>
    <a href="logout.jsp" class="button logout-button">Logout</a>
    
    <div class="selection">
        <form action="salesReport.jsp">
            <select name="month" id="Month">
                <option value="">- Month -</option> 
                <option value="'JANUARY'">Jan</option>
                <option value="'FEBRUARY'">Feb</option>
                <option value="'MARCH'">Mar</option>
                <option value="'APRIL'">Apr</option>
                <option value="'MAY'">May</option>
                <option value="'JUNE'">Jun</option>
                <option value="'JULY'">Jul</option>
                <option value="'AUGUST'">Aug</option>
                <option value="'SEPTEMBER'">Sep</option>
                <option value="'OCTOBER'">Oct</option>
                <option value="'NOVEMBER'">Nov</option>
                <option value="'DECEMBER'">Dec</option>
            </select>
            <button type="submit">Submit</button>
        </form>
    
        <form action="salesReport.jsp">
            <select name="listing" id="Listing">
                <option value="">- Listing -</option>
                <option value="TL">Transit Line</option>
                <option value="CUS">Customer</option>
                <option value="DC">Destination City</option>
                <option value="BTL">Best Line</option>
                <option value="BCUS">Best Customer</option>
            </select>
            <button type="submit">Submit</button>
        </form>
    </div>
    
    <table>
        <% 
        if (request.getParameter("month") != null && !request.getParameter("month").isEmpty()){
            String month = request.getParameter("month");
            System.out.println("month: " + request.getParameter("month"));
            ResultSet rs = stmt.executeQuery("SELECT sum(total_cost) FROM reservations WHERE DATE_FORMAT(date_reserved, '%M') = " + month);
            out.println("<h3>");
            if(rs.next()){
                if(rs.getString(1) != null){
                    out.println(month.replace("'", "")+" TOTAL REVENUE: $"+rs.getString(1));
                    out.println("</h3>");
                    out.print("<tr><th>Customer</th><th>Sales</th><th>Schedule #</th><th>Ticket Date</th><th>Reserve Date</th></tr>");
                }
                else{
                    out.print("No data for this month");
                    out.println("</h3>");
                }
            }
            rs = stmt.executeQuery("SELECT * FROM reservations WHERE DATE_FORMAT(date_reserved, '%M') = " + month 
                    + " ORDER BY date_reserved DESC");
            while (rs.next()){
                String table = "<tr><td>"+rs.getString("username")+"</td><td>"+rs.getString("total_cost")+"</td><td>"
                    +rs.getString("schedule_num")+"</td><td>"+rs.getString("date_ticket")
                    +"</td><td>"+rs.getString("date_reserved")+"</td></tr>";
                out.println(table);
            }
        }
        %>
    </table>
    <table>
        <%
        if(request.getParameter("listing") != null && !request.getParameter("listing").isEmpty()) {
            String listing = request.getParameter("listing");
            System.out.println("listing: " + request.getParameter("listing"));
            
            if(listing.equals("CUS")){
                out.print("<tr><th>Customer</th><th>Sales</th></tr>");
                ResultSet rs = stmt.executeQuery("SELECT username, sum(total_cost) FROM reservations GROUP BY username");
                while (rs.next()){
                    String table = "<tr><td>"+rs.getString("username")+"</td><td>"
                        +rs.getString("sum(total_cost)")+"</td></tr>";
                    out.println(table);
                }
            }
            if(listing.equals("BCUS")){
                out.print("<tr><th>Customer</th><th>Sales</th></tr>");
                ResultSet rs = stmt.executeQuery("SELECT username, sum(total_cost) FROM reservations GROUP BY username ORDER BY sum(total_cost) DESC LIMIT 5");
                while (rs.next()){
                    String table = "<tr><td>"+rs.getString("username")+"</td><td>"+rs.getString("sum(total_cost)")+"</td></tr>";
                    out.println(table);
                }
            }
            if(listing.equals("TL")){
                out.print("<tr><th>Transit Line</th><th>Sales</th></tr>");
                ResultSet rs = stmt.executeQuery("SELECT tl_name, sum(total_cost) FROM reservations INNER JOIN train_schedule_assignment ON reservations.schedule_num = train_schedule_assignment.schedule_num INNER JOIN transit_line ON train_schedule_assignment.tl_id = transit_line.tl_id group by tl_name");
                while (rs.next()){
                    String table = "<tr><td>"+rs.getString("tl_name")+"</td><td>"+rs.getString("sum(total_cost)")+"</td></tr>";
                    out.println(table);
                }
            }
            if(listing.equals("BTL")){
                out.print("<tr><th>Transit Line</th><th>Sales</th></tr>");
                ResultSet rs = stmt.executeQuery("SELECT tl_name, sum(total_cost) FROM reservations INNER JOIN train_schedule_assignment ON reservations.schedule_num = train_schedule_assignment.schedule_num INNER JOIN transit_line ON train_schedule_assignment.tl_id = transit_line.tl_id group by tl_name ORDER BY sum(total_cost) DESC LIMIT 5");
                while (rs.next()){
                    String table = "<tr><td>"+rs.getString("tl_name")+"</td><td>"+rs.getString("sum(total_cost)")+"</td></tr>";
                    out.println(table);
                }
            }
            if(listing.equals("DC")){
                out.print("<tr><th>Destination City</th><th>Sales</th></tr>");
                ResultSet rs = stmt.executeQuery("SELECT name, sum(total_cost) FROM TrainDatabase.reservations INNER JOIN station ON reservations.destination = station.station_id group by name");
                while (rs.next()){
                    String table = "<tr><td>"+rs.getString("name")+"</td><td>"+rs.getString("sum(total_cost)")+"</td></tr>";
                    out.println(table);
                }
            }
            db.closeConnection(con);
        }
        %>
    </table>

</body>
</html>
