<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
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
    .button-group {
        margin-top: 20px;
    }
    .button-group button {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 18px;
        margin: 10px 0;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .button-group button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <header>
        <h1>SAWS Train Bookings</h1>
    </header>
    <div class="container">
        <p><i>GROUP 5: Shyam Mehta, Andy Chen, Wahab Dar, Sriya Vemuri</i></p>
        <div class="button-group">
            <button onClick="window.location.href='formPage.jsp?command=register'">Register</button>
            <button onClick="window.location.href='formPage.jsp?command=login'">Login</button>
        </div>
    </div>
</body>
</html>
