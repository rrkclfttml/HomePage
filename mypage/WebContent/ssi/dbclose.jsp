<%@ page contentType="text/html; charset=UTF-8" %> 
<%
	if (rs != null) {
		rs.close();
	}
	if (ps != null) {
		ps.close();
	}
	if (con != null) {
		con.close();
	}
%>