<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
    .home-button {
        background-color: green;
        position: absolute;
        top: 2%;
        left: 4%;
    }
    .logout-button {
        background-color: gray;
        position: absolute;
        top: 2%;
        right: 4%;
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
    a {
        text-decoration: none;
        color: black;
    }
</style>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Reservations</title>
</head>

<body>
<a href="Home.jsp"><button class="home-button">Home</button></a>
<a href="logout.jsp"><button class="logout-button">Logout</button></a>
    <%

    if((session.getAttribute("user") == null) || (session.getAttribute("role") == null))  {
        response.sendRedirect("index.jsp");
    }

    String role = (String)session.getAttribute("role");
    //out.print(role);
    String rid = "";

        try{
            //connect to database
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();

            if(request.getParameter("res_change") != null){
                System.out.println("RES CHANGE");

                if((request.getParameter("res_change")).equals("delete") && (request.getParameter("v_rid") != null)){
                    rid = request.getParameter("v_rid");
                    String remove = "delete from reservations where rid = " + rid;
                    stmt.executeUpdate(remove);

                } else if((request.getParameter("res_change")).equals("Update")){
                    rid = request.getParameter("v_rid");
                    %>
                    <jsp:include page="UpdateResTable.jsp"/>
                    <%
                }
            }

            if(session.getAttribute("schedule") != null){
                    rid = request.getParameter("v_rid");
                    %>
                    <jsp:include page="AddReservation.jsp"/>
                    <%
                }
                db.closeConnection(con);
            } catch (Exception e) {
                out.print(e);
            }

    if ((role.equals("customer"))) {
        %>
        <div style="align:center; text-align:center;">
            <jsp:include page="ResTable_Customer.jsp"/>
        </div>
        <%
    } else if ((role.equals("administrator"))) {
        %>
        <div style="align:center; text-align:center;">
            <jsp:include page="ResTable_Admin.jsp"/>
        </div>
        <%
    } else if ((role.equals("customer_service_rep"))) {
        %>
        <div style="align:center; text-align:center;">
            <jsp:include page="ResTable_CustomerRep.jsp"/>
        </div>
        <%
    }

    %>
    <div style="text-align: center; padding-top: 30px;">
        <a href="TrainSchedule.jsp">
            <button style="font-size: 20px;background-color: gray;">Book Again</button>
        </a>
    </div>
</body>
</html>
