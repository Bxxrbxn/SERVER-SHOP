<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>주문 결과</title>
</head>
<body>
<%
    String userId = request.getParameter("userId");
    int productId = Integer.parseInt(request.getParameter("productId"));
    int itemCount = Integer.parseInt(request.getParameter("itemCount"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, "c##scot", "12341234"); // 실제 유저네임과 비밀번호 사용
        pstmt = conn.prepareStatement("INSERT INTO orders (ITEM_COUNT, ORDER_DATE, PRODUCT_ID, STATUS, USER_ID) VALUES (?, SYSDATE, ?, '처리중', ?)");
        pstmt.setInt(1, itemCount);
        pstmt.setInt(2, productId);
        pstmt.setString(3, userId);
        pstmt.executeUpdate();
        out.println("<h2>주문이 성공적으로 완료되었습니다.</h2>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>주문 처리 중 오류가 발생했습니다.</h2>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { }
        if (conn != null) try { conn.close(); } catch (SQLException ex) { }
    }
%>
</body>
</html>
