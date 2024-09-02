<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In/Register</title>
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
        padding: 20px 0;
        margin-bottom: 20px;
    }
    header h1 {
        margin: 0;
        font-size: 24px;
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
    p {
        font-style: italic;
        color: #555;
    }
    form {
        margin-top: 20px;
    }
    form input[type="text"],
    form input[type="password"] {
        display: block;
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    form input[type="submit"] {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 18px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    form input[type="submit"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <header>
        <% 
            String type = request.getParameter("command");
            session.setAttribute("type", type);
            session.setAttribute("filterRole", "all");
            if (type.equals("register")) {
                out.println("<h1>Register Page:</h1>");
            } else if (type.equals("login")) {
                out.println("<h1>Login Page:</h1>");
            }
        %>
    </header>
    <div class="container">
        <form action="HandleLoginDetails.jsp" method="POST">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username"/> <br/>
            <label for="password">Password:</label>
            <input type="password" name="password" id="password"/> <br/>
            <input type="submit" value="Submit"/>
        </form>
    </div>
</body>
</html>
