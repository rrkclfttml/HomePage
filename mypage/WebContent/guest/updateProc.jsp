<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>
<%
	boolean flag=dao.update(dto);
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
<%
	if(flag){
		out.println("방명록을 수정했습니다.");
	}else{
		out.println("수정을 실패했습니다.");
	}
%>
  <DIV class='bottom'>
    <input type='button' value='목록' onclick="location.href='./list.jsp'">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

