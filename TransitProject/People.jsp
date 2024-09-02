<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Table with database</title>

<style>
	/* General body styling */
	body {
		font-family: Arial, Helvetica, sans-serif;
		background-color: #f4f4f4;
		margin: 0;
		padding: 20px;
	}

	/* Header styling */
	h1, h3 {
		text-align: center;
		color: #333;
	}

	/* Button styling */
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

	button.home-button {
		background-color: #4CAF50;
		position: absolute;
		top: 20px;
		left: 30px;
	}

	button.logout-button {
		background-color: #f44336;
		position: absolute;
		top: 20px;
		right: 30px;
	}

	button:hover {
		opacity: 0.8;
	}

	/* Link styling */
	a {
		color: white;
		text-decoration: none;
	}

	/* Table styling */
	table {
		width: 80%;
		margin: 2% auto;
		border-collapse: collapse;
		background-color: white;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
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

	/* Form styling */
	.register {
		display: block;
		margin: 20px auto;
		width: fit-content;
		background-color: #008CBA;
		padding: 10px 20px;
		border-radius: 10px;
		color: white;
		text-decoration: none;
		text-align: center;
	}

	.userSelect {
		width: fit-content;
		margin: 20px auto;
		padding: 10px 20px;
		background-color: #ffffff;
		border: 1px solid #ddd;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	}

	.userSelect form {
		display: flex;
		align-items: center;
	}

	.userSelect form p {
		margin-right: 10px;
	}

	.userSelect select {
		padding: 10px;
		margin-right: 10px;
		border-radius: 5px;
		border: 1px solid #ccc;
	}

	.userSelect input[type="submit"] {
		background-color: #4CAF50;
		color: white;
		border: none;
		padding: 10px 20px;
		border-radius: 5px;
		cursor: pointer;
	}

	.userSelect input[type="submit"]:hover {
		background-color: #45a049;
	}

	/* Edit and Delete button styling */
	.table-action-buttons a {
		background-color: #ffa500;
		color: white;
		padding: 5px 10px;
		border-radius: 5px;
		margin: 0 5px;
		display: inline-block;
		transition: background-color 0.3s;
	}

	.table-action-buttons a.delete {
		background-color: #f44336;
	}

	.table-action-buttons a:hover {
		opacity: 0.8;
	}
</style>
</head>
<body>
<button class="home-button"><a href="Home.jsp">Home</a></button>
<button class="logout-button"><a href="logout.jsp">Logout</a></button>
<h1>Users</h1>
<a class="register" href='formPage.jsp?command=register'>Register a User</a>

<div class="userSelect">
	<form action="People.jsp" method="POST">
		<p><strong>Select User Role: </strong></p>
		<select name="role">
			<option value="all">All</option>
			<option value="customer">Customer</option>
			<option value="customer representative">Customer Representative</option>
		</select>
		<input type="submit" value="Submit"/>
	</form>
</div>

<table>
	<tr>
		<th>Username</th>
		<th>Email</th>
		<th>SSN</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Telephone</th>
		<th>City</th>
		<th>State</th>
		<th>Zipcode</th>
		<th>Role</th>
		<th>Edit</th>
		<th>Delete</th>
	</tr>
	<% 
	try {
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet rs = null;
		String s = null;
		if(session.getAttribute("filterRole").equals("all")) {
			s = "all";
		} else {
			s = request.getParameter("role");
		}
		
		if(s == null) {
			s = "all";
		}
		
		if(s.equals("customer")) {
			session.setAttribute("filterRole", "customer");
			rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email FROM users WHERE role = 'customer'");
		} else if(s.equals("customer representative")) {
			session.setAttribute("filterRole", "customer rep");
			rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email FROM users WHERE role = 'customer_service_rep'");
		} else if(s.equals("all")) {
			session.setAttribute("filterRole", "null");
			rs = stmt.executeQuery("SELECT username, ssn, fname, lname, telephone, city, state, role, zipcode, email FROM users");
		}
		
		while(rs.next()) {
		%>
			<tr>
			<td><%= rs.getString("username") %></td>
			<td><%= rs.getString("email") %></td>
			<td><%= rs.getString("ssn") %></td>
			<td><%= rs.getString("fname") %></td>
			<td><%= rs.getString("lname") %></td>
			<td><%= rs.getString("telephone") %></td>
			<td><%= rs.getString("city") %></td>
			<td><%= rs.getString("state") %></td>
			<td><%= rs.getString("zipcode") %></td>
			<td><%= rs.getString("role") %></td>
			<td class="table-action-buttons">
				<a href="adminEdit.jsp?value=<%= rs.getString("username") %>">Edit</a>
			</td>
			<td class="table-action-buttons">
				<a class="delete" href="deletePerson.jsp?value=<%= rs.getString("username") %>">Delete</a>
			</td>
			</tr>
		<%
		}
		db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}
	%>
</table>
</body>
</html>
