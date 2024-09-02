<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Train Schedule</title>
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
            margin-bottom: 20px;
        }

        .button {
            display: inline-block;
            font-size: 1em;
            padding: 10px 20px;
            color: white;
            background-color: #06d85f;
            border-radius: 20px;
            text-decoration: none;
            transition: background-color 0.3s;
            margin: 10px;
        }

        .button:hover {
            background-color: #4caf50;
        }

        .home-button, .logout-button {
            position: absolute;
            top: 20px;
            border-radius: 10px;
            font-size: 20px;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            color: white;
            transition: background-color 0.3s;
        }

        .home-button {
            left: 30px;
            background-color: #4caf50;
        }

        .home-button:hover {
            background-color: #45a049;
        }

        .logout-button {
            right: 30px;
            background-color: #f44336;
        }

        .logout-button:hover {
            background-color: #e53935;
        }

        .link-button {
            color: black;
            text-decoration: none;
        }

        .link-button:hover {
            text-decoration: none;
        }

        .center-content {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        table {
            background-color: white;
            border-collapse: collapse;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            overflow: hidden;
        }

        td {
            padding: 20px;
            text-align: center;
        }

    </style>
</head>
<body>
    <a href="Home.jsp" class="home-button link-button">Home</a>
    <a href="logout.jsp" class="logout-button link-button">Logout</a>
    <h2>Manage Train Schedule</h2>
    <div class="center-content">
        <table>
            <tr>
                <td><a class="button link-button" href="addTrainSchedule.jsp">Add Train Schedule</a></td>
            </tr>
            <tr>
                <td><a class="button link-button" href="changeScheduleNumPage.jsp?button=edit">Edit Train Schedule</a></td>
            </tr>
            <tr>
                <td><a class="button link-button" href="changeScheduleNumPage.jsp?button=delete">Delete Train Schedule</a></td>
            </tr>
        </table>
    </div>
</body>
</html>
