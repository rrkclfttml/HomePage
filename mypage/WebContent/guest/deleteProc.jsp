<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="guest.GuestDAO"/>
 
<%
	int gno=Integer.parseInt(request.getParameter("gno"));
	boolean flag=dao.delete(gno);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br> 
<DIV class="title"></DIV>
 <div>
		<%
			if (flag) {
				out.print("방명록을 삭제했습니다.");
			} else {
				out.print("삭제를 실패했습니다.");
			}
		%>

</div>  
  <DIV class='bottom'>
    <input type='button' value='목록' onclick="location.href='./list.jsp'">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

