<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	if((session.getAttribute("user") == null) || (session.getAttribute("role") == null))  {
		response.sendRedirect("index.jsp");
	}
		//connect to database
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

		//System.out.println("here");

		String rid = request.getParameter("v_rid");
		//System.out.println(rid);
		String trip = request.getParameter("trip");
		//System.out.println(trip);
		String disc = request.getParameter("discount");
		//System.out.println(disc);
		String org = (String) session.getAttribute("v_org");
		//System.out.println(org);
		String dest = (String) session.getAttribute("v_dest");
		//System.out.println(dest);
		String schNum = request.getParameter("schNum");
		//System.out.println(schNum);

		int fare = 0;
		int origin = Integer.parseInt(org);
		int des = Integer.parseInt(dest);


		String getFare = "SELECT tl.tl_id, tl.fare"
				+ " FROM transit_line tl, train_schedule_assignment tsa"
				+ " WHERE tsa.schedule_num = '" + schNum + "' AND tl.tl_id = tsa.tl_id ";

		System.out.println(getFare);

		ResultSet result = stmt.executeQuery(getFare);

		while(result.next()){
			fare = result.getInt("tl.fare");
		}

		if(trip.equals("Round")){
			fare = fare *2;
		}

		if(disc.equals("Senior/Child") || disc.equals("Disabled") ){
			fare = fare/2;
		}

		

		double totalFare = fare * Math.abs((des - origin));
		System.out.println(totalFare);
		totalFare += 3.5;

		String update = "UPDATE reservations"
				+ " SET discount = '" + disc
				+ "' , destination = '" + dest
				+ "' , origin = '" + origin
				+ "' , schedule_num = '" + schNum
				+ "' , trip = '" + trip
				+ "' , total_cost = " + totalFare
				+ " WHERE rid = " + rid;


		System.out.println(update);
		stmt.executeUpdate(update);
		session.removeAttribute("v_org");
		session.removeAttribute("v_dest");

		db.closeConnection(con);
	} catch (Exception e) {
		out.print(e);
	}


%>

</body>
</html>
