<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>주문 조회</title>
</head>
<body>
<h1>주문 조회</h1>
<form method="post">
    <label for="userId">사용자 ID:</label>
    <input type="text" id="userId" name="userId" required>
    <input type="submit" value="조회">
</form>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String userId = request.getParameter("userId");
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url, "c##scot", "12341234"); // 실제 유저네임과 비밀번호 사용
            String sql = "SELECT o.ITEM_COUNT, o.ORDER_DATE, o.STATUS, p.PRODUCT_NAME, p.PRICE FROM orders o JOIN product p ON o.PRODUCT_ID = p.ID WHERE o.USER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            out.println("<table border='1'>");
            out.println("<tr><th>상품 이름</th><th>가격</th><th>수량</th><th>주문 날짜</th><th>상태</th></tr>");
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("PRODUCT_NAME") + "</td>");
                out.println("<td>" + rs.getInt("PRICE") + "</td>");
                out.println("<td>" + rs.getInt("ITEM_COUNT") + "</td>");
                out.println("<td>" + rs.getDate("ORDER_DATE") + "</td>");
                out.println("<td>" + rs.getString("STATUS") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h2>주문 조회 중 오류가 발생했습니다.</h2>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) { }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
            if (conn != null) try { conn.close(); } catch (SQLException ex) { }
        }
    }
%>
</body>
</html>
