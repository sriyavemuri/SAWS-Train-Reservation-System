<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Person</title>
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
    form input[type="text"] {
        display: block;
        width: 100%;
        padding: 10px;
        margin: 10px 0;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    form select {
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
        <h1>Edit Person</h1>
    </header>
    <div class="container">
        <form action="HandlePerson.jsp" method="POST">
            <label for="fname">First Name:</label>
            <input type="text" name="fname" id="fname"/> <br/>
            <label for="lname">Last Name:</label>
            <input type="text" name="lname" id="lname"/> <br/>
            <label for="ssn">SSN:</label>
            <input type="text" name="ssn" id="ssn"/> <br/>
            <label for="zipcode">Zipcode:</label>
            <input type="text" name="zipcode" id="zipcode"/> <br/>
            <label for="email">Email:</label>
            <input type="text" name="email" id="email"/> <br/>
            <label for="telephone">Telephone:</label>
            <input type="text" name="telephone" id="telephone"/> <br/>
            <label for="city">City:</label>
            <input type="text" name="city" id="city"/> <br/>
            <label for="state">State:</label>
            <input type="text" name="state" id="state"/> <br/>
            <label for="role">Role:</label>
            <select name="role" id="role">
                <option value="customer">Customer</option>
                <option value="customer_service_rep">Customer Representative</option>
            </select>
            <input type="submit" value="Submit"/>
        </form>
    </div>
</body>
</html>
