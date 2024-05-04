<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상품 조회 페이지</title>
</head>
<body>
<h1>상품 목록</h1>
<table border="1">
    <tr>
        <th>상품 ID</th>
        <th>상품 이름</th>
        <th>설명</th>
        <th>가격</th>
        <th>수량</th>
    </tr>
    <%
    String url = "jdbc:oracle:thin:@localhost:1521:xe";
    String user = "c##scot";
    String pass = "12341234";
    String query = "SELECT * FROM product";
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();
        rs = stmt.executeQuery(query);
        boolean hasResults = false;

        while (rs.next()) {
            hasResults = true;
            int id = rs.getInt("ID");
            String productName = rs.getString("PRODUCT_NAME");
            String description = rs.getString("DESCRIPTION");
            int price = rs.getInt("PRICE");
            int productCount = rs.getInt("PRODUCT_COUNT");
%>
<tr>
    <td><%= id %></td>
    <td><%= productName %></td>
    <td><%= description %></td>
    <td><%= price %></td>
    <td><%= productCount %></td>
</tr>
<%
        }
        if (!hasResults) {
            out.println("<tr><td colspan='5'>상품이 없습니다.</td></tr>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error retrieving products: " + e.getMessage() + "</h2>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
        if (conn != null) try { conn.close(); } catch (SQLException e) { }
    }
%>
</table>
</body>
</html>
