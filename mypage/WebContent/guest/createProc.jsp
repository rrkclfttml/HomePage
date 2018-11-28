<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="guest.GuestDAO"/>
<jsp:useBean id="dto" class="guest.GuestDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	boolean flag=dao.create(dto);
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
<div>
	<%
		if(flag){
			out.print("방명록을 등록했습니다.");
		}else{
			out.print("등록을 실패했습니다.");
		}
	%>

</div>

  <DIV class='bottom'>
    <input type='button' value='계속등록' onclick="location.href='./createForm.jsp'">
    <input type='button' value='목록' onclick="location.href='./list.jsp'">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 

