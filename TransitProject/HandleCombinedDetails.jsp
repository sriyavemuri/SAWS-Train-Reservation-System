<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.TransitProject.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Processing...</title>
</head>
<body>
    <%
        try {
            ApplicationDB db = new ApplicationDB();
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();
            String type = (String) session.getAttribute("type");

            if (type.equals("register") || type.equals("login")) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                if (username == "" || password == "" || username == null || password == null) {
                    out.println("<h1 style='color:red'> Username/Password cannot be empty </h1> <a href='index.jsp'>Click here to try again</a>");
                } else if (type.equals("register")) {
                    String statement = "INSERT INTO users (username, password) VALUES (?, ?)";
                    PreparedStatement ps = con.prepareStatement(statement);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    int x = ps.executeUpdate();

                    if (x == 1) {
                        session.setAttribute("user", username);
                        response.sendRedirect("index.jsp?command=edit");
                    }
                } else if (type.equals("login")) {
                    ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE username='" + username + "' AND password='" + password + "'");

                    if (rs.next()) {
                        session.setAttribute("user", rs.getString("username"));
                        session.setAttribute("role", rs.getString("role"));

                        ArrayList<String> transitLines = new ArrayList<>();
                        ArrayList<Integer> scheduleNums = new ArrayList<>();
                        ArrayList<String> startTimes = new ArrayList<>();

                        ResultSet res = stmt.executeQuery("SELECT t.schedule_num, t.arrival_time, tl.tl_name FROM train_schedule_timings t, reservations r, transit_line tl, train_schedule_assignment tsa WHERE tsa.schedule_num = t.schedule_num AND tsa.tl_id = tl.tl_id AND t.schedule_num = r.schedule_num AND r.username='" + session.getAttribute("user") + "' ORDER BY t.arrival_time");
                        while (res.next()) {
                            if (!(scheduleNums.contains(res.getInt("t.schedule_num")) && startTimes.contains(res.getString("t.arrival_time")))) {
                                transitLines.add(res.getString("tl.tl_name"));
                                scheduleNums.add(res.getInt("t.schedule_num"));
                                startTimes.add(res.getString("t.arrival_time"));
                            }
                        }

                        session.setAttribute("transitLinesInit", transitLines);
                        session.setAttribute("scheduleNumsInit", scheduleNums);
                        session.setAttribute("startTimesInit", startTimes);

                        response.sendRedirect("Home.jsp");
                    } else {
                        out.println("<h1> Oops! Invalid username or password. </h1> <br> <a href='index.jsp'>Click here to try again</a>");
                    }
                }
            } else if (type.equals("edit")) {
                String fname = request.getParameter("fname");
                String zipcode = request.getParameter("zipcode");
                String email = request.getParameter("email");
                String lname = request.getParameter("lname");
                String telephone = request.getParameter("telephone");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String ssn = request.getParameter("ssn");
                String role = request.getParameter("role");
                String user = (String) session.getAttribute("user");

                if (fname == "" || zipcode == "" || email == "" || lname == "" || telephone == "" || city == "" || state == "" || ssn == "" || fname == null || zipcode == null || email == null || lname == null || telephone == null || city == null || state == null || ssn == null) {
                    out.println("<h1 style='color:red'> Fields cannot be empty </h1> <a href='index.jsp'>Click here to try again</a>");
                } else {
                    String statement = "UPDATE users SET fname=?, lname=?, telephone=?, city=?, state=?, zipcode=?, email=?, role=?, ssn=? WHERE username=?";
                    PreparedStatement ps = con.prepareStatement(statement);
                    ps.setString(1, fname);
                    ps.setString(2, lname);
                    ps.setString(3, telephone);
                    ps.setString(4, city);
                    ps.setString(5, state);
                    ps.setString(6, zipcode);
                    ps.setString(7, email);
                    ps.setString(8, role);
                    ps.setString(9, ssn);
                    ps.setString(10, user);
                    int x = ps.executeUpdate();

                    if (x == 1) {
                        ArrayList<String> transitLines = new ArrayList<>();
                        ArrayList<Integer> scheduleNums = new ArrayList<>();
                        ArrayList<String> startTimes = new ArrayList<>();

                        ResultSet res = stmt.executeQuery("SELECT t.schedule_num, t.arrival_time, tl.tl_name FROM train_schedule_timings t, reservations r, transit_line tl, train_schedule_assignment tsa WHERE tsa.schedule_num = t.schedule_num AND tsa.tl_id = tl.tl_id AND t.schedule_num = r.schedule_num AND r.username='" + session.getAttribute("user") + "' ORDER BY t.arrival_time");
                        while (res.next()) {
                            if (!(scheduleNums.contains(res.getInt("t.schedule_num")) && startTimes.contains(res.getString("t.arrival_time")))) {
                                transitLines.add(res.getString("tl.tl_name"));
                                scheduleNums.add(res.getInt("t.schedule_num"));
                                startTimes.add(res.getString("t.arrival_time"));
                            }
                        }

                        session.setAttribute("transitLinesInit", transitLines);
                        session.setAttribute("scheduleNumsInit", scheduleNums);
                        session.setAttribute("startTimesInit", startTimes);

                        response.sendRedirect("Home.jsp");
                    }
                }
            }

            db.closeConnection(con);
        } catch (SQLException e) {
            if (e.getSQLState().startsWith("23")) {
                session.invalidate();
                out.println("<h1 style='color:red'> Sorry. This username is already been taken! Try another one. </h1> <a href='index.jsp'>Click here to try again</a>");
            }
        } catch (Exception e) {
            out.print(e);
        }
    %>
</body>
</html>
