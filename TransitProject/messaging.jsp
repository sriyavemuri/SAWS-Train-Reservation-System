<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Messaging</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #F6F4F3;
            margin: 0;
            padding: 20px;
        }

        h3 {
            font-size: 32px;
            text-align: center;
            color: #333;
        }

        .header-buttons {
            display: flex;
            justify-content: space-between;
            margin: 20px;
        }

        .header-buttons a {
            text-decoration: none;
        }

        .header-buttons button {
            border: none;
            border-radius: 8px;
            color: white;
            padding: 10px 20px;
            text-align: center;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .header-buttons .home-button {
            background-color: #4CAF50;
        }

        .header-buttons .logout-button {
            background-color: #777;
        }

        .header-buttons button:hover {
            opacity: 0.8;
        }

        .search-bar {
            text-align: center;
            margin: 20px 0;
        }

        .search-bar input[type="text"] {
            width: 60%;
            padding: 10px;
            font-size: 18px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        .search-bar button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }

        .search-bar button:hover {
            opacity: 0.8;
        }

        .posts-container {
            margin: 20px auto;
            max-width: 1200px;
        }

        .posts-container .post {
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .posts-container .post h2 {
            font-size: 24px;
            color: #333;
            margin-top: 0;
        }

        .posts-container .post p {
            font-size: 16px;
            color: #555;
        }

        .posts-container .post .question,
        .posts-container .post .answer {
            margin-bottom: 20px;
        }

        .posts-container .post .answer h2 {
            font-size: 20px;
            color: #007BFF;
        }

        .posts-container .post .answer p {
            font-size: 16px;
            color: #555;
        }

        .alert {
            background-color: #FFCDD2;
            color: #C62828;
            padding: 20px;
            border-radius: 8px;
            margin: 20px 0;
        }

        .popup-form {
            display: none;
            background-color: rgba(0, 0, 0, 0.8);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .popup-form .form-content {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            width: 50%;
            max-width: 600px;
            text-align: center;
            position: relative;
        }

        .popup-form .form-content h3 {
            margin-top: 0;
        }

        .popup-form .form-content input[type="text"],
        .popup-form .form-content textarea {
            width: 90%;
            padding: 10px;
            font-size: 16px;
            margin: 10px 0;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .popup-form .form-content button {
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .popup-form .form-content button:hover {
            opacity: 0.8;
        }

        .popup-form .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            font-size: 24px;
            color: #777;
            cursor: pointer;
        }

        .popup-form .close-btn:hover {
            color: #333;
        }
    </style>
    <%
    	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();

    	//if user did not log in yet, redirect to index.jsp
    	if(session.getAttribute("role") == null || session.getAttribute("user") == null) {
    		response.sendRedirect("index.jsp");
    	} else if (!(session.getAttribute("role").equals("customer"))) {
    		%>
    			<style>
    				#ticketQuery {
	    				width: 355px;
					    height: 30px;
					    font-size: 30px;
					    position: absolute;
					    top: 6%;
					    left: 5%;
    				}
    				#forumAnswer {
	    				width: 80%;
	            		height: 80%;
	            		background-color: white;
			            position: absolute;
			            left: 10%;
			            top: 10%;
			            display: none;
			            z-index: 99;
			            border-radius: 8px;
			            padding: 20px;
		            }
		            
		            #forumAnswer textarea {
			            width: 90%;
			            padding: 10px;
			            font-size: 16px;
			            margin: 10px 0;
			            border-radius: 8px;
			            border: 1px solid #ccc;
        			}
        			
        			#forumAnswer button {
			            background-color: #007BFF;
			            color: white;
			            border: none;
			            border-radius: 8px;
			            padding: 10px 20px;
			            font-size: 16px;
			            cursor: pointer;
			            margin-top: 10px;
			            display: block;
			            margin-left: auto;
			            margin-right: auto;
			        }
			        
			        .posts button {
			            background-color: #183059;
			            color: white;
			            border: none;
			            border-radius: 8px;
			            padding: 10px 20px;
			            font-size: 16px;
			            cursor: pointer;
			            margin-top: 10px;
			            display: block;
			            margin-left: auto;
			            margin-right: auto;
			        }
    			</style>
    		
    		<%
    	}
    
    	//Catching for empty subject/content on forum post
		if(session.getAttribute("badPost") != null) {
			if(session.getAttribute("badPost").equals("Yes")) {
				%>
					<script>
						alert("Error. Please fill in all sections of post!");
					</script>
				<%
				//resetting badPost
				session.setAttribute("badPost", "No");
			}
		}
    	
		System.out.println("Role of current viewer: " + session.getAttribute("role"));
    
    %>
</head>

<body>
    <div class="header-buttons">
        <a href="Home.jsp"><button class="home-button">Home</button></a>
        <a href="logout.jsp"><button class="logout-button">Logout</button></a>
    </div>
    <h3>Messaging</h3>
    
    <div class="search-bar">
        <form action="messaging.jsp" method="POST">
            <button id="resetSearch" onClick="resetSearch()">Reset Search</button>
        </form>
        <form action="messaging.jsp" method="POST">
            <input name="search" id="questionQuery" type="text" onkeydown="searchEvent()" placeholder="Search for a question here!">
        </form>
    </div>
    
	<%
    	if ((session.getAttribute("role").equals("customer"))) {
    %>
		    <form action="messaging.jsp" method="POST">
		    	<div id="forumPost" class="popup-form">
		    		<div class="form-content">
			    		<div class="close-btn" onClick="closeBox()">&#10006;</div>
			    		<h3>Ask a Question</h3>
			    		<input name="subject" type="text" placeholder="Subject">
			    		<textarea name="content" placeholder="What's wrong?"></textarea>
				        <button onClick="postToDB()">Post Question</button>
			    	</div>
			    </div>
		    </form>
	<%
		}else if (!(session.getAttribute("role").equals("customer"))) {
    %>
    		<form action="messaging.jsp" method="POST">
    			<div id="forumAnswer" class="popup-form">
    				<div class="form-content">
    					<div class="close-btn" onClick="closeBox()">&#10006;</div>
    					<h3>Troubleshoot Problem</h3>
    					<input name="ticketId" id="ticketQuery" type="text" placeholder="TicketID">
    					<textarea name="answer" placeholder="Troubleshoot problem"></textarea>
		        		<button onClick="answerDB()">Post Answer</button>
	        		</div>
	    		</div>
    		</form>
    
    <%
		}
    %>
    
    <%
	    ArrayList<String> transitLines = new ArrayList<String>();
		ArrayList<Integer> scheduleNums = new ArrayList<Integer>();
		ArrayList<String> startTimes = new ArrayList<String>();
		
		ResultSet res = stmt.executeQuery("SELECT t.schedule_num, t.arrival_time, tl.tl_name FROM `train_schedule_timings` t, `reservations` r, `transit_line` tl, `train_schedule_assignment` tsa WHERE tsa.schedule_num = t.schedule_num AND tsa.tl_id = tl.tl_id AND t.schedule_num = r.schedule_num AND r.username='" + session.getAttribute("user") + "' ORDER BY t.arrival_time");
	 	while(res.next()) {
	 		if(!(scheduleNums.contains(res.getInt("t.schedule_num")) && startTimes.contains(res.getString("t.arrival_time")))) {
	 			//System.out.println("transitLine: " + res.getString("tl.tl_name"));
		 		transitLines.add(res.getString("tl.tl_name"));
		 	
		 		//System.out.println("scheduleNum: " + res.getInt("t.schedule_num"));
		 		scheduleNums.add(res.getInt("t.schedule_num"));
		 	
		 		//System.out.println("startTimes: " + res.getString("t.arrival_time"));
		 		startTimes.add(res.getString("t.arrival_time"));
	 		}
	 		
		}
		
		@SuppressWarnings("unchecked")
		ArrayList<String> transitLinesInit = (ArrayList<String>)session.getAttribute("transitLinesInit");
		
		if(transitLinesInit.size() > 0) {
			System.out.println(startTimes.size());
			out.println("<div class='alert'>");
			@SuppressWarnings("unchecked")
			ArrayList<Integer> scheduleNumsInit = (ArrayList<Integer>)session.getAttribute("scheduleNumsInit");
			@SuppressWarnings("unchecked")
			ArrayList<String> startTimesInit = (ArrayList<String>)session.getAttribute("startTimesInit");
			
			int flag = 0;
			for(int i = 0; i < startTimes.size(); i++) {
				System.out.println("START TIME\n\n\n");
				System.out.println(startTimes.get(0));
				String[] currTime = startTimes.get(i).split(":");
				int currS = (Integer.parseInt(currTime[0]) * 60 * 60) + (Integer.parseInt(currTime[1])) * 60 + Integer.parseInt(currTime[2]);
				
				String[] initTime = startTimesInit.get(i).split(":");
				int initS = (Integer.parseInt(initTime[0]) * 60 * 60) + (Integer.parseInt(initTime[1])) * 60 + Integer.parseInt(initTime[2]);
				
				if(initS > currS) {
					flag = 1;
					System.out.println("early");
					out.println("<h2>Today's train on " + transitLinesInit.get(i) + " at " + startTimesInit.get(i) + " will now be arriving " + (Math.abs(currS - initS)) / 60 + " minutes early at " + startTimes.get(i) + "</h2>");
				} else if (initS < currS) {
					flag = 1;
					System.out.println("delayed");
					out.println("<h2>Today's train on " + transitLinesInit.get(i) + " at " + startTimesInit.get(i) + " will now be arriving " + (Math.abs(currS - initS)) / 60 + " minutes late at " + startTimes.get(i) + "</h2>");
				} else {
					System.out.println("on time");
				}
			}
			
			if(flag == 0) {
				out.println("<h2>All reservations will be arriving on time!</h2>");
			}
			out.println("</div>");
		} else {
			out.println("<div class='alert'>");
			out.println("<h2>Purchase tickets to view early arrivals or delays.</h2>");
			out.println("</div>");
		}
		
    %>
    
    <%	
		String msgQuery = "SELECT * FROM messaging ORDER BY mid DESC";
    	if(session.getAttribute("search") != null) {
    		String[] keywords = ((String)session.getAttribute("search")).split(" ");
    		msgQuery = "SELECT * FROM messaging WHERE content REGEXP '" + keywords[0].replaceAll("'", "''").replaceAll("\"", "\\\"");
    		for(int i = 1; i < keywords.length; i++) {
    			System.out.println("word: " + keywords[i]);
    			msgQuery += "|" + keywords[i].replaceAll("'", "\\'").replaceAll("\"", "\\\"");
    		}
    		msgQuery += "'";
    		String temp = msgQuery;
    		
    		msgQuery += " UNION " + temp.replace("content", "subject") + " UNION " + temp.replace("content", "answer") + " ORDER BY mid DESC";
    		
    		
    	}
    	
    	System.out.println("msgQuery: " + msgQuery);
    	session.setAttribute("search", null);
		
		ResultSet rs = stmt.executeQuery(msgQuery);
		
		String postView = "";
		while(rs.next()) {
			if(session.getAttribute("role").equals("administrator") || session.getAttribute("role").equals("customer_service_rep")) {
				postView += "<div class=\"post\">" + 
										"<div class=\"question\"><h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "&emsp;ticketID: <span>" + rs.getInt("mid") + "</h2>" + 
										"<p>" + rs.getString("content") + "</p></div>";
				if(rs.getString("answer") != null) {
					postView += "<div class='answer'><h2>Response from Representative: <span>" + rs.getString("admin") + "</span></h2>" + 
							"<p><span>" + rs.getString("answer") + "</p>" +
					"</div>";
				} else {
					postView += "<div class='answer'>" + 
							"<h2 style=\"color: #57B8FF\">OPEN TICKET</h2>" +
					"</div>";
				} 
				postView += "</div>";
			} else {
				postView += "<div class=\"post\">" + 
										"<div class=\"question\"><h2>" + rs.getString("subject") + " - " + "<span>" + rs.getString("user") + "</span>" + "</h2>" + 
										"<p>" + rs.getString("content") + "</p></div>";
				if(rs.getString("answer") != null) {
					postView += "<div class='answer'><h2>Response from Representative: <span>" + rs.getString("admin") + "</span></h2>" + 
							"<p><span>" + rs.getString("answer") + "</p>" +
					"</div>";
				} else {
					postView += "<div class='answer'>" + 
							"<h2 style=\"color: #57B8FF\">No response yet</h2>" +
					"</div>";
				} 
				postView += "</div>";
			}
		}
		
		if(postView.length() == 0) {
			out.println("<h3>No posts.</h3>");
		} else {
			out.println("<div class='posts-container'>" + postView + "</div>");
		}
		if(session.getAttribute("role").equals("customer")) {
			%> 
				<button id="askQuestion" onClick="questionPost()">Ask a question</button>
			<%
		} else {
			%>
				<button id="askQuestion" onClick='answerPost()'>Troubleshoot/Solve</button>
			<%
		}
	%>
    <script>
    	function closeBox() {
    		var answer = document.getElementById("forumAnswer");
    		var question = document.getElementById("forumPost");
    		if(answer == null) {
    			question.style.display = "none";
    		} else {
    			answer.style.display = "none";
    		}
    		
    	}
    	
    	function searchEvent() {
    		<%
    			String search = request.getParameter("search");
    			if(search != null) {
    				session.setAttribute("search", search);
    				response.sendRedirect("messaging.jsp");
    			}
    			
    		%>
    	}
    	
    	function questionPost() {
    		document.getElementById("forumPost").style.display = "flex";
    	}
    	
    	function answerPost() {
    		document.getElementById("forumAnswer").style.display = "flex"
    	}
    	
    	//In admin view, each forum post will have the mid in the subject header
    	function postToDB() {
    		<%
    			String user = (String)session.getAttribute("user");
	        	String subject = request.getParameter("subject");
	    	    String content = request.getParameter("content");
	    	    if(subject != null && content != null) {
	    	    	content = content.replaceAll("\n", "<br>");
	    	   		System.out.println("subject: " + subject);
	    		    System.out.println("content: " + content);
	    		    String query = "INSERT INTO messaging (user, subject, content) VALUES (?, ?, ?)";
	    		    System.out.println("query: " + query);
	    		    if(subject.length() == 0 || content.length() == 0) {
	    		    	System.out.println("bad post");
	    		    	session.setAttribute("badPost", "Yes");
	    		    	response.sendRedirect("messaging.jsp");
	    		    } else {
	    		    	System.out.println("good post");
	    		    	session.setAttribute("badPost", "No");
	    		    	PreparedStatement ps = con.prepareStatement(query);
		    		    ps.setString(1, user);
		    		    ps.setString(2, subject);
		    		    ps.setString(3, content);
	    		    	
		    		    if (ps.executeUpdate() != 1) {
		    		    	System.out.println("some error. Probably never going to happen but keeping it here just in case.");
		    		    }
		    		    response.sendRedirect("messaging.jsp");
	    		    }
	    	    }
    		%>
    	}
    	
    	function answerDB() {
    		<%
    			String admin = (String) session.getAttribute("user");
	        	String ticketId = request.getParameter("ticketId");
	    	    String answer = request.getParameter("answer");
	    	    if(ticketId != null && answer != null) {
	    	    	answer = answer.replaceAll("\n", "<br>");
	    	    	System.out.println("ticketID: " + ticketId);
		    	    System.out.println("answer: " + answer);
		    	    String query = "UPDATE messaging SET admin = ?, answer = ? WHERE mid = ?";
		    	    System.out.println("query: " + query);
		    	    if(ticketId.length() == 0 || answer.length() == 0) {
	    		    	System.out.println("bad post");
	    		    	session.setAttribute("badPost", "Yes");
	    		    	response.sendRedirect("messaging.jsp");
	    		    } else {
	    		    	System.out.println("good post");
	    		    	session.setAttribute("badPost", "No");
	    		    	PreparedStatement ps = con.prepareStatement(query);
	    		    	ps.setString(1, admin);
	    		    	ps.setString(2, answer);
	    		    	ps.setString(3, ticketId);
	    		    	
	    		    	if (ps.executeUpdate() != 1) {
		    		    	System.out.println("some error. Probably never going to happen but keeping it here just in case.");
		    		    }
		    		    response.sendRedirect("messaging.jsp");
	    		    }
	    	    }
	    	    
	    	    db.closeConnection(con);
    		%>
    	}
    </script>
</body>
</html>
