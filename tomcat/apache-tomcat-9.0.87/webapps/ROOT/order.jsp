<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 주문 페이지</title>
</head>
<body>
<h1>상품 주문</h1>
<form action="submitOrder.jsp" method="post">
    <label for="productId">상품 선택:</label>
    <select id="productId" name="productId">
        <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                String url = "jdbc:oracle:thin:@localhost:1521:xe";
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(url, "c##scot", "12341234"); // 실제 유저네임과 비밀번호 사용
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT ID, PRODUCT_NAME FROM product");
                while (rs.next()) {
                    out.println("<option value='" + rs.getInt("ID") + "'>" + rs.getString("PRODUCT_NAME") + "</option>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) { }
                if (stmt != null) try { stmt.close(); } catch (SQLException ex) { }
                if (conn != null) try { conn.close(); } catch (SQLException ex) { }
            }
        %>
    </select><br>
    <label for="itemCount">수량:</label>
    <input type="number" id="itemCount" name="itemCount" min="1" required><br>
    <label for="userId">사용자 ID:</label>
    <input type="text" id="userId" name="userId" required><br>
    <input type="submit" value="주문하기">
</form>
</body>
</html>
